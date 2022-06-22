# R: una introducción rápida #

<div class="alert alert-block alert-info"> <b>NOTA:</b> Modificado de <a href="https://github.com/karoliskoncevicius/tutorial_r_introduction"> karoliskoncevicius</a> </div>

Este artículo se enfoca en conceptos específicos de R como vectorización, reciclaje, creación de subconjuntos, matrices y objetos data.frame.
Se omiten las sentencias de control y las declaraciones de función/objeto.

## Tipos ##

R almacena datos en varios tipos de objetos diferentes.
A continuación se muestran algunos objetos de diferentes tipos:

```r
TRUE              # lógico
1L                # entero
1                 # double
1+0i              # complejo
"one"             # caracter
```

Algunos de estos tipos tienen valores con un significado especial:

```r
NaN           # double "no es un número"
Inf           # double "infinito"
-Inf          # double "infinito negativo"
NA            # valor lógico "faltante"
NA_integer_   # valor "faltante" entero
NA_real_      # double valor "faltante"
NA_complex_   # valor complejo "faltante"
NA_character_ # carácter "falta" valor
NULL          # variable especial sin tipo
```

Además, R también usa otros tipos más complejos: `raw`, `list`, `environment`, `closure`.


## Operadores ##

Para manipular y combinar objetos, R tiene varios operadores estándar:

```r
+    # adición (suma)
-    # resta
/    # división
*    # multiplicaión
^    # potencia, como 2^2
**   # notación alternativa para potencia, como 2**2
!    # negación
&    # lógico 'y' (and)
|    # lógico 'o' (or)
==   # igual
!=   # no igual
>    # mayor que
>=   # mayor o igual
<    # menos que
<=   # menor que o igual
&&   # versión escalar de lógica y
||   # versión escalar de lógica o
```

Los tipos y operadores se pueden combinar en un formato infijo estándar:

```r
TRUE |  FALSE   # TRUE
   2 +  2       # 4
   3 *  10      # 30
3+0i +  0+1i    # 3+1i
   3 == 10      # FALSE
   4 <  Inf     # TRUE
 "a" != "b"     # TRUE
```

Algunos operadores se utilizan con un solo objeto:

```r
!TRUE           # FALSE
-10L            # -10
```

Algunos operadores pueden combinar diferentes tipos, proyectando el resultado al tipo más general:

```r
TRUE + 1L     # 2
  2L * 2.2    # 4.4
   2 & TRUE   # TRUE
   0 & TRUE   # FALSE (0 se trata como FALSO, cualquier otro número como VERDADERO)
```

Los valores de tipo especial se devuelven en circunstancias especiales:

```r
   10 / 0       # Inf
   -2 / 0       # -Inf
    0 / 0       # NaN
-1+0i / 0       # NaN+NaNi
```

Si falta un valor, el operador determinará si se puede conocer el resultado:

```r
1^NA            # 1
2^NA            # NA
NA^0            # 1

TRUE  | NA      # TRUE
TRUE  & NA      # NA
FALSE | NA      # NA
FALSE & NA      # FALSE
```

Cuando se utilizan múltiples operadores dentro de una expresión, su orden se determina por precedencia.

```r
2 + 2 / 2       # resultado = 3, porque la división tiene mayor precedencia
```

Dado que los símbolos disponibles en el teclado no son suficientes para cubrir todos los operadores necesarios, otros operadores menos utilizados se definen rodeándolos con un símbolo de porcentaje `%`:

```r
%/%             # División entera
%%              # residuo (resto) después de la división entera (módulo)

27 %/% 24       # resultado = 1
27 %%  24       # resultado = 3
```

## Variables ##

Los nombres de variables deben comenzar con un punto o una letra y contener solo letras, números, puntos y guiones bajos.
No pueden sobrescribir valores especiales existentes como `NA` y `TRUE`.
Se pueden usar tres operadores de asignación para lograr lo mismo, pero `<-` es preferido:

```r
x <- 2
x =  2 
2 -> x
```

Además, R permite definir identificadores "no sintácticos".
Los nombres de variables estándar deben seguir reglas definidas, pero las comillas graves obligan a que cualquier cadena se evalúe como un identificador:

