# Limpiar pantalla y remover objetos existentes
cat("\014") 
rm(list = ls())

## Bases de datos ordenadas ("tidy") 

library("tidyverse")
library("janitor")
library("readr") 

setwd("/Users/Mauricio/Library/Mobile Documents/com~apple~CloudDocs/Teaching/ISUC/2020_2_data_analysis_r/repo/slides/class_10/")
va_messy <- read.delim("value_added_agricultue.csv", sep= ";")

va_messy %>% View()

va_data <- va_messy %>% row_to_names(row_number = 1) %>%  
  rename(country = 1) %>% 
  mutate(across(-country, ~ as.character(.x))) %>% View()
  pivot_longer(cols = -c("country"), names_to = "year", values_to = "added_value") %>% 
  mutate(added_value = if_else(added_value == "", NA_character_, added_value)) %>% 
  drop_na(added_value) %>% mutate(added_value = scan(text=added_value, dec=",", sep=".")) %>%
  arrange(year,country)
va_data  
 

## Valores perdidos implícitos

va_data <- va_data %>% complete(country,year)  
va_data %>% complete(country,year, fill = list(added_value = 0))  


## Completa valores perdidos

va_data %>% arrange(country,year) %>%
  group_by(country) %>%
  fill(added_value, .direction = c("down")) %>%
  replace_na(list(added_value = 0))  %>%
  ggplot(aes(x=year,y=added_value, group=country,colour=country))  +
  geom_line() +
  theme(legend.position = "none")
  

