n <- 10000
x <- rnorm(n,mean=0,sd=1)
y <- 1 + log(abs(x)) - cos(2*exp(x)) +  rnorm(n,mean=0,sd=1)


misdatos <- tibble(x=x, y=y)