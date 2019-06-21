library(data.table)
library(lubridate)

## Download zip file and unzip into working directory (if it does not already exist)
if(!file.exists("data.zip")){
      url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      download.file(url,destfile = "./data.zip")
      unzip("data.zip")
}

## Load Household Power Consumption data and subset
data <- as.data.table(fread("household_power_consumption.txt",sep=";",header=TRUE))
data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007"]

## Create new $Datetime column by pasting original $Date and $Timeto act as x-axis for plot
data$Datetime <- as.POSIXct(paste(data$Date,data$Time), format = "%d/%m/%Y %H:%M:%S")

## Open png 'plot1.png', generate histogram of Global Active Power & set main label, xlabel, and color of histogram.
png(filename = "plot1.png",width=480,height=480)
hist(as.numeric(data$Global_active_power),main = "Global Active Power",xlab = "Global Active Power (kilowatts)",col="red")
invisible(dev.off())
