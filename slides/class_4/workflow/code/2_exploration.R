
#################### Manipulates data #################### 

# Visualizar datos

essdata

dimensiones <- dim(essdata) # dimensiones, y guardo en objeto

head(essdata) # 6 primeras observaciones

tail(essdata)

attributes(essdata)

str(essdata)

summary(essdata)

summary(essdata$eisced)

summary(essdata$cntry)

# tabla educacion por nivel de ingreso, imprimir resultado 

table(essdata$eisced, essdata$hinctnta) 

print(table(essdata$eisced, essdata$hinctnta))



print("================ TODO OK CON LA EXPLORACIÓN !!!! ====================") # Debugging flags


