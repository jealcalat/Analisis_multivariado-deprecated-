# usaremos el paquete datarium para extraer un conjunto de datos
# install.packages("datarium")

# cargamos los datos 'marketing'. Estos datos nos dicen el impacto que tienen
# medios como youtube, facebook y diarios en ventas
data("marketing", package = "datarium")

# inspeccionar los datos
head(marketing)
str(marketing)

# graficar las variables

# gráfico de dispersion
plot(marketing$youtube, marketing$sales)

# parece una relación quasi-lineal

# coeficientes usando las definiciones
# cov(x,y)/var(x)
b1 <- cov(marketing$youtube, marketing$sales) / var(marketing$youtube)
# b0 = y_barra - b1 * x_barra
# y = b0 + b1*x
# sales = b0 + b1 * youtube

b0 <- mean(marketing$sales) - b1 * mean(marketing$youtube)
b0
b1

# ahora creamos un modelo de regresión simple usando lm
form <- sales ~ youtube

model <- lm(form, data = marketing)
model
# la ecuación sería
# sales = 8.44 + 0.047*youtube

# estimaciones y pruebas de hipótesis
# primero, recordar dos conceptos clave:
# los residuales son la diferencia entre el ajustado y el observado
# los valores ajustados son los que obtenemos con los parámetros
params <- coef(model)

ajustados <- params[1] + params[2] * marketing$youtube
lines(marketing$youtube, ajustados, col = "red", lwd = 2)
# y_hat

plot(marketing$youtube, marketing$sales)
abline(model, col = "red", lwd = 2)

library(ggplot2)

ggplot(
  marketing,
  aes(x = youtube, y = sales)
) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)

residuales <- marketing$sales - ajustados


residuales2 <- resid(model)

# rss es la suma de residuales cuadrados
rss <- sum(residuales^2) #
# tamaño de la muestra
n <- nrow(marketing)

# intervalo de confianza para b1
# primero calculamos el error residual estándar, usando raiz (rss / (n-2))
rse <- sqrt(rss / (n - 2)) # estimador de sigma
# equivalente a var(residuales)
# hacemos una función para el se_b1 y se_b0

summary(model)

se_b0_fun <- function(rse, x, n) {
  mean_x <- mean(x)
  x_dev <- sum((x - mean_x)^2)
  sqrt(rse^2 * (1 / n + ((mean_x^2) / x_dev)))
}


s1_b1_fun <- function(rse, x, n) {
  mean_x <- mean(x)
  x_dev <- sum((x - mean_x)^2)
  sqrt(rse^2 / x_dev)
}

se_b1 <- s1_b1_fun(rse, marketing$youtube, n)
se_b1

se_b0 <- se_b0_fun(rse, marketing$youtube, n)

se_b1
se_b0

# podemos obtener varios estadísticos usando summary
summary(model)
sum_model <- summary(model)
# el Std. error nos muestra el error estándar para b1 y b0 que obtuvimos
# de forma manual antes
coeficientes <- as.data.frame(sum_model$coefficients)
coeficientes$`Std. Error`[2] # se_b1
coeficientes$`Std. Error`[1] # se_b0

# ahora, el IC 95%
# b1 +- t * se_b1
t_alfa <- qt(1 - 0.05 / 2, n - 2)
t_alfa
ci_b1 <- b1 + c(-1, 1) * 2 * se_b1
ci_b1
#
# # para el b0
#
# ci_b0 <- b0 + c(-1,1) * 2 * se_b0
# ci_b0

# existe un método para obtener esto en R
confint(model)

# Prueba de H0
# con t_crit
t_obs <- b1 / se_b1
alfa <- 0.05
# 1 - alfa/2 corresponde al 97.5 % del área de la dist-t;
# n - 2 es n - p parámetros
t_crit <- qt(1 - alfa / 2, df = n - 2)

print(
  ifelse(
    t_obs > t_crit, "Rechazar H_0", "No rechazar H0"
  )
)
# con p-val

pval <- 2 * (1 - pt(t_obs, n - 2))

