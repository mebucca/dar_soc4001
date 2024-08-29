# Script clase 1

## Primeros pasos en R: 

"Hello world" # texto
log(4 + exp(0)) # número
4==7 # evaluación lógica


## Packages
p <- c("tidyverse","modelr")
install.packages(p) # instala paquete

library("tidyverse") # carga paquete

?tidyverse # ayuda paquetes
?lm # ayuda funciones
?anova

## Working directory

# fija directorio de trabajo
setwd("~/Library/Mobile Documents/com~apple~CloudDocs/Teaching/ISUC/2020_2_categorical_data_analysis/hw_ans")
getwd() # chequea directorio de trabajo

## Operadores básicos

2 + 2      # suma
2/2        # división
2*2        # multiplicación
2^2        # exponente
sqrt(2)    # raiz cuadrada
log(2)     # log
exp(2)     # exponencial
2 == 2     # evaluación lógica
42 >= 2    # evaluación lógica
2 <= 42    # evaluación lógica
2 != 42    # evaluación lógica
23 %/% 2   # division por entero -> 11
23 %% 2    # el remanente -> 1

raiz2 <- sqrt(2) # crea objeto que contiene resultado de operación matemática



## Tipos de datos

1L          # entero
1.0         # numérico
"1"         # texto o "string"
TRUE == 1   # lógica
FALSE == 0  # lógica
NA          # valor perdido
factor()    # factor

x <- 2*2
class(x)
is.numeric(x)

##Símbolos básicos

x <- 1        # operador de asignación
              # más comentario

x = 1         # igual, operador de asignación
x == 1        # evaluación lógica
y <- sample(1:100,10); y  # muestra de 10 valores seleccionados aleatoriamente entre 1 y 100
y <- y[c(1,6,3)]   # selection de elementos en posición 1,6,3 y re-escribe y
sort(y)       # ordena de mayor a menor
rm(x)         # remover un objeto   


## Funciones


# funcion que suma todo los elementos de un vector y divide por la cantidad elemento: promedio

mi_promedio <- function(x) {
  suma <- sum(x)
  n    <- length(x)
  return(suma/n)
}

mi_promedio(y) # evalua función con y como input
  
y2 <- sample(1:1000, 50) # creo otro vector y2

mi_promedio(y2) # evalua función con y2 como input


# función con texto

my_fn2 <- function(x){
  fx <- paste(x,"!!!") #<<
return(fx)
}
my_fn2("usa R")


## Vectores

x <- c(1, 2, 3, 4, 5)
y <- c(6:10)
z <- c(x,y); z
u <- c("a","b","c")
v <- letters[4:6]
w <- c(u,v); w

## Construcción de vectores

# repetición de un elemento
rep(3,5)
# sequencia desde, hasta, 'by"
seq(4,12,by=2)
# sequencia desde, largo n
seq(4,9,length.out = 5)
# muestra aleatoria dentro de un rango
sample(1:50,5)
# muestra aleatoria dentro de un rango
sample(1:50,5)


## Operaciones con vectores:

x <- c(1,5,2)
y <- c(1,2,3)

# adición
x + y

# multiplicación/division por una contante (elemento-por-elemento)
y/2

# multiplicación/division por otro vector (elemento-por-elemento)
x*y


## Matrices: juntando vectores con igual dimensión

# column-bind
cbind(x,y)   # matriz 3 x 2

# row-bind
rbind(x,y)   # matriz 2 x 3


## Matrices: función 'matrix'

x <- 1:10

matrix(x, nrow=2, ncol=5, byrow=TRUE)

matrix(x, nrow=2, ncol=5, byrow=FALSE)

## Reciclaje matrices

matrix(1:5, nrow=2, ncol=5, byrow=FALSE)



## Strings (texto)

mystr <- "texto"; mystr

paste(mystr, "!!", sep="")

paste( c(mystr,"!","!"), collapse = "-")



## Factors

x <- rep(1:3, 2); x # "replicate" secuencia 1:3 dos veces

factor_x <- factor(x, levels=c(1, 2, 3), labels=c("A","B","C")); factor_x

y <- 10:15
lm(y ~ factor_x)

## Reordernar etiquetas de factores 
  
factor_x <- factor(x, levels=c(2, 1, 3), labels=c("B","C","A")); factor_x

lm(y ~ factor_x)


## Extraer valores y etiquetas de factores

as.numeric(factor_x)

as.character(factor_x)


