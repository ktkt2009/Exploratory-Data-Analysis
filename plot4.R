## Reading downloaded data set
data_stage0 <- read.csv("./Data/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
#set date format
data_stage0$Date <- as.Date(data_stage0$Date, format="%d/%m/%Y")

## Subsetting the data
data <- subset(data_stage0, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data_stage0)

## Converting dates
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

## Plot 4

par(mfrow=c(2,2), mar=c(3,4,3,1), oma=c(0,0,.5,0))
with(data, {
  plot(Global_active_power~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~Datetime, type="l", 
       ylab="Voltage", xlab="")
  plot(Sub_metering_1~Datetime, type="l", 
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", legend = names(data)[7:9], col = c("black", "red", "blue"), lty = 1, lwd = 0.25, bty = "n")
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
         
  plot(Global_reactive_power~Datetime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

## Saving to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()