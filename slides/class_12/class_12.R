library("tidyverse")
library("wesanderson")
library("cowplot")
library("lubridate")
library("viridis")

setwd(
  "~/Library/Mobile Documents/com~apple~CloudDocs/Teaching/ISUC/2020_2_data_analysis_r/repo/slides/class_12/")

# leer archivo csv
covid_data <- read_delim("covid_data.csv", delim=";")


covid_data <- covid_data %>% filter(date==as.Date("2020-11-17")) 
covid_data  %>% glimpse()



# Scatterplot

#jitter <- position_jitter(width = 10, height = 1)



# colores a mano

covid_data %>% ggplot(aes(y=total_deaths_per_million, 
                          x=hospital_beds_per_thousand, group="hello", colour=continent)) +
  geom_point() +
  scale_x_log10() + scale_y_log10() +
  geom_smooth(method = "lm", se=F) +
  scale_color_manual(values =c("red","blue","purple","black","yellow","pink"))
 

# paleta continua
pal <- wes_palette("Rushmore1", 100, type = "discrete")

covid_data %>% ggplot(aes(y=total_deaths_per_million, 
                          x=hospital_beds_per_thousand, group="hello", colour=median_age)) +
  geom_point() +
  scale_x_log10() + scale_y_log10() +
  geom_smooth(method = "lm", se=F) +
  scale_color_gradientn(colours = pal)
  #scale_color_viridis(option = "plasma")


# Scatterplot por grupos

covid_data %>% filter(continent!="Oceania")  %>% ggplot(aes(y=total_deaths_per_million, 
                          x=hospital_beds_per_thousand, 
                          group=continent,
                          colour=continent
)) +
  geom_point(alpha=0.3) +
  scale_x_log10() + scale_y_log10() +
  geom_smooth(method = "lm", se=F) +
  labs(x="Camas de hospital por mil hbs.", y="muertes totales por millón hbs.", colour="continente") +
  facet_wrap(continent ~ .) +
  theme_dark() +
  theme(legend.position = "bottom") +
  scale_color_viridis(option = "plasma", discrete = TRUE, direction = -1)



# Density

p <- covid_data %>% ggplot(aes(y=total_deaths_per_million, x=gdp_per_capita)) +
  scale_x_log10() + scale_y_log10() +
  geom_density_2d_filled() +
  labs(title="Grafico de densidad",  x="GDP per cápita", y="muertes totales por millón hbs.") 

p <- p + theme_bw()
  
# Guarda archivo

ggsave("miprimerggplot.pdf", p, width = 20, height = 20, units = "cm")
