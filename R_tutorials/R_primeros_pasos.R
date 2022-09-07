## Primeros pasos ----
"Hello world"
hw <- "Helo World"
print(hw)

log(4+ exp(0))

# Instalar paquetes
## No correr aun, tarda mucho
# install.packages('tidyverse') 
# Se pueden instalar en bulk

# NO CORRER
# pck <- c("tidyverse", "caret")
# install.packages(pck)

# Cargar una librería

library(tidyverse)
library(tidymodels)

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
FALSE == 0  # lógica
NA          # valor perdido
factor()    # factor

# Puedes comprobar qué tipo de variable es con class(x) o is.numeric().