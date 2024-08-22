
################################################## Preámbulo #################################################

# Limpiar pantalla y remover objetos existentes
cat("\014") 
rm(list = ls())

# Carga paquetes


################################################# Directorios #################################################


# Change the line below to set your own working directory

folder <- "tudirectorio"
dircode     <- paste0(folder,"code/") 
dirdata 	  <- paste0(folder,"data/") 
dirresults  <- paste0(folder,"results/");  dirresults


############################################# Importar datos ################################################# 


# Set working directory
getwd()
setwd(dirdata)
getwd()

mydata <- "cargarslosdatosaquí"



########################################## Exploración de datos ##############################################


# Llama otro R script que contiene análisis. 
# Organizar el trabajo de esta manera permite que el código sea más legible y manejable.


# Establece el directorio de trabajo correspondiente
setwd(dircode)
source("2_exploration.R")


############################################ Recodificación #################################################


# Establece el directorio de trabajo correspondiente
setwd(dircode)

source("3_recoding.R")


############################################## Data analysis #################################################


# Set working directory
setwd(dircode)

source("4_analyses.R")
