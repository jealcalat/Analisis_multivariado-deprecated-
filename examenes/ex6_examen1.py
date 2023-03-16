# %%
import numpy as np
import scipy.stats as ss

# %%
mu = np.array([1, 1])
p1 = np.array([4, 15])
p2 = np.array([4, -13])
rho = -0.6
s1 = 2
s2 = 8
# %%
sigma = np.array([[s1**2, rho * s1 * s2], [rho * s1 * s2, s2**2]])
sigma_inv = np.linalg.inv(sigma)
# euclidean
l2_p1 = np.linalg.norm(p1 - mu)
l2_p2 = np.linalg.norm(p2 - mu)

# malahanobis
DM1 = np.sqrt(np.dot((p1 - mu).T, np.dot(sigma_inv, p1 - mu)))
DM2 = np.sqrt(np.dot((p2 - mu).T, np.dot(sigma_inv, p2 - mu)))
# La distancia teórica por encima de la cual consideramos outlier es
DM_teorica = np.sqrt(ss.chi2.ppf(0.99, 2))
result_outlier = 'P1' if DM1 > DM_teorica else 'P2' if DM2 > DM_teorica else None
# %%
print(f"Distancias euclideanas----------------------------")
print(f"L2_p1 = {l2_p1.round(2)} y L2_p2 = {l2_p2.round(2)}")
print(f"Distancias de Malahanobis-------------------------")
print(f"DM1 = {DM1.round(2)} y DM2 = {DM2.round(2)}")
print(f"El punto {result_outlier } es un outlier al {1-0.01} de confianza.")
