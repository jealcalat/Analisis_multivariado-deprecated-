# obtener listas de objetos
jupyter_list <- list.files(pattern = "(.*).ipynb$", full = TRUE, recursive = TRUE)
# iterar sobre elementos
for (l in jupyter_list) {
  comando <- paste0("quarto render ", l)
  system(comando)
}
