# usaremos el paquete datarium para extraer un conjunto de datos
install.packages("datarium")

# cargamos los datos 'marketing'. Estos datos nos dicen el impacto que tienen
# medios como youtube, facebook y diarios en ventas
data("marketing", package = "datarium")

# inspeccionar los datos
head(marketing)

# graficar las variables

# gráfico de dispersion
plot(marketing$youtube, marketing$sales)

# parece una relación quasi-lineal

# coeficientes usando las definiciones
b1 <- cov(marketing$youtube, marketing$sales) / var(marketing$youtube)
b0 <- mean(marketing$sales) - b1 * mean(marketing$youtube)
b0
b1

# ahora creamos un modelo de regresión simple usando lm

model <- lm(sales ~ youtube, data = marketing)
model
# la ecuación sería
# sales = 8.44 + 0.047*youtube

# estimaciones y pruebas de hipótesis
# primero, recordar dos conceptos clave:
# los residuales son la diferencia entre el ajustado y el observado
# los valores ajustados son los que obtenemos con los parámetros
params <- coef(model)

ajustados <- params[1] + params[2] * marketing$youtube
residuales <- marketing$sales - ajustados

# rss es la suma de residuales cuadrados
rss <- sum(residuales^2)
# tamaño de la muestra
n <- nrow(marketing)

# intervalo de confianza para b1
# primero calculamos el error residual estándar, usando raiz (rss / (n-2))
rse <- sqrt(rss/(n-2))
# equivalente a var(residuales)
# hacemos una función para el se_b1 y se_b0
se_b0_fun <- function(rse, x, n) {
  mean_x <- mean(x)
  x_dev <- sum((x - mean_x)^2)
  sqrt( rse^2 * ( 1/n + ((mean_x^2) / x_dev) ))
  
}
s1_b1_fun <-function(rse, x, n) {
  mean_x <- mean(x)
  x_dev <- sum((x - mean_x)^2)
  sqrt(rse^2 / x_dev)
}
se_b1 <- s1_b1_fun(rse, marketing$youtube, n)
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
ci_b1 <- b1 + c(-1,1) * 2 * se_b1
ci_b1

# para el b0

ci_b0 <- b0 + c(-1,1) * 2 * se_b0
ci_b0

# existe un método para obtener esto en R
confint(model)

# Prueba de H0
# con t_crit
t_obs <- b1 / se_b1
alfa <- 0.05
# 1 - alfa/2 corresponde al 97.5 % del área de la dist-t;
# n - 2 es n - p parámetros
t_crit <- qt(1 - alfa/2, df = n - 2)

print(ifelse(
  t_obs > t_crit, "Rechazar H_0", "No rechazar H0"
))
# con p-val

pval <- 2*(1-pt(t_obs, n - 2))

# curva bajo la hipótesis nula
curve(dt(x, n-2), -9, 19, n = 400)
# el t observado está muy lejos del 0
abline(v = t_obs, col = 2)

# de nuevo, toda esta información se obtiene con summary
summary(model)$coefficients

# regresión lineal múltiple

model_m <- lm(sales ~ youtube + facebook + newspaper, data = marketing)

summary(model_m)

# interpretación:
# para valores de youtube y newspaper fijos, el incremento en 1000 adicionales
# en youtube produce un incremento 0.189*1000 = 189 en unidades de ventas

## Predecir nuevos valores (valores promedio)
# usar colMeans para obtener los promedios por columna, luego trasponer
# luego convertir en dataframe y seleccionar solo las primeras 3 variables
new_data <- colMeans(marketing) |> t() |> as.data.frame() |> dplyr::select(1:3)
# usar perdict para obtener los estimados de sales usando new_data con el modelo2
predict(model_m, newdata = new_data, type = 'response')

# ¿qué pasaria su no se gasta en facebook?
new_data$facebook <- 0 # fijar gasto de facebook en 0
predict(model_m, newdata = new_data, type = 'response')
# y en youtube?
new_data <- colMeans(marketing) |> t() |> as.data.frame() |> dplyr::select(1:3)

# qué pasaría si no se gasta en youtube?
new_data$youtube <- 0 # fijar gasto de youtube
predict(model_m, newdata = new_data, type = 'response')

# y en newspaper?
new_data$newspaper <- 0
new_data <- colMeans(marketing) |> t() |> as.data.frame() |> dplyr::select(1:3)
predict(model_m, newdata = new_data, type = 'response')

# ¿Por qué si se fija fb en 0 el cambio en la respuesta es menor si su beta es mayor?

# El error en facebook es mayor que en youtube, por lo que el efecto sin ruido es mayor
# para youtube.
# Además---
# Es posible que haya una interacción entre youtube y facebook

model_m <- lm(sales ~ youtube + facebook + newspaper + youtube*facebook, data = marketing)
summary(model_m)

## ---------------------------------------------------------------------------

# ahora necesitamos hacer diagnóstico del modelo.
# Recordar las asunciones:
# 1. los errores (residuales) son independientes, cov(e_i, e_j) = 0
# 2. los errores tienen la misma varianza
# 3. los errores están distribuidos normalmente


lines(marketing$youtube, ajustados)

# veamos cómo se comportan los residuos con respecto a los valores ajustados
# dado que asumimos que los residuos 
par(mfrow = c(2, 2))
plot(model)