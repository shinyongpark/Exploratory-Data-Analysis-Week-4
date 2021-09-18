plot1 <- function() {
  
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  total_emmissions <- aggregate(Emissions ~ year, NEI, sum)
  
  png("plot1.png", width=480, height=480)
  barplot((total_emmissions$Emissions)/10^6, names.arg=total_emmissions$year, xlab="Year", ylab="PM2.5 Emissions (10^6 Tons)", ylim = c(0, 7.5), main="Total PM2.5 Emissions - All United States")
  dev.off()
}

plot1()