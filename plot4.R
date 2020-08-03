## To create plot4.png
## Time history of three sub meterings
library(dplyr)
library(data.table)
library(lubridate)

# Load data and create a timestamp variable T
dtfile <- "data/household_power_consumption.txt"
DT <- fread(dtfile)
DT <- DT %>% 
  subset(Date %in% c("1/2/2007", "2/2/2007")) %>%
  mutate(T=dmy_hms(paste(Date, Time, sep=" "))) %>%
  mutate(Sub_metering_1=
           as.numeric(Sub_metering_1),
         Sub_metering_2=
           as.numeric(Sub_metering_2),
         Sub_metering_3=
           as.numeric(Sub_metering_3),
         Global_active_power=
           as.numeric(Global_active_power),
         Voltage=
           as.numeric(Voltage),
         Global_reactive_power=
           as.numeric(Global_reactive_power)
  )
  

# Create a plot
# Define a function for easy repeating
sub_plt <- function(x, y){
  points(DT$T,
         x,
         type = "l",
         col = y)
}

# Add four subplots seperately
png(file="plot4.png", width=480, height=480)
par(mfrow = c(2,2), mar = c(4, 4, 2, 1))
with(DT, {
  # Figure 1 Time history of Global_active_power
  plot(T,
       Global_active_power,
       type = "l",
       col = "black",
       xlab = "",
       ylab = "Global Active Power (kilowatts)")
  
  # Figure 2 Time history of Voltage
  plot(T,
       Voltage,
       type = "l",
       col = "black",
       xlab = "datetime",
       ylab = "Voltage")
  
  # Figure 3 Time history of Sub_metering 1-3
  plot(T, 
       Sub_metering_1, 
       type="n", 
       xlab = "", 
       ylab = "Energy sub metering")
  
  sub_plt(DT$Sub_metering_1, "black")
  sub_plt(DT$Sub_metering_2, "red")
  sub_plt(DT$Sub_metering_3, "blue")
  legend("topright",
         lty = 1,
         col = c("black", "red", "blue"),
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         bty = "n")
  
  # Figure 4 Time history of Global_reactive_power
  plot(T,
       Global_reactive_power,
       type = "l",
       col = "black",
       xlab = "datetime")
  }
  )

dev.off()