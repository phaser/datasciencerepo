library(plyr)
library(ggplot2)

nds <- NEI[NEI$fips == 24510, ]

nds <- ddply(nds, .(year, type), numcolwise(sum))
g <- ggplot(nds, aes(x=year, y=Emissions)) +
    geom_point(shape=1) +
    facet_grid(type ~ .)
print(g)
dev.copy(png, file="plot3.png")
dev.off()
