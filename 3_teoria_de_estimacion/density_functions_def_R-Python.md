| Función                                                                                    | Nombre          | Comando en Python                | Argumentos                             |
| ------------------------------------------------------------------------------------------ | --------------- | -------------------------------- | -------------------------------------- |
| $p(x)=\binom{n}{k}p^k(1-p)^{n-k}$                                                          | Binomial        | `binom.pmf(k, n, p)`             | $n$=`n`, $k$=`k`, $p$=`p`              |
| $p(x) = \frac{{e^{ - \lambda } \lambda ^k }}{k!}$                                          | Poisson         | `poisson.pmf(k, mu, loc=0)`      | $k$=`k`, $\lambda$=`lambda`            |
| $p(x)=\frac{1}{b-a}$                                                                       | Uniforme[^1]    | `uniform.pdf(x, loc, loc+scale)` | $x$=`x`, $a$=`loc`, $b$=`loc+scale`    |
| $p(x)=\frac{1}{\sigma\sqrt{2\pi \sigma}}\exp\left\{-\frac{(x-\mu)^2}{2\sigma^2} \right\} $ | Normal[^2]      | `norm.pdf(x, loc, scale)`        | $x$=`x`, $\mu$=`loc`, $\sigma$=`scale` |
| $p(x)=\lambda e^{-\lambda x};\ p(x)=\frac{1}{\lambda}e^{-x/\lambda}$                       | exponencial[^3] | `expon.pdf(x, loc, scale)`       | $x$=`x`, $\lambda$=`1/scale`           |

**Notas:**

[^1]: La función densidad uniforme por defecto tiene un rango entre [0, 1], pero con los argumentos `loc` y `scale` se pueden crear rangos [a, b].
[^2]: La normal por defecto tiene media, o $\mu$, de 0; y desviación estándar, $\sigma$, de 1, por lo que la función de densidad sería
$$
  p(x)=\frac{1}{\sqrt{2\pi}}\exp\left\{-\frac{x^2}{2}\right\}
$$
[^3]: La función de densidad exponencial tiene varias *parametrizaciones*. En `scipy.stats` la común es usando el parámetro `scale`, que es básicamente la desviación estándar (y, en la exponencial y en poisson, también la media). Esta parametrización por defecto corresponde a $p(x)=\frac{1}{\lambda}e^{-x/\lambda}$. El argumento `loc` no corresponde a un parámetro en particular de la exponencial, es simplemente una translación de la distribución. Por defecto es 0.

