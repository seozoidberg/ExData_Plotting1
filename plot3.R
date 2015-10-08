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

## Getting dates and times
my_subset_data$fulltime <- as.POSIXct(paste(my_subset_data$Date, my_subset_data$Time), format = "%d/%m/%Y %H:%M:%S")

## Constructing the plot 3
png(file = "plot3.png")
  plot(my_subset_data$fulltime, my_subset_data$Sub_metering_1, type = "n", xlab = "", ylab ="Energy sub metering")
    lines(my_subset_data$fulltime, my_subset_data$Sub_metering_1, col = "black")
    lines(my_subset_data$fulltime, my_subset_data$Sub_metering_2, col = "red")
    lines(my_subset_data$fulltime, my_subset_data$Sub_metering_3, col = "blue")
      legend("topright", legend = names(my_subset_data)[7:9], lty = 1, col = c("black", "red", "blue"))
dev.off()