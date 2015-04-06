set.seed(1)
lambda <- 0.2
numSim <- 1000
sampleSize <- 40

#Simulating data
data = NULL
for (i in 1 : 1000){
      data = c(data, mean(rexp(40, rate = lambda)))
}

data <- as.data.frame(data)
colnames(data) <- "avarage"

#Creating theoretical distibution
xfit <- seq(min(data), max(data), length=100)
yfit <- dnorm(xfit, mean=1/lambda, sd=(1/lambda/sqrt(sampleSize)))

#Creating histogram of avarages
png(filename = "plot1.png", width = 500, height = 500)
library(ggplot2)
g <- ggplot(data, aes(avarage)) + 
      xlab(NULL) + ylab("Density") + 
      ggtitle("Distribution of avarages drawn from \nexponential distribution with lambda = 0.2")

g + 
      geom_histogram(aes(y = ..density..), binwidth = density(rowMeans(x = data))$bw, fill = "white", colour = "black") + 
      geom_density(colour = "black", size = 1) + 
      geom_vline(xintercept = 5, colour = "red", size = 1) +
      geom_vline(xintercept = mean(data$avarage), colour = "black", size = 1) + 
      geom_path(data = as.data.frame(yfit), x = xfit, y = yfit, colour = "red", linetype = 2, size = 1)
dev.off()

mean(data$avarage)
var(data$avarage)


qqnorm(data$avarage); qqline(data$avarage)
