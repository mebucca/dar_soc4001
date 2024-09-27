 #7.1 (T1-5)  Crea una base de datos que contenga sólo las variables "type" and "prestige". Llama tal objeto "subdatos_duncan". 


subdatos_duncan <- duncan %>% select(type,prestige)



 #7.2 (T1-8) Crea una nueva variable llamada "educacion_agg". Asigna valor 1 a "educacion_agg" para aquellas observaciones en las cuales la variable "education" toma un valor por sobre la media. Asigna valor 0 a "educacion_agg" para aquellas observaciones en las cuales la variable "education" toma un valor igual o menor a la media.


education_promedio <- mean(duncan$education)
duncan$educacion_agg <- NA
duncan$educacion_agg[duncan$education > education_promedio] <- 1
duncan$educacion_agg[duncan$education <= education_promedio] <- 0


print("================ RECODIFICACIÓN LISTA !!!! ====================") # Debugging flags


