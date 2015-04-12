###### Script works if working directory is in the same file as the .txt file and have already unzipped file
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


#Plot 4: 1. Plot 2, 2. Voltage vs time with label, 3. Plot3 4. Global_reactive_power vs. date/time
### To change legend size for plot3, change the value of cex. To remove borders around legend, bty = "n"
png(file = "plot4.png")
par(mfrow = c(2,2))
with(df, {
        # Plot 1 at [1,1]
        plot(time, df$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
        
        #Plot 2 at [1,2]
        plot(time, df$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
        
        #Plot 3 at [2,1]
        plot(time, df$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
        par(new = TRUE)
        lines(time, df$Sub_metering_2, type = "l", xlab = "", ylab = "", col = "red")
        par(new = TRUE)
        lines(time, df$Sub_metering_3, type = "l", xlab = "", ylab = "", col = "blue")
        legend("topright", pch = NULL, cex = .9, lty = 1, lwd = 1:2, bty = "n", col = c("black", "red", "blue"),
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        
        #Plot 4 at [2,2]
        plot(time, df$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
})
dev.off()  