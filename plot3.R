# Script works if working directory is in the same file as the .txt file and have already unzipped file
        # Example: setwd("C:/Users/..../Desktop/ExData_Plotting1")

# Simultaneously reads and subsets the dates of interest to make graphs; reduces computational demands
library(sqldf)
options(gsubfn.engine = "R")
require(RH2)
# 2007-02-01 and 2007-02-02 convert to 01/02/2007 and 02/02/2007
df <- read.csv.sql("household_power_consumption.txt", 
                   sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'", 
                   header = TRUE, sep = ";")
closeAllConnections()

# Defines "?" as NAs for further removal
df[df=="?"] <- NA
df <- na.omit(df)

#conversion of separate Date and Time columns into one super variable
library(lubridate)
time <- dmy(df$Date) + hms(df$Time)

#Plot 3: Need to use the with argument to plot sub_metering 1/2/3 vs time; 1: black, 2: red, 3: blue
### par(new = TRUE) allows to add additional plots on to same graph
png(file = "plot3.png")
plot(time, df$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
par(new = TRUE)
lines(time, df$Sub_metering_2, type = "l", xlab = "", ylab = "", col = "red")
par(new = TRUE)
lines(time, df$Sub_metering_3, type = "l", xlab = "", ylab = "", col = "blue")
legend("topright", pch = NULL, cex = 1, lty = 1, lwd = 1:2, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()