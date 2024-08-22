library("readr")
library("tidyverse")
library("ggplot2")

x <- url("https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto1/Covid-19.csv")
data_covid <- read_csv(x)

data_covid %>% glimpse()

data_covid <- data_covid %>% 
  pivot_longer(cols = -c(Region,`Codigo region`,Comuna,`Codigo comuna`,Poblacion), 
               names_to = "Fecha", values_to = "Casos_diarios") %>%
  mutate(Fecha = as.Date(Fecha, format = "%Y-%m-%d"))


data_covid %>% 
              ggplot(aes(x=Fecha, y=Casos_diarios, group=Comuna)) +
               geom_line(alpha=0.3) +
               theme(legend.position = "none") +
               labs(x="Fecha", y="Número de Casos Diarios", title = "Evolución casos Covid-19") +
               theme_bw()