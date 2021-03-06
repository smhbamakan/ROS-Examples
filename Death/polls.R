#' ---
#' title: "Regression and Other Stories: Death penalty poll"
#' author: "Andrew Gelman, Jennifer Hill, Aki Vehtari"
#' date: "`r format(Sys.Date())`"
#' ---

#' Death penalty poll - Proportion of American adults supporting the death
#' penalty. See Chapter 4 in Regression and Other Stories.
#' 
#' -------------
#' 

#+ setup, include=FALSE
knitr::opts_chunk$set(message=FALSE, error=FALSE, warning=FALSE, comment=NA)
# switch this to TRUE to save figures in separate files
savefigs <- FALSE

#' **Load packages**
library("rprojroot")
root<-has_dirname("ROS-Examples")$make_fix_file()
library("ggplot2")
theme_set(bayesplot::theme_default(base_family = "sans"))

#' **Percentage support for the death penalty**
#+ eval=FALSE, include=FALSE
if (savefigs) postscript(root("Death/figs","polls.ps"), horizontal=TRUE)
#+
par(mar=c(5,5,4,2)+.1)
polls <- matrix(scan(root("Death/data","polls.dat")), ncol=5, byrow=TRUE)
support <- polls[,3]/(polls[,3]+polls[,4])
year <-  polls[,1] + (polls[,2]-6)/12
plot(year, support*100, xlab="Year",
      ylab="Percentage support for the death penalty", cex=2, cex.main=2,
      cex.axis=2, cex.lab=2, type="l")
#+ eval=FALSE, include=FALSE
if (savefigs) dev.off()

#' ggplot version
poll <- data.frame(support, year)
ggplot(aes(x = year, y = support*100), data = poll) + geom_line() +
    labs(x= "Year", y = "Percentage support for the death penalty")

#+ eval=FALSE, include=FALSE
if (savefigs) postscript(root("Death/figs","states.ps"), horizontal=TRUE)
#+
death <- read.table(root("Death/data","dataforandy.txt"), header=TRUE)
ex.rate <- death[,7]/100
err.rate <- death[,6]/100
hom.rate <- death[,4]/100000
ds.per.homicide <- death[,2]/1000
ds <- death[,1]
ex <- ex.rate*ds
err <- err.rate*ds
hom <- ds/ds.per.homicide
pop <- hom/hom.rate
state.abbrs <- row.names(death)
std.err.rate <- sqrt((err+1)*(ds+1-err)/((ds+2)^2*(ds+3)))
par(mar=c(5,5,4,2)+.1)
plot(ds/hom, err.rate, xlab="Death sentences per homicide",
      ylab="Rate of reversal of death sentences", cex=2, cex.main=2,
      cex.axis=2, cex.lab=2, type="n")
text(ds/hom, err.rate, state.abbrs, cex=1.5)
for (i in 1:length(ds)){
  lines(rep(ds[i]/hom[i],2), err.rate[i] + c(-1,1)*std.err.rate[i], lwd=.5)
}
#+ eval=FALSE, include=FALSE
if (savefigs) dev.off()

#' ggplot version
poll <- data.frame(ds, hom, err.rate, std.err.rate, state.abbrs)
ggplot(aes(x = ds/hom, y = err.rate,
           ymin = err.rate - std.err.rate, ymax = err.rate + std.err.rate),
       data = poll) + geom_pointrange() +
    labs(x= "Death sentences per homicide",
         y = "Rate of reversal of death sentences") +
    geom_text(aes(label=state.abbrs), hjust = "right", nudge_x=-0.0005)

#+ eval=FALSE, include=FALSE
if (savefigs) postscript(root("Death/figs","deathpolls.ps"), horizontal=TRUE)
#+
par(mar=c(5,5,4,2)+.1)
polls <- matrix(scan(root("Death/data","polls.dat")), ncol=5, byrow=TRUE)
support <- polls[,3]/(polls[,3]+polls[,4])
year <-  polls[,1] + (polls[,2]-6)/12
plot(year, support*100, xlab="Year", ylim=c(min(100*support)-1, max(100*support)+1),
      ylab="Percentage support for the death penalty", cex=2, cex.main=2,
      cex.axis=2, cex.lab=2, pch=20)
for (i in 1:nrow(polls))
  lines(rep(year[i],2), 100*(support[i]+c(-1,1)*sqrt(support[i]*(1-support[i])/1000)))
#+ eval=FALSE, include=FALSE
if (savefigs) dev.off()

#' ggplot version
poll <- data.frame(support, year, sd = sqrt(support*(1-support)/1000))
ggplot(aes(x = year, y = support*100,
           ymin = 100*(support-sd), ymax =  100*(support+sd)),
       data = poll) + geom_pointrange() +
    labs(x= "Year", y = "Percentage support for the death penalty")
