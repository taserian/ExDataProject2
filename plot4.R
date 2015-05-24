# Across the United States, how have emissions from coal combustion-related
# sources changed from 1999–2008?

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

combustion <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coal <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coalCombustion <- (combustion & coal)
combustionSCC <- SCC[coalCombustion,]$SCC
combustionData <- NEI[NEI$SCC %in% combustionSCC,]

png(filename = "plot4.png",
    width = 480, height = 480, units = "px", pointsize = 14,
    bg = "white",  res = NA)

library(ggplot2)

coalCumbPlot <- ggplot( combustionData, aes(factor(year), Emissions/10^3)) +
  geom_bar(stat="identity", fill="blue", width=0.75) +
  theme_bw() +
  guides(fill=FALSE) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emissions (thousands of tons)")) + 
  labs(title=expression("US Coal Combustion Source Emissions (PM"[2.5]*") from 1999-2008"))

print(coalCumbPlot)

dev.off()