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

#Construct and save the plot as a png file
png("plot1.png", width = 480, height = 480)
hist(as.numeric(data$Global_active_power), xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red", main = "Global Active Power")
dev.off()

