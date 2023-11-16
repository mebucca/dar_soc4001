library("tidyverse")
library("broom")
library("viridis")


setwd(
  "~/Library/Mobile Documents/com~apple~CloudDocs/Teaching/ISUC/2020_2_data_analysis_r/repo/slides/class_12/")

# leer archivo csv
covid_data <- read_delim("covid_data.csv", delim=";")

covid_data <- covid_data %>% filter(date==as.Date("2020-11-17")) 
covid_data  %>% glimpse()




# Purrr



covid_data <- covid_data %>% 
  dplyr::select(continent,location,total_cases_per_million, 
                total_deaths_per_million, population_density,median_age, gdp_per_capita) %>%
  pivot_longer(cols=c(total_cases_per_million,total_deaths_per_million), 
               names_to="dv", values_to="y") %>% 
  pivot_longer(cols=c(population_density,median_age,gdp_per_capita), 
               names_to="iv", values_to="x")  


fit_lm <- covid_data %>% group_by(continent,dv,iv) %>% nest() %>%
  mutate(fit = map(data, ~ lm(y ~ x, data = .x))) %>% 
  mutate(coefs = map(fit, tidy)) %>% 
  unnest(cols = c(continent,dv,iv,coefs)) %>% select(-c(data,fit))


# Nota: como acceder a una base de datos en particular
#a <- covid_data %>% group_by(continent,dv,iv) %>% nest()
#a$data[[which(a$dv=="total_cases_per_million" & a$iv=="median_age" & a$continent=="Europe")]]


plot <- fit_lm %>% filter(term=="x") %>%  
  ggplot(aes(x=continent, y=estimate, fill=continent)) +  
  geom_col() + facet_wrap(dv ~ iv, scales="free_y") +
  scale_fill_viridis_d() +
  theme_bw()
