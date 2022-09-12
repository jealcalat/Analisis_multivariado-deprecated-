## Primeros pasos ----
"Hello world"
hw <- "Helo World"
print(hw)

log(4+ exp(0))

# Asignación
# comandos: <-, =

suma_ab <- 7 + 8

suma_ab_igual = 7 + 8

a <- 6
b <- 7

rx <- rnorm(n = 10, mean = a, sd = sqrt(b))

# a <- 9
# aritmética

10/2 # división
a / 2 # división de un objeto asignado
a * 3 # multiplicación
vec_a <- c(6, 7, 8, 9, 10) # asignar, crear vector
sqrt(9)
sqrt(vec_a)
sum(vec_a)

sum_vec <- 0
for (i in 1:length(vec_a)) {
  sum_vec <- vec_a[i] + sum_vec
}
sum_vec

vec_a_cuad <- vec_a^2
vec_a^2

a %% 3
b %% 3

## Funciones en R (base)

sum(vec_a) / length(vec_a)
mean(x = vec_a)
vec_a <- c(vec_a, NA)
sd(x = vec_a, na.rm = TRUE)

# Instalar paquetes
## No correr aun, tarda mucho
# install.packages("tidyverse")
install.packages('ggExtra')
# Se pueden instalar en bulk

# NO CORRER
pck <- c("caret", "gridExtra", "car")
install.packages(pck)

# Cargar una librería

library(tidyverse)
library(caret)

# *********************************************************
# Los comentarios se marcan con #
# los comentarios no son evaluados
# a = 2 vs
a = 2
# datos básicos de R

1L          # entero
1.0         # numérico
"1"         # texto o "string"
TRUE == 1   # lógica

sum(c(TRUE, TRUE, FALSE))

FALSE == 0  # lógica
NA          # valor perdido
factor()    # factor

3 == 4 # igual que
3 < 4 # menor que
3 <= 4 # menor o igual
3 > 4 # mayor que
3 != 4 # diferente que

vec_a <- c(1, 2, 3, 10, 12)

vec_logical <- a <= vec_a
vec_a[vec_logical]
sum(vec_logical)
length(vec_logical)

# Puedes comprobar qué tipo de variable es con class(x) o is.numeric().

## Objetos en R

# Vectores
vec_a <- c(1, 2, 3, 4, "5") # coerción de num a chr
vec_a <- c(TRUE, FALSE, 2, 3)
print(vec_a)
class(vec_a)

# logico < num < chr < factor
vec_a <- c(1, 2, 3,5)
as.factor(vec_a)

# matrices

mat_x <- matrix(NA, nrow = 2, ncol = 2)
mat_x <- matrix(
  c(1, 2, 3, 4, 5, 6, 7, 8, 9),
  ncol = 3,
  byrow = TRUE
)

# subsetting usando [] 
mat_x[1, ] # primera fila
mat_x[ ,1] # primera columna

mat_x[3, 2] # tercera fila, segunda columna

vec_primera_fila <- mat_x[1, ]
vec_primera_fila[3] <- 9
vec_primera_fila
mat_x[1, 2] <- 0 # reemplazo in situ

mat_x

mat_x[1, 2] <- 'cero'
mat_x
# data.frame
df_ejemplo <- data.frame(
  v1 = 1:10,
  v2 = letters[1:10]
)
df_ejemplo

str(df_ejemplo)

# subsetting de data.frames es igual que en matrices

df_ejemplo[1, ] # primera fila
df_ejemplo[ ,1] # primera columna
df_ejemplo[1, 2] # celda de la primera fila, segunda columna

