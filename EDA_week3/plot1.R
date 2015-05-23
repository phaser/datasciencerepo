library(plyr)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI <- transform(NEI, year = as.factor(year), type = as.factor(type))
nds <- ddply(NEI, .(year), numcolwise(sum))

boxplot(nds$Emissions ~ nds$year, xlab="Year", ylab="Emissions")
title("Total Emissions in tons by year")
dev.copy(png, file="plot1.png")
dev.off()