```r
x   <- 1
2   <- 1   # error
`2` <- 1   # pasa por alto la evaluación normal y trata "2" como nombre de variable

x          # forma estándar de referirse a la variable llamada "x"
`x`        # se refiere a la misma variable
2          # objeto 2 de tipo doble
`2`        # se refiere a la variable no sintáctica "2"
```


## Llamada de función (function call) ##

Las funciones se llaman escribiendo el nombre de la función y paréntesis con una lista de parámetros pasados.
Los parámetros se pueden especificar por su posición o por su nombre.

```r
sqrt(3)
sqrt(x = 3)
```

Todos los operadores demostrados anteriormente también son funciones y se pueden llamar de la misma manera:

```r
`+`(2, 3)                 # 2 + 3
`|`(x = TRUE, y = FALSE)  # x | y
`!`(TRUE)                 # !TRUE
```

La asignación en sí también es una llamada de función:

```r
`<-`("newvar", 2)  # crea una variable "newvar"
`=`("newvar", 2)   # lo mismo
```

Algunas funciones que habrían sido útiles hasta ahora:

```r
ls()      # lists all assigned variables
typeof()  # returns the type of an object
```


## Obteniendo ayuda ##

Las funciones implementadas en R tienen páginas de documentación que se pueden buscar a través de otra función: `help()`:

```r
help(sum)
help(`<-`)
help(help)
?sum          # atajo para llamar a ayuda()
??sum         # busca todos los resultados que coincidan con 'sum'
```


## Vectores ##

Casi todos los objetos en R son vectorizados: pueden contener múltiples elementos y tienen un atributo llamado "longitud".

```r
length(NaN)
length(1)
length("what")  # la cadena no es un vector, sino un elemento
```

Un vector con múltiples elementos se crea con la función combinar, `c()`:

```r
c(-1L, 0L, 1L)
c(1+1i, -1+3i)
c(TRUE, FALSE, TRUE)
c("a", "b", "any string")
```

`c()` se puede usar para combinar vectores entre sí:

```r
vec1 <- c(1, 2)
vec2 <- c(2, 3)
c(vec1, vec2)
c(c(1,2), c(2,3))  # lo mismo
c(c(1,2,2,3))      # lo mismo
c(1,2,2,3)         # lo mismo
```

Una secuencia de enteros creciente/decreciente se puede crear usando un atajo: `:`

```r
1:2
10:1
-100:100
```

Cuando diferentes tipos son combinados, el vector resultante toma al tipo más general, un atributo que se llama "coerción":

```r
c(TRUE, 1L)               # integer
c(TRUE, 1)                # double
c(1L, 1+1i)               # complex
c(TRUE, "A")              # character
c(NA_integer_, NA_real_)  # double
```

La mayoría de los operadores, cuando se aplican a vectores, aplican la operación a cada elemento de forma separada (elementwise):

```r
x <- c(1, 2, 3)
y <- c(0, 10, 1)

x + 1     # 2 3 4
x + y     # 1 12 4
x > 2     # FALSE FALSE TRUE
x > y     # FALSE TRUE FALSE
```

Muchas funciones funcionan con vectores también:

```r
x <- c(1, 2, 3, 4, 5)
y <- c(2, 1, 3, 1, 5)

mean(x)
sum(y)
log2(x)
cor(x, y)
paste(x, y)
```

Los vectores pueden estar vacíos (longitud 0):

```r
logical()
integer()
double()
character()
complex()

length(complex())
length(c(numeric(), numeric(), numeric()))
```

Los elementos dentro de un vector pueden tener nombres:

```r
x <- c(a=1, b=2, c=3, d=4)
names(x) # retorna "a" "b" "c" "d"
```

Los nombres de los elementos no necesitan ser únicos:

```r
x <- c(a=1, b=2, b=3, d=4)
names(x)
```


## Recycling ##

R puede aplicar operadores binarios sobre vectores de distinta longitud, en cuyo caso se produce un reciclaje: el vector más corto se amplía hasta igualar la longitud del más largo reciclando sus elementos a partir del primero:

```r
x <- c(1, 1, 1, 1)
y <- c(0, 1)

        # original       después de reciclar   resultado
x + y   # x = 1 1 1 1    x = 1 1 1 1           1 2 1 2
        # y = 0 1        y = 0 1 0 1
```

