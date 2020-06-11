library("data.table")
library("stringr")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile = "XYZ.zip")
unzip(zipfile = "XYZ.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

vehicle <- filter(SCC,str_detect(SCC.Level.Two, "Vehicle"))
vehicleSCC <- vehicle$SCC

NEIsub <- filter(NEI, NEI[,2] %in% vehicleSCC)
data <- filter(NEIsub, fips=="24510" | fips =="06037")

data$city <- ifelse(data$fips =="24510", "Baltimore City", "Los Angeles County")

png("plot6.png")

p <-ggplot(data, aes(factor(year),Emissions,fill=city))+geom_bar(stat="identity",width=0.8)+facet_grid(.~city)+scale_fill_manual(values = c("#F26B5E", "#D9A78B"))+labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + labs(title=expression("PM"[2.5]*" Motor Vehicle Emissions in Baltimore & LA, 1999-2008"))
print(p)

dev.off()