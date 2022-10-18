packages <- c("tidyverse",   # data manipulation and visualization
              "carData",     # data set to obtain professor's 9-month salary
              "broom",       # nice table format of cofficients from lm()
              "ggrepel",     # ggplot extension to repel text and extra features
              "glue",        # concatentate strings and alias
              "plot3D",      # plot 3D figures
              "RColorBrewer" # load color palettes
)
xfun::pkg_attach2(packages, message = F)
n_round <- 3

obtain_cost <- function(y, x, b) {
  y_pred <- x %*% b
  e <- y - y_pred
  se <- e^2
  mse <- mean(se)
  return(mse)
}

X <- model.matrix(~ x)


n_sample <- 20000
df_gd <- tibble(
  int = sample(seq(-40, 20, 0.1), n_sample, T),
  slope = sample(seq(-100, 100, 0.1), n_sample, T)
) %>%
  rowwise() %>%
  mutate(cost = obtain_cost(y, X, b = c(int, slope)))

y <- as.matrix(y)


scatter3D(x = df_gd$int,
          y = df_gd$slope,
          z = df_gd$cost,
          xlab = "intercept",
          ylab = "slope",
          zlab = "cost (mse)",
          col = ramp.col(col = sort(RColorBrewer::brewer.pal(9, "Blues"), decreasing = F),
                         n = length(unique(df_gd$cost))),
          colkey = F,
          phi = 10,
          theta = 45,
          main = "Gradient Descent (3D View)"
)


ggplot(df_gd, aes(slope, int, color = cost)) +
  geom_point() +
  geom_point(data = subset(df_gd, cost == min(cost)), color = "black", shape = 21, alpha = .5) +
  geom_text_repel(
    data = subset(df_gd, cost == min(cost)),
    mapping = aes(label = paste0("min(cost) = ", round(cost, n_round), "\nintercept = ", round(int, n_round), "\nslope = ", round(slope, n_round))),
    nudge_y = 30000,
    nudge_x = 1000,
    box.padding = 1.5,
    point.padding = 0.5,
    segment.size = 0.2,
    segment.color = "black",
    color = "black"
  ) +
  labs(
    title = "Gradient Descent (2D View)",
    y = "intercept",
    color = "cost (mse)"
  ) +
  scale_color_distiller(palette = "Blues") +
  theme_minimal()


subset(df_gd, cost == min(cost))
lm(y ~ x)
