
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


# tabla educacion por nivel de ingreso, imprimir resultado 

table(essdata$eisced, essdata$hinctnta) 

print(table(essdata$eisced, essdata$hinctnta))



print("================ EXPLORACIÓN LISTA !!!! ====================") # Debugging flags


