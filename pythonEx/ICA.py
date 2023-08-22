import numpy as np
import matplotlib.pyplot as plt
from sklearn.datasets import fetch_openml
from sklearn.decomposition import FastICA

# Load MNIST dataset
mnist = fetch_openml('mnist_784', version=1)
X = mnist.data
y = mnist.target.astype(int)

# Perform ICA
n_components = 2  # Number of components for visualization
ica = FastICA(n_components=n_components)
X_ica = ica.fit_transform(X)

# Plot ICA results
plt.figure(figsize=(10, 6))
for i in range(10):
    plt.scatter(X_ica[y == i, 0], X_ica[y == i, 1], label=str(i), alpha=0.5)
plt.title('ICA of MNIST dataset')
plt.xlabel('Independent Component 1')
plt.ylabel('Independent Component 2')
plt.legend()
plt.show()

