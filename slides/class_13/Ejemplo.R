
data_casen_csv <- read.csv("https://raw.githubusercontent.com/mebucca/dar_soc4001/master/data/sample_casen2017.csv")
data_casen_csv %>% glimpse()

library("pacman")
p_load("ggsci")

#

data_casen_csv %>% 
  mutate(corte = if_else(log(yautcor) > 12,"Alto ingreso","Bajo ingreso")) %>%
  drop_na(corte) %>%
  ggplot() +
  aes(x=esc, y=log(yautcor), colour=factor(corte)) +
  geom_point(alpha=0.4) +
  labs(x="Años de escolaridad", y="log-ingresos", title=NULL) +
  scale_color_startrek()


data_casen_csv %>% group_by(sexo,esc) %>%
  summarise(promedio_ingreso = mean(yautcor, na.rm=T)) %>% 
  ggplot() +
  aes(x=esc, y=promedio_ingreso, group=factor(sexo), colour=factor(sexo)) +
  geom_point() +
  geom_smooth() +
  labs(x="Años de escolaridad", y="Promedio ingres", title=NULL,
       colour="Sexo") +
  scale_color_startrek()
  
 

