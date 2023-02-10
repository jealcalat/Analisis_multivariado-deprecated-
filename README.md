
# Análisis Estadístico Multivariable

Curso de la maestría en ciencia de datos (MCD) del ITESO.

Inicio: 15 de enero de 2023
Fin: 15 de mayo de 2023
**Plataforma**: Teams (reuniones virtuales), CANVAS (administración del curso), y GitHub (materiales del curso y calendario)

**Instructor**: Emmanuel Alcalá
**Correo**: <jaime.alcala@iteso.mx>
**Asesorías**: solicitar cita.

---
**Contenido**

- [Análisis Estadístico Multivariable](#análisis-estadístico-multivariable)
  - [Calendario del curso](#calendario-del-curso)
  - [Temas del curso](#temas-del-curso)
  - [Bibliografía](#bibliografía)
  - [Evaluación](#evaluación)
    - [Tareas](#tareas)
    - [Participación en clase](#participación-en-clase)
    - [Proyectos](#proyectos)
    - [Exámenes](#exámenes)
  - [Tutoriales de `R`](#tutoriales-de-r)
    - [Fundamentos de `R`](#fundamentos-de-r)
    - [Cargar datos (csv, xlsx) en R con RStudio](#cargar-datos-csv-xlsx-en-r-con-rstudio)
    - [Data wrangling con `{dplyr}` y `{tidyr}`](#data-wrangling-con-dplyr-y-tidyr)
    - [Visualización con `{ggplot}`](#visualización-con-ggplot)
    - [Documentos reproducibles con RMarkdown](#documentos-reproducibles-con-rmarkdown)
    - [Modelamiento con `{tidymodels}`](#modelamiento-con-tidymodels)
  - [Tutoriales de MML](#tutoriales-de-mml)
    - [Cálculo](#cálculo)

## Calendario del curso

Para ver el calendario del curso, revisa el siguiente enlace: [Calendario del curso](listas/calendario_del_curso.md). Las fechas se pueden reajustar de acuerdo a cómo avancemos. Para este curso es más importante entender los conceptos que abarcar un temario.

Algunos recursos que he ido recopilando, como una recomendación que han hecho los propios alumnos, se encuentran en [Lecturas y recursos recomendados](lecturas_recursos.md). Estos mismos recursos y lecturas pueden ser usados para sus presentaciones.


## Temas del curso

1. Variables aleatorias multivariadas
   1. [Correlaciónes y covarianzas](https://nbviewer.org/github/jealcalat/Analisis_multivariado/blob/main/1_variables_aleatorias_multivariadas/1.1_correlaciones_covarianzas.ipynb)

2. Modelos de distribución multivariados
   1. [Funciones de distribución y densidad](https://nbviewer.org/github/jealcalat/Analisis_multivariado/blob/main/2_modelos_multivariados/2.1_funciones_distribucion_densidad.ipynb)
   2. [Distribucion multinormal](https://nbviewer.org/github/jealcalat/Analisis_multivariado/blob/main/2_modelos_multivariados/2.2_distribucion_multinormal.ipynb)

3. Teoría de la estimación
   1. [Función de verosimilitud](https://nbviewer.org/github/jealcalat/Analisis_multivariado/blob/main/3_teoria_de_estimacion/3.1_funcion_verosimilitud.ipynb)
   2. [Prueba de verosimilitud](https://nbviewer.org/github/jealcalat/Analisis_multivariado/blob/main/3_teoria_de_estimacion/3.2_prueba_verosimilitud.ipynb)
   3. [Prueba de hipótesis lineal (regresión lineal)](https://nbviewer.org/github/jealcalat/Analisis_multivariado/blob/main/3_teoria_de_estimacion/3.3_prueba_hipotesis_lineal.ipynb)
   4. [Regresión logística](https://nbviewer.org/github/jealcalat/Analisis_multivariado/blob/main/3_teoria_de_estimacion/3.4_regresion_logistica.ipynb)

4. Técnicas multivariadas
   1. [ANOVA, MANOVA, ANCOVA](https://nbviewer.org/github/jealcalat/Analisis_multivariado/blob/main/4_tecnicas_multivariadas/4.1_anova_manova_ancova.ipynb)
   2. [Modelos log-lineal](https://nbviewer.org/github/jealcalat/Analisis_multivariado/blob/main/4_tecnicas_multivariadas/4.2_modelos_log-lineal.ipynb)
   3. [Selección de variables](https://nbviewer.org/github/jealcalat/Analisis_multivariado/blob/main/4_tecnicas_multivariadas/4.3_seleccion_de_variables)

5. Descomposición de datos y técnicas de análisis
   1. [Análisis de componentes principales](https://nbviewer.org/github/jealcalat/Analisis_multivariado/blob/main/5_descomposicion_datos_tecnicas/5.1_analisis_de_componentes_principales.ipynb)
   2. [Análisis factorial](https://nbviewer.org/github/jealcalat/Analisis_multivariado/blob/main/5_descomposicion_datos_tecnicas/5.2_analisis_factorial.ipynb)
   3. [Análisis de clúster](https://nbviewer.org/github/jealcalat/Analisis_multivariado/blob/main/5_descomposicion_datos_tecnicas/5.3_analisis_de_cluster.ipynb)
   4. [Modelos de Mezclas Gaussianas]()
   5. [Análisis discriminante](https://nbviewer.org/github/jealcalat/Analisis_multivariado/blob/main/5_descomposicion_datos_tecnicas/5.4_analisis_discriminante.ipynb)

6. Aplicaciones

---
## Bibliografía

- [*Applied Multivariate Statistical Analysis*](https://link.springer.com/content/pdf/10.1007/978-3-662-45171-7.pdf). Wolfgang H. and Simar. L. Springer, 2015
- *Applied Multivariate Statistical Concepts*. Hahs-Vaughn, D. Editorial Routledge, 2016.
- [*Applied Multivariate Statistics with R*](https://web.uniroma1.it/memotef/sites/default/files/file%20lezioni/102b_textbook.pdf). Zelterman, D. Editorial Springer, 2015.

## Evaluación

| RUBROS                                                    | PORCENTAJE |
| --------------------------------------------------------- | ---------- |
| 1. [Tareas](#tareas)                                      | 30%        |
| 2. [Participación en clase](#participación-en-clase)      | 15%        |
| 3. [Proyectos (Solución de casos de estudio)](#proyectos) | 25%        |
| 4. [Exámenes](#exámenes)                                  | 30%        |
| Total                                                     | 100%       |


### Tareas

Serán 3 tareas:

1. [Tarea 1](/tareas/tarea1.pdf), de las unidades 1 y 2.
2. [Tarea 2](/tareas/Tarea2.pdf), de las unidades 3 y 4.
3. [Tarea 3](/tareas/tarea3.pdf), de la unidad 5.

Para la entrega de tareas, usar la plantilla de RMarkdown de la sección Documentos reproducibles con [RMarkdown](#documentos-reproducibles-con-rmarkdown).

### Participación en clase

La participación en clase se evaluará con exposiciones grupales, una exposición por equipo. Las exposiciones estarán distribuidas de la siguiente manera:

| Equipo   | Tema                   |
| -------- | ---------------------- |
| Equipo 1 | Regresión logística    |
| Equipo 2 | PCA                    |
| Equipo 3 | Análisis factorial     |
| Equipo 4 | Análisis discriminante |

Organización sugerida de las exposiciones:

**Regresión logística**
1. Modelos lineales generalizados (énfasis en función de enlace).
2. Implementación y diagnóstico de modelo de regresión logística en R/Python.
3. Interpretación de resultados (efectos marginales, odds ratio, intervalos de confianza, etc).
   
**PCA**
1. Estructura matemática (combinación lineal).
2. Método de obtención con factorización matricial.
3. Implementación e interpretación en R/Python


### Proyectos

Resolver un caso de estudio escogiendo alguno de los temas de las unidades 3, 4 y 5. Los proyectos son individuales y deben entregarse también según la estructura que se les pida; pueden usar[RMarkdown](#documentos-reproducibles-con-rmarkdown). Deberán tener las siguientes secciones

1. Introducción: describir un problema o una pregunta. Ver [este ejemplo]() si tienes dudas de cómo hacerlo.
2. Datos: describir los datos que se van a usar, sus variables, si se hizo un tratamiento o tranformación (e.g., ingeniería de características). 
3. Presentación del análisis:
   1. Métodos: el análisis que harás. Debes describir formalmente dicho análisis (aquí me entero de que tienes una comprensión formal de dicho análisis).
   2. Resultados: gráficos principales y tablas de estadísticos, lo más refinado que puedas.
4. Conclusión: transmite tus hallazgos a una audiencia más amplia.

### Exámenes

- [Examen 1](examenes/examen1.pdf)
- [Examen 2](examenes/examen2.pdf)
---

<!-- ## Datasets

- [RDatasets](https://vincentarelbundock.github.io/Rdatasets/articles/data.html)
- [The Humanitarian Data Exchange](https://data.humdata.org/)
- [TidyTuesday](https://github.com/rfordatascience/tidytuesday)
- [Openpsychometrics](https://openpsychometrics.org/_rawdata/) -->

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

- [`R: control de flujo y funciones`](https://nbviewer.org/github/jealcalat/Analisis_multivariado/blob/main/R_tutorials/r_flujo_funciones.ipynb). Notar que está en forma de jupyter notebook. El código en las celdas se puede copiar a un script de `R` o, si se tiene instalado `IRkernel`, se puede correr directamente en jupyter seleccionando el kernel de `R`.
- [`R Workflow`](http://hbiostat.org/rflow/) de Frank Harrell es un libro-curso en línea que va desde lo [básico](https://hbiostat.org/rflow/rbasics.html) hasta temas más avanzados como [simulación](https://hbiostat.org/rflow/sim.html) o [cómputo paralelo](https://hbiostat.org/rflow/parallel.html). Tiene una *desventaja*: para los temas avanzados, hay que familiarizarse con la librería del autor, [`rms`](https://cran.r-project.org/web/packages/rms/index.html), que proviene del libro *Regresion Modeling Strategies*. En el apartado 1.1 del libro menciona los repositorios usados.

### Cargar datos (csv, xlsx) en R con RStudio

- [Navegar en directorios y fijar el directorio de trabajo](https://www.youtube.com/watch?v=OJ4WBjV5o1I). Asume que se tiene instalado R y RStudio.
- [Importar datos con R](https://www.youtube.com/watch?v=WWY8VPh6ryo) 

### Data wrangling con `{dplyr}` y `{tidyr}`

Tutorial avanzado.

En la [`esta`](https://nbviewer.org/github/jealcalat/Analisis_multivariado/blob/main/R_tutorials/data_wrangling_dplyr.ipynb) notebook se encuentra un tutorial sencillo de *data wrangling* usando los paquetes de `{dplyr}` y `{tidyr}`. Se cubren aspectos como transformación, enriquecimiento y limpieza de tal forma que tengamos un estándar llamado `tidy data`.

### Visualización con `{ggplot}`

`{ggplot}` (oficialmente, `{ggplot2}`) es un paquete popular para la visualización de datos que implementa un conjunto de principios de visualización llamado "the grammar of graphics". Ha sido tan influyente que existen implementaciones en Python y Matlab.

En [`esta`](https://nbviewer.org/github/jealcalat/Analisis_multivariado/blob/main/R_tutorials/data_viz_ggplot.ipynb) notebook de jupyter se encuentra un sencillo tutorial con los fundamentos.

### Documentos reproducibles con RMarkdown

Consultar [esta plantilla de RMarkdown](R_tutorials/rmarkdown_plantilla.Rmd), que se usará para la entrega de tareas *opcionalmente*. 

### Modelamiento con `{tidymodels}`

- [recipes]
- [parsnip]:
  - Regresión lineal
    - The MLW way
    - The OLS way
  - ANOVA

## Tutoriales de MML

Algunos tutoriales de matemáticas y estadística básica. El libro recomendable para matemáticas de ML es [Mathematics for Machine Learning](/refs/mml-book.pdf) de Deisenroth, Faisal y Ong.

### Cálculo

- [Este un curso de Cálculo para ML](https://www.youtube.com/watch?v=-J_GKa_2TPQ&list=PLiiljHvN6z193BBzS0Ln8NnqQmzimTW23&index=3). Para derivadas, es suficiente para tener la noción de derivada consultar los videos 3-8.
- [En este video explican algunas reglas de derivación útiles.](https://www.youtube.com/watch?v=aVNa-J8iB5I).
- [Este video es una introducción concisa de integración](https://www.youtube.com/watch?v=Ec-cGjh0Fr0)