El reciclaje ayuda a escribir expresiones vectoriales comunes de elemento a elemento sin recurrir a los bucles:

```r
# resta 1 a cada elemento
x <- c(1, 2, 3, 4)
x - 1

# revisa si cada elemento es mayor a 2 (retorna lógico)
x <- c(1, 2, 3, 4)
x > 2

# convierte cada segundo elemento de x en 0
x <- c(1, 2, 3, 4)
y <- c(0, 1)
x * y
```

Cuando el vector más largo no es un múltiplo del más corto - el reciclaje tiene lugar pero se muestra una advertencia:

```r
c(1, 2, 3) - c(0, 1)   # resultado: 1 1 3

# Warning message:
# In c(1, 2, 3) - c(0, 1) :
#   longer object length is not a multiple of shorter object length
```


## Creación de subconjuntos (subsetting) ##

Un vector puede ser tratado como un array de elementos, por lo que podríamos querer subconjuntarlo seleccionando sólo una fracción de esos elementos.
En R esto se realiza utilizando el operador `[`.

```r
x <- c(10, 20, 30, 40)
x[1]
```

Los elementos se pueden seleccionar especificando las posiciones deseadas (la numeración en R empieza por el índice 1).

```r
x <- c(10, 20, 30, 40)

x[4]
x[1:2]
x[0]       # selecciona "nada" - devuelve un vector vacío
x[c(1,1)]  # el mismo elemento puede ser seleccionado muchas veces
x[5]       # NA (no existe un quinto elemento de x)
```

Los elementos pueden ser seleccionados especificando las posiciones que deben ser descartadas:

```r
x <- c(10, 20, 30, 40)

x[-1]
x[c(-1,-3)]
x[c(-1,-1)]  # el mismo elemento es removido dos veces
x[-5]        # doesn't change x in any way
```

Los elementos pueden ser seleccionados especificando `TRUE` si el elemento debe ser devuelto, y `FALSE` en caso contrario:

```r
x <- c(10, 20, 30, 40)

x[c(TRUE, FALSE, FALSE, FALSE)]
x[c(TRUE, TRUE, FALSE, TRUE)]
x[c(FALSE, TRUE)]               # c(FALSE, TRUE) es reciclado, retorna elementos pares

# ejemplo interesante
x[x > 20]  # 1) x > 20 compara cada elemento de x con 20
           # 2) x > 20 crea in-place un vector lógico (dentro de corchetes)
           # 3) el vector lógico de TRUE y FALSE se usa para subsetting
           # 4) como resultado, solo los elementos de x mayores que 20 son retornados
```

Los elementos se pueden seleccionar por su nombre.

```r
x <- c(a=10, b=20, c=30, d=40)

x["a"]
x[c("a", "b")]
x[c("e")]      # NA - no existe elemento llamado 'e'
x[-c("a")]     # error, esta sintaxis no se puede utilizar para soltar elementos

# cuando los nombres no son únicos se devuelve el primer elemento coincidente
x <- c(a=10, b=20, b=30, d=40)

x["b"]         # 20
```

La selección vacía selecciona todos los elementos:

```r
x <- c(10, 20, 30, 40)

x[]
```


## Sustitución ##

Los elementos de un vector pueden ser reemplazados utilizando la sintaxis de indexación con una asignación.

```r
x <- c(10, 20, 30, 40)
x[1] <- 0                  # reemplaza el primer elemento con 0
x
```

Reemplazar por índice:

```r
x <- c(10, 20, 30, 40)

x[4] <- c(51)
x[c(1,3)] <- c(12, 32)
x[0]  <- 0                 # no hace nada
x[5]  <- 50                # añade "z" a la 5ta posición del vector
x[10] <- 100               # añade "z" a la 10ma posición, añade NA a la 6:9na
```

Sustitución por exclusión de posiciones:

```r
x <- c(10, 20, 30, 40)

x[-c(1,2,3)] <- 41
x[-1] <- c(22,32,43)
x[-5] <- 100               # reemplaza todos los elementos
```

Sustituir por la indexación lógica:

