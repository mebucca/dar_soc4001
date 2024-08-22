
# Descargar en la base de datos en formato SPSS desde aquí:
#http://observatorio.ministeriodesarrollosocial.gob.cl/encuesta-casen-en-pandemia-2020
# Renombrar el archivo como "Casen_2020"

# Establecer directory de trabajo (cambiar a la ubicación en computador donde guardaron la base de datos)

getwd()
setwd("/Users/Mauricio/Library/Mobile Documents/com~apple~CloudDocs/Teaching/ISUC/2022_2_data_analysis_r/repo/slides/class_3")

# Importar datos Casen 2020 desde formato .sav (SPSS). Requiere paquete "foreign" para leer archivos .sav

install.packages("foreign")
library("foreign")

?foreign
??foreign
data_casen <-  read.spss("Casen_2020.sav", to.data.frame=TRUE)
?read.spss

# Visualizar datos (muchos = display en pantalla es desastrozo)

data_casen

dim(data_casen)
head(data_casen)
tail(data_casen)
attributes(data_casen)
str(data_casen)
summary(data_casen)


# Seleccionar set de datos de interés

vars <- c("comuna", "sexo", "edad", "esc", "educ" ,"yautcor", "ytotcor", "pobreza")

subdata_casen <- data_casen[,vars]

dim(subdata_casen)
head(subdata_casen)
str(subdata_casen)

# Summary

summary(subdata_casen)


# Transformar variables (ingresos en miles de pesos). Reemplaza la variable original

subdata_casen$yautcor <- subdata_casen$yautcor/1000
subdata_casen$ytotcor_nueva <- subdata_casen$ytotcor/1000

# Crea variable nueva

table(subdata_casen$pobreza)

subdata_casen$pobre <- 1
subdata_casen$pobre[subdata_casen$pobreza=="No pobres"] <- 0
subdata_casen$pobre[is.na(subdata_casen$pobreza)] <- NA


# tablas

table(subdata_casen$pobreza,subdata_casen$pobre)

prop.table(table(subdata_casen$pobreza))

# lo mismo que arriba pero guardando el objecto previamente
mitable <- table(subdata_casen$pobreza)
prop.table(mitable)


# tabla con proporciones

pov_educ <- table(subdata_casen$educ,subdata_casen$pobreza)

rows <- nrow(pov_educ) 
pov_educ <- pov_educ[-rows,] # excluyendo la última fila ("No Sabe")

prop.table(pov_educ) # % celda (tabla suma a 100)
prop.table(pov_educ, margin=1) # % fila (filas suman a 100)



########################### Ejercicio 1 ##############################

# Contruir una tabla de contingencia con la distribución educacional 
# para cada categoría de pobreza

prop.table(pov_educ, margin=2) # % columna (columnas suman a 100)

######################################################################


## Funciones básicas para vectores y variables

sum(subdata_casen$yautcor, na.rm = TRUE)   # suma
mean(subdata_casen$yautcor, na.rm = TRUE)   # promedio
sd(subdata_casen$yautcor)     # desviación estándar
max(subdata_casen$yautcor,na.rm = TRUE)    # máximo
which.max(subdata_casen$yautcor) # posición de valor máximo 
min(subdata_casen$yautcor)    # mínimo
which.min(subdata_casen$yautcor) # posición de valor mínimo 
rank(subdata_casen$yautcor)   # ranking de valores
median(subdata_casen$yautcor) # mediana
range(subdata_casen$yautcor, na.rm = TRUE)  # rango
unique(subdata_casen$sexo) # lista de elementos únicos
length(subdata_casen$yautcor) # largo


# Quantiles

quantile(subdata_casen$yautcor, p=0.5, na.rm = TRUE) # median
quantile(subdata_casen$yautcor, p=c(.2,.4,.6,.8), na.rm = TRUE) # calculando quintiles de ingreso
quantile(subdata_casen$yautcor, p=seq(0,1,by=0.1), na.rm = TRUE) # deciles
quantile(subdata_casen$yautcor, p=seq(0,1,by=0.05), na.rm = TRUE) # veintiles


