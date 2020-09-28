library(dplyr)
library(ggplot2)
library(readr)

## Create a directory named "data" under the current directory, then download and unzip if data has not been downloaded and unzipped yet

if(!dir.exists("./data")) dir.create("./data")
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file_unzipped <- "household_power_consumption.txt"
if(!file.exists("exdata_data_household_power_consumption.zip") & !file.exists(file_unzipped)){
  download.file(fileURL, "exdata_data_household_power_consumption.zip", method = "curl")
  unzip(zipfile = "exdata_data_household_power_consumption.zip", exdir = "./data")
}
  
## Load the txt data into a data frame named "df"
df <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

## Change the Date variable to POSIXIt from character 
df$Date <- as.Date(df$Date, "%d/%m/%Y")

## Subset data of interest (data of 02/01/2007-02/02/2007)
df_subset <- subset(df, df$Date >= "2007-02-01" & df$Date <= "2007-02-02", na.rm = TRUE)

## Create plot1
hist(df_subset$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power")
dev.copy(png, "plot1.png", width = 480, height = 480)
dev.off()