```r
x <- c(10, 20, 30, 40)

x[c(TRUE, FALSE, TRUE, FALSE)] <- c(11,31)
x[c(TRUE, TRUE, TRUE, FALSE)] <- c(11,31)  # c(11, 31) serán reciclados
x[c(FALSE, TRUE)] <- c(22,42)              # c(FALSE TRUE) serán reciclados
x[x < 10] <- NA
```

Sustituir por nombre:

```r
x <- c(a=10, b=20, c=30, d=40)

x["b"] <- 21
x[c("a","d")] <- c(11,41)
x["z"] <- 2                # añadirá un nuevo elemento llamado "z"

# cuando los nombres no son únicos - se sustituye el primer elemento coincidente
x <- c(a=10, b=20, b=30, d=40)

x["b"] <- 21               # reemplaza b=20 element
```

Una asignación vacía es un atajo para reemplazar todos los elementos:

```r
x <- c(10, 20, 30, 40)

x   <- 0  # sustituye x con 0
x[] <- 0  # sustituye todos elementos of x con 0
```

Después de la sustitución, si es necesario, el vector se convierte al tipo más general:

```r
x <- c(1, 2, 3, 4)  # x es double
x[4] <- "e"         # x es ahora caracter
```

## Tipo lista ##

En un vector todos los elementos tienen el mismo tipo.
Las listas pueden almacenar múltiples elementos de diferentes tipos.

```r
list(1L, 0, "a", TRUE)  # no hay coerción a caracteres
```

Dado que las listas pueden almacenar vectores, los elementos de una lista pueden tener cualquier longitud:

```r
l <- list(c("a","b"), c(TRUE, FALSE), 1:100)

length(l)  # la longitud es el número de elementos en la lista: 3
```

La lista puede almacenar otras listas dentro de sí misma:

```r
list(list(1, 3+0i), list("a"))
list(list(1, 3+0i), "a")        # una lista puede tener tanto listas como vectores simples
list(list(1, list("a")))        # las listas pueden estar anidadas a más de 2 niveles de profundidad
list(a=TRUE, b=1:100)           # los elementos de la lista pueden tener nombres
```

Una lista puede estar vacía y almacenar elementos vacíos:

```r
l1 <- list()
l2 <- list(numeric(), list(), complex())

length(l1)  # 0
length(l2)  # 3
```


Las mismas reglas de subconjunto descritas anteriormente se aplican también a las listas:

```r
l <- list(a=TRUE, b=c("a","b"), c=1:100)

l[1]                     # lista con un elemento
l[c(1,2)]
l[-1]
l[c(TRUE, FALSE, TRUE)]
l[c("a","c")]
l[]
```

El operador especial de corchetes dobles `[[` se utiliza para extraer elementos de una lista.
Pero sólo permite la indexación por números y nombres positivos:

```r
l <- list(a=TRUE, b=c("a","b"), c=1:100)

l[[1]]                   # primer elemento de una lista
l[[c(1,2)]]              # error: no puede devolver dos objetos, sin una lista que los contenga
l[[-c(1,2)]]             # error: no se pueden utilizar índices negativos para los elementos de la lista
l[[c(TRUE,FALSE,TRUE)]]  # error: no se pueden utilizar índices lógicos
l[[c("a")]]
l[[c("a","b")]]          # error: no puede devolver dos objetos, sin una lista que los contenga
```

Los elementos de las listas anidadas pueden seleccionarse apilando corchetes dobles:

```r
l <- list(list(TRUE), list(list(1, 2:3)))

l[[1]]               # selecciona el primer elemento - una lista
l[[1]][[1]]          # selecciona el segundo elemento a partir del primer elemento (lista)
l[[2]][[1]][[1]]     # selección anidada más profunda (¡difícil de describir!)
l[[2]][[1]][[2]][2]  # selecciona un elemento de un vector profundamente anidado
```

Los elementos de una lista se sustituyen mediante procedimientos equivalentes a su subconjunto:

```r
l <- list(a=TRUE, b=c("a","b"), c=1:100)

l[[1]] <- FALSE       # sustituye el primer elemento de la lista por FALSE
l[1] <- list(FALSE)   # igual que arriba
l[1] <- FALSE         # también igual que arriba
l[[1]] <- list(FALSE) # ! reemplaza el primer elemento con una lista
l[2] <- NULL          # elimina el segundo elemento de la lista
```

