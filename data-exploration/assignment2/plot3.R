# plot3.R
# Of the four types of sources indicated by the `𝚝𝚢𝚙𝚎` (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
# Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

# Imports
library(ggplot2)
library(reshape2)

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
total.emissions.baltimore <- tapply(NEI.baltimore$Emissions, list(NEI.baltimore$year, NEI.baltimore$type), FUN=sum)
total.emissions.baltimore.melt <- melt(total.emissions.baltimore, id.vars="type")
names(total.emissions.baltimore.melt) <- c("Year", "Type", "Emissions")
total.emissions.baltimore.melt$Year <- as.factor(total.emissions.baltimore.melt$Year)

# Produce plot
q3.plot <- ggplot(data.frame(total.emissions.baltimore.melt), aes(x=Year, y=Emissions)) +
    ylab("Emissions (tons)") +
    geom_bar(stat="identity") +
    facet_grid(Type ~.) 
ggsave("plot3.png", width=5, height=5)