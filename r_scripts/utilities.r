center <- function(x) x - mean(x)

plot_area_normal <- function(from_x, to_x, fill) {
  # valores para x y y en el área sombreada
  sx <- c(from_x, seq(from_x, to_x, 0.01), to_x)
  sy <- c(0, dnorm(seq(from_x, to_x, 0.01)), 0)
  # crear área sombreada con sx y sy
  polygon(
    sx, sy,
    col = fill
  )
}

plot_ellipse <- function(x, rad, colores) {
  # colors <- palette()[1:length(rad)]
  names(colores) <- rad
  for (r in rad) {
    car::ellipse(
      center = colMeans(x),
      shape = cov(x),
      radius = r,
      col = colores[r],
      fill = TRUE,
      fill.alpha = 0.1,
      segments = 150
    )
  }
}

sim_bivariate <- function(rho, sigma_vec, mu_vec, N, seed = 123) {
  sigma_1 <- sigma_vec[1]
  sigma_2 <- sigma_vec[2]
  Sigma <- matrix(
    c(
      sigma_1^2, rho * sigma_1 * sigma_2,
      rho * sigma_1 * sigma_2, sigma_2^2
    ),
    ncol = 2
  ) #+ 0.0001
  L <- t(chol(Sigma))
  # set.seed(seed)
  u <- matrix(rnorm(2 * N), 2, N) # 2 filas, N/2 columnas
  # sumar element-wise, mu1 + col_1, mu2 + col_2
  x <- (mu_vec + t(L %*% u))
  x
}