Los mismos procedimientos de sustitución funcionan en las listas anidadas:

```r
l <- list(list(TRUE), list(list(1, 2:3)))

l[[1]][[1]]          <- FALSE
l[[2]][[1]][[1]]     <- 0
l[[2]][[1]][[2]][1]  <- -1     # reemplazar elemento de un vector profundamente anidado
l[[2]][[2]]          <- list() # reemplazar una lista entera anidada
```

La selección de un solo elemento de una lista por su nombre es un procedimiento frecuente, por lo que tiene un operador de acceso directo, `$`:

```r
l <- list(a=TRUE, b=c("a","b"), c=list(c1=1, c2=2))

l$a     # lo mismo que l[["a"]]
l$c     # lo mismo que l[["c"]]
l$c$c1  # lo mismo que l[["c"]][["c1"]]
```

Se puede utilizar el mismo atajo para la sustitución:

```r
l <- list(a=TRUE, b=c("a","b"), c=list(c1=1, c2=2))

l$a     <- FALSE  # reemplazar elemento "a"
l$c$c1  <- 0      # reemplazar "c1" elemento de la lista "c"
l$c     <- NA     # reemplazar toda la lista "c" con NA
```

## Matrices ##

Las matrices son vectores con un atributo adicional de dimensión.
A continuación se presentan múltiples formas equivalentes de crear matrices:

```r
x <- c(1, 2, 3, 4)

matrix(x, nrow=2, ncol=2)
dim(x) <- c(2,2)
attr(x, "dim") <- c(2,2)
```

Los atributos de una matriz se pueden obtener mediante funciones:

```r
X <- matrix(1:10, nrow=2, ncol=5)

dim(X)
nrow(X)
ncol(X)
```

Como las matrices se construyen a partir de vectores, cualquier tipo de vector, incluida una lista, puede convertirse en una matriz:

```r
matrix(c(TRUE, FALSE, TRUE, FALSE), nrow=2, ncol=2)
matrix(1:4, nrow=2, ncol=2)
matrix(c("a","b","c","d"), nrow=2, ncol=2)
matrix(list(TRUE, 2, "a", 3+0i), nrow=2, ncol=2)
```

Una matriz, al igual que un vector, puede estar vacía:

```r
matrix(logical(), nrow=0, ncol=0)
matrix(double(), nrow=0, ncol=0)
matrix(list(), nrow=0, ncol=0)
```

Bajo el capó, la matriz es un vector, "doblado" en forma de matriz rellenando primero la primera columna, luego la segunda, y así sucesivamente:

```r
x <- 1:20

matrix(x, ncol=4)

#      [,1] [,2] [,3] [,4]
# [1,]    1    6   11   16
# [2,]    2    7   12   17
# [3,]    3    8   13   18
# [4,]    4    9   14   19
# [5,]    5   10   15   20
```

Y todos los operadores que trabajan con vectores tratan las matrices como vectores.
Esto es lo que ocurre cuando se añade un vector a una matriz:

```r
X <- matrix(1:8, nrow=4)
v <- 1:2

X + v    # 1) X se "aplana" a una forma vectorial 1 2 3 4 5 6 7 8
         # 2) v se recicla para que coincida con la longitud de X 1 2 1 2 1 2
         # 3) se realiza la suma de elementos 2 4 4 6 8 9 10
         # 4) X se vuelve a "doblar" en una matriz, columna por columna:
         #      [,1] [,2]
         # [1,]    2    6
         # [2,]    4    8
         # [3,]    4    8
         # [4,]    6   10
```

Esto permite especificar fácilmente algunas operaciones comunes:

```r
X <- matrix(1:20, nrow=4)
Y <- matrix(runif(20), nrow=4)

X + 1 # añadir un número a cada elemento de una matriz
X > 2 # comparar cada elemento de una matriz con un número
X / Y # divide los elementos de una matriz entre otra
X < Y # comparar dos matrices elemento a elemento
X - rowMeans(X) # resta la media de cada fila de una matriz
```

Al igual que los operadores, las funciones que trabajan con vectores tratan las matrices como vectores:

