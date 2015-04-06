# Loading data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

#Regular expression - motor
motorID <- SCC[grep("vehic|motor", SCC$Short.Name, ignore.case = TRUE), 1]

#Subseting data
subset <- NEI[(NEI$SCC %in% motorID), ]                                      #Motor vehicles
EmissionMotorBaltimoreLA <- subset[subset$fips %in% c("24510", "06037"), ]   #Baltimore or Los Angeles

#Aggregating data by year variable
totalEmission <- aggregate(x = EmissionMotorBaltimoreLA$Emissions, by = list(EmissionMotorBaltimoreLA$year, EmissionMotorBaltimoreLA$fips), FUN = sum)
colnames(totalEmission) <- c("year", "City", "emission")

#Decoding cities
totalEmission$City[totalEmission$City == "06037"] <- "Los Angeles"
totalEmission$City[totalEmission$City == "24510"] <- "Baltimore"

#Creating plot
library(ggplot2)
png(filename = "./charts/plot6.png", bg = "transparent")

with(totalEmission, 
     qplot(x = year, 
           y = emission,
           geom = "line",
           color = City,
           xlab = "Year",
           ylab = expression('Total PM'[2.5]*" emission"),
           main = "Comparison of emissions from motor vehicle \nsources in Baltimore City and Los Angeles \nfrom 1999 to 2008"))

dev.off()