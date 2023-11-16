install.packages("devtools")
devtools::install_github("DougLuke/UserNetR")
library("statnet") 
library("UserNetR")
library("tidyverse")
data("Krebs")
data_911 <- Krebs
rm(Krebs)

path <- "/Users/Mauricio/Library/Mobile Documents/com~apple~CloudDocs/Teaching/ISUC/2021_2_data_analysis_r/repo/slides/class_10/"
setwd(path)

#Description
#This network shows the contacts among the terrorists who carried out the 9-11 hijackings in 2001.

#Format
#A network object with 19 vertices and 27 edges

#Details
#This network data set was first constructed and analyzed by Valdis Krebs. 
#Using publically available data at the time, he constructed this contact network to illustrate the contact ties that 
#the 19 hijackers had prior to the attack.


edgelist <- read.csv(url("https://raw.githubusercontent.com/mebucca/dar_soc4001/master/slides/class_10/network_terrorists911.csv"))

adjacency_matrix <- as.sociomatrix(data_911)
plot.network(network(adjacency_matrix))

# 1) respuesta 

adjacency_tibble <- edgelist %>% mutate(edge = 1) %>%
  complete(ego,alter, fill=list(edge = 0)) %>%
  pivot_wider(names_from = alter, values_from = edge)
  

#  Adjacency Matrix -->  Edgelist 

edgelist_tibble <- adjacency_tibble %>%
  pivot_longer(-ego, names_to = "alter", values_to = "edge") %>%
  # filter(edge==1) %>%
  mutate(edge = if_else(edge==1,edge,NA_real_)) %>%
  drop_na(edge) %>%
  select(-edge)

# World Inequality Data

install.packages("devtools")
devtools::install_github("WIDworld/wid-r-tool")
library("wid")

data_inequality <- download_wid(
  indicators = "shweal", # Shares of personal wealth
  areas = c("FR","GB","DE","US"),  # In France, Great Britain, Germany, USA
  perc = c("p0p50", "p90p100", "p99p100") # Bottom 50%, top 10% and top 1%
) %>% select(-variable) %>% arrange(country,year)

data_inequality %>% as_tibble()

# mirar los datos 
data_inequality %>% group_by(country,percentile) %>% summarise(min(year),max(year)) # NAs implícitos
data_inequality %>% ggplot(aes(x=year,y=value, group=percentile, colour=percentile)) + geom_point() + facet_wrap(. ~ country)


# Hacer explícitos los NAs implícitos

data_inequality %>% complete(country,percentile,year)

# rellenar valores perdidos con el valor del año anterior disponible para el mismo país en la misma variable
# chequear que los datos estén ordenados correctamente

data_inequality <- data_inequality %>% complete(country,percentile,year) %>%
  arrange(country,percentile,year) %>%
  group_by(country,percentile) %>%
  fill(value, .direction = "down")

# repite gráfico y compara
data_inequality %>% ggplot(aes(x=year,y=value, group=percentile, colour=percentile)) + geom_point() + facet_wrap(. ~ country)


# poner cada variable ("percentile") en una variable separadamente (wide)


data_inequality <- data_inequality %>% pivot_wider(names_from = percentile, values_from = value)
