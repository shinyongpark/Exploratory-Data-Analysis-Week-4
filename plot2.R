plot2 <- function() {
  
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  baltimore <- subset(NEI, fips=="24510")
  agg <- aggregate(Emissions ~ year, baltimore, sum)
  
  png("plot2.png", width=480, height=480)
  barplot(agg$Emissions, names.arg=agg$year, xlab="Year", ylab="PM2.5 Emissions (Tons)", ylim=c(0,3500), main="Total PM2.5 Emissions - Baltimore City, MD")
  dev.off()
}

plot2()