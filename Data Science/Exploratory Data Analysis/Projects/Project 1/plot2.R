library(tidyverse)
library(lubridate)
library(stringr)

# loading data
data_raw <- read_delim("household_power_consumption.txt", delim = ";", na = "?")


# filtering and changing to date format 
data <- data_raw %>%
  filter(Date %in% c('1/2/2007', '2/2/2007')) %>%
  mutate(Date = dmy(Date),
         moment = ymd_hms(str_c(Date, Time)))
rm(data_raw)


# plot2 - BEAR IN MIND POLISH WEEKDAY NAMES
png("rplot2.png")
plot(data$moment, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()