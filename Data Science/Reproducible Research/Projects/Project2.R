# downloading file
download.file("https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2",
              "storm.bz2")

# loading packages
library(tidyverse)
library(lubridate)
library(stringr)

# reading in the data
data_raw <- read_csv("storm.csv.bz2")

# preprocessing
data <- data_raw %>%
  select(State = STATE, Date = BGN_DATE, County = COUNTYNAME, Event = EVTYPE,
         Fatalities = FATALITIES, Injuries = INJURIES, Property_Damage = PROPDMG, Crop_Damage = CROPDMG,
         Property_Damage_Scale = PROPDMGEXP, Crop_Damage_Scale = CROPDMGEXP) %>%
  mutate(Date = mdy(str_extract(Date, "\\d{1,2}/\\d{1,2}/\\d{4}")),
         Year = year(Date))


# quick glance at the population and time span
data %>%
  count(State) %>%
  arrange(desc(n))

data %>%
  count(Event) %>%
  arrange(desc(n)) 

# recoding some variables
data <- data %>%
  mutate(Event = ifelse(Event %in% c("TSTM WIND", "THUNDERSTORM WINDS"), "THUNDERSTORM WIND", Event))

data %>%  
  count(Event) %>%
  arrange(desc(n))

# Plotting number of events
data %>%
  count(Year) %>%
  arrange(Year) %>%
ggplot() + geom_line(aes(Year, n), col = "darkred", lwd = 1) + ggtitle("Yearly number of events") +
  ylab("")


# which were the most harmful to population
victims <- data %>%
  group_by(Event) %>%
  summarise(Fatalities = sum(Fatalities),
            Injuries = sum(Injuries)) %>%
  mutate(Victims = Fatalities + Injuries) %>%
  arrange(desc(Victims)) %>%
  slice(1:5)

ggplot(victims) + geom_col(aes(reorder(Event, -Victims), Victims), fill = "darkred") +
  ggtitle("The most harmful events for the population") + xlab("Event")


# which were the most harmful economically
data %>%
  filter(Property_Damage_Scale == "B") %>%
  arrange(desc(Property_Damage)) %>%
  slice(1:3) %>%
  select(State, Date, Event, Property_Damage)

data %>%
  filter(Crop_Damage_Scale == "B") %>%
  arrange(desc(Crop_Damage)) %>%
  slice(1:3) %>%
  select(State, Date, Event, Crop_Damage)

