library("data.table")
library("stringr")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile = "XYZ.zip")
unzip(zipfile = "XYZ.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

Comb <- filter(SCC,str_detect(SCC.Level.One, "Comb"))
Coal <- filter(SCC,str_detect(SCC.Level.Four, "Coal"))
CoalComb <- rbind(Comb,Coal)
CoalCombSCC <- CoalComb$SCC

NEIsub <- filter(NEI, NEI[,2] %in% CoalCombSCC)

png("plot4.png")

p <- ggplot(NEIsub, aes(x=factor(year),y=Emissions/10^4))+geom_bar(stat="identity",fill="#f15664",width=0.8)+ labs(x="year", y=expression("PM"[2.5]*" Emission (in 10^4 Tons unit)"))+ labs(title=expression("PM"[2.5]*" Coal Combustion Emissions Across US from 1999-2008"))
print(p)

dev.off()

