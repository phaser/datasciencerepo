nds <- NEI[NEI$fips == 24510, ]

nds <- ddply(nds, .(year), numcolwise(sum))
mean <- mean(nds$Emissions)

plot(nds$year, nds$Emissions, xlab="Year", ylab="Emissions")
abline(lm(formula = nds$Emissions ~ nds$year))

title("Total Emissions (Baltimore City, Maryland)")
dev.copy(png, file="plot2.png")
dev.off()