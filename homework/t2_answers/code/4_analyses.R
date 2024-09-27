 #- 8.1 Usa un loop para calcular la media y la desviación estándar de la variable "prestige" para las observaciones en cada uno de los niveles de la variable "educacion_agg". 
#Almacena los resultados en una matriz, donde las filas correspondan a cada nivel de "educacion_agg". 
#En la primera columna almacena la media y en la segunda la desviación estándar. Usa nombres informativos para filas y columnas. 
 

 resultados <- matrix(NA,2,2) 
 
 for (i in 1:2) {

 	 resultados[i,1] <- mean(duncan$prestige[duncan$educacion_agg == i - 1], na.rm = T)
 	 resultados[i,2] <- median(duncan$prestige[duncan$educacion_agg == i - 1],  na.rm = T)

}

colnames(resultados) <- c("media prestigio","mediana prestigio")
rownames(resultados) <- c("Educ bajo la media","Educ sobre la media")



 #- 8.2 Usa la función `write.table()` para almacenar la tabla en la carpeta `results`. Guarda esta tabla con el nombre "mi_table.txt". Documentación del comando en:
 
 file_name <- paste0(dirresults,"mi_table.txt")

 write.table(resultados, file = file_name)




 #- 8.3 Crea un scatterplot de las variables "prestige" and "education" y almacénalo en la carpeta `results` con el nombre "mi_grafico.jpeg".
 

dev.off()

filename <- paste0(dirresults,"mi_grafico.jpeg")
jpeg(file=filename, width=600, height=350)
plot(duncan$prestige,duncan$education, xlab="Prestigio", ylab="Educación")

dev.off()
