codes <- filter(SCC, grepl("Vehicle", SCC.Level.Two))
nds <- filter(NEI, SCC %in% codes$SCC)
nds <- nds[nds$fips == 24510,]
nds <- ddply(nds, .(year), numcolwise(sum))

boxplot(nds$Emissions ~ nds$year, xlab="Year", ylab="Emissions")
title("Emissions (Baltimore City, Maryland) / motor")
dev.copy(png, file="plot5.png")
dev.off()