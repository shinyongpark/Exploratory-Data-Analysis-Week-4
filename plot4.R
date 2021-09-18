library(dplyr)
library(ggplot2)
library(data.table)

SCC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))

combustion <- grepl("comb", SCC[, SCC.Level.One], ignore.case=TRUE)
coal <- grepl("coal", SCC[, SCC.Level.Four], ignore.case=TRUE) 
ansSCC <- SCC[combustion & coal, SCC]
ansNEI <- NEI[NEI[,SCC] %in% ansSCC]

png("plot4.png")

ggplot(ansNEI,aes(x = factor(year),y = Emissions/10^5)) + geom_bar(stat="identity", fill ="#FF9999", width=0.75) + labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))

dev.off()
