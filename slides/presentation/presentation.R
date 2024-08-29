library(rvest)
library(tidyverse)
library(pals)
library(ggdark)

pagina <- read_html("https://es.wikipedia.org/wiki/Anexo:Presidentes_de_Chile")

republica <- pagina %>%
  html_node(xpath = "/html/body/div[3]/div[3]/div[5]/div[1]/table[3]") %>%
  html_table() %>% select(1,3,4,5,7) %>% 
  as_tibble(.name_repair = ~ c("mandato","presidente","inicio","fin","partido"))

cons_lib <- pagina %>%
  html_node(xpath = "/html/body/div[3]/div[3]/div[5]/div[1]/table[5]") %>%
  html_table() %>% select(1,3,4,5,7,9) %>% 
  as_tibble(.name_repair = ~ c("mandato","presidente","inicio","fin","partido","coalicion")) %>%
  mutate(partido = if_else(grepl("Independiente", partido),coalicion,partido)) %>%
  mutate(partido = if_else(partido=="","Independiente",partido)) %>%
  select(-coalicion)


parlam <- pagina %>%
  html_node(xpath = "/html/body/div[3]/div[3]/div[5]/div[1]/table[8]") %>%
  html_table() %>% select(1,3,4,5,7,9) %>% 
  as_tibble(.name_repair = ~ c("mandato","presidente","inicio","fin","partido","coalicion")) %>%
  mutate(partido = if_else(grepl("Independiente", partido),coalicion,partido)) %>%
  mutate(partido = if_else(partido=="","Independiente",partido)) %>%
  select(-coalicion)


pres <- pagina %>%
  html_node(xpath = "/html/body/div[3]/div[3]/div[5]/div[1]/table[10]") %>%
  html_table() %>% select(1,3,4,5,7,9) %>% 
  as_tibble(.name_repair = ~ c("mandato","presidente","inicio","fin","partido","coalicion")) %>%
  mutate(partido = if_else(grepl("Independiente", partido),coalicion,partido)) %>%
  mutate(partido = if_else(partido=="","Independiente",partido)) %>%
  select(-coalicion)


demoh <- pagina %>%
  html_node(xpath = "/html/body/div[3]/div[3]/div[5]/div[1]/table[14]") %>%
  html_table() %>% select(1,3,4,5,7,9) %>% 
  as_tibble(.name_repair = ~ c("mandato","presidente","inicio","fin","partido","coalicion")) %>%
  mutate(partido = if_else(grepl("Independiente", partido),coalicion,partido)) %>%
  mutate(partido = if_else(partido=="","Independiente",partido)) %>%
    select(-coalicion)

presidentes <- bind_rows(republica,cons_lib,parlam,pres,demoh) 

presidentes <- presidentes %>%
  filter(grepl("Presidente de la República|Presidenta de la República", mandato)) %>% 
  separate(inicio, into=c("fecha","inicio"), - 4, convert = T) %>% select(-fecha,) %>%
  separate(fin, into=c("fecha","fin"), - 4, convert = T) %>% select(-fecha,-mandato) %>%
  separate(partido, into=c("partido","otro"), sep = "([.[.])") %>% select(-otro) %>%
  mutate(partido = if_else(presidente=="Ricardo Lagos Escobar","Socialista",partido)) %>%
  mutate(fin = if_else(inicio==2018,"2021",fin)) %>% mutate(fin=as.numeric(fin)) %>% 
  mutate(n=1)  %>%  arrange(inicio) %>% group_by(partido) %>% mutate(csum_pres = cumsum(n), ultimo=last(inicio)) 

presidentes %>% ggplot(aes(x=inicio, y=csum_pres, color=reorder(partido, ultimo))) + geom_point() + geom_line() +
  labs(x="Año", y="Número acumulado de Presidentes", colour="Partido/Coalición") +
  scale_color_manual(values=as.vector(stepped3(16))) + dark_theme_grey()
  