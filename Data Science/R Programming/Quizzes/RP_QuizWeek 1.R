x <- 4
class(x)
class(x<-c(4, TRUE, "a"))
x <- list(2, "a", "b", TRUE)
x[[1]]
x <- 1:4
y <- 2:3
x+y
class(x+y)

x <- list(2, "a", "b", TRUE)
x[[2]]



head(data)
tail(data)
data[47,1]
table(is.na(data$Ozone))

mean(data$Ozone, na.rm = TRUE)

subset1 <- subset(data, Ozone > 31 & Temp > 90)
mean(subset1$Solar.R)
subset2 <- subset(data, Month == 6)
mean(subset2$Temp)
subset3 <- subset(data, Month == 5)
max(subset3$Ozone, na.rm = TRUE)

x <- 4L
class(x)
class(c(4, "a", TRUE))

x <- c(17, 14, 4, 5, 13, 12, 10)
x[x >= 10] <- 4
