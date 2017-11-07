library(tidyverse)

# reading in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# plot3
baltimore_types <- NEI %>%
  filter(fips == 24510) %>%
  mutate(year = factor(year)) %>%
  group_by(year, type) %>%
  summarise(sums = sum(Emissions)) 


png("plot3.png")
ggplot(baltimore_types, aes(x = year, y = sums, col = type)) + geom_point() + geom_line(aes(group = type), lwd = 1) +
  ggtitle("Emission of PM2.5 in Baltimore per type of source") + xlab("Source type") + ylab("Emission")
dev.off()