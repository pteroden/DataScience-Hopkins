# Loading data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

#Subsetting rows concerning only Baltimore
EmissionBaltimore <- NEI[NEI$fips == "24510", ]
totalEmission <- aggregate(x = EmissionBaltimore$Emissions, by = list(EmissionBaltimore$type, EmissionBaltimore$year), FUN = sum)
colnames(totalEmission) <- c("type", "year", "emission")

#Ploting
library(ggplot2)
png(filename = "./charts/plot3.png", bg = "transparent")

with(totalEmission, 
     qplot(x = year, 
           y = emission,color = type,
           geom = c("line", "point"),
           xlab = "Year",
           ylab = expression('Total PM'[2.5]*" emission"),
           main = "Total emissions in Baltimore from 1999 to 2008", ))

dev.off()