# This script uses the National Emissions Data downloaded from web
# This plots histogram for PM2.5 across years
library(dplyr)
#Read the data 
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")
NEI.Baltimore<-filter(NEI,fips == 24510)
aggregatedTotalByYear <- aggregate(Emissions ~ year, NEI.Baltimore, sum)
png("plot2.png")
barplot(height=aggregatedTotalByYear$Emissions,
        names.arg=aggregatedTotalByYear$year,
        xlab="Years",
        ylab="Total PM2.5 Emission",
        main="Total PM2.5 Emissions for Baltimore City by Year")

dev.off()
