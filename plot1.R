## To create plot1.png
## Frequency distribution of global active power
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
png(file="plot1.png", width=480, height=480)
with(DT, hist(Global_active_power,
              col = "red",
              xlab = "Global Active Power (kilowatts)",
              ylab = "Frequency",
              main = "Global Active Power"))
dev.off()