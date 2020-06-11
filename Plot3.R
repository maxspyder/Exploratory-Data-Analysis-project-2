library("data.table")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile = "XYZ.zip")
unzip(zipfile = "XYZ.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

data <- filter(NEI, fips=="24510")

png("plot3.png",height = 600,width = 600)

p <- ggplot(data,aes(factor(year),Emissions,fill=type))+geom_bar(stat="identity")+ facet_grid(.~type)+ labs(x="year", y=expression("PM"[2.5]*" Emission (in Tons unit)"))+ labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Type"))
print(p)

dev.off()