setwd("~/Dropbox/MOOC/Kursy/Data Science Specialization/Getting and Cleaning Data/Quizzes")
#question 1
library(httr)
library(jsonlite)
repo <- GET("https://api.github.com/users/jtleek/repos")
repo_j <- fromJSON("https://api.github.com/users/jtleek/repos")
repo_j$created_at[7]

#q2
install.packages("sqldf")
library(sqldf)
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileURL, destfile = "data/acs.csv", method = "curl")
acs <- read.csv("data/acs.csv")
table(sqldf("SELECT pwgtp1 FROM acs WHERE AGEP < 50"))

#q3
length(unique(acs$AGEP))
sqldf("select DISTINCT AGEP from acs")




#q4
con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
close(con) #close the connection

for (i in c(10, 20, 30, 100)) {
      print(nchar(htmlCode[i]))
}


#q5
urlek <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(urlek, destfile = "./data/filek.for", method = "curl")

filek <- read.fwf("data/filek.for", widths = c(13, 6, 1, 3, 4, 5, 1, 3, 5, 4, 1, 150), skip = 4); head(filek, 3)
filek2 <- read.fwf("data/filek.for", widths = 10000)
head(filek2, 10)
colnames(filek)
head(filek$V1, 10)
sum(filek$V6)
