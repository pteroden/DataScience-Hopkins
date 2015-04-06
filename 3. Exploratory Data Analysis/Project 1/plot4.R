#Load data only for the dates 2007-02-01 and 2007-02-02
data <- read.table("./data/household_power_consumption.txt", sep = ";", header = T, na.strings = "?")
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")

#Converting dates and time
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

#Choosing device
png(filename = "plot4.png", 
    width = 480, height = 480,
    units = "px", bg = "transparent")

#Setting number of charts in columns and rows
par(mfrow = c(2, 2))

#1st chart
plot(data$Global_active_power~data$Datetime, 
     type = "l", 
     xlab = "", 
     ylab = "Global Active Power (kilowatts)")

#3rd chart
plot(data$Voltage~data$Datetime, 
     type = "l", 
     xlab = "datetime", 
     ylab = "Voltage")

#2nd chart
plot(data$Sub_metering_1~data$Datetime, type = "l",
     ylab="Energy sub metering", xlab="")
lines(data$Sub_metering_2~data$Datetime, col = "red")
lines(data$Sub_metering_3~data$Datetime, col = "blue")
legend("topright", lwd = 1, bty = "n",
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#4th chart
plot(data$Global_reactive_power~data$Datetime, 
     type = "l", 
     xlab = "datetime", 
     ylab = "Global_reactive_power")

# Closing connection
dev.off()