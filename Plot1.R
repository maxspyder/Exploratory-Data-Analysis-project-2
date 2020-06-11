library("data.table")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile = "XYZ.zip")
unzip(zipfile = "XYZ.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

data <- aggregate(NEI$Emissions, by=list(Category=NEI$year), FUN=sum)

png("plot1.png")

barplot(data[, 2], names = data[, 1], xlab = "Years", ylab = "Emissions", main = "Emissions over the Years")

dev.off()