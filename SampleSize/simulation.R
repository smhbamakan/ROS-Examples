#' ---
#' title: "Regression and Other Stories: Sample size simulation"
#' author: "Andrew Gelman, Jennifer Hill, Aki Vehtari"
#' date: "`r format(Sys.Date())`"
#' ---

#' Sample size simulation. See Chapter 16 in Regression and Other Stories.
#' 
#' -------------
#' 

#+ setup, include=FALSE
knitr::opts_chunk$set(message=FALSE, error=FALSE, warning=FALSE, comment=NA)

#' **Load packages**
library("rprojroot")
root<-has_dirname("ROS-Examples")$make_fix_file()
library("rstanarm")

#' **Simulated data 1: predictor range (-0.5, 0.5)**
N <- 1000
sigma <- 10
y <- rnorm(N, 0, sigma)
x1 <- sample(c(-0.5,0.5), N, replace=TRUE)
x2 <- sample(c(-0.5,0.5), N, replace=TRUE)
fake <- data.frame(c(y,x1,x2))

#' **Fit models**
#+ results='hide'
fit_1a <- stan_glm(y ~ x1, data = fake, refresh = 0)
fit_1b <- stan_glm(y ~ x1 + x2 + x1:x2, data = fake, refresh = 0)
#+
print(fit_1a)
print(fit_1b)

#' **Simulated data 2: predictor range (0, 1)**
x1 <- sample(c(0,1), N, replace=TRUE)
x2 <- sample(c(0,1), N, replace=TRUE)

#' **Fit models**
#+ results='hide'
fit_2a <- stan_glm(y ~ x1, data = fake, refresh = 0)
fit_2b <- stan_glm(y ~ x1 + x2 + x1:x2, data = fake, refresh = 0)
#+
print(fit_2a)
print(fit_2b)


#' **Simulated data 2: predictor range (-1, 1)**
x1 <- sample(c(-1,1), N, replace=TRUE)
x2 <- sample(c(-1,1), N, replace=TRUE)

#' **Fit models**
#+ results='hide'
fit_3a <- stan_glm(y ~ x1, data = fake, refresh = 0)
fit_3b <- stan_glm(y ~ x1 + x2 + x1:x2, data = fake, refresh = 0)
#+
print(fit_3a)
print(fit_3b)
