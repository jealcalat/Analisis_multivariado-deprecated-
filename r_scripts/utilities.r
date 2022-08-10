plot_area_normal <- function(from_x, to_x, fill = "#B3B3FF") {
  # valores para x y y en el área sombreada
  sx <- c(from_x, seq(from_x, to_x, 0.01), to_x)
  sy <- c(0, dnorm(seq(from_x, to_x, 0.01)), 0)
  # crear área sombreada con sx y sy
  polygon(
    sx, sy,
    col = fill
  )
}
