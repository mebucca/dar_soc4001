


library("tidyverse")
set.seed(232356456432)


###################### Preguntas Alejándro Ávalos ######################

tab1 <- tibble(group = sample(c("A","B"),100, replace=T), x= rnorm(100))

tab1 <- tab1 %>% group_by(group) %>%
  mutate(id = seq(1:n())) 

tab1_max <- tab1 %>% group_by(group) %>% summarise(max = max(id))


tab2 <- tibble(group = sample(c("A","B"),10, replace=T), x= rnorm(10))

tab2 <- tab2 %>% left_join(tab1_max, by="group") %>%
  group_by(group) %>%
  mutate(n = n()) %>%
  mutate(id = seq( first(max) +1, first(max) + first(n))) %>%
  select(-c(max,n))


set.seed(8972)
tabA <- tibble(group = sample(c("A","B"),100, replace=T), x= rnorm(100))

tabA <- tabA %>% group_by(group) %>%
  mutate(id = seq(1:n())) %>% ungroup()

set.seed(32434)


tabB <- tibble(group = sample(c("A","B"), 100, replace=T), x= rnorm(100))

tabB <- tabB %>% group_by(group) %>%
  mutate(id = seq(1:n())) %>% ungroup()


tabA %>% select(id,x) %>% left_join(tabB, by="id", suffix=c("_1","_2"))


###################### Preguntas David Jara ######################

mydf <- tab2 %>% nest(-group)

n_grupos <- length(unique(tab2$group))


for (i in 1:n_grupos) {
  df <- mydf$data[[i]]
  assign( paste0("df_",i), df )
}