```r
X <- matrix(1:20, ncol=4)

length(X)  # 20
sum(X)     # suma todos los elementos
sqrt(X)    # raíz cuadrada de cada elemento de la matriz
```

Existen muchas funciones y operadores especializados para trabajar con matrices. Algunos de ellos:

```r
X <- matrix(rnorm(20), ncol=4)
Y <- matrix(rnorm(20), nrow=4)

t(X)     # transponer matriz
diag(X)  # obtener la diagonal de la matriz
X %*% Y  # multiplicar la matriz
X %x% Y  # producto Kronecker de las matrices
```

Los elementos dentro de una matriz se pueden subconjuntar y sustituir como si estuvieran en un vector:

```r
X <- matrix(1:20, ncol=4)
# todos retornan vectores
X[1]
X[c(2,3,5)]
X[-2]
X[c(TRUE,FALSE)]
X[X >= 10]

# sigue siendo matriz
X[1] <- 0
# sustituye los elementos 2, 3 y 5 de la primera columna por -2, -3 y -5
X[c(2,3,5)] <- c(-2,-3,-5)
# todos los elementos de la matriz que sean mayores o iguales que 10 se sustituyen por 10
X[X >= 10] <- 10
```

Además la matriz permite realizar las mismas operaciones en filas y columnas:

```r
X <- matrix(1:20, ncol=4)
X[1:2, 1:2]
```

Selección de filas y columnas por un índice:

```r
X <- matrix(1:20, ncol=4)

X[1:2,]     # primeras dos filas
X[,3:4]     # tercera y cuarta columna
X[1:2, 3:4] # combinación de las anteriores
X[1,]       # seleccionando una sola fila se obtiene un vector simple (no una matriz)
X[,2]       # lo mismo con las columnas
```

Eliminación de filas y columnas por un índice:

```r
X <- matrix(1:20, ncol=4)

X[-1,]          # deja la primera fila
X[,-c(2,3)]     # deja la segunda y tercera columna
X[-1, -c(2,3)]  # combinación de lo anterior
X[-1, c(2,3)]   # eliminación de filas combinada con la selección de columnas
X[,-c(1:3)]     # cuando se deja una sola fila/columna - se devuelve un vector
```

Selección de filas y columnas por índices lógicos:

```r
X <- matrix(1:20, ncol=4)

X[c(TRUE,FALSE,TRUE,FALSE,FALSE),]               # selecciona la 1a y 3a filas
X[,c(TRUE,FALSE,TRUE,FALSE)]                     # selecciona la 1a y 3a columnas
X[c(TRUE,FALSE,TRUE,FALSE,FALSE), c(TRUE,FALSE)] # combinación (con reciclaje)
X[,c(TRUE,FALSE,FALSE,FALSE)]                    # devuelve un vector

# ejemplo práctico
X[rowMeans(X) > 10,]       # todas las filas con una media superior a 10
```

Las filas y columnas de una matriz también pueden tener sus propios nombres que pueden utilizarse para la selección:

```r
X <- matrix(1:20, ncol=4)
rownames(X) <- paste0("r", 1:5)
colnames(X) <- paste0("c", 1:4)

X[c("r1", "r2"),]               # filas denominadas "r1" y "r2"
X[,c("c1", "c3")]               # columnas denominadas "c1" y "c3"
X[c("r1", "r2"), c("c1", "c3")] # combinación de las anteriores
X[, "c4"]                       # devuelve un vector
```

Además, la matriz también tiene un formato especial de subdivisión: por pares fila-columna:

```r
X <- matrix(1:20, ncol=4)
i <- rbind(c(1,2),  # elemento en fila 1 columna 2
           c(2,2),  # elemento en fila 2 columna 2
           c(4,1)   # elemento en fila 4 columna 1
           )

X[i]  # selecciona los elementos en todas las posiciones especificadas
```

Y lo mismo con los nombres:

```r
X <- matrix(1:20, ncol=4)
rownames(X) <- paste0("r", 1:5)
colnames(X) <- paste0("c", 1:4)
i <- rbind(c("r1","c2"),
           c("r2","c2"),
           c("r4","c1")
           )

X[i]  # lo mismo que antes
```

Los elementos dentro de la matriz pueden ser reemplazados utilizando todos los ejemplos de subconjuntos descritos anteriormente.
Sin embargo, para ahorrar tiempo y espacio, no se demostrará más.


