# ejercicio MLE poisson
#
set.seed(5)
px <- rpois(50, 3)
sum(px)

neg_ll_pois <- function(lambda, x) {
  l <- dpois(x, lambda, log = TRUE)
  -sum(l)
}

lambda_est <- nlm(neg_ll_pois, p = 17, x = px, iterlim = 500)$estimate
lambda_est
# simular: realizar 1000 simulaciones y obtener la media muestral x_barra
# y graficar un histograma

nsims <- 1000
x_barra_vec <- rep(NA, nsims)
sum_xi_vec <- rep(NA, nsims)
for (i in 1:nsims) {
  pois_temp <- rpois(50, lambda_est)
  x_barra_vec[i] <- mean(pois_temp)
  sum_xi_vec[i] <- sum(pois_temp)
}


par(las = 1, mfrow = c(1, 2))
hist(x_barra_vec)
hist(sum_xi_vec)
# notar que el valor más frecuente es 3 para lambda
mean(x_barra_vec)
# y 150 para la suma
mean(sum_xi_vec)
