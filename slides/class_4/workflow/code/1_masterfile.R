
################################################### Preambulo ###################################################

# Limpiar pantalla y remover objetos existentes
cat("\014") 
rm(list = ls())

# Carga paquetes
library("readstata13")
library("psych")
library("scales")
library("stargazer")

library("pacman")
p_load(readstata13,psych,scales,stargazer)

################################################# Directorios #################################################


# Change the line below to set your own working directory

folder <- "~/Library/Mobile Documents/com~apple~CloudDocs/Teaching/ISUC/2023_2_data_analysis_r/repo/slides/class_4/workflow/"

dircode     <- paste0(folder,"code/") 
dirdata 	  <- paste0(folder,"data/") 
dirresults  <- paste0(folder,"results/");  dirresults



############################################# Importar datos ################################################# 


# Set working directory

setwd(dirdata)
getwd()

essdata <- read.dta13("ESS8_subset.dta", convert.factors=FALSE); essdata


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
