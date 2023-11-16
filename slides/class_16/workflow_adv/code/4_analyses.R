##################### Descriptivos  ##################### 

# usando xtable

filename <- paste0(dirresults,"table_des1.tex") 

essdata_sub %>% group_by(cntry) %>%  
	dplyr::summarise(across(c("eisced", "age"), list(mean= ~ mean(.x, na.rm=T), sd= ~ sd(.x, na.rm=T)) )) %>%
	xtable() %>%
	print(file=filename)


#  usando stargazer
  
filename <- paste0(dirresults,"table_des2.txt") 

essdata_sub %>% tidyr::pivot_wider(names_from=cntry, values_from=c(eisced,age)) %>%
  dplyr::select(eisced_DE:age_IT) %>%
    as.data.frame() %>%
    stargazer(type="text", out=filename)


####################### Figuras ######################### 


jitter <- position_jitter(width = 1, height = 0.5)

mi_figura <- essdata_sub %>% filter(age>30) %>% ggplot(aes(x=yrbrn, y=eisced, colour=gndr_string)) +
  geom_point(alpha=0.1, position = jitter) +
	geom_smooth(method="lm",se=F) + 
  	scale_color_viridis(discrete=TRUE, option="plasma") +
    labs(x="año de nacimento", y="máxima educación alcanzada", colour="genero")

filename <- paste0(dirresults,"mi_figura.pdf") 
ggsave(filename, mi_figura, width = 25, height = 20, units = "cm") # guarda ggplot en archivo



################## Modelos de Regresión ################## 


# Fit linear model

model1 <- lm(eisced ~ age + factor(gndr_string), data=essdata_sub); model1


# Update modelo existente 
model2 <- update(model1, . ~ . + factor(gndr_string)*age); model2



# exportar resultados a una tabla latex

filename <- paste0(dirresults,"mi_tablareg.txt")


stargazer(model1, model2, type="text",
          covariate.labels=c("Age","Gender (Male=1)", "Gender*Age","Intercepto"),
          dep.var.labels=c("Education","Education"),
          out=filename)


cat("================ ANÁLISIS LISTOS !!!! ====================") # Debugging flags