## Dataframes ##

Los dataframes en R se implementan como una clase sobre las listas, con la restricción de que cada elemento dentro de una lista tenga la misma longitud.
Esta implementación permite construir tablas, donde cada elemento de la lista se interpreta como una columna separada.
Como resultado, a diferencia de una matriz, la clase `data.frame` puede contener columnas de diferentes tipos (e.g., la col1 puede ser numérica, la col2 lógica, etc).


```r
l <- list(id=1:5, name=c("a","b","c","d","e"), state=c(TRUE,TRUE,FALSE,TRUE,TRUE))
as.data.frame(l)

#   id name state
# 1  1    a  TRUE
# 2  2    b  TRUE
# 3  3    c FALSE
# 4  4    d  TRUE
# 5  5    e  TRUE

# lo mismo que antes
df <- data.frame(id=1:5, name=c("a","b","c","d","e"), state=c(TRUE,TRUE,FALSE,TRUE,TRUE))
```

Esto también permite tener listas anidadas en las columnas de un data.frame:

```r
df <- data.frame(id=1:2, name=c("Albert","Bob"))
df$objects <- list(c("key","pin"), c("ball"))

#   id   name  objects
# 1  1 Albert key, pin
# 2  2    Bob     ball
```

Dado que los data.frames son listas, se subconjuntan utilizando el operador de subconjunto de listas:

```r
df <- data.frame(id = 1:3, name = c("Albert","Bob","Cindy"))

df[1]           # primer elemento de la lista (primera columna)
df[1:2]         # dos primeros elementos de la lista (primera y segunda columnas)
df[-1]          # elimina el primer elemento de la lista (primera columna)
df[[2]][2:3]    # segundo y tercer elemento del vector de la segunda columna
df$id           # elemento de la lista (columna) por nombre
df$nombre[1:2]  # primeros dos elementos del vector de la columna "nombre
```

Se pueden utilizar operadores equivalentes para la sustitución.
Aquí sólo se ofrecen algunos ejemplos más prácticos:

```r
df <- data.frame(id = 1:3, name = c("Albert","Bob","Cindy"))

df$name[df$id=="2"]           <- "Bobby"
df$surname                    <- c("Thompson", NA, "Friedman")
df$surname[df$name=="Bobby"]  <- "Smith"
```

Dado que el data.frame se organiza como una matriz, también permite realizar operaciones de subconjunto de matrices, con formas equivalentes utilizadas para la sustitución:

```r
df <- data.frame(id = 1:3, name = c("Albert","Bob","Cindy"))

df[,1]          # primera columna (como en el caso de una matriz, devuelve un vector simple)
df[1,]          # primera fila de un data.frame (devuelve un data.frame)
df[df$id==2, ]  # todas las entradas para id = 2
df[df$id %in% 2:3, ] # todas las entradas para ids 2 y 3
```

Al igual que una matriz, el data.frame puede tener nombres de fila, y los nombres de columna suelen venir por defecto.
Y esos nombres pueden utilizarse para subconjuntar filas y columnas al estilo de una matriz:


```r
df <- data.frame(id = 1:3, name = c("Albert","Bob","Cindy"))
rownames(df) <- c("a", "b","c")

#   id   name
# a  1 Albert
# b  2    Bob
# c  3  Cindy

df[c("a", "b"),] # filas denominadas "a" y "b"
df[, "nombre"] # columna denominada "nombre"
df[c("a", "b"), "nombre"] # combinación de las dos
```

Reemplazar toda la entrada (una fila) es un procedimiento necesario a menudo.
Dado que estas entradas son subconjuntos del data.frame, son data.frames en sí mismos y deben sustituirse por un data.frame equivalente (o una lista).
Por lo tanto, la sustitución tiene que utilizar nombres de elementos iguales:

```r
df <- data.frame(id = 1:3, name = c("Albert","Bob","Cindy"))

df[df$id==2, ] <- list(id=2, name="Bruce")        # new entry for id = 2
df[df$id==2, ] <- data.frame(id=2, name="Bruce")  # same

#   id   name
# 1  1 Albert
# 2  2  Bruce
# 3  3  Cindy
```