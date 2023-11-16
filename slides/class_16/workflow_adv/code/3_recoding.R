
# Seleccionar set de datos de interés

essdata_sub <-  essdata %>% select(idno,cntry,gndr,yrbrn,eisced,hinctnta)


# filtra filas que cumplen condición lógica 

essdata_sub <- essdata_sub %>% filter(cntry %in% c("DE","GB","FR","IT","ES"), yrbrn>1910)


# crea nueva variable

essdata_sub <- essdata_sub %>% mutate(age = 2019 - yrbrn)




# recodifica variable existente


essdata_sub <- essdata_sub %>% mutate(eisced = na_if(eisced, 55)) # eisced==55 es NA



essdata_sub <- essdata_sub %>% mutate(generation = if_else(yrbrn > 2000, "Millenial", "Viejo"))


essdata_sub <- essdata_sub %>%
 mutate(gndr_string = case_when(
	gndr == 1 ~ "Male",
	gndr == 2 ~ "Female"
	)
) %>% drop_na(gndr_string)


cat("================ RECODIFICACIÓN LISTA !!!! ====================") # Debugging flags

