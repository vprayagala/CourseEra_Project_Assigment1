# This script uses the National Emissions Data downloaded from web
# This plots histogram for PM2.5 across years
library(dplyr)
library(ggplot2)
#Read the data 
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

# filter baltimore city
NEI.Baltimore<-filter(NEI,fips == 24510)

NEISCC<-inner_join(NEI.Baltimore,SCC,by="SCC")

#grepl - pattern matching, serach for 'vehcilces' in short name 
vehicles<-grepl("vehicles",NEISCC$Short.Name,ignore.case=T)

NEI.Vehicles<-filter(NEI.Baltimore,vehicles)
aggregatedTotalByYear <- aggregate(Emissions ~ year, NEI.Vehicles, sum)
png("plot5.png")
draw<-ggplot(aggregatedTotalByYear,aes(as.factor(year),Emissions))
plot<-draw+geom_histogram(stat="identity",color="red",fill="white") +
  xlab("year") +
  ylab("Total Emissions for Vehcicles") +
  ggtitle("Total Vehicles Emissions by Year") 
print(plot)
dev.off()
