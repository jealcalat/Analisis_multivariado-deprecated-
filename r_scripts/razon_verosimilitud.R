
# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #
## EJEMPLO DE LR
# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #

# LR, lambda, para normal
lambda_fun <- function(x_bar) {
  exp(-(1 / 4) * (x_bar - 10)^2)
}

par(las = 1, mgp = c(2, 0.5, 0), tck = -0.017)
x_vec <- seq(2, 18, 0.001)
lx <- lambda_fun(x_vec)
plot(
  x_vec, lx,
  xlab = expression(bar(x)),
  ylab = expression(lambda(bar(x))),
  type = "l",
  main = "dist de lambda"
)
# notar que tiene centro en 10
# debemos hallar un lamda <= k
k <- max(lx[lx <= 0.2])
x1 <- x_vec[lx == k]
abline(h = k)
abline(v = x1)

# normal estandar
curve(dnorm(x), from = -3, to = 3, main = "Normal estandar")
alfa <- 0.05 / 2
abline(v = qnorm(p = c(alfa, 1 - alfa)))
# encontrar el cuantil (en x) correspondiente a un alfa de 0.05 para dos colas
# recordar que queremos hallar el cuantil en una curva simétrica, tal que
# ese cuantil cubra el (1-alfa)*100 del área.
qnorm(1 - alfa)
# el alfa lo obtenemos nuevamente así
2*(1-pnorm(1.9599))
# el área cubierta es obviamente la integral 1.96 - 1.96
pnorm(1.96) - pnorm(-1.96)
# o lo que es lo mismo
integrate(dnorm, mean = 0, sd = 1, lower = -1.96, upper = 1.96)

# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #

# ejercicio en clase--- 
## -2log(lambda) -- chisq

# prueba para Poisson con L(theta_hat)/L(theta_1, theta_2)
x_hat <- 20
y_hat <- 22
n <- 100
lambda_poiss <- function(x_hat, y_hat, n) {
  
  num_ <- n*(x_hat + y_hat)*log(0.5 * (x_hat + y_hat))
  denom <- (n*x_hat) * log (x_hat) + (n*y_hat) * log(y_hat)
  -2 * (num_ - denom)
}

l2log <- lambda_poiss(x_hat, y_hat, n) |> round(3)

alfa <- 0.01
crit_val <- qchisq(1-alfa, 1)

curve(dchisq(x, 1), 0, 20) |> round(3)
abline(v = crit_val)
abline(v = l2log, col = 'blue')

cat(sprintf("-2log(lambda) = %s,\n k (critical val) = %s", l2log, crit_val))

# concluimos que la media en los dos turnos difiere si -2log(lambda) >= crit_val
# aunque, en realidad, *rechazamos* H0


## :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# dependencia de n para el -2log(lambda) - ejemplo con normal
# para obtener el MLE de una normal
neg_log_like_normal <- function(media, x, sigma) {
  sum(-dnorm(x, mean = media, sd = sigma, log = T))
}

# dado 

nsims <- 1000
n_vec <- c(3, 10, 30, 300)
sigma <- 4
par(mfrow = c(2, 2), mar = c(3, 3, 2, 0), las =1)
for (n in n_vec) {
  LR_vec <- rep(NA, 100)
  
  for (i in 1:nsims) {
    set.seed(i)
    x <- rnorm(n, 10, sd = sigma)
    
    logL0 <- sum(log(dnorm(x, mean = 10, sd = sigma)))
    out <- nlm(neg_log_like_normal, 10, x = X, sigma = sigma)
    logL1 <- sum(log(dnorm(x, mean = out$estimate, sd = sigma)))
    LR_vec[i] <- -2 * (logL0 - max(logL0, logL1))
  }
  plot(density(LR_vec, from = 0, to = max(LR_vec), adjust = 2), main = sprintf("n = %s", n))
  curve(dchisq(x, 1), from = 0, to = max(LR_vec), add = TRUE, col = 2)
}
