library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

data_sector <- SCC[grepl("mobile",SCC$EI.Sector, ignore.case=TRUE),]
scc_list <- data_sector[grep("vehicle",data_sector$SCC.Level.Two, ignore.case=TRUE),]

ansSCC <- SCC[scc_list$SCC,]$SCC
ansNEI <- NEI[NEI$SCC %in% ansSCC,]
ansNEI <- NEI[NEI$SCC %in% ansSCC & NEI$fips %in% c("06037", "24510"),]
ansNEI$year <- as.factor(ansNEI$year)
combinedNEI <- mutate(ansNEI, City = ifelse(fips == "06037", "Los Angeles, CA", ifelse(fips == "24510", "Baltimore City, MD", 0)))
agg <- aggregate(Emissions~(City+year), combinedNEI, sum)

png("plot6.png", width=480, height=480)
ggplot(data=agg, aes(y=Emissions, x=year, fill = City)) + geom_bar(stat="identity", position = "dodge") + scale_y_continuous(breaks = round(seq(500, 7500, by = 500),1)) + ggtitle("Total PM2.5 Emissions - Motor Vehicles", subtitle = "Baltimore City vs Los Angeles") + labs(x = "Year", y = "PM2.5 Emissions (Tons)")
dev.off()