
# Seleccionar set de datos de interés

vars <- c("cntry","gndr","yrbrn","eisced")

essdata_sub <- essdata[,vars]

dim(essdata_sub)

head(essdata_sub)


# filtra filas que cumplen condición lógica 
 
attach(essdata_sub)

essdata_sub <- essdata_sub[(cntry=="AT" | cntry=="BE") & yrbrn>1990, ]
dim(essdata_sub)

detach(essdata_sub)

attach(essdata_sub) # attach version re-escrita de los datos para evitar problemas

# crea nueva variable

age <- 2019 - yrbrn

essdata_sub$age <- 2019 - yrbrn

detach(essdata_sub)

attach(essdata_sub)  # attach version re-escrita de los datos para evitar problemas

mean(age, na.rm=T)


# recodifica variable existente


essdata_sub$generacion <- ifelse(yrbrn > 2000, "Millenial", "Viejo") # ejemplo simple: >2000 = millenial, else: viejo

essdata_sub$gndr_string <- ifelse(gndr == 1, "Male", ifelse(gndr == 2, "Female", NA)) # recodifica y adjunta a base de datos

sum(is.na(essdata_sub$gndr_string))
sum(is.na(essdata_sub$gndr))

detach(essdata_sub)


print("================ RECODIFICACIÓN LISTA !!!! ====================") # Debugging flags

