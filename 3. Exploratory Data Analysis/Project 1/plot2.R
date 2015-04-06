#Load data only for the dates 2007-02-01 and 2007-02-02
data <- read.table("./data/household_power_consumption.txt", sep = ";", header = T, na.strings = "?")

data$Date <- as.Date(data$Date, "%d/%m/%Y")
data <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")

#Converting dates and time
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

#Choosing device
png(filename = "plot2.png", 
    width = 480, height = 480,
    units = "px", bg = "transparent")

#Creating plot
plot(data$Global_active_power~data$Datetime, 
     type = "l", 
     xlab = "", 
     ylab = "Global Active Power (kilowatts)")

# Closing connection
dev.off()