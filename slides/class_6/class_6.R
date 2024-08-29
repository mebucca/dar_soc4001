# Carga datos
library("tidyverse")

setwd("~/Library/Mobile Documents/com~apple~CloudDocs/Teaching/ISUC/2021_2_data_analysis_r/repo/slides/class_6/")

# leer archivo csv

data_casen_csv <- read_csv("sample_casen2017.csv")


# Creación de nuevas variables

data_casen_csv <- data_casen_csv %>% 
  mutate(anno = 2017) %>% 
  mutate(ln_ytotcor_mm = log((ytotcor + 1)/1000)) 
  
  
# mutate, if_else: creación de datos

data_casen_csv %>% select(sexo,edad,ytotcor,anno,ln_ytotcor_mm) %>%
  mutate(sexo2 = if_else(sexo==1,1,0)) %>% select(sexo,sexo2) 


data_casen_csv %>% select(sexo,edad,ytotcor) %>% 
  mutate(sexo = if_else(sexo==1,sexo,0))

data_casen_csv %>% select(sexo,edad,ytotcor) %>% 
  mutate(sexo = if_else(sexo==1,edad,0))


## mutate, case_when: creación de datos (empieza con todo NA y después substituye por pedazos)

data_casen_csv %>% select(sexo,edad,ytotcor) %>% 
  mutate(edad_cat = case_when(edad <= 18 ~ 1, 
                              edad >18 & edad<=65 ~ 2, 
                              edad > 65  ~ 3) 
  )


data_casen_csv %>% select(sexo,edad,ytotcor) %>% 
  mutate(edad_cat = case_when(edad > 5 & edad<=18 ~ 1,
                              edad >18 & edad<=65 ~ 2, 
                              edad > 65  ~ 3, 
                              TRUE ~ 0)
  )



############################# Ejercicio 1 #############################

# Usando la funcion  quantile(data_casen_csv$ytotcor, p=c(0.25,0.5,0.75), na.rm=T), calcula 
# los limites que separan a los 4 cuartiles de ingreso autónomo (25% mas pobre, segundo 25% mas pobre, segundo 25% mas rico y 25% mas rico).
# Luego, usando estos límites y la funcion case_when crea una nueva variable llamada "cuartiles" que tome valor 1 para individuds en primer
# cuartil (25% más pobre), hasta 4 para el cuarto cuartil (25% más rico)

qs <- quantile(data_casen_csv$ytotcor, p=c(0.25,0.5,0.75), na.rm=T)

data_casen_csv  <- data_casen_csv %>% mutate(cuartiles = case_when(ytotcor<qs[1] ~ 1,
                                                ytotcor>=qs[1] & ytotcor<qs[2] ~ 2,
                                                ytotcor>=qs[2] & ytotcor<qs[3] ~ 3,
                                                ytotcor>=qs[3] ~ 4)
                                                ) 



## group_by: operaciones agrupadas.

cuadrado <- function(x) {x^2}

data_casen_csv %>% 
  group_by(region) %>% 
  mutate(n_region = n(), mean_ytotcor_region = mean(ytotcor, na.rm = T), cuadrado_edad = cuadrado(edad)) %>% 
  ungroup() %>% 
  select(region,sexo,edad, ytotcor,n_region, mean_ytotcor_region,cuadrado_edad ) 



data_casen_csv <- data_casen_csv %>% 
  mutate(edad_cat = case_when(edad > 5 & edad<=18 ~ 1,
                              edad >18 & edad<=65 ~ 2, 
                              edad > 65  ~ 3, 
                              TRUE ~ 0))  %>% 
  group_by(region, sexo, edad_cat) %>% 
  mutate(n_region = n(), mean_ytotcor_region = mean(ytotcor, na.rm = T)) %>%
  ungroup() %>%
  select(!edad_cat)


# sampling by group

data_casen_csv %>% group_by(sexo) %>% sample_n(size = 4, replace = T)

data_casen_csv %>%  sample_n(size = 8, replace = T)


############################# Ejercicio 2 #############################

# Usando las funciones group_by y summarise, calcula el promedio y desviacion estándar de ytotcor
# por cuartil de ingresos

data_casen_csv %>% 
  group_by(cuartiles) %>%
  summarise(promedio = mean(ytotcor, na.rm=T), sd = sd(ytotcor, na.rm=T))


