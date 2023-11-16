# leer archivo csv
library("pacman")
p_load(tidyverse,ggsci)
data_casen_csv <- read.csv("https://raw.githubusercontent.com/mebucca/dar_soc4001/master/data/sample_casen2017.csv")
data_casen_csv %>% glimpse()



data_casen_csv %>% 
  mutate(corte = if_else(log(ytotcor) > 12,1,0)) %>%
  drop_na(corte) %>%
  ggplot() + 
  aes(x=esc, y=log(ytotcor), group=factor(corte), colour=factor(corte)) +
  geom_point(alpha=0.5) +
  labs(x="Años de escolaridad", y= "(log) Ingreso Autónomo", colour="Corte") +
  scale_color_startrek()


data_casen_csv %>% group_by(esc,sexo) %>%
  summarise(promedio_ingresos = mean(ytotcor, na.rm=T)) %>%
  ggplot() +
  aes(x=esc, y=promedio_ingresos, group=factor(sexo), colour=factor(sexo)) +
  geom_point() +
  geom_smooth() +
  scale_color_startrek()



