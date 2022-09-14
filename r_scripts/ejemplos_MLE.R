x <- c(115L, 122L, 130L, 127L, 149L, 160L, 152L, 138L, 149L, 180L)
x <- as.numeric(x)
neg_log_lik_gaussian <- function(mu,sigma) {
  -sum(dnorm(x, mean=mu, sd=sigma, log=TRUE))
}

log_lik_gaussian <- function(theta, x) {
  sigma <- exp(theta[2])
  mu <- ifelse(theta < 10, theta*2, theta)
  l <- dnorm(x, mean=mu, sd=sigma)
  sum())
}

stats4::mle(neg_log_lik_gaussian, start = c(mu=20, sigma=5), 
            method = 'SANN', control=list(maxit=300e4))

coef <- stats4::mle(neg_log_lik_gaussian, start = c(mu=90, sigma=10), method = 'BFGS')

optim(c(102,19), fn = log_lik_gaussian, x=x, method = 'BFGS')

pars <- coef@coef

pars <- stats4::mle(neg_log_lik_gaussian, start = pars, method = 'BFGS')@coef
stats4::mle(neg_log_lik_gaussian, start = pars, method = 'BFGS')

mean(x)
sd(x)

(sum((x-mean(x))^2)/(length(x) - 1)) |> sqrt()


rate_fit_R <- fitdistr(x,'normal')


neg_log_lik_gaussian <- function(theta, x) {
  -sum(dnorm(x, theta[1], theta[2], log=TRUE))
}

theta.start <- c(x[1], mean(x[1:2]))

nlm(neg_log_lik_gaussian, theta.start, x=x, iterlim = 1e5)

set.seed(145)
mu_real <- 50
sd_real <- 5
rx_sim <- rnorm(100, mu_real, sd_real)

mle_nlm <- nlm(neg_log_lik_gaussian, c(rx_sim[1], IQR(x)/2), x = rx_sim, iterlim = 1000)

coefs <- mle_nlm$estimate

hist(rx_sim, freq = FALSE, ylim = c(0, 0.1))
curve(dnorm(x, mean = coefs[1], sd = coefs[2]),
      col = 'red', lwd = 2,
      from = 10, to = 90, add=TRUE)
# simulación de diferentes valores aleatorios

nsims <- 100
n <- length(rx_sim)
for (i in 1:nsims) {
  rx <- rnorm(n, mean = coefs[1], sd = coefs[2])
  lines(density(rx, from = 0, to = 100), lwd = 0.1)
}
