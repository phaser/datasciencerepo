library(plyr)
library(dplyr)
library(ggplot2)

codes <- filter(SCC, grepl("Vehicle", SCC.Level.Two))
nds <- filter(NEI, SCC %in% codes$SCC)
bm <- nds[nds$fips == "24510" | nds$fips == "06037",]

bm <- ddply(bm, .(year, fips), numcolwise(sum))

# See the change in percentages versus the first year
for(e in seq_along(bm[,3]))
{
    if (bm[e,2] == "06037")
    {
        bm[e, 3] <- bm[e, 3] / 6110
    }
    if (bm[e,2] == "24510")
    {
        bm[e, 3] <- bm[e, 3] / 404
    }
}

g <- ggplot(bm, aes(x=year, y=Emissions, fill=fips)) +
     geom_bar(stat="identity", position=position_dodge(), colour="black") +
     scale_fill_discrete(name="By City",
                        labels=c("Los Angeles", "Baltimore"))
print(g)

dev.copy(png, file="plot6.png")
dev.off()