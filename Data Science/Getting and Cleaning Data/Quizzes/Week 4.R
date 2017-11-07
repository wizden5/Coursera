#Q1
setwd("~/Dropbox/MOOC/Kursy/Data Science Specialization/Getting and Cleaning Data")
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(URL, destfile = "./data/us.csv", method = "curl")

us <- read.csv("./data/us.csv", stringsAsFactors = FALSE)
names(us)
strsplit(names(us), "wgtp")[123]


#Q2
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(URL, destfile = "./data/gdp.csv", method = "curl")
gdp <- read.csv("./data/gdp.csv", stringsAsFactors = FALSE, skip = 4, nrows = 190)

gdp$X.4 <- gsub(",", "", gdp$X.4)
gdp$X.4 <- as.numeric(gdp$X.4)
mean(gdp$X.4)


#Q3
grep("^United", gdp$X.3, value = TRUE)

#Q4
gdp <- read.csv("./data/gdp.csv", stringsAsFactors = FALSE, nrow = 190, skip = 4)
edu <- read.csv("./data/edu.csv", stringsAsFactors = FALSE)


#gdp
str(gdp)
sapply(gdp, table)
gdp <- select(gdp, X, Gross.domestic.product.2012, X.2, X.3)
names(gdp)
gdp <- rename(gdp, Code = X, GDPRank = X.1, Country = X.3, GDP = X.4)
gdp$GDPRank <- as.numeric(gdp$GDPRank)
str(gdp$GDPRank)

countries <- merge(edu, gdp,  by.x = "CountryCode", by.y = "Code")

library(lubridate)
names(countries)
head(countries$Special.Notes)
length(grep("end: June", countries$Special.Notes, value = TRUE))


#Q5
install.packages("quantmod")
library(quantmod)
amzn = getSymbols("AMZN", auto.assign=FALSE)
sampleTimes = index(amzn)

sampleTimes[1:10]
years(sampleTimes)
years <- format(sampleTimes, "%Y")
table(years)

chosen <- sampleTimes[format(sampleTimes, "%Y") == "2012"]
table(wday(chosen, label = TRUE))
