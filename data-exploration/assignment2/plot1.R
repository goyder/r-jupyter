# plot1.R
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

# Obtain and read in data
if (!file.exists("data")) {
    dir.create("data")
}

if (!file.exists("data/pollution.zip")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                 "data/pollution.zip")
}

unzip("data/pollution.zip", exdir="data")

NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# Data prep
total.emissions <- tapply(NEI$Emissions, NEI$year, FUN=sum)

# Prepare plot
if (file.exists("plot1.png")) {
    file.remove("plot1.png")
}
png("plot1.png", width=480, height=480, units="px")
barplot(total.emissions,
       main="Total PM2.5 emissions across USA",
       xlab="Year",
       ylab="Emissions (tons)")
dev.off()