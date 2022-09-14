par(mgp = c(1.2, 0.25, 0))
options(repr.plot.width = 7, repr.plot.height = 5)
k <- 9
n <- 10
theta_1 <- 0.5
theta_2 <- 0.7
like_binom_plot(k, n, theta_2, theta_1)

# grid-search

theta <- seq(0, 1, 0.0001)

L <- dbinom(9, 10, theta)
plot(theta, L)

ind_max <- which.max(L)

theta[ind_max]

plot(theta, L)


# En la práctica, este método puede ser muy costoso. Imaginar, por ejemplo, 
# que se tiene que hacer una búsqueda para estimar 2 parámetros. Tendríamos que 
# hacer combinaciones del grid de ambos parámetros. Este suele ser el método de 
# fuerza bruta que se usa, en ocasiones, como primera aproximación o cuando no nos 
# funciona ninguna otra cosa.
#
# Es más eficiente usar un algoritmo de optimización, como `optimize()`. Tiene 
# los siguientes argumentos:

?optimize
k <- 9
n <- 10

L <- function(theta) dbinom(k, n, theta)
mle <- optimize(L, interval = c(0, 1), maximum = TRUE)

print(mle)


binom_mle <- function(k, n) {
  L <- function(theta) log(dbinom(k, n, theta))
  # usar solo interval entre 0 y 1 para theta
  # dado que buscamos un máximo, declaramos TRUE
  mle <- optimize(L, interval = c(0, 1), maximum = TRUE)
  mle
}
mle_theta <- binom_mle(9, 10)
mle_theta
# retorna dos valores: el valor que maximiza, y la fn objetivo (L)
# maximum corresponde al MLE, theta_hat. El valor de la objetivo
# variará en con respecto al valor encontrado antes porque omitimos el coeficiente binomial