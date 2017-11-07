library(tidyverse)
library(stringr)

# reading in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# plot5
combustion <- NEI %>%
  filter(fips == 24510) %>%
  mutate(year = factor(year)) %>%
  inner_join(SCC, by = 'SCC') %>%
  filter(str_detect(EI.Sector, "Vehicles")) %>%
  group_by(year) %>%
  summarise(sums = sum(Emissions)) 


png("plot5.png")
ggplot(combustion) + geom_col(aes(x = year, y = sums), fill = "darkred") +
  ggtitle("Emission of PM2.5 from motor vehicles") + xlab("Year") + ylab("Emission [t]")
dev.off()