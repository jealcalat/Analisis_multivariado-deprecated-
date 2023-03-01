library(sfsmisc)
# fijar semilla aleatoria para reproducir resultado
set.seed(966)
rx <- rnorm(10000)
rx2 <- rx^2

# computamos la densidad de rx con la función density()
# que implementa kernel density estimation
den_rx <- density(rx)
# usaremos den_rx para construir una función con métodos de interpolación
fun_interpol <- approxfun(den_rx)
# ahora encontraremos la densidad que tendrían nuestros puntos rx originales
rx_den <- fun_interpol(rx)

# graficamos el histograma y la densidad para corroborar
hist(rx, freq = FALSE) # freq FALSE para graficar densidad
lines(den_rx, col = 'red')
# graficaremos los puntos rx_den que interpolamos para asegurarnos de que caen
# en la línea de densidad roja
points(rx, rx_den, cex = 0.6)

# ahora usaremos integración numérica para obtener el valor esperado E[X], que es
# la integral de x*f(x)dx, integrada en todo el rango de x
integrate.xy(rx, rx * rx_den)
# el anterior valor es próximo a la media con la variable original
mean(rx)
# ahora usaremos integración numérica para computar E[X^2], pero usando
# la densidad de rx original (rx_den, calculada en la línea 13)
integrate.xy(rx, rx_den * rx2)
# corroboramos que el valor es próximo a la media calculada de forma tipica
mean(rx2)

