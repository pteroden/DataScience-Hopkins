# Loading data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

EmissionBaltimore <- NEI[NEI$fips == "24510", ]
totalEmission <- aggregate(x = EmissionBaltimore$Emissions, by = list(EmissionBaltimore$year), FUN = sum)

png(filename = "./charts/plot2.png", bg = "transparent")
plot(totalEmission, 
     xlab = "Year", 
     ylab = expression('Total PM'[2.5]*" emission"), 
     type = "l", 
     main = "Total emissions in Baltimore from 1999 to 2008")
dev.off()