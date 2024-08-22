#################### Basic data analysis  #################### 

# descriptives: calcula media y sd de una variable de interes




################ Modelos de Regresión ################## 

# Crea dos modelos de regresión y crea una tabla publicable usando stargazer(). Guarda la tabla en la carpeta resultados.


# Fit linear model

model1 <- lm(variabledependiente ~ variableindependiente1 ), data=tusdatos); model1


# Update modelo existente 
model2 <- lm(variabledependiente ~ variableindependiente1 + variableindependiente2 ), data=tusdatos); model2


# visualiza el "summary" de cada modelo

# exportar resultados a una linda tabla 

filename <- paste0(dirresults,"tutabla.txt")


stargazer(model1, model2, type="text", out=filename)


print("================ ANÁLISIS LISTOS !!!! ====================") # Debugging flags


