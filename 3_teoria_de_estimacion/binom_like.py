import numpy as np
import matplotlib.pyplot as plt
import scipy.stats as ss
import math as m
from scipy.optimize import minimize
from scipy.optimize import Bounds
# pmf para binomial


def binom_pmf(n, k, p):
    return k * np.log(p) + (n - k) * np.log(1 - p) + np.log(m.comb(n, k))


# optimización usando grid search
n = 10
k = 9
p = 0.5
binom_pmf(n, k, p)
step = 0.05
grid_vals = np.linspace(0, 1, int(1 / 0.05))
log_like = binom_pmf(n, k, p=grid_vals)

arg_max = np.argmax(log_like)
plt.plot(grid_vals, log_like)
plt.scatter(grid_vals[arg_max], log_like[arg_max], c='red')
plt.text(grid_vals[arg_max] * 0.8, log_like[arg_max] * 2.8,
         s=f'$\\argmax\ l(\\theta)={{{round(grid_vals[arg_max], 3)}}}$')
plt.xlabel('$\\theta$')
plt.ylabel('$l(\\theta)$')
plt.show()

# usando rutinas de optimización


def binom_pmf2(p, n, k):
    ll = k * np.log(p) + (n - k) * np.log(1 - p) + np.log(m.comb(n, k))
    return -ll


n = 10
k = 9
theta = 0.7
res = minimize(binom_pmf2, theta, args=(n, k),
               method='Nelder-Mead')

res.x
grid_vals = np.linspace(0, 1, 1000)
plt.plot(grid_vals, binom_pmf2(grid_vals, n, k))
plt.scatter(res.x, res.fun, c='red')
plt.text(res.x * 0.8, res.fun * 2.8,
         s=f'$\\argmax\ l(\\theta)={{{round(res.x[0], 3)}}}$')
plt.xlabel('$\\theta$')
plt.ylabel('$l(\\theta)$')
plt.show()