# curva bajo la hipótesis nula
curve(dt(x, n - 2), -9, 19, n = 400)
# el t observado está muy lejos del 0
abline(v = t_obs, col = 2)

# de nuevo, toda esta información se obtiene con summary
summary(model)$coefficients

## Intervalos de predicción: ---------------------------------------------------
# Así como cuando ajustamos parámetros, tenemos intervalos de confianza para
# ese ajuste, cuando predecimos también lo hacemos con *incertidumbre*, por lo tanto
# un valor predicho en x* tiene un y* con un intervalo en donde y* podría caer
# al (1-alfa)*100 de confianza.

youtube_new <- 178
new_data <- data.frame(
  youtube = youtube_new
)
# calculamos el intervalo de confianza
predict(model, newdata = new_data, type = "response", interval = "confidence")
# y_promedio = b0 + b1*x_promedio
# ahora el intervalo de predicción
predict(model, newdata = new_data, type = "response", interval = "prediction")
# asignar la predicción (una matriz) a pred_new
pred_new <- predict(model,
  newdata = new_data,
  type = "response",
  interval = "prediction"
) |> as.data.frame()

pred_new <- as.data.frame(
  predict(model,
          newdata = new_data,
          type = "response",
          interval = "prediction"
  )
)

pred_new$upr

# graficar nuevamente datos originales
plot(
  marketing$youtube,
  marketing$sales,
  col = "grey80",
  # extender el rango en X y en Y
  xlim = range(marketing$youtube) * c(1, 1.5),
  ylim = range(marketing$sales) * c(1, 1.2)
)
# graficar valor predicho
points(youtube_new, pred_new$fit, col = "red")
# añadir intervalo de predicción
segments(
  x0 = youtube_new, x1 = youtube_new,
  y0 = pred_new$lwr, y1 = pred_new$upr,
  col = "blue"
)
# graficar segundo valor
youtube_new2 <- 390
new_data <- data.frame(
  youtube = youtube_new2
)
pred_new <- predict(model,
  newdata = new_data,
  type = "response",
  interval = "prediction"
) |>
  as.data.frame()
points(youtube_new2, pred_new$fit, col = "red")
segments(
  x0 = youtube_new2, x1 = youtube_new2,
  y0 = pred_new$lwr, y1 = pred_new$upr,
  col = "blue"
)

# comparemos intervalos de confianza y de predicción para diferentes valores de yt
youtube_new <- data.frame(youtube = seq(0, 450, 0.1))
conf_interval <- predict(
  model,
  newdata = youtube_new,
  interval = "confidence"
)

lines(youtube_new$youtube, conf_interval[, 2], col = "blue", lty = 2)
lines(youtube_new$youtube, conf_interval[, 3], col = "blue", lty = 2)

pred_interval <- predict(
  model,
  newdata = youtube_new,
  interval = "prediction"
)
lines(youtube_new$youtube, pred_interval[, 2], col = "orange", lty = 2)
lines(youtube_new$youtube, pred_interval[, 3], col = "orange", lty = 2)

# ahora visualizamos cómo se comporta el error conforme x se aleja de la media
error_newx <- function(x_new, x, n, rse) {
  pred_error <- (x_new - mean(x))^2
  sse <- sum((x - mean(x))^2)
  sqrt(
    rse^2 * (1 + 1/n + pred_error/sse)
  )
}

x_new <- seq(min(marketing$youtube), 800, 0.5)

error <- error_newx(x_new, marketing$youtube, n, rse)

plot(x_new, error, type = 'l')
abline(v = mean(marketing$youtube))
x_new[which.min(error)]
mean(marketing$youtube)
# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# regresión lineal múltiple -------------------------------------------

# sales = b0 + b1*youtube + b2*facebook + b3*newspaper
model_m <- lm(sales ~ youtube + facebook + newspaper, data = marketing)

summary(model_m)

# interpretación:
# para valores de youtube y newspaper fijos, el incremento en 1000 adicionales
# en facebook produce un incremento 0.189*1000 = 189 en unidades de ventas

