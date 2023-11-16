library("tidyverse")
library("readxl")
library("knitr")

set.seed(615)

ayudantes <- tibble(Ayudante=c("Matias","Martín","Sebastian"), Grupo=1:3)

path <- "/Users/Mauricio/Library/Mobile Documents/com~apple~CloudDocs/Teaching/ISUC/2022_2_data_analysis_r/repo/files/listado_estudiantes.xlsx"

listado_estudiantes <- read_excel(path) %>% dplyr::select(Nombres) %>% rename(Estudiante = Nombres) %>%
  rowwise() %>%
  mutate(Grupo = sample(1:3,1)) %>%
  left_join(ayudantes,by="Grupo") %>%
  arrange(Grupo) %>%
  dplyr::select(Grupo,Ayudante,Estudiante)

kable(listado_estudiantes)
