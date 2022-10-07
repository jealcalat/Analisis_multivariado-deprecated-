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
# el Std. error nos muestra el error estándar para b1 y b0
coeficientes <- as.data.frame(sum_model$coefficients)
coeficientes$`Std. Error`[2]
coeficientes$`Std. Error`[1]

# ahora, el IC 95%
ci_b1 <- b1 + c(-1,1) * 2 * se_b1
ci_b1

# para el b0

ci_b0 <- b0 + c(-1,1) * 2 * se_b0
ci_b0

# existe un método para obtener esto en R
confint(model)

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