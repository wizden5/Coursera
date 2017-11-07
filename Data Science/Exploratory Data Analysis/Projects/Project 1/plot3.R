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


# plot3 - BEAR IN MIND POLISH WEEKDAY NAMES
png("rplot3.png")
plot(data$moment, data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(data$moment, data$Sub_metering_2, col = "red")
lines(data$moment, data$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1, 1, 1), col = c("black", "red", "blue"))
dev.off()


