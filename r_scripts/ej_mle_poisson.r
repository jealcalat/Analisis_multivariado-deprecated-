# esta simulacion produce exactamente datos como los del problema
set.seed(5)
n <- 50
λ <- 3
prx <- rpois(n, λ)
hist(prx, freq = FALSE)

neg_log_like_pois <- function(x, lambda) {
  # log true para log transformar
  ll <- dpois(x, lambda = lambda, log = TRUE)
  # log like negativa
  -sum(ll)
}

# como parametro inicial tomamos la desv de prx
par_inicial <- sd(prx)
# colocamos los argumentos de nlmQ
est_coef <- nlm(f = neg_log_like_pois, p = par_inicial, x = prx)
est_coef

# experimentos Monte Carlo
# cómo explorar esta solución? podemos realizar simulaciones
# con valores aleatorios, podemos saber si en 'diferentes' circunstancias
# podríamos obtener datos similares a prx. En particular, si el estimador
# MLE de λ es la media, podemos probarlo simulando el experimento aleatorio
# de n=50, lambda=media, nsim veces y ver qué tan frecuentemente
# encontraríamos resultados como los observados con el parámetro que estimamos
nsim <- 1500
vec_sum_xi <- rep(NA, nsim)
vec_mean <- rep(NA, nsim)

for (i in 1:nsim) {
  # usamos el estimador encontrado con MLE numerico
  rx_tmp <- rpois(n, est_coef$estimate)
  vec_mean[i] <- mean(rx_tmp)
  vec_sum_xi[i] <- sum(rx_tmp)
}

par(las = 1, mfrow = c(1, 2))
# graficamos las medias; 3 es el valor mas frecuente?
hist(vec_mean)
# graficamos la suma; 150 es el mas frecuente?
hist(vec_sum_xi)

mean(vec_mean)
mean(vec_sum_xi)

# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #
## EJEMPLO DE LR
# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: #


lambda_fun <- function(x_bar) {
  exp(-(1 / 4) * (x_bar - 10)^2)
}

par(las = 1)
x_vec <- seq(2, 18, 0.001)
lx <- lambda_fun(x_vec)
plot(
  x_vec, lx,
  xlab = expression(bar(x)),
  ylab = expression(lambda(bar(x))),
  type = "l"
)
# notar que tiene centro en 10
# debemos hallar un lamda <= k
k <- max(lx[lx <= 0.2])
x1 <- x_vec[lx == k]
abline(h = k)
abline(v = x1)

# normal estandar
curve(dnorm(x), from = -3, to = 3)
alfa <- 0.05 / 2
abline(v = qnorm(p = c(alfa, 1 - alfa)))

qnorm(1 - alfa)
