#setting the directory
setwd("~/Dropbox/MOOC/Kursy/Data Science Specialization/Getting and Cleaning Data/Quizzes")

#downloading the file
if(!file.exists("data")){
      dir.create("data")
}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileURL, destfile = "data/idaho.csv", method = "curl")

#loading to R
idaho <- read.csv("idaho.csv")

#questions
str(idaho)
table(idaho$VAL)
str(idaho$FES)
summary(idaho$FES)
table(idaho$FES)

library(xlsx)
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileURL, destfile = "data/gas.xlsx", method = "curl")
gas <- read.xlsx("data/gas.xlsx", sheetIndex = 1, rowIndex = 18:23, colIndex = 7:15)
sum(gas$Zip*gas$Ext,na.rm=T)

library(XML)
fileURL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(fileURL, useInternalNodes = TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
rootNode[[1]][[1]][[2]]
zipcodes <- xpathSApply(doc, "//zipcode", xmlValue)
zipcodes_t <- zipcodes[zipcodes == "21231"]

library(data.table)
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileURL, destfile = "data/microdata.csv", method = "curl")
DT <- fread("data/microdata.csv")
tables()
DT[2,]


tapply(DT$pwgtp15,DT$SEX,mean)
DT[,mean(pwgtp15),by=SEX]
