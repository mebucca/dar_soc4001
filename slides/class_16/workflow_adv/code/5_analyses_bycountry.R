##################### Descriptivos  ##################### 

# usando xtable

filename <- paste0(dirresults,"table_des1_",i,".tex") 

essdata_sub_cntry %>% 
	dplyr::summarise(across(c("eisced", "age"), list(mean= ~ mean(.x, na.rm=T), sd= ~ sd(.x, na.rm=T)) )) %>%
	as.data.frame() %>%
	xtable() %>%
	print(file=filename)


#  usando stargazer


filename <- paste0(dirresults,"table_des2_",i,".txt") 

essdata_sub_cntry %>% 
  select(eisced,age) %>%
    as.data.frame() %>%
    stargazer(out=filename, type = "text")


####################### Figuras ######################### 


jitter <- position_jitter(width = 1, height = 0.5)

titulo <- paste0("Relación entre año de nacimento y educación en ",i)

mi_figura <- essdata_sub_cntry %>% filter(age>30) %>% ggplot(aes(x=yrbrn, y=eisced, colour=gndr_string)) +
	geom_point(alpha=0.2, position = jitter) +
	geom_smooth(method="lm",se=F) + 
  	scale_color_viridis(discrete=TRUE, option="plasma") +
    labs(x="año de nacimento", y="máxima educación alcanzada", colour="genero", title=titulo)


filename <- paste0(dirresults,"mi_figura_",i,".pdf") 
ggsave(filename, mi_figura, width = 12, height = 10, units = "cm")




################## Modelos de Regresión ################## 


# Fit linear model

model1 <- lm(eisced ~ age + factor(gndr_string), data=essdata_sub_cntry); model1


# Update modelo existente 
model2 <- update(model1, . ~ . + factor(gndr_string)*age); model2



# exportar resultados a una tabla latex

filename <- paste0(dirresults,"mi_tablareg_",i,".txt")


stargazer(model1, model2, type="text",
          covariate.labels=c("Age","Gender (Male=1)", "Gender*Age","Intercepto"),
          dep.var.labels=c("Education","Education"),
          out=filename)


print("================ ANÁLISIS LISTOS !!!! ====================") # Debugging flags


