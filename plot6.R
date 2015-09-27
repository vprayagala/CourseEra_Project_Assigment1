# This script uses the National Emissions Data downloaded from web
# This plots histogram for PM2.5 across years
library(dplyr)
library(ggplot2)
#Read the data 
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

# filter baltimore city and Los Angels
county<-c("24510","06037")
NEI.Subset<-filter(NEI,fips %in% county)

NEISCC.Subset<-inner_join(NEI.Subset,SCC,by="SCC")

#grepl - pattern matching, serach for 'vehcilces' in short name 
veh<-grepl("vehicles",NEISCC.Subset$Short.Name,ignore.case=T)

NEI.Veh<-filter(NEI.Subset,veh)

aggTotByYear<- aggregate(Emissions ~ fips + year , NEI.Veh, sum)

png("plot6.png")
draw<-ggplot(aggTotByYear,aes(year,Emissions,color=fips))
plot<-draw+geom_line() +
  xlab("year") +
  ylab("Total Emissions for Vehcicles") +
  ggtitle("Total Vehicles Emissions in Baltimore and LA by Year") 
print(plot)
dev.off()
