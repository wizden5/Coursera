library(tidyverse)
library(stringr)

# reading in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# plot4
combustion <- NEI %>%
  mutate(year = factor(year)) %>%
  inner_join(SCC, by = 'SCC') %>%
  filter(str_detect(EI.Sector, "Coal")) %>%
  group_by(year) %>%
  summarise(sums = sum(Emissions)) 


png("plot4.png")
ggplot(combustion) + geom_col(aes(x = year, y = sums), fill = "darkred") +
  ggtitle("Emission of PM2.5 from coal-combustion related sources") + xlab("Year") + ylab("Emission [t]")
dev.off()