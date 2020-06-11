library("data.table")
library("stringr")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile = "XYZ.zip")
unzip(zipfile = "XYZ.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

vehicle <- filter(SCC,str_detect(SCC.Level.Two, "Vehicle"))
vehicleSCC <- vehicle$SCC

NEIsub <- filter(NEI, NEI[,2] %in% vehicleSCC)
data <- filter(NEIsub, fips=="24510")

png("plot5.png")

p <- ggplot(data, aes(x=factor(year),y=Emissions))+geom_bar(stat="identity",fill="#026957",width=0.8)+ labs(x="year", y=expression("PM"[2.5]*" Emission (in Tons unit)"))+ labs(title=expression("PM"[2.5]*" Motor Vehicle Emissions Across Baltimore City from 1999-2008"))
print(p)

dev.off()