import numpy as np
import matplotlib.pyplot as plt
from sklearn.datasets import fetch_openml
from sklearn.decomposition import PCA

# Load MNIST dataset
mnist = fetch_openml('mnist_784', version=1)
X = mnist.data
y = mnist.target.astype(int)

# Perform PCA
n_components = 2  # Number of components for visualization
pca = PCA(n_components=n_components)
X_pca = pca.fit_transform(X)

# Plot PCA results
plt.figure(figsize=(10, 6))
for i in range(10):
    plt.scatter(X_pca[y == i, 0], X_pca[y == i, 1], label=str(i), alpha=0.5)
plt.title('PCA of MNIST dataset')
plt.xlabel('Principal Component 1')
plt.ylabel('Principal Component 2')
plt.legend()
plt.show()

