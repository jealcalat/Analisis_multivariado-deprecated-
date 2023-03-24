# %% Import libraries
import numpy as np
import matplotlib.pyplot as plt

# %% Define sigmoid function


def sigmoid(x):
    return 1 / (1 + np.exp(-x))

# Define cost function


def cost_function(h, y):
    return (-y * np.log(h) - (1 - y) * np.log(1 - h)).mean()

# Define gradient descent function


def gradient_descent(X, y, theta, alpha, num_iter):
    m = len(y)
    cost_history = []

    for i in range(num_iter):
        # Compute predictions
        h = sigmoid(np.dot(X, theta))

        # Compute errors
        error = h - y

        # Update parameters
        theta = theta - alpha * (1 / m) * np.dot(X.T, error)

        # Compute cost
        cost = cost_function(h, y)
        cost_history.append(cost)

    return theta, cost_history


# Generate some data for binary classification
np.random.seed(0)
num_samples = 100
X = np.c_[np.ones((num_samples, 1)), np.random.randn(num_samples, 2)]
y = np.random.randint(0, 2, num_samples)

# Initialize parameters
theta = np.zeros(X.shape[1])
alpha = 0.01
num_iter = 1000

# Run gradient descent
theta, cost_history = gradient_descent(X, y, theta, alpha, num_iter)

# Print the final parameters and cost
print(theta)
print(cost_history[-1])

# %%

plt.plot(cost_history)
