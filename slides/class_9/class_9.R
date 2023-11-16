### REPASO CLASE TEÓRICA

# Limpiar pantalla y remover objetos existentes
cat("\014") 
rm(list = ls())

library("tidyverse")
library("carData")
library("janitor")

data(WeightLoss)
wl <- WeightLoss %>% as.tibble(); wl
rm(WeightLoss)


# de ancho a largo

wl_long <- wl %>% mutate(id = 1:n()) %>% # crea un id única para identificar individuos fácilmente
  pivot_longer(cols = -c(id,group),     
               names_to = "outcome_week",
               values_to = "score") %>%
  separate(outcome_week, into = c("outcome", "week"), sep = 2) %>%
  mutate(week = as.integer(week))


# de largo a ancho

wl_tidy <- wl_long %>% 
  pivot_wider(names_from = outcome, values_from = score)


wl_tidy


### EJERCICIO PRÁCTICO

# Bajar datos covid desde repositorio Github del Ministerio de la Ciencia
# Repositorio y descripción de los datos: https://github.com/MinCiencia/Datos-COVID19/tree/master/output/producto1

# En particular:
# "El archivo Covid-19.csv contiene las columnas 'Región', ‘Código Región’, 'Comuna', ‘Código comuna’, 'Población', 
# múltiples columnas correspondientes a '[fecha]', y una columna 'Tasa'. Estas últimas columnas, ‘[fecha]’,
# contienen los 'Casos Confirmados' reportados por el Ministerio de Salud de Chile en cada una de las fechas que se
# indican en las respectivas columnas."

library("readr")
library("tidyverse")

# almacenamos en R
data_covid <- read.csv(url("https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto1/Covid-19.csv"))


# visualizamos los datos
data_covid 


# 1) Pasar datos de ancho a largo para que las fechas queden a lo largo.  


# 2) - calcular el promedio de casos por cada 1000 mil habitantes en cada comuna
# - calcular el total de casos por cada 1000 mil habitantes en cada comuna

