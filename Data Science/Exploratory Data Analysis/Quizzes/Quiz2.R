#Q2
library(nlme)
library(lattice)
xyplot(weight ~ Time | Diet, BodyWeight)

#Q4
ibrary(lattice)
library(datasets)
data(airquality)
p <- xyplot(Ozone ~ Wind | factor(Month), data = airquality)

#Q7
library(ggplot2)
library(datasets)
data(airquality)

airquality = transform(airquality, Month = factor(Month))
g <- qplot(Wind, Ozone, data = airquality, facets = . ~ Month)

qplot(Wind, Ozone, data = airquality, facets = . ~ factor(Month))
qplot(Wind, Ozone, data = airquality, geom = "smooth")

#Q9
library(ggplot2)
g <- ggplot(movies, aes(votes, rating))
print(g)

#Q10
qplot(votes, rating, data = movies)
