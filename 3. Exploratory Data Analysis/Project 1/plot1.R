#Load data only for the dates 2007-02-01 and 2007-02-02
data <- read.table("./data/household_power_consumption.txt", sep = ";", header = T, na.strings = "?")
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))

#Choosing device
png(filename = "plot1.png", 
    width = 480, height = 480,
    units = "px", bg = "transparent")

#Constructing histogram
hist(data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

# Closing connection
dev.off()