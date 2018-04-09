# plot4.R
# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

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

# Generate list of SCC values that are coal-based
coal <- grep("Coal", unique(SCC$EI.Sector))
coal.sectors <- unique(SCC$EI.Sector)[coal]
SCC.coal <- filter(SCC, EI.Sector %in% coal.sectors)

# Filter and reshape NEI data on coal-based SCC values
NEI.coal <- filter(NEI, SCC %in% SCC.coal$SCC)
NEI.coal %>% group_by(Year=year) %>% summarise(Emissions=sum(Emissions)) -> NEI.coal
NEI.coal$Year <- as.factor(NEI.coal$Year)

# Produce Plot
coal.plot <- ggplot(NEI.coal, aes(x=Year, y=Emissions)) + 
geom_col() + 
ylab("P2.5 Emissions (tons)") + 
ggtitle("P2.5 Emissions from Coal Sources")
ggsave("plot4.png", width=5, height=5)