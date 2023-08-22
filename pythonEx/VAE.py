import numpy as np
import matplotlib.pyplot as plt
from tensorflow.keras.datasets import mnist
from tensorflow.keras.models import Model
from tensorflow.keras.layers import Input, Dense, Lambda
from tensorflow.keras.losses import mse, binary_crossentropy
from tensorflow.keras import backend as K

# Load and preprocess the MNIST dataset
(x_train, _), (x_test, _) = mnist.load_data()
x_train = x_train.astype('float32') / 255.0
x_test = x_test.astype('float32') / 255.0
x_train = x_train.reshape((-1, 784))
x_test = x_test.reshape((-1, 784))

# Set dimensions for latent space
original_dim = 784
latent_dim = 2
intermediate_dim = 256

# Encoder network
input_img = Input(shape=(original_dim,))
hidden_enc = Dense(intermediate_dim, activation='relu')(input_img)
z_mean = Dense(latent_dim)(hidden_enc)
z_log_var = Dense(latent_dim)(hidden_enc)

# Reparameterization trick
def sampling(args):
    z_mean, z_log_var = args
    epsilon = K.random_normal(shape=(K.shape(z_mean)[0], latent_dim), mean=0.0, stddev=1.0)
    return z_mean + K.exp(0.5 * z_log_var) * epsilon

z = Lambda(sampling, output_shape=(latent_dim,))([z_mean, z_log_var])

# Decoder network
decoder_hidden = Dense(intermediate_dim, activation='relu')
decoder_out = Dense(original_dim, activation='sigmoid')

decoder_input = Input(shape=(latent_dim,))
hidden_dec = decoder_hidden(decoder_input)
output_img = decoder_out(hidden_dec)

# Define models
encoder = Model(input_img, [z_mean, z_log_var, z], name='encoder')
decoder = Model(decoder_input, output_img, name='decoder')

# VAE model
vae_output = decoder(encoder(input_img)[2])
vae = Model(input_img, vae_output, name='vae')

# Loss functions
reconstruction_loss = binary_crossentropy(input_img, vae_output) * original_dim
kl_loss = -0.5 * K.sum(1 + z_log_var - K.square(z_mean) - K.exp(z_log_var), axis=-1)
vae_loss = K.mean(reconstruction_loss + kl_loss)

vae.add_loss(vae_loss)
vae.compile(optimizer='adam')

# Train the VAE
vae.fit(x_train, epochs=50, batch_size=128, validation_data=(x_test, None))

# Generate images using the trained VAE
n = 15
grid_x = np.linspace(-4, 4, n)
grid_y = np.linspace(-4, 4, n)

figure = np.zeros((28 * n, 28 * n))
for i, yi in enumerate(grid_x):
    for j, xi in enumerate(grid_y):
        z_sample = np.array([[xi, yi]])
        x_decoded = decoder.predict(z_sample)
        digit = x_decoded[0].reshape(28, 28)
        figure[i * 28: (i + 1) * 28, j * 28: (j + 1) * 28] = digit

plt.figure(figsize=(10, 10))
plt.imshow(figure, cmap='Greys_r')
plt.show()

