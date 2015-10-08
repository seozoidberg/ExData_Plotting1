library(dplyr)

## loading data if it already exists
if (file.exists("2feb_data.csv"))
{ 
  my_subset_data <- read.csv("2feb_data.csv")

## else -> subsetting required data  
} else if (file.exists("household_power_consumption.txt"))
  {
  my_data <- read.table("household_power_consumption.txt", header = T, sep = ";", colClasses = "character")
  my_subset_data <- filter(my_data, Date == "1/2/2007" | Date == "2/2/2007")
  write.csv(my_subset_data, "2feb_data.csv", row.names = F)

## else -> unziping and subsetting required data      
  } else if (file.exists("exdata-data-household_power_consumption.zip"))
{ 
  unzip("exdata-data-household_power_consumption.zip")
    my_data <- read.table("household_power_consumption.txt", header = T, sep = ";", colClasses = "character")
    my_subset_data <- filter(my_data, Date == "1/2/2007" | Date == "2/2/2007")
    write.csv(my_subset_data, "2feb_data.csv", row.names = F)

## else -> downloading, unziping and subsetting required data          
} else 
{
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "exdata-data-household_power_consumption.zip", method="curl")
    unzip("exdata-data-household_power_consumption.zip")
      my_data <- read.table("household_power_consumption.txt", header = T, sep = ";", colClasses = "character")
      my_subset_data <- filter(my_data, Date == "1/2/2007" | Date == "2/2/2007")
      write.csv(my_subset_data, "2feb_data.csv", row.names = F)
}

## Constructing the plot 1

png(file = "plot1.png")
  hist(as.numeric(my_subset_data$Global_active_power), col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()