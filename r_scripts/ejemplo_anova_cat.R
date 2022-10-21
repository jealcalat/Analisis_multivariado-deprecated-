# ANOVA ----
# Paso 1 ----
# H0:
# Las medias de los fertilizantes son iguales

# Paso 2 ----
# Las medias de los fertilizantes no son iguales

# Paso 3 ----
# La prueba estadística de H0 se hará con un nivel alfa de 0.05
alfa <- 0.05

# Paso 4 ---- Recolectar datos
# datos de crecimento de una planta usando 3 tipos de fertilizante
# y un grupo control sin ningún fertilizante
datos <- data.frame(
     Control = c(21, 19.5, 22.5, 21.5, 20.5, 21),
          F1 = c(32, 30.5, 25, 27.5, 28, 28.6),
          F2 = c(22.5, 26, 28, 27, 26.5, 25.2),
          F3 = c(28, 27.5, 31, 29.5, 30, 29.2)
)
datos
# Paso 4.1 ----
# Es bueno hacer visualización para darse una idea de qué está ocurriendo
# cargar tidyverse
library(tidyverse)
# convertir de wide a long (tidy)
datos_long <- datos |> 
  pivot_longer(cols = Control:F3, 
               names_to = 'Tratamiento', 
               values_to = 'Crecimiento')
datos_long
# visualización

ggplot(datos_long,
       aes(x = Tratamiento, 
           y = Crecimiento)) +
  geom_boxplot() +
  theme_bw()


# visualización de variabilidad

ggplot(datos_long,
       aes(x = Tratamiento, 
           y = Crecimiento)) +
  geom_point() +
  geom_hline(yintercept = mean(datos_long$Crecimiento), color = 'red') +
  theme_bw()

mean(datos_long$Crecimiento)
# para añadir las medias por grupo, podemos crear un segundo data.frame

col_means <- datos |>
  colMeans() |> 
  t() |> 
  as.data.frame() |> 
  pivot_longer(cols = Control:F3, 
               names_to = 'Tratamiento', 
               values_to = 'Crecimiento')

col_means <- datos |> 
  pivot_longer(cols = Control:F3, 
               names_to = 'Tratamiento', 
               values_to = 'Crecimiento') |> 
  group_by(Tratamiento) |>
  summarise(media_trat = mean(Crecimiento),
            cantidad = n(),
            rango_iq = IQR(Crecimiento),
            mediana = median(Crecimiento)
            )

col_means

# repetimos el gráfico y añadimos las medias grupales
ggplot(datos_long,
       aes(x = Tratamiento, y = Crecimiento)) +
  geom_point() +
  geom_hline(yintercept = mean(datos_long$Crecimiento), color = 'red') +
  # añadir medias grupales
  geom_point(data = col_means,
             mapping = aes(x = Tratamiento, y = media_trat),
             color = 'blue',
             shape = '-', size = 25) +
  theme_bw()

# Paso 5 ----
# Calcular el estadístico de prueba
# Primero, vamos a correr un modelo de regresión lineal, y luego compararemos
# los resultados

anv <- lm(Crecimiento~Tratamiento, data=datos_long)
summary(anv)

# Crecimiento = mu_control + b1 * F1 + b2*F2 + b3*F3

# qué es ese 21 en intercepto?

# repetimos el gráfico y añadimos las medias grupales
ggplot(datos_long,
       aes(x = Tratamiento, y = Crecimiento)) +
  geom_point() +
  geom_hline(yintercept = mean(datos_long$Crecimiento), color = 'red') +
  geom_hline(yintercept = 21, color = 'green') +
  # añadir medias grupales
  geom_point(data = col_means,
             aes(x = Tratamiento, y = media_trat),
             color = 'blue', shape = '-', size = 13) +
  theme_bw()

# el efecto del Control!
# ¿cuál es el efecto de F1, F2 y F3?

f1 <- 21 + 7.6
f2 <- 21 + 4.8667
f3 <- 21 + 8.2
# añado color al tratamiento para resaltar
ggplot(datos_long,
       aes(x = Tratamiento, y = Crecimiento, color = Tratamiento)) +
  geom_point() +
  scale_color_manual(name = 'Tratamiento', values = c('green', 'cyan', 'steelblue', 'navy')) +
  geom_hline(yintercept = mean(datos_long$Crecimiento), color = 'red') +
  geom_hline(yintercept = 21, color = 'green') +
  geom_hline(yintercept = c(f1, f2, f3), color = c('cyan', 'steelblue', 'navy')) +
  # añadir medias grupales
  # geom_point(data = col_means,
  #            aes(x = Tratamiento, y = media_trat),
  #            color = 'blue', shape = '-', size = 13) +
  theme_bw()

