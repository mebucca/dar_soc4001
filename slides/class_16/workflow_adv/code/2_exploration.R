
#################### Manipulates data #################### 


# tabla educacion por nivel de ingreso, imprimir resultado 

essdata %>% with(table(eisced,hinctnta)) %>% knitr::kable()


cat("================ EXPLORACIÓN LISTA !!!! ====================") # Debugging flags


