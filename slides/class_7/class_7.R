
library(tidyverse)

# leer archivo csv desde github
url <- "https://raw.githubusercontent.com/mebucca/dar_soc4001/master/data/sample_casen2017.csv"
data_casen_csv <- read.csv(url)


## summarise: extrayendo información de los datos


data_casen_csv %>% 
  summarise(mean_ytotcor = mean(ytotcor, na.rm = T)) 


data_casen_csv %>% 
  summarise(mean_ytotcor = mean(ytotcor, na.rm = T), 
            median_ytotcor = median(ytotcor, na.rm = T)) %>%
  mutate(ratio = mean_ytotcor/median_ytotcor) 


#Quantile:

data_casen_csv %>% 
  summarise(q20=quantile(ytotcor, probs=0.2, na.rm = T))


#3er caso:
data_casen_csv %>% 
  summarise(tercer=nth(ytotcor, n=5))


#Cantidad de valores distintos
data_casen_csv %>% 
  summarise(distintos=n_distinct(sexo))


## summarise across() variables

data_casen_csv %>% 
  summarise(across(c("sexo","edad") , mean))

data_casen_csv %>% 
  summarise(across( 2:4 , mean))


data_casen_csv %>% 
  summarise(across(starts_with("y"), mean))

data_casen_csv %>% 
  summarise(across(starts_with("y"), ~mean(.x, na.rm = TRUE) ))


data_casen_csv %>% 
  summarise(across(contains("ed"), ~mean(.x, na.rm = TRUE) ))


## summarise una variable con una lista de funciones


data_casen_csv %>% 
  summarise(across(edad, list(media = mean, mediana = median)))


data_casen_csv %>% 
  summarise(across(ytrabajocor, list(media =  ~mean(.x, na.rm = TRUE), mediana = ~median(.x, na.rm = TRUE))))


data_casen_csv %>% 
  summarise(across(c("edad","ytrabajocor"), list(average =  ~mean(.x, na.rm = TRUE), q50 = ~median(.x, na.rm = TRUE))))



## summarise muchas variable con una lista de funciones

data_casen_csv %>% 
  summarise(across(starts_with("y"), list(media = ~mean(.x, na.rm = TRUE), mediana= ~median(.x, na.rm = TRUE)) ))


## summarise by_group(): resumiendo datos agupados


mitabla <- data_casen_csv %>% 
  mutate(edad_cat = case_when(edad <= 18 ~ "menores",
                              edad >18 & edad<=65 ~ "adultos",
                              edad > 65  ~ "adultos mayores")) %>%
  group_by(region, sexo, edad_cat) %>% 
  summarise(mean_ytotcor = mean(ytotcor, na.rm = T), 
            median_ytotcor = median(ytotcor, na.rm = T)) %>%
  mutate(ratio = mean_ytotcor/median_ytotcor) %>%
  arrange(desc(ratio))


# Combinando herramientas

data_casen_csv %>% 
  group_by(region, sexo) %>% 
  summarise(across(ytrabajocor, list(media =  ~mean(.x, na.rm = TRUE), mediana = ~median(.x, na.rm = TRUE))))


## join: juntar bases de datos


data_a <- data_casen_csv %>% filter(region <2 | region>=15 ) %>%
  group_by(region) %>% 
  summarise(across(edad, mean)); data_a

data_b <- data_casen_csv %>% filter(region <3 | region>=16 ) %>%
  group_by(region) %>% 
  summarise(across(c(edad,yautcorh), mean)); data_b


#`inner_join()`

data_a   %>% inner_join(data_b, by="region")

data_b   %>% inner_join(data_a, by="region")

data_a %>% inner_join(data_b %>% select(!edad), by="region")

data_a %>% select(!edad) %>% inner_join(data_b, by="region")


#`left_join()`

data_a %>% left_join(data_b  %>% select(!edad), by="region")


#`right_join()`
data_a  %>% right_join(data_b %>% select(!edad), by="region")


#`full_join()`
data_a  %>% full_join(data_b %>% select(!edad), by="region")


#`full_join()`
data_a  %>% full_join(data_b, by="region") %>%
  mutate(edad = if_else(is.na(edad.x),edad.y,edad.x)) %>%
  select(!c(edad.x,edad.y))


data_a  %>% full_join(data_b, by="region") %>%
  rowwise() %>%
  mutate(edad = max(edad.x, edad.y, na.rm = T)) %>%
  select(!c(edad.x,edad.y))


## join: juntar bases de datos por más de una llave


## Ejercicio: agregar datos de "mi tabla" a la siguiente submuestra de la CASEN. 
## Junta por tre llaves: region, sexo y edad_cat

mitabla

submuestra <- data_casen_csv %>% 
  mutate(edad_cat = case_when(edad <= 18 ~ "menores",
                              edad >18 & edad<=65 ~ "adultos",
                              edad > 65  ~ "adultos mayores")) 




