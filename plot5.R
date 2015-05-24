# How have emissions from motor vehicle sources changed from 1999–2008 in
# Baltimore City?

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesData <- NEI[NEI$SCC %in% vehiclesSCC,]

baltimoreVehiclesData <- vehiclesData[vehiclesData$fips == 24510,]

png(filename = "plot5.png",
    width = 480, height = 480, units = "px", pointsize = 14,
    bg = "white",  res = NA)

library(ggplot2)

baltimorePlot <- ggplot(baltimoreVehiclesData, aes(factor(year), Emissions)) +
  geom_bar(stat = "identity", fill = "#66CCFF", width = 0.75) +
  theme_bw() +  
  guides(fill = FALSE) +
  labs(x = "year", y = expression("Total PM"[2.5]*" Emission (tons)")) + 
  labs(title = expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))

print(baltimorePlot)

dev.off()