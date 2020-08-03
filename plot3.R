## To create plot3.png
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
           as.numeric(Sub_metering_3)
         )

# Create a plot
# Define a function for easy repeating
sub_plt <- function(x, y){
  points(DT$T,
       x,
       type = "l",
       col = y)
}

# Add three curves seperately
png(file="plot3.png", width=480, height=480)
with(DT, plot(T, 
              Sub_metering_1, 
              type="n", 
              xlab = "", 
              ylab = "Energy sub metering"))
sub_plt(DT$Sub_metering_1, "black")
sub_plt(DT$Sub_metering_2, "red")
sub_plt(DT$Sub_metering_3, "blue")
legend("topright",
       lty = 1,
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()