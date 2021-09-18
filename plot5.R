library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

data_sector <- SCC[grepl("mobile",SCC$EI.Sector, ignore.case=TRUE),]
scc_list <- data_sector[grep("vehicle",data_sector$SCC.Level.Two, ignore.case=TRUE),]

ansSCC <- SCC[scc_list$SCC,]$SCC
ansNEI <- NEI[NEI$SCC %in% ansSCC,]
ansNEI$year <- as.factor(ansNEI$year)
baltimore <- subset(ansNEI, fips=="24510")
agg <- aggregate(Emissions~year, ansNEI, sum)

png("plot5.png", width=480, height=480)
ggplot(data=agg, aes(y=Emissions/10^6, x=year)) + geom_bar(stat="identity") + ggtitle("Total PM2.5 Emissions - Baltimore City, MD", subtitle = "By Motor Vehicles") + labs(x = "Year", y = "PM2.5 Emissions (10^6 Tons)")
dev.off()