library(dplyr)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

emissionsMD<-subset(NEI,fips=="24510") %>%
    group_by(type,year) %>%
    summarize(Emissions=sum(Emissions,na.rm=TRUE))
png(filename="plot3.png",width=720,height=480)
ggplot(emissionsMD,aes(year,Emissions, group=type, color=type)) + geom_line()+geom_point(size=2,shape=15) + 
    labs(x="Year",y=expression(paste(PM[2.5], " Emissions (in tons)"))) +
    ggtitle(expression(paste("Total ", PM[2.5], " Emissions from Each Type of Source")), subtitle="Baltimore City, Maryland from 1999-2008")
dev.off()