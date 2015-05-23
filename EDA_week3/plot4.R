codes <- filter(SCC, grepl("Coal", SCC.Level.Four))
nds <- filter(NEI, SCC %in% codes$SCC)

nds <- ddply(nds, .(year), numcolwise(sum))

boxplot(nds$Emissions ~ nds$year, xlab="Year", ylab="Emissions")
title("Total Emissions in tons by year / coal")
dev.copy(png, file="plot4.png")
dev.off()