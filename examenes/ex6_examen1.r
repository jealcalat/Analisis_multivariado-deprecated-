mu <- c(1, 1)
p1 <- c(4, 15)
p2 <- c(4, -13)
rho <- -0.6
s1 <- 2
s2 <- 8
alfa <- 0.01
# definir sigma
sigma <- matrix(c(s1**2, rho * s1 * s2, rho * s1 * s2, s2**2),
  nrow = 2, byrow = TRUE
)
# sigma inversa
sigma_inv <- solve(sigma)
# distancias euclideanas
l2_p1 <- sqrt(sum((p1 - mu)^2))
l2_p2 <- sqrt(sum((p2 - mu)^2))

# distancias de Malahanobis
DM1 <- sqrt(
  t(p1 - mu) %*% sigma_inv %*% (p1 - mu)
)

DM2 <- sqrt(
  t(p2 - mu) %*% sigma_inv %*% (p2 - mu)
)

DM_teorica <- qchisq(1 - alfa, 2) |> sqrt()

print(
  sprintf(
    "Las distancias de Malahanobis son dM1: %0.3f; dM2: %0.3f", DM1, DM2
  )
)

print(
  sprintf(
    "El valor crítico con alfa = 0.01 para la chi-cuadrada es %0.3f", 
  )
)

print(
  sprintf(
    "Por lo tanto, el %s es el único outlier al 1-alfa=0.99 de confianza", ifelse(DM1 >= DM_teorica, "P1", "P2")
  )
)
