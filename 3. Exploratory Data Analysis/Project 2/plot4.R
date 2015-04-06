# Loading data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

#Regular expression - Coal
coalID <- SCC[grep("coal", SCC$Short.Name, ignore.case = TRUE), 1]

#Subseting data
subset <- NEI[(NEI$SCC %in% coalID), ]

#Aggregating data by year variable
totalEmission <- aggregate(x = subset$Emissions, by = list(subset$year), FUN = sum)
colnames(totalEmission) <- c("year", "emission")

#Creating plot
library(ggplot2)
png(filename = "./charts/plot4.png", bg = "transparent")

with(totalEmission, 
     qplot(x = year, 
           y = emission,
           geom = "line",
           xlab = "Year",
           ylab = expression('Total PM'[2.5]*" emission"),
           main = "Total emissions from coal \ncombustion-related sources from 1999–2008"))

dev.off()