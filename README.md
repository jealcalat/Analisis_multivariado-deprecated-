
# Análisis Estadístico Multivariable

Curso de la maestría en ciencia de datos (MCD) del ITESO.

**TOC**

- [Análisis Estadístico Multivariable](#análisis-estadístico-multivariable)
  - [Temas del curso](#temas-del-curso)
  - [Bibliografía](#bibliografía)
  - [Datasets](#datasets)
  - [Tutoriales de `R`](#tutoriales-de-r)
    - [Fundamentos de `R`](#fundamentos-de-r)
    - [Data wrangling con `{dplyr}` y `{tidyr}`](#data-wrangling-con-dplyr-y-tidyr)
    - [Visualización con `{ggplot}`](#visualización-con-ggplot)
    - [Modelamiento con `{tidymodels}`](#modelamiento-con-tidymodels)

## Temas del curso

1. Variables aleatorias multivariadas
   1. [Correlaciónes y covarianzas](1_variables_aleatorias_multivariadas/1.1_correlaciones_covarianzas.ipynb)

2. Modelos de distribución multivariados
   1. [Funciones de distribución y densidad](2_modelos_multivariados/2.1_funciones_distribucion_densidad.ipynb)
   2. [Distribucion multinormal](2_modelos_multivariados/2.2_distribucion_multinormal.ipynb)

3. Teoría de la estimación
   1. [Función de verosimilitud](3_teoria_de_estimacion/3.1_funcion_verosimilitud.ipynb)
   2. [Prueba de verosimilitud](3_teoria_de_estimacion/3.2_prueba_verosimilitud.ipynb)
   3. [Prueba de hipótesis lineal (regresión lineal)](3_teoria_de_estimacion/3.3_prueba_hipotesis_lineal.ipynb)
   4. [Regresión logística](3_teoria_de_estimacion/3.4_regresion_logistica.ipynb)

4. Técnicas multivariadas
   1. [ANOVA, MANOVA, ANCOVA](4_tecnicas_multivariadas/4.1_anova_manova_ancova.ipynb)
   2. [Modelos log-lineal](4_tecnicas_multivariadas/4.2_modelos_log-lineal.ipynb)
   3. [Selección de variables](4_tecnicas_multivariadas/4.3_seleccion_de_variables)

5. Descomposición de datos y técnicas de análisis
   1. [Análisis de componentes principales](5_descomposicion_datos_tecnicas/5.1_analisis_de_componentes_principales.ipynb)
   2. [Análisis factorial](5_descomposicion_datos_tecnicas/5.2_analisis_factorial.ipynb)
   3. [Análisis de clúster](5_descomposicion_datos_tecnicas/5.3_analisis_de_cluster.ipynb)
   4. [Análisis discriminante](5_descomposicion_datos_tecnicas/5.4_analisis_discriminante.ipynb)

6. Aplicaciones

## Bibliografía

- [*Applied Multivariate Statistical Analysis*](https://link.springer.com/content/pdf/10.1007/978-3-662-45171-7.pdf). Wolfgang H. and Simar. L. Springer, 2015
- *Applied Multivariate Statistical Concepts*. Hahs-Vaughn, D. Editorial Routledge, 2016.
- *Applied Multivariate Statistics with R*. Zelterman, D. Editorial Springer, 2015.


## Datasets

- [RDatasets](https://vincentarelbundock.github.io/Rdatasets/articles/data.html)
- [The Humanitarian Data Exchange](https://data.humdata.org/)
- [TidyTuesday](https://github.com/rfordatascience/tidytuesday)
- [Openpsychometrics](https://openpsychometrics.org/_rawdata/)

## Tutoriales de `R`

### Fundamentos de `R`

Existen muchos tutoriales básicos de R. Estos son algunos de mis favoritos:

- [Data Carpentry: Intro to R](https://datacarpentry.org/R-genomics/01-intro-to-R.html)
  - Comenzar [aquí](https://datacarpentry.org/R-genomics/00-before-we-start.html).
- [Data Carpentry: Starting with data](https://datacarpentry.org/R-genomics/02-starting-with-data.html)
- [Data Carpentry: Data frames](https://datacarpentry.org/R-genomics/03-data-frames.html)

Otro recurso:

- [`En este tutorial`](R_tutorials/r_intro.md) se puede consultar una introducción rapidísima, básica, a `R`. Se tratan cosas como operadores, sintaxis, vectores, matrices, listas, data.frames y su indexación, subsetting, etc.

Al ser básicos, no enseñan algunas cosas avanzadas tales como construir nuestras propias funciones, control de flujo (ciclos `for` o `while`, enunciados con `if-else`, etc.).

Para una introducción básica a esto, revisar el tutorial

- [`R: control de flujo y funciones`](R_tutorials/r_flujo_funciones.ipynb). Notar que está en forma de jupyter notebook. El código en las celdas se puede copiar a un script de `R` o, si se tiene instalado `IRkernel`, se puede correr directamente en jupyter seleccionando el kernel de `R`.
- [`R Workflow`](http://hbiostat.org/rflow/) de Frank Harrell es un libro-curso en línea que va desde lo [básico](https://hbiostat.org/rflow/rbasics.html) hasta temas más avanzados como [simulación](https://hbiostat.org/rflow/sim.html) o [cómputo paralelo](https://hbiostat.org/rflow/parallel.html). Tiene una *desventaja*: para los temas avanzados, hay que familiarizarse con la librería del autor, [`rms`](https://cran.r-project.org/web/packages/rms/index.html), que proviene del libro *Regresion Modeling Strategies*. En el apartado 1.1 del libro menciona los repositorios usados.


### Data wrangling con `{dplyr}` y `{tidyr}`

En la [`esta`](R_tutorials/data_wrangling_dplyr.ipynb) notebook se encuentra un tutorial sencillo de *data wrangling* usando los paquetes de `{dplyr}` y `{tidyr}`. Se cubren aspectos como transformación, enriquecimiento y limpieza de tal forma que tengamos un estándar llamado `tidy data`.

### Visualización con `{ggplot}`

`{ggplot}` (oficialmente, `{ggplot2}`) es un paquete popular para la visualización de datos que implementa un conjunto de principios de visualización llamado "the grammar of graphics". Ha sido tan influyente que existen implementaciones en Python y Matlab.

En [`esta`](R_tutorials/data_viz_ggplot.ipynb) notebook de jupyter se encuentra un sencillo tutorial con los fundamentos.

### Modelamiento con `{tidymodels}`

- [recipes]
- [parsnip]:
  - Regresión lineal
    - The MLW way
    - The OLS way
  - ANOVA