## Predecir nuevos valores (valores promedio)
# usar colMeans para obtener los promedios por columna, luego trasponer
# luego convertir en dataframe y seleccionar solo las primeras 3 variables
new_data <- colMeans(marketing) |>
  t() |>
  as.data.frame() |>
  dplyr::select(1:3)
# usar perdict para obtener los estimados de sales usando new_data con el modelo2
predict(model_m, newdata = new_data, type = "response")

# ¿qué pasaria su no se gasta en facebook?
new_data$facebook <- 0
new_data$facebook <- 0 # fijar gasto de facebook en 0
predict(model_m, newdata = new_data, type = "response")
# y en youtube?
new_data <- colMeans(marketing) |>
  t() |>
  as.data.frame() |>
  dplyr::select(1:3)

# qué pasaría si no se gasta en youtube?
new_data$youtube <- 0 # fijar gasto de youtube
predict(model_m, newdata = new_data, type = "response")

# y en newspaper?
new_data$newspaper <- 0
new_data <- colMeans(marketing) |>
  t() |>
  as.data.frame() |>
  dplyr::select(1:3)
predict(model_m, newdata = new_data, type = "response")

# ¿Por qué si se fija fb en 0 el cambio en la respuesta es menor si su beta es mayor?

# El error en facebook es mayor que en youtube, por lo que el efecto sin ruido es mayor
# para youtube.
# Además---
# Es posible que haya una interacción entre youtube y facebook
# model selection and multimodel inference
model_m2 <- lm(sales ~ youtube + facebook + newspaper + youtube * facebook, data = marketing)
summary(model_m2)

AIC(model)
AIC(model_m)
AIC(model_m2)

# akaike information criterion
# balance entre qué tan buen predictor es un modelo, y su complejidad

# ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# sales = b0 + b1*youtube + b2*facebook + b3*newspaper
model_m <- lm(sales ~ youtube + facebook + newspaper, data = marketing)
# Prueba F
summary(model_m)

sum_model_m <- summary(model_m)

# suma de cuadrados totales (varianza total)
tss <- sum((marketing$sales - mean(marketing$sales))^2)
# suma de cuadrados residuales (varianza no explicada)
rss <- sum(residuals(model_m)^2)
# el numerador es la varianza explicada; denominador la no explicada
# p = 3, n = nobs(model_m)
# 
f_obs <- ((tss-rss)/3)/(rss / (n - 3 - 1))
f_obs
alfa = 0.05
f_crit <- qf(1-alfa, 3, n - 3 - 1)
f_crit



# valor p?

pf(f_obs, 3, n-3-1)

sum_model_m

curve(
  df(x, 3, n-3-1),
  0, 590, n = 700
)
abline(v = f_obs, col = 2)

# ¿cómo depende F de n?

n1 <- 10
n2 <- 200
p <- 6
curve(df(x, p, n1-p-1), 0, 10, col = 2)
curve(df(x, p, n2-p-1), add =TRUE, col = 'blue')


p <- 8
n_vec <- (p+2):100
f_hat <- sapply(n_vec, function(nf){qf(1-0.05, p, nf-p-1)})

plot(n_vec, f_hat, type = 'l', log = 'xy')

# par aun p fijo, la cantidad de muestra necesaria para F_crit desciende,
# es decir, conforme n crece, el F_obs necesario para probar H0 decrece.

# TODO
# ## ---------------------------------------------------------------------------
# 
# # ahora necesitamos hacer diagnóstico del modelo.
# # Recordar las asunciones:
# # 1. los errores (residuales) son independientes, cov(e_i, e_j) = 0
# # 2. los errores tienen la misma varianza
# # 3. los errores están distribuidos normalmente
# 
# 
# lines(marketing$youtube, ajustados)
# 
# # veamos cómo se comportan los residuos con respecto a los valores ajustados
# # dado que asumimos que los residuos
# par(mfrow = c(2, 2))
# plot(model)
