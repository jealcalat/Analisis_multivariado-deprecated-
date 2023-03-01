| Función                                                                                    | Nombre      | Comando en Python           | Argumentos                       |
| ------------------------------------------------------------------------------------------ | ----------- | --------------------------- | -------------------------------- |
| $p(x)=\binom{n}{k}p^k(1-p)^{n-k}$                                                          | Binomial    | ``                          | $n$=size, $k$=x, $p$=prob        |
| $p(x) = \frac{{e^{ - \lambda } \lambda ^k }}{k!}$                                          | Poisson     | `poisson.pmf(k, mu, loc=0)` | $k$=`k`, $\lambda$=`lambda`      |
| $p(x)=\frac{1}{b-a}$                                                                       | Uniforme    | `dunif(x, min, max)`        | $x$=`x`, $a$=min, $b$=max        |
| $p(x)=\frac{1}{\sigma\sqrt{2\pi \sigma}}\exp\left\{-\frac{(x-\mu)^2}{2\sigma^2} \right\} $ | Normal      | `dnorm(x, mean, sd)`        | $x$=`x`, $\mu$=mean, $\sigma$=sd |
| $p(x)=\lambda e^{-\lambda x};\ p(x)=\frac{1}{\lambda}e^{-x/\lambda}$                       | exponencial | `expon.pdf(x, loc, scale)`  | $x$=`x`, $\lambda$=`1/scale`     |

**Notas:**

La función de densidad exponencial tiene varias *parametrizaciones*. En `scipy.stats` la común es usando el parámetro `scale`, que es básicamente la desviación estándar (y, en la exponencial y en poisson, también la media). Esta parametrización por defecto corresponde a $p(x)=\frac{1}{\lambda}e^{-x/\lambda}$. El argumento `loc` no corresponde a un parámetro en particular de la exponencial, es simplemente una translación de la distribución. Por defecto es 0.