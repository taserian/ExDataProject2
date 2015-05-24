# Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California (fips ==
# "06037"). Which city has seen greater changes over time in motor vehicle
# emissions?

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesData <- NEI[NEI$SCC %in% vehiclesSCC,]
vehiclesBaltimore <- vehiclesData[vehiclesData$fips == 24510,]
vehiclesBaltimore$city <- "Baltimore City"
vehiclesLosAng <- vehiclesData[vehiclesData$fips=="06037",]
vehiclesLosAng$city <- "Los Angeles County"
citiesData <- rbind(vehiclesBaltimore, vehiclesLosAng)

png(filename = "plot6.png",
    width = 480, height = 480, units = "px", pointsize = 14,
    bg = "white",  res = NA)

library(ggplot2)

comparisonPlot <- ggplot(citiesData, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=year), stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  guides(fill=FALSE) + 
  theme_bw() +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))

print(comparisonPlot)

dev.off()