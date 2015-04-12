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

#Plot 2: x-axis is a combination of date and hour; label only based on specific day of the week
#conversion of separate Date and Time columns into one super variable
library(lubridate)
time <- dmy(df$Date) + hms(df$Time)

png(file = "plot2.png")
plot(time, df$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()