La distribución exponencial es una distribución de probabilidad continua que se utiliza comúnmente para modelar el tiempo entre eventos que ocurren de forma aleatoria e independiente a una tasa media constante.

Supongamos que tenemos una muestra aleatoria de n observaciones de una distribución exponencial con un parámetro desconocido λ. La función de densidad de probabilidad (pdf) de la distribución exponencial se define como:

$f(x|\lambda) = \lambda e^{-\lambda x}$ para $x > 0$ y $0$ en otro caso.

La función de verosimilitud para la muestra es el producto de la pdf para cada observación:

$L(\lambda | x_1, x_2, ..., x_n) = \prod_{i=1}^{n} \lambda e^{-\lambda x_i} = \lambda^n e^{-\lambda\sum_{i=1}^{n}x_i}$

La función de log-verosimilitud se obtiene al tomar el logaritmo natural de la función de verosimilitud:

$\ln L(\lambda | x_1, x_2, ..., x_n) = n \ln \lambda - \lambda \sum_{i=1}^{n} x_i$

El estimador de máxima verosimilitud de λ es el valor de λ que maximiza la función de verosimilitud o, equivalentemente, la función de log-verosimilitud. Tomando la derivada de la función de log-verosimilitud con respecto a λ y estableciéndola igual a cero, obtenemos:

$\frac{d}{d\lambda}\ln L(\lambda | x_1, x_2, ..., x_n) = \frac{n}{\lambda} - \sum_{i=1}^{n}x_i = 0$

Resolviendo para λ, obtenemos:

$\hat{\lambda}{MLE} = \frac{n}{\sum{i=1}^{n}x_i}$

Así, el estimador de máxima verosimilitud de λ es el recíproco de la media muestral.

Aquí hay un ejemplo de estimación de máxima verosimilitud para la distribución exponencial:

Supongamos que tenemos una muestra de 5 observaciones de una distribución exponencial con un parámetro desconocido λ:

$x_1 = 0.7, x_2 = 1.2, x_3 = 0.5, x_4 = 2.1, x_5 = 1.8$

La función de verosimilitud para la muestra es:

$L(\lambda | x_1, x_2, x_3, x_4, x_5) = \lambda^5 e^{-\lambda(x_1+x_2+x_3+x_4+x_5)} = \lambda^5 e^{-\lambda(6.3)}$

La función de log-verosimilitud es:

$\ln L(\lambda | x_1, x_2, x_3, x_4, x_5) = 5 \ln \lambda - \lambda(6.3)$

Tomando la derivada de la función de log-verosimilitud con respecto a λ y estableciéndola igual a cero, obtenemos:

$\frac{d}{d\lambda}\ln L(\lambda | x_1, x_2, x_3, x_4, x_5) = \frac{5}{\lambda} - 6.3 = 0$

Solucionando para $\lambda$ tenemos:

$\hat{\lambda}_{MLE} = \frac{5}{6.3} \approx 0.7937$

