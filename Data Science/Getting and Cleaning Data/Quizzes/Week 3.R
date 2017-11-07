#Q1
fURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fURL, destfile = "./data/housing.csv", method = "curl")
housing <- read.csv("./data/housing.csv")

names(housing)
table(housing$ACR)
table(housing$AGS)
#standard
housing$agricultureLocal2 <- ifelse(housing$ACR == 3 & housing$AGS > 3, 1, 0)

#with dplyr
housing <- mutate(housing, agricultureLocal = ifelse(ACR == 3 & AGS > 3, 1, 0))

head(housing[which(housing$agricultureLocal == 1),], 3)

#Q2
fURL2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(fURL2, destfile = "./data/jeff.jpeg", method = "curl")
image <- readJPEG("./data/jeff.jpg", native = TRUE)
quantile(image, probs = c(0.3, 0.8))


#Q3
URL1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
URL2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(URL1, destfile = "./data/gdp.csv", method = "curl")
download.file(URL2, destfile = "./data/edu.csv", method = "curl")

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
countries_3 <- arrange(countries, desc(GDPRank))
countries_3[13,"Country"]


#Q4
tapply(countries$GDPRank, countries$Income.Group, mean)


#Q5
countries_5 <- mutate(countries, GDPgroups = cut2(GDPRank, g = 5))
table(countries_5$GDPgroups, countries_5$Income.Group)
