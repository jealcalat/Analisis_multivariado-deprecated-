library(lattice)

# function f(x1,x2) = 2 * x1, for 0 < x1 < 1, 0 < x2 < 1
x1 <- seq(0, 1, 0.01)
x2 <- seq(0, 1, 0.01)
fx1x2 <- expand.grid(x1 = x1, x2 = x2)
fx1x2$z <- 2 * fx1x2$x1
wireframe(z ~ x1 * x2, data = fx1x2,
          scales = list(arrows = FALSE),
          xlim = c(-1, 2),
          ylim = c(0, 1),
          zlim = c(0, 3),
          shade = TRUE)

# function f(x1, x2) = exp(-(x1 + x2)) for x1, x2 > 0


x1 <- seq(0, 5, 0.01)
x2 <- seq(0, 5, 0.01)
fx1x2 <- expand.grid(x1 = x1, x2 = x2)
fx1x2$z <- exp(-(fx1x2$x1 + fx1x2$x2))

wireframe(z ~ x1 * x2, data = fx1x2,
          scales = list(arrows = FALSE),
          xlim = c(0, 6),
          ylim = c(0, 6),
          zlim = c(0, 1.5),
          shade = TRUE,
          screen = list(x = -70, y = -10))


