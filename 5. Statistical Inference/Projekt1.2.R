#Basic exploratory analysis
library(datasets)
library(ggplot2)
ggplot(data = ToothGrowth, aes(x = as.factor(dose), y = len, fill = supp)) + 
      geom_bar(stat = "identity") + 
      facet_grid(. ~ supp) + 
      labs(x = "Dose [mg]", y = "Tooth length", title = "ToothGrowth Dataset") + 
      guides(fill = guide_legend(title = "Delivery method"))

#Summary
summary(ToothGrowth)


OJ <- ToothGrowth[ToothGrowth$supp == "OJ",]
VC <- ToothGrowth[ToothGrowth$supp == "VC",]
t.test(x = OJ$len, y = VC$len)
