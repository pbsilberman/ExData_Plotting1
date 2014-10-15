# We operate under the assumption that the data is in the current working directory.
# Additionally the data has the file name "household_power_consumption.txt".

# Read the data into a table. 
df <- read.table("household_power_consumption.txt", sep = ";", header = TRUE);

# Convert the Date column from factor to Date/Time.
df$Date <- as.Date(df$Date, "%d/%m/%Y");

# Excise the data from 2007-02-01 to 2007-02-02
newdf <- df[which(df$Date >= "2007-02-01" & df$Date <= "2007-02-02"), ];

# Convert the Time column from factor to Date/Time.
newdf$Time <- strptime(paste(newdf$Date,newdf$Time), "%Y-%m-%d %H:%M:%S");

# Convert the other columns to numeric.
newdf$Sub_metering_1 <- as.numeric(levels(newdf$Sub_metering_1))[newdf$Sub_metering_1];
newdf$Sub_metering_2 <- as.numeric(levels(newdf$Sub_metering_2))[newdf$Sub_metering_2];
newdf$Sub_metering_3 <- as.numeric(levels(newdf$Sub_metering_3))[newdf$Sub_metering_3];
newdf$Global_active_power <- as.numeric(levels(newdf$Global_active_power))[newdf$Global_active_power];
newdf$Global_reactive_power <- as.numeric(levels(newdf$Global_reactive_power))[newdf$Global_reactive_power];
newdf$Voltage <- as.numeric(levels(newdf$Voltage))[newdf$Voltage];

# Adjust the parameters to 2x2 so we can fit all four graphs in one png.
# Using the png device, create the graphs.
png(file = "plot4.png");
par(mfrow = c(2,2), mar = c(4,4,4,2), oma = c(0,0,0,0), cex = .8);
with(newdf, {
        plot(newdf$Time, newdf$Global_active_power, type = "l", main = "", ylab = "Global Active Power", xlab = "")
        plot(newdf$Time, newdf$Voltage, type = "l", main = "", xlab = "datetime", ylab = "Voltage")
        plot(newdf$Time, newdf$Sub_metering_1, type = "l", main = "", 
             ylab = "Energy sub metering", xlab = "")
        lines(newdf$Time, newdf$Sub_metering_2, type = "l", col = "red")
        lines(newdf$Time, newdf$Sub_metering_3, type = "l", col = "blue")
        legend("topright", col = c("black", "red", "blue"), 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", lty = 1)
        plot(newdf$Time, newdf$Global_reactive_power, type = "l", xlab = "datetime", ylab="Global_reactive_power", main = "")
});
dev.off();