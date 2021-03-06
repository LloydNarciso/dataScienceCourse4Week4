## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

emissionsMD<-subset(NEI,fips=="24510")
x<-c("1999","2002","2005","2008")
png(filename="plot2.png",width=720,height=480)
totalEmissionsMD<-with(emissionsMD,tapply(Emissions,year,sum,na.rm=TRUE))
plot(x,totalEmissionsMD,main=expression(paste("Total ", PM[2.5], " Emissions in Baltimore City, Maryland from 1999-2008")),xlab="Year",
     ylab=expression(paste(PM[2.5], " Emissions (in tons)")),pch=15,cex=2,lwd=2,col="blue")
lines(x,totalEmissionsMD,type="l",col="blue")
dev.off()