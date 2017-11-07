library(tidyverse)
library(lubridate)

# loading data
data_raw <- read_delim("household_power_consumption.txt", delim = ";", na = "?")


# filtering and changing to date format 
data <- data_raw %>%
  filter(Date %in% c('1/2/2007', '2/2/2007')) %>%
  mutate(Date = dmy(Date),
         moment = ymd_hms(str_c(Date, Time)))
rm(data_raw)



# plot1
png("rplot1.png")
hist(data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()