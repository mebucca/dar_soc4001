library("pacman")
p_load(tidyverse,ggsci)

data_casen_csv <- read.csv("https://raw.githubusercontent.com/mebucca/dar_soc4001/master/data/sample_casen2017.csv")
data_casen_csv %>% glimpse()

misresultos <- data_casen_csv %>% nest(-c(educ)) %>%
  mutate(tabla = map(data, ~ table(.x$sexo,.x$ecivil))) %>% 
  mutate(chi_test = map(tabla, ~ chisq.test(.x))) %>%
  mutate(stat = map_dbl(chi_test, ~ .x$statistic))


misresultos %>% filter(educ < 20) %>% select(educ,stat) %>%  
  ggplot() +
  aes(x=educ, y=stat) +
  geom_point() +
  geom_smooth(method="lm") +
  labs(x="Nivel educacional", y="Chi-2 entre sexo y estado civil")
