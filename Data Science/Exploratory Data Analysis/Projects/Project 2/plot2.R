library(tidyverse)

# reading in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# plot2
baltimore <- NEI %>%
  filter(fips == 24510) %>%
  group_by(year) %>%
  summarise(sums = sum(Emissions))



png("plot2.png")
barplot(baltimore$sums, names.arg = baltimore$year, col = "darkred",
        main = "Total emission of PM2.5 in Baltimore City", xlab = "Year", ylab = "Emission [t]")
dev.off()