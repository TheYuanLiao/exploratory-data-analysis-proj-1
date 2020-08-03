## To create plot2.png
## Time history of Global active power
library(dplyr)
library(data.table)
library(lubridate)

# Load data and create a timestamp variable T
dtfile <- "data/household_power_consumption.txt"
DT <- fread(dtfile)
DT <- DT %>% 
  subset(Date %in% c("1/2/2007", "2/2/2007")) %>%
  mutate(T=dmy_hms(paste(Date, Time, sep=" "))) %>%
  mutate(Global_active_power=
           as.numeric(Global_active_power))

# Create a plot
png(file="plot2.png", width=480, height=480)
with(DT, plot(T,
              Global_active_power,
              type = "l",
              col = "black",
              xlab = "",
              ylab = "Global Active Power (kilowatts)"))
dev.off()