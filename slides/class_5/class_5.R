
#Bajar base de datos manuelmente en https://github.com/mebucca/dar_soc4001/blob/master/slides/class_5/sample_casen2017.dta

install.packages("tidyverse")
install.packages("haven")

library("tidyverse")
library("haven") 

# establecer directorio
setwd(" ... ") 

## haven: cargar archivos .dta (Stata)

read_dta("sample_casen2017.dta") # problema. Necesitamos especificar algunas opciones (ver abajo)

# leer archivo dta 
data_casen_dta <- read_dta("sample_casen2017.dta", encoding = "latin1", .name_repair = "minimal")

## Crear un tibble

library("tibble")

mytibble <- 
  tibble(
    x=rep(c("A","B","C"),8),
    y=sample(1:10,size=24, replace = T), 
    z=factor(sample(letters,size=24))
  )

print(mytibble)


## Transformar un data frame en tibble

as.data.frame(data_casen_csv)
as_tibble(data_casen_csv)


# pipes

data_casen_csv %>%
  select(esc,sexo,ypchautcor) %>%
  arrange(esc) %>%
  filter(esc <= 12 & sexo == 2) 


## arrange: ordenación de datos

data_casen_csv %>% arrange(edad)
data_casen_csv %>% arrange(edad,desc(sexo),yautcor)

## select: selección de variables

data_casen_csv %>% select(sexo,edad,educ)
data_casen_csv %>% select(!c(sexo,edad,educ))
data_casen_csv %>% select(1:5,8)
data_casen_csv %>% select(starts_with("y"))
data_casen_csv %>% select(ends_with("a"))
data_casen_csv %>% select(contains("cor"))
data_casen_csv %>% select((num_range("x", 10:15)))


## filter: selección de variables

data_casen_csv %>% filter(sexo==2)
data_casen_csv %>% filter(sexo==2 & edad>=18 & (region==2 | region==6) )

## anidando operaciones

data_casen_csv %>% 
  filter(sexo==2 | region==13) %>% 
  select(sexo, region) %>% head()


########################### Ejercicio ################################

#Seleccionar las variables region e ingreson total corregido (ytotcor). Retén solo a los hombres con un ingreso tota deñ 10 millones o mas. Visualiza el resultsdo en la consola cuenta cuantos hay en cada región



