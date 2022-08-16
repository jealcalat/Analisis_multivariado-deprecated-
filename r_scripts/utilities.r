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

scatter_plot <- function(x, y, fill = "navy", color = "red", ...) {
  plot(
    x,
    y,
    axes = FALSE,
    panel.first = {
      axis(1, col = 8, tck = -0.015, cex = 1.5)
      axis(2, las = 1, col = 8, tck = -0.015, cex = 1.5)
      grid(col = 8)
    },
    pch = 21,
    cex = 1.2,
    col = color,
    bg = fill,
    ...
  )
}


den_histogram <- function(x_dat,
                          side = 1,
                          fill = "#B3B3FF",
                          color = "red",
                          plot_limits = NULL,
                          density_limits = NULL,
                          amplify_max_density = 1.1,
                          density_line = TRUE,
                          add = FALSE,
                          axis = TRUE) {
  # Basado en

  if (class(plot_limits) == "NULL") {
    plot_limits <- range(x_dat)
  }

  x_dat <- x_dat[which(x_dat >= plot_limits[1] & x_dat <= plot_limits[2])]
  h <- hist(x_dat, breaks = "fd", plot = FALSE)
  x_base <- rep(h$breaks, each = 2)
  y_base <- c(0, rep(h$density, each = 2), 0)
  breaks_base <- h$breaks
  densities_base <- c(h$density, tail(h$density, 1))

  den <- KernSmooth::bkde(x_dat)
  

  if (class(density_limits) == "NULL") {
    density_limits <- c(0, max(h$density) * amplify_max_density)
  }

  variable_limits <- plot_limits

  if (side == 1) {
    xlims <- variable_limits
    ylims <- density_limits
    x <- x_base
    y <- y_base
    x0 <- breaks_base
    x1 <- breaks_base
    y0 <- rep(0, length(breaks_base))
    y1 <- densities_base
    x_den <- den$x
    y_den <- den$y
  }
  if (side == 2) {
    xlims <- density_limits
    ylims <- variable_limits
    x <- y_base
    y <- x_base
    y0 <- breaks_base
    y1 <- breaks_base
    x0 <- rep(0, length(breaks_base))
    x1 <- densities_base
    axis <- FALSE
    y_den <- den$x
    x_den <- den$y
  }

  if (!add) {
    plot(0, type = "n", xlim = xlims, ylim = ylims, axes = FALSE, ann = FALSE)
    if (axis) {
      axis(1, tck = -0.015, lwd = 2, col = "#525252", cex = 2)
      axis(2, tck = -0.015, lwd = 2, col = "#525252", cex = 2, las = 2)
    }
    polygon(x, y, col = fill, border = NA)
    if (density_line) {
      lines(
        x_den, y_den, # from = plot_limits[1], to = plot_limits[2]),
        col = color, lwd = 2
      )
    }
  }
}


# Layout
scatter_marginal <- function(x, y, color, fill, ...) {
  # guardar config original
  old_op <- par()
  layout(
    matrix(c(2, 0, 1, 3),
      nrow = 2,
      ncol = 2,
      byrow = TRUE
    ),
    widths = c(3, 0.5),
    heights = c(0.5, 3), respect = TRUE
  )
  par(mar = c(5.1, 4.1, 0, 0))
  scatter_plot(x, y, fill = fill, color = color, ...)
  par(mar = c(0, 4.1, 0, 0), bty = "n")
  den_histogram(x, side = 1, axis = FALSE, fill = fill, color = color)
  par(mar = c(5.1, 0, 0, 0), bty = "n")
  den_histogram(y, side = 2, axis = FALSE, fill = fill, color = color)
  # restablecer config original
  # par(old_op)
}
