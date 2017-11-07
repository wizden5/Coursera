library(tidyverse)
library(stringr)

# reading in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# plot6
comparison <- NEI %>%
  filter(fips == "24510" | fips == "06037") %>%
  mutate(year = factor(year)) %>%
  inner_join(SCC, by = 'SCC') %>%
  filter(str_detect(EI.Sector, "Vehicles")) %>%
  mutate(fips = recode(fips, "24510" = "Baltimore", "06037" = "LA")) %>%
  group_by(year, fips) %>%
  summarise(sums = sum(Emissions)) 


png("plot6.png")
ggplot(comparison) + geom_col(aes(x = fips, y = sums, fill = year), position = "dodge") +
  ggtitle("Emission of PM2.5 in Baltimore and LA") + xlab("Year") + ylab("Emission [t]")
dev.off()