# Las medias intragrupales se obtienen con el intercepto más el efecto;
# por lo tanto, el efecto es el intercepto - media grupal

# para conocer las sumas de cuadrados:
anova(anv)
# lo que arroja un F de 27.46; el efecto del tratamiento es robusto y significativo

# Ahora hacemos todo a mano. Para obtener el F observado, necesitamos descomponer
# la variabilidad en explicada vs no explicada
# descomposición de variabilidad
# tss = variabilidad-tratamiento + variabilidad-residual

# y_ij - Y_global
tss <- sum((datos_long$Crecimiento - mean(datos_long$Crecimiento))^2)
tss

# la variabilidad del tratamiento es la suma de las desviaciones de la media
# de cada grupo con respecto a la media global, multiplicada por n_j

# n_j * (media_grupal - Media_Global)^2

sum_intragrupo <- datos_long |> 
  group_by(Tratamiento) |> 
  summarise(nj = n(),
            y_barra_j = mean(Crecimiento))

gmean <- mean(datos_long$Crecimiento)
gmean

tr_ss <- sum(sum_intragrupo$nj * (sum_intragrupo$y_barra_j - gmean)^2)
tr_ss

# finalmente, necesitamos la varianza residual (no explicada)

res_ss <- tss - tr_ss
res_ss
# también se puede obtener a partir del modelo 
sum(residuals(anv)^2)

# para convertirlos a varianzas (suma promedio de cuadrados) necesitamos los grados
# de libertad. Para tss, los grados de libertad es N - 1
N <- nrow(datos_long)
df_tss <- N-1
# para el tratamiento, tenemos 4 tratamientos - 1
df_trat <- 3
# los grados de libertad del error son los grados de libertad de tss - los de tratamiento
df_res <- df_tss - df_trat

# ahora podemos calcular la varianza explicada y la no explicada

var_exp <- tr_ss/df_trat
var_no_exp <- res_ss/df_res

# Paso 6 ----
# y el estadístico F es

F_obs <- var_exp/var_no_exp
F_obs

# el F_alfa o F_crit

F_crit <- qf(1-alfa, df1 = df_trat, df2 = df_res)
F_crit

# Paso 7 ----

print(
  ifelse(
    F_obs > F_crit, "Rechazar H0", "Aceptar H0"
  )
)

# O
p_val <- df(F_obs, df_trat, df_res)
p_val

print(
  ifelse(
    p_val < alfa, "Rechazar H0", "Aceptar H0"
  )
)


# Paso 8 ----
# Probar que el fertilizante F1 es mayor que Control

# alfa = 0.05
# alfa = 1 - 0.95
# alfa = 1 - (0.95 * 0.95)

# Pruebas de Tukey para comparaciones de medias
# Necesitamos computar un estadístico q de tukey, que tiene una distribución
# qtukey(1-alfa, tratamientos, grados de libertad residuales)
# Calculamos un estadístico 
# w = q_tukey * sqrt( (res_ss/df_res) / num_replicas )
q <- qtukey(1-0.05, 4, df_res)
w <- q * sqrt( (res_ss/df_res) / 6 )

# si una diferencia de medias es mayor que w, la diferencia es significativa

col_means

mean_f1 <- col_means |> 
  filter(Tratamiento == "F1") |> 
  pull(media_trat)

mean_control <- col_means |> 
  filter(Tratamiento == "Control") |> 
  pull(media_trat)

diff_means <- mean_f1 - mean_control

diff_means
w
# la diferencia es significativa

# Podemos hacerlo para todas las posibles diferencias de medias convirtiendo
# el obeto de lm en anova con la función aov
anv <- aov(anv) # Tukey-Cramer

# modelos mixtos, jerárquicos, multinivel

TukeyHSD(anv, conf.level = .99) # alfa= 0.01

# y podemos visualizar
tkdiff <- TukeyHSD(anv, conf.level = .95)
plot(tkdiff, las = 2)
