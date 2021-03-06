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

png(filename = "plot4.png", width = 480, height = 480)

par(mfrow = c(2, 2))
{
        plot(Global_active_power ~ date_time, hpc, type = "n", xlab = "", ylab = "Global Active Power")
        lines(Global_active_power ~ date_time, hpc)
        
        plot(Voltage ~ date_time, hpc, type = "n", xlab = "datetime")
        lines(Voltage ~ date_time, hpc)
        
        plot(Sub_metering_1 ~ date_time, hpc, type = "n", xlab = "", ylab = "Energy sub metering")
        lines(Sub_metering_1 ~ date_time, hpc)
        lines(Sub_metering_2 ~ date_time, hpc, col = "red")
        lines(Sub_metering_3 ~ date_time, hpc, col = "blue")
        legend("topright", bty = "n",lty = 1, col = c("black", "red", "blue"),legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        
        plot(Global_reactive_power ~ date_time, hpc, type = "n", xlab = "datetime")
        lines(Global_reactive_power ~ date_time, hpc)
}

dev.off()
