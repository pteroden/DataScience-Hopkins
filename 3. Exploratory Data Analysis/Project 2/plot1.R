# Loading data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

totalEmission <- aggregate(x = NEI$Emissions, by = list(NEI$year), FUN = sum)


png(filename = "./charts/plot1.png", 
    bg = "transparent")

plot(totalEmission, 
     xlab = "Year", 
     ylab = expression('Total PM'[2.5]*" emission"), 
     type = "l", 
     main = "Total emissions in Unated States from 1999 to 2008")

dev.off()