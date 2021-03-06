library(data.table)
library(dplyr)

# Only pull the data if we don't already have it.
if (!(file.exists("household_power_consumption.txt"))) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip")
    unzip("household_power_consumption.zip")
}

# Read in and filter the data.
power_consumption <- fread("household_power_consumption.txt", header = TRUE, sep = ';', na.strings = "?")
power_consumption <- mutate(power_consumption, datetime = as.POSIXct(paste(Date, " " ,Time), format="%d/%m/%Y %H:%M:%S" ))
start_date <- strptime("2007-02-01", "%Y-%m-%d")
end_date <- strftime("2007-02-03", "%Y-%m-%d")
power_consumption_subset <- filter(power_consumption, (start_date <= datetime) & (datetime < end_date))

# Output our Plot2 file.
if (file.exists("plot2.png")) {
    file.remove("plot2.png")
}

png("plot2.png", width=480, height=480, units="px")
plot(power_consumption_subset$datetime, power_consumption_subset$Global_active_power, type='l',
    ylab = "Global Active Power (kilowatts)",
    xlab = "")
axis.POSIXct(1, power_consumption_subset$datetime, format = "%a")
dev.off()