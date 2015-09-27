# This script uses the National Emissions Data downloaded from web
# This plots histogram for PM2.5 across years
library(dplyr)
library(ggplot2)
#Read the data 
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

NEISCC<-inner_join(NEI,SCC,by="SCC")


#grepl - pattern matching, serach for 'coal' in short name 
coal<-grepl("coal",NEISCC$Short.Name,ignore.case=T)

NEI.Coal<-filter(NEI,coal)
aggregatedTotalByYear <- aggregate(Emissions ~ year, NEI.Coal, sum)
png("plot4.png")
draw<-ggplot(aggregatedTotalByYear,aes(as.factor(year),Emissions))
plot<-draw+geom_histogram(stat="identity",color="red",fill="white") +
  xlab("year") +
  ylab("Total Emissions Containing Coal") +
  ggtitle("Total Coal Emissions by Year") 
print(plot)
dev.off()
