#' ---
#' title: "Regression and Other Stories: Helicopters"
#' author: "Andrew Gelman, Jennifer Hill, Aki Vehtari"
#' date: "`r format(Sys.Date())`"
#' ---

#' Example data file for helicopter flying time exercise. See Chapter
#' 1 in Regression and Other Stories.
#' 
#' -------------
#' 

#+ setup, include=FALSE
knitr::opts_chunk$set(message=FALSE, error=FALSE, warning=FALSE, comment=NA)

#' **Load packages**
library("rprojroot")
root<-has_dirname("ROS-Examples")$make_fix_file()

#' **Load data**
helicopters <- read.table(root("Helicopters/data","helicopters.txt"), header=TRUE)

#' **Display the example data**
print(helicopters)
