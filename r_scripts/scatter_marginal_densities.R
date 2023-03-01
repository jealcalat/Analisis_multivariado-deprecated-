red_light <- "#be1b1b75"
blue_light <- "#B3B3FF"
green_light <- "#77f475"


scatter_plot <- function(x, y, fill = "navy", color = "red", plot_grid = FALSE,...) {
  plot(
    x,
    y,
    axes = FALSE,
    panel.first = {
      axis(1, col = 8, tck = -0.015, cex = 1.5)
      axis(2, las = 1, col = 8, tck = -0.015, cex = 1.5)
    },
    pch = 21,
    cex = 1.2,
    col = color,
    bg = fill,
    ...
  )
  if (plot_grid) grid(col = 8)
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
  # Basado en https://osf.io/bv8fr

  if (class(plot_limits) == "NULL") {
    plot_limits <- range(x_dat)
  }

  x_dat <- x_dat[which(x_dat >= plot_limits[1] & x_dat <= plot_limits[2])]
  h <- hist(x_dat, breaks = "fd", plot = FALSE)
  x_base <- rep(h$breaks, each = 2)
  y_base <- c(0, rep(h$density, each = 2), 0)
  breaks_base <- h$breaks
  densities_base <- c(h$density, tail(h$density, 1))
  # kernel density
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
  par(old_op)
}