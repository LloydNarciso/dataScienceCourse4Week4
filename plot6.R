library(dplyr)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## grab all NEI entries involving motor vehicles
SCCsub<-SCC[grep("Mobile.*Vehicles",SCC$EI.Sector),]
emissionsMVMD<-subset(NEI,SCC %in% SCCsub$SCC & fips=="24510") %>%
    group_by(year) %>%
    summarize(Emissions=sum(Emissions,na.rm=TRUE))
emissionsMVLA<-subset(NEI,SCC %in% SCCsub$SCC & fips=="06037") %>%
    group_by(year) %>%
    summarize(Emissions=sum(Emissions,na.rm=TRUE))
emissionsCity<-merge(emissionsMVMD,emissionsMVLA,by="year")
png(filename="plot6.png",width=720,height=480)
ggplot(emissionsCity,aes(year)) + geom_point(aes(y=Emissions.x,color="Baltimore City, Maryland"),size=2,shape=15) + 
    geom_line(aes(y=Emissions.x,color="Baltimore City, Maryland")) +
    geom_point(aes(y=Emissions.y,color="Los Angeles, California"),size=2,shape=15) + 
    geom_line(aes(y=Emissions.y,color="Los Angeles, California")) +
    labs(x="Year",y=expression(paste(PM[2.5], " Emissions (in tons)"))) +
    ggtitle(expression(paste("Total ", PM[2.5], " Emissions from Motor Vehicles")), 
            subtitle="Baltimore City, Maryland and Los Angeles, California from 1999-2008") +
    scale_color_manual(name="City",breaks=c("Baltimore City, Maryland","Los Angeles, California"),values=c("blue","red"))
dev.off()