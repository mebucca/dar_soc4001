library("tidyverse")
library("broom")
library("viridis")
library("readr") 

setwd(
  "~/Library/Mobile Documents/com~apple~CloudDocs/Teaching/ISUC/gentle-ggplot2/data/")

# leer archivo csv
data_casen_csv <- read_csv("sample_casen2017.csv")

data_casen_csv <- data_casen_csv %>% mutate(y = log(ytotcor)) %>% drop_na(y)

# media y sd en muestra
stats <- c(mu= mean(data_casen_csv$y), sd= sd(data_casen_csv$y)); stats

n = length(data_casen_csv$y)

# sd of mu_hat  = sigma/sqrt(n)
sd_mu_hat; stats["sd"]/sqrt(n)



set.seed(13232)


#  Demonstration of the distrution of mu_hat across 1000 samples of size n.

mues_hat = NULL

for (i in 1:1000) {
  
  una_muestra <- rnorm(n,stats["mu"],stats["sd"] )
  mu_hat <- mean(una_muestra) 
  mues_hat <- c(mues_hat,mu_hat)
  
}


# Mean and SD of mu_hat 

mean_mu_hat <- mean(mues_hat)
sd_mu_hat  <- sd(mues_hat)

# mean of mu_hat  = mu
mean_mu_hat; stats["mu"]

# sd of mu_hat  = sigma/sqrt(n)
sd_mu_hat; stats["sd"]/sqrt(n)

# Distribution of mu_hat: approximately normal
hist(mues_hat)
abline(v = mean(mues_hat), col="red", lwd=3, lty=2)


# 95% confidence interval

quantile(mues_hat, p=c(0.025,0.975))
ci = stats["mu"] + c(-1.96,1.96)*(stats["sd"]/sqrt(n)); ci

