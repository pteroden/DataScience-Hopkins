# Loading data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

#Regular expression - motor
motorID <- SCC[grep("vehic|motor", SCC$Short.Name, ignore.case = TRUE), 1]

#Subseting data
subset <- NEI[(NEI$SCC %in% motorID), ]                        #Motor vehicles
EmissionMotorBaltimore <- subset[subset$fips == "24510", ]     #Baltimore

#Aggregating data by year variable
totalEmission <- aggregate(x = EmissionMotorBaltimore$Emissions, by = list(EmissionMotorBaltimore$year), FUN = sum)
colnames(totalEmission) <- c("year", "emission")

#Creating plot
library(ggplot2)
png(filename = "./charts/plot5.png", bg = "transparent")

with(totalEmission, 
     qplot(x = year, 
           y = emission,
           geom = "line",
           xlab = "Year",
           ylab = expression('Total PM'[2.5]*" emission"),
           main = "Total Emissions From Motor Vehicle Sources\n from 1999 to 2008 in Baltimore City"))

dev.off()