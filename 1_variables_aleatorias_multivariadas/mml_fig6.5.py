import numpy as np
import numpy.linalg as npl
from scipy.stats import multivariate_normal
import matplotlib.pyplot as plt
from matplotlib.pyplot import figure
from matplotlib.gridspec import GridSpec
import scipy
from scipy import stats
# Data setup.
mean1 = np.array([10, 2])
mean2 = np.array([0, 0])
cov2 = np.vstack([[1.7, 2.], [2., 8.4]])
n = 3000
second = np.round(np.random.multivariate_normal(mean2, cov2, n)*.6, 3)
A = 1+second@np.vstack([[-1, 0], [0, 1]])
B = 1+second
# Data setup.

# Figure setup.
fig = plt.figure(figsize=(14, 12))
gs = GridSpec(2, 2)
ax1 = fig.add_subplot(gs[0])
ax1.axis("equal")
ax2 = fig.add_subplot(gs[1])
ax2.axis("equal")
# Figure setup.

# Left plot.
ax1.scatter(A[:, 0], A[:, 1], c="k")
ax1.plot(np.mean(A[:, 0])*np.ones(100),
         np.linspace(-4, 6, 100), c="orange", lw=5)
ax1.plot(np.linspace(-1, 3, 100),
         np.mean(A[:, 1])*np.ones(100), c="magenta", lw=5)
ax1.set_title("Variance along X is %1.1f." % np.var(
    A[:, 0]) + " and along Y is %1.1f." % np.var(A[:, 1]))

# Right plot.
ax2.scatter(B[:, 0], B[:, 1], c="k")
ax2.plot(np.mean(B[:, 0])*np.ones(100),
         np.linspace(-4, 6, 100), c="orange", lw=5)
ax2.plot(np.linspace(-1, 3, 100),
         np.mean(B[:, 1])*np.ones(100), c="magenta", lw=5)
ax2.set_title("Variance along X is %1.1f." % np.var(
    B[:, 0]) + " and along Y is %1.1f." % np.var(B[:, 1]))

plt.savefig("img/same_var_diff_cov.png", dpi=300)
