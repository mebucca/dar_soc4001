
################################################## Preámbulo #################################################

# Limpiar pantalla y remover objetos existentes
cat("\014") 
rm(list = ls())

# Carga paquetes

library("pacman")
p_load("haven",
       "tidyverse",
       "knitr",
       "viridis",
       "rmarkdown",
       "stargazer",
       "xtable",
       "tinytex")

################################################# Directorios #################################################


# Change the line below to set your own working directory

folder <- "/Users/Mauricio/Library/Mobile Documents/com~apple~CloudDocs/Teaching/ISUC/2024_2_data_analysis_r/repo/slides/class_16/workflow_adv/"
dircode    <- paste0(folder,"code/") 
dirdata 	 <- paste0(folder,"data/") 
dirresults <- paste0(folder,"results/")


############################################# Importar datos ################################################# 


# Set working directory

setwd(dirdata)
essdata <- read_dta("ESS8_subset.dta")


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


setwd(dircode)
source("4_analyses.R")


# Análisis por país

paises <- unique(essdata_sub$cntry)
paises_nombres <- c("Alemania","España","Francia","Inglaterra","Italia")


for (i in paises) {

  
cat("================ ANÁLISIS DATOS ",i, " ==================") # Debugging flags

	# Análisis por país
	essdata_sub_cntry <- essdata_sub %>% filter(cntry == i)
  #assign(paste0("base_",i),essdata_sub_cntry)
	
	setwd(dircode)
	source("5_analyses_bycountry.R")

## Reporte por país

setwd(dircode)
 	render(input = "6_reportes.Rmd",
        output_file=paste0(dirresults,"reporte_", i, ".docx"),
        params=list(new_title=paste("Reporte ", paises_nombres[which(paises==i)]))
        )

}






