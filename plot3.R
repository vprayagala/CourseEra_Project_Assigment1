# This script uses the National Emissions Data downloaded from web
# This plots histogram for PM2.5 across years
library(dplyr)
library(ggplot2)
#Read the data 
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

NEI.Baltimore<-filter(NEI,fips == 24510)
aggregatedTotalByYear <- aggregate(Emissions ~ type + year, NEI.Baltimore, sum)
png("plot3.png")
draw<-ggplot(aggregatedTotalByYear,aes(year,Emissions,color=type))
plot<-draw+geom_line() +
      xlab("year") +
      ylab("Total PM2.5 Emissions") +
      ggtitle("Total PM2.5 Emissions by Year and Type") 
print(plot)
dev.off()
