library(datasets)
data(iris)
?iris
str(iris)

tapply(iris$Sepal.Length, iris$Species, mean)
rowMeans(iris[,1:4])
apply(iris[, 1:4], 2, mean)

data(mtcars)
tapply(mtcars$mpg, mtcars$cyl, mean)
str(mtcars)
(abs(tapply(mtcars$hp, mtcars$cyl, mean)[1]-tapply(mtcars$hp, mtcars$cyl, mean)[3]))[[1]]

debug(ls)
ls()
