library(tidyverse)

# reading in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# plot1
emissions_sum <- NEI %>%
  group_by(year) %>%
  summarise(sums = sum(Emissions))

png("plot1.png")
barplot(emissions_sum$sums, names.arg = emissions_sum$year, col = "darkred",
        main = "Total emission of PM2.5", xlab = "Year", ylab = "Emission [t]")
dev.off()