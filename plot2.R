# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make a
# plot answering this question.

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimore <- NEI[NEI$fips=="24510",]
aggregateBaltimore <- aggregate(Emissions ~ year, baltimore, sum)

png(filename = "plot2.png",
    width = 480, height = 480, units = "px", pointsize = 14,
    bg = "white",  res = NA)

barplot(
  aggregateBaltimore$Emissions/1000,
  names.arg=aggregateBaltimore$year,
  xlab="Year",
  ylab="PM2.5 Emissions (thousands of tons)",
  main="Total Emissions From PM2.5 Across All Baltimore City Sources"
)

dev.off()