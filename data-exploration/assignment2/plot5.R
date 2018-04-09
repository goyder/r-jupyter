# plot5.R
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

# Imports
library(ggplot2)
library(reshape2)
library(dplyr)

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
SCC.vehicles <- unique(SCC$EI.Sector)[grep("Vehicle", unique(SCC$EI.Sector))]
SCC.vehicles <- filter(SCC, EI.Sector %in% SCC.vehicles)
NEI.baltimorevehicles <- filter(NEI, (SCC %in% SCC.vehicles$SCC) & fips %in% "24510")
NEI.baltimorevehicles %>% group_by(Year=year) %>% summarise(Emissions=sum(Emissions)) -> NEI.baltimorevehicles.summary

# Produce plot
vehicles.plot <- ggplot(NEI.baltimorevehicles.summary, aes(x=Year, y=Emissions)) + 
geom_col() + 
ylab("P2.5 Emissions (tons)") + 
ggtitle("P2.5 Emissions from Vehicles in Baltimore")

ggsave("plot5.png", width=5, height=5)