# Funciones de paquetes

install.packages("ineq")
library("ineq")
?ineq
??ineq

?Gini
Gini(subdata_casen$yautcor, corr = TRUE, na.rm = TRUE)

# Funciones propias 

qs <- quantile(subdata_casen$yautcor, p=c(.1,.9), na.rm = TRUE); qs
qs[1]; qs[2]
# función que calcula ratio 90-10 (ratio entre ingreso del decil 9 y el decil 1)




########################### Ejercicio 2 ##############################

# Contruir una función llamada "ratio9010" que calcule la razon entre
# el percentil 90 y el percentil 10 de una variable x. Recuenda omitir
# valors perdidos


ratio9010 <- function(x){
  qq <- quantile(x, p=c(.1,.9), na.rm = TRUE)
  ratio <- qq[2]/qq[1]
  names(ratio) <- "r9010"
  return(ratio)
} 

ratio9010(subdata_casen$yautcor)
ratio9010(subdata_casen$esc)


######################################################################


# Filtrar casos y aplicar nuestra función a un subconjunto de datos

ratio9010(subdata_casen$yautcor[subdata_casen$comuna=="Iquique"])
ratio9010(subdata_casen$yautcor[subdata_casen$comuna=="Vitacura"])

Gini(subdata_casen$yautcor[subdata_casen$comuna=="Iquique"], corr = FALSE, na.rm = TRUE)
Gini(subdata_casen$yautcor[subdata_casen$comuna=="Vitacura"], corr = FALSE, na.rm = TRUE)



## for loops

# iteración: para cada valor de i calcula: i + (i-1), lo almacena en objeto x y lo imprime.
# por ejemplo. Si i=5 entonces x= 5 + 4 = 9

for (i in 1:10) {
  x <- i + (i-1)
  print(x)
}


# iteración: define un conjunto de comunas, calcula ratio 90-10 de ingresos para cada comuna y guarda resultado en un vector.

table(subdata_casen$comuna)

comunas <- c("Arica", "Providencia", "Macul") # lista de comunas
ratios <- rep(NA,length(comunas)) # crea vector vacio con el mismo largo que el numero de comunas. Aca guardaremos resultados

pos=1 # este valor se usará para definir posición de cada resultado en vector "ratios"

for (j in comunas) {

  ratios[pos] <- ratio9010(subdata_casen$yautcor[subdata_casen$comuna==j])
  pos = pos + 1

}

ratios


########################### Ejercicio 3 ##############################


# Usando un loop calcula promedio de ingreso, ratio9010 y Gini para cada comuna y lo almacena en una matriz
# pon comunas en las filas y las tres medidas (promedio, ratio9010 y Gini) en las columnas.
# para obtener lista y numbero de comunas usa el siguiente código:

comunas  <- unique(subdata_casen$comuna)
ncomunas <- length(comunas)


resultados <- matrix(NA, nrow = ncomunas, ncol = 3 ) 

row=1
for(i in comunas){
  resultados[row,1] <- mean(subdata_casen$yautcor[subdata_casen$comuna==i], na.rm = T)
  resultados[row,2] <- ratio9010(subdata_casen$yautcor[subdata_casen$comuna==i])
  resultados[row,3] <- Gini(subdata_casen$yautcor[subdata_casen$comuna==i], corr = FALSE, na.rm = TRUE)
  row = row + 1
}

######################################################################


# agrega nombre filas y columnas y transforma 
# matriz en base de datos


colnames(resultados) <- c("promedio","r9010","gini")
rownames(resultados) <- comunas
resultados
resultados <- as.data.frame(resultados)


#Visualización

x <- seq(1:100)
y <- sin(x)
plot(x,y, type="l")


## Scatterplots

plot(resultados$promedio, resultados$gini, 
   xlab="Ingreso autonomo promedio en comuna", 
   ylab="Indice de Gini",
   type="p",  
   pch=16, 
   col="blue")

abline(lm(resultados$gini ~ resultados$promedio))

