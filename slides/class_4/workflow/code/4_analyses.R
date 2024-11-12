#################### Basic data analysis  #################### 

# descriptives

mean(essdata_sub$age, na.rm = T)
sd(essdata_sub$age, na.rm = T)
table(essdata_sub$gndr_string)


sapply(essdata_sub[,c("eisced", "age")], mean, na.rm=TRUE) 
sapply(essdata_sub[,c("eisced", "age")], sd, na.rm=TRUE) 


# by group
summary_table <- describeBy(essdata_sub[,c("eisced", "age")], essdata_sub$cntry)



#################### Plots  #################### 

filename <- paste0(dirresults,"miprimerplot.jpeg")
jpeg(file=filename, width=600, height=350)

par(mfrow=c(1,2))

# plot izquierda

unique(essdata$eisced)
essdata$eisced <- ifelse(essdata$eisced==55, NA, essdata$eisced)

#plot(essdata$eisced, essdata$hinctnta)

#plot(jitter(essdata$eisced,2), jitter(essdata$hinctnta,2), pch=16, col="blue", 
#     xlab="Education", ylab="Income")

plot(jitter(essdata$eisced,1), jitter(essdata$hinctnta,2), 
  col = rgb(red = 0, green = 0, blue = 1, alpha = 0.05),
     pch = 16,xlab="Education", ylab="Income")

countries <- unique(essdata$cntry)

for (c in countries) {
  data_country <- essdata[essdata$cntry==c,] 
  abline(lm(hinctnta ~ eisced, data=data_country), col="red")
}

# plot derecha
hist(essdata$eisced, col="green")

dev.off()



################ Modelos de Regresión ################## 


# Fit linear model

model1 <- lm(eisced ~ age + factor(gndr_string), data=essdata_sub); model1


# Update modelo existente 
model2 <- update(model1, . ~ . + factor(gndr_string)*age); model2


# acceder al output 

names(model2)

model2$coefficients 
model2$residuals 


# summary del modelo

sum_model2 <- summary(model2); sum_model2 
names(sum_model2)

sum_model2$r.squared
sum_model2$sigma


# exportar resultados a una linda tabla 

filename <- paste0(dirresults,"miprimeratabladeregresion.txt")



stargazer(model1, model2, type="text",
          covariate.labels=c("Age","Gender (Male=1)", "Gender*Age","Intercep"),
          dep.var.labels=c("Education","Education"),
          out=filename)


print("================ ANÁLISIS LISTOS !!!! ====================") # Debugging flags


