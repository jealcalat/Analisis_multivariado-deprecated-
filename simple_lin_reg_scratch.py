# %% Import libraries
from sklearn.linear_model import LinearRegression
import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import minimize
import statsmodels.api as sm

# Define the linear model


def linear_model(x, b0, b1):
    return b0 + b1 * x

# Define the negative log-likelihood function


def neg_log_likelihood(params, x):
    # assign the parameters
    b0 = params[0]
    b1 = params[1]
    sigma = params[2]

    # Compute the predicted values
    y_pred = linear_model(x, b0, b1)

    # Compute the negative log-likelihood of the normal.
    # beware we're using the log transformation of the normal
    nll = -np.sum(np.log(1 / (np.sqrt(2 * np.pi) * sigma)) -
                  0.5 * ((y - y_pred) / sigma)**2)

    return nll


# Generate some data for simple linear regression
np.random.seed(0)
num_samples = 100
x = np.linspace(0, 10, num_samples)
sigma = 1
y = 3 + 2 * x + np.random.normal(0, sigma, num_samples)

# Plot the data
plt.scatter(x, y)
plt.xlabel('x')
plt.ylabel('y')
plt.show()

# Initialize parameters
b0 = 0
b1 = 0
sigma = 1

# Run the minimization algorithm
result = minimize(neg_log_likelihood, [b0, b1, sigma], args=(x),
                  method='Nelder-Mead',
                  bounds=[(None, None), (None, None), (0, None)])

# Print the optimal parameters and the minimum negative log-likelihood
print("Estimates: ----")
print("Intercept: %0.2f\nSlope: %0.2f\nSigma:%0.2f" %
      (result.x[0], result.x[1], result.x[2]))
# print(result.fun)


# %% fit the model using OLS from statmodels
# matrix model of the form X = [1, x]
X = sm.add_constant(x)
model = sm.OLS(y, X).fit()

# Print the optimal parameters from OLS; sigma is the residual variance
print("Estimates: ----")
print("Intercept: %0.2f\nSlope: %0.2f\nSigma:%0.2f" %
      (model.params[0], model.params[1], np.sqrt(model.resid.var()).round(2)))

# %%
# Plot the fitted line
plt.scatter(x, y)
plt.plot(x, linear_model(x, result.x[0], result.x[1]), 'r')
plt.plot(x, linear_model(x, model.params[0], model.params[1]), 'k:')
plt.xlabel('x')
plt.ylabel('y')
plt.show()

# %%

# Generate some data
np.random.seed(0)
X = np.random.rand(100, 1)
y = 2 + 3 * X + np.random.rand(100, 1)

# Fit a linear regression model
lin_reg = LinearRegression()
lin_reg.fit(X, y)

# Plot the data and the fitted line
plt.scatter(X, y)
plt.plot(X, lin_reg.predict(X), color='red')
plt.show()

# Compute the cost function for a range of parameter values
theta0 = np.linspace(lin_reg.intercept_ - 1, lin_reg.intercept_ + 1, 100)
theta1 = np.linspace(lin_reg.coef_[0] - 1, lin_reg.coef_[0] + 1, 100)
J_vals = np.zeros((len(theta0), len(theta1)))
for i in range(len(theta0)):
    for j in range(len(theta1)):
        y_pred = theta0[i] + theta1[j] * X
        J_vals[i, j] = np.sum((y_pred - y) ** 2) / (2 * len(y))

# Plot the cost function
theta0, theta1 = np.meshgrid(theta0, theta1)
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
ax.plot_surface(theta0, theta1, J_vals)
plt.show()
# %%
