n <- 10000
x <- rnorm(n,mean=0,sd=1)
y <- 1 + log(abs(x)) - cos(2*exp(x)) +  rnorm(n,mean=0,sd=1)

misdatos <- tibble(x=x, y=y)

library("tidyverse")


misdatos  %>%
  ggplot(aes(x=x,y=y)) +
  geom_density2d_filled() +
  geom_density_2d(colour="white") 
