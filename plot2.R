Url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("./exdata_data_household_power_consumption.zip")) {
        download.file(Url, destfile = "./exdata_data_household_power_consumption.zip")  
}

unzip("./exdata_data_household_power_consumption.zip")

var_names <- read.table("./household_power_consumption.txt", sep = ";", nrows = 1)
hpc <- read.table("./household_power_consumption.txt", col.names = var_names, na.strings = "?", sep = ";", skip = 66638, nrows = 69517-66638)

remove(Url, var_names)

hpc$Date <- strptime(hpc$Date, format = "%d/%m/%Y")
hpc$Time <- format(hpc$Time, format = "%H:%M:%S")
hpc$date_time <- as.POSIXct(paste(hpc$Date, hpc$Time))

png(filename = "plot2.png", width = 480, height = 480)

plot(Global_active_power ~ date_time, hpc, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(Global_active_power ~ date_time, hpc)

dev.off()
