# plot6.R
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (𝚏𝚒𝚙𝚜 == "𝟶𝟼𝟶𝟹𝟽"). 
# Which city has seen greater changes over time in motor vehicle emissions?

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
NEI.vehicles <- filter(NEI, (SCC %in% SCC.vehicles$SCC) & fips %in% c("24510", "06037"))
NEI.vehicles %>% 
group_by(Year=year, City=fips) %>% 
summarise(Emissions=sum(Emissions)) %>% 
mutate(City=if_else(City=="06037", "LA", "Baltimore")) -> NEI.vehicles.summary

# Produce plot
vehicles.plot <- ggplot(NEI.vehicles.summary, aes(x=Year, y=Emissions)) + 
geom_col() + ylab("P2.5 Emissions (tons)") + 
facet_grid(City ~., scales="free_y") + 
ggtitle("P2.5 Emissions from Vehicles")

ggsave("plot6.png", width=5, height=5)