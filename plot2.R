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


## Open 'plot2.png' and set line chart to Date (x-axis) by Global Active Power (y-axis) 
png(filename = "plot2.png",width=480,height=480)
plot(data$Datetime,data$Global_active_power,type="n",xlab="Date",ylab="Global Active Power (kilowatts)")
lines(data$Datetime,data$Global_active_power)
invisible(dev.off())

