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

## Open 'plot4.png' and create 4 charts, separated by par(mfcol)
png(filename = "plot4.png",width=480,height=480)
par(mfcol = c(2,2))

plot(data$Datetime,data$Global_active_power,type="n",xlab="Date",ylab="Global Active Power (kilowatts)")
lines(data$Datetime,data$Global_active_power)

plot(data$Datetime,data$Sub_metering_1,type = "n",xlab = "Date", ylab = "Energy sub metering")
lines(data$Datetime,data$Sub_metering_1)
lines(data$Datetime,data$Sub_metering_2,col = "red")
lines(data$Datetime,data$Sub_metering_3,col = "blue")
legend("topright",lty = 1,col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

plot(data$Datetime,data$Voltage,type="n",xlab="Date",ylab="Voltage")
lines(data$Datetime,data$Voltage)

plot(data$Datetime,data$Global_reactive_power,type="n",xlab="Date",ylab="Global Reactive Power")
lines(data$Datetime,data$Global_reactive_power)


invisible(dev.off())
