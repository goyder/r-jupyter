# plot2.R
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (`𝚏𝚒𝚙𝚜 == "𝟸𝟺𝟻𝟷𝟶"`) from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

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
NEI.baltimore <- NEI[NEI$fips == "24510", ]
total.emissions.baltimore <- tapply(NEI.baltimore$Emissions, NEI.baltimore$year, FUN=sum)

# Prepare plot
png("plot2.png", width=480, height=480, units="px")
barplot(total.emissions.baltimore,
       main="Total PM2.5 emissions from Baltimore",
       xlab="Year",
       ylab="Emissions (tons)")
dev.off()