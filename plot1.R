Url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("./exdata_data_household_power_consumption.zip")) {
        download.file(Url, destfile = "./exdata_data_household_power_consumption.zip")  
}

unzip("./exdata_data_household_power_consumption.zip")

var_names <- read.table("./household_power_consumption.txt", sep = ";", nrows = 1)
hpc <- read.table("./household_power_consumption.txt", col.names = var_names, na.strings = "?", sep = ";", skip = 66638, nrows = 69517-66638)

remove(Url, var_names)

png(filename = "plot1.png", width = 480, height = 480)

hist(hpc$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

dev.off()
