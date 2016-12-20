library(dplyr)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## grab all NEI entries involving motor vehicles
SCCsub<-SCC[grep("Mobile.*Vehicles",SCC$EI.Sector),]
emissionsMV<-subset(NEI,SCC %in% SCCsub$SCC & fips=="24510") %>%
    group_by(year) %>%
    summarize(Emissions=sum(Emissions,na.rm=TRUE))
png(filename="plot5.png",width=720,height=480)
ggplot(emissionsMV,aes(year,Emissions)) + geom_line(color="blue")+geom_point(color="blue",size=2,shape=15) + 
    labs(x="Year",y=expression(paste(PM[2.5], " Emissions (in tons)"))) +
    ggtitle(expression(paste("Total ", PM[2.5], " Emissions from Motor Vehicles")), subtitle="Baltimore City, Maryland from 1999-2008")
dev.off()