link <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if(!file.exists("Household Power Consumption.zip")){
    download.file(link, destfile = "Household Power Consumption.zip", method = "curl")
    unzip(zipfile = "Household Power Consumption.zip")
}

#Load packages
invisible(lapply(c("data.table", "dplyr"), require, quietly = TRUE, character.only = TRUE))

#Read data
data <- fread("household_power_consumption.txt")

#Subset rows from the dates 2007-02-01 and 2007-02-02
data <- filter(data, as.Date(Date, "%d/%m/%Y") == "2007-02-01" | as.Date(Date, "%d/%m/%Y") == "2007-02-02")

#Create date-time string
date.time <- strptime(paste(data$Date, data$Time, sep = " "), "%d/%m/%Y %H:%M:%S")

#Construct and save the plot as a png file
png("plot3.png", width = 480, height = 480)

with(data, plot(date.time, Sub_metering_1, xlab = "", ylab = "", type = "l", col = "black"))
with(data, lines(date.time, Sub_metering_2, xlab = "", ylab = "", type = "l", col = "red"))
with(data, lines(date.time, Sub_metering_3, xlab = "", ylab = "", type = "l", col = "blue"))

title(xlab = "", ylab = "Energy sub metering")

legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, lwd = 1)

dev.off()

