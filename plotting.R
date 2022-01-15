# CMSC 197 - 2
# 2nd Mini Project: Part 2
# by Jon Robien Jinon

# load required libraries
library("lubridate")

#download files
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if(!file.exists("part2.zip")){
  download.file(url, "part2.zip")
}

if(!dir.exists("specdata")){
  dir.create("specdata")
}

if(!file.exists("specdata/household_power_consumption.txt")){
  unzip("part2.zip", exdir = "specdata")
}


# load data
print("Reading data...")
data <- read.table("./specdata/household_power_consumption.txt", header=TRUE, sep=';', na.strings=c('NA','?', ''))

# convert date column to Date 
data$Date <- dmy(data$Date)

# filter data from "2007-02-01" to "2007-02-02"
select_dates <- ymd(c("2007-02-01", "2007-02-02"))
data <- data[data$Date %in% select_dates, ]

# -------------- Make Plots ----------------

# Plot 1


png("plot1.png", width=720, height=720) # setup png file

hist(data$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col='red')

dev.off() # close file
print("plot1.png created")




# Plot 2


# Add DateTime column
data$DateTime <- with(data, ymd_hms(paste(Date, Time)))

png("plot2.png", width=720, height=720) # setup png file

plot(Global_active_power ~ DateTime, data, ylab="Global Active Power (kilowatts)", xlab=NA, type="l")

dev.off() # close file
print("plot2.png created")




# Plot 

# Created a function for plot 3 because plot 4 reuses it
plot3 <- function(){
  
  plot(Sub_metering_1 ~ DateTime, data, ylab="Energy sub metering", xlab=NA, type='l')
  
  # used lines() to stack plots together
  lines(Sub_metering_2 ~ DateTime, data, col='red')   # line 2
  
  lines(Sub_metering_3 ~ DateTime, data, col='blue')  # line 3
  
  legend('topright', lty=1, lwd = 3, col=c('black', 'red', 'blue'), legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))
}


png("plot3.png", width=720, height=720) # setup png file

plot3() #make plot

dev.off() #close file
print("plot3.png created")




# Plot 4

png("plot4.png", width=720, height=720) # setup png file

# Setup a 2x2 layout using par for multiple plots
par(mfrow = c(2,2))

# Add plots
plot(Global_active_power ~ DateTime, data, ylab="Global Active Power (kilowatts)", xlab=NA, type='l')

plot(Voltage ~ DateTime, data, type='l')

plot3()

plot(Global_reactive_power ~ DateTime, data, type='l')


dev.off() # close file
print("plot4.png created")
