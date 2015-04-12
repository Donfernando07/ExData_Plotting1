# Script works if working directory is in the same file as the .txt file and assumes you have already
# unzipped file
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

#Plot 1
png(file = "plot1.png")
hist(df$Global_active_power, breaks = 12, freq = TRUE, col = "red", border = "black",
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", ylim = c(0, 1200))
dev.off()