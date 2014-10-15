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

# Convert sub_metering columns from factor to numeric.
newdf$Sub_metering_1 <- as.numeric(levels(newdf$Sub_metering_1))[newdf$Sub_metering_1];
newdf$Sub_metering_2 <- as.numeric(levels(newdf$Sub_metering_2))[newdf$Sub_metering_2];
newdf$Sub_metering_3 <- as.numeric(levels(newdf$Sub_metering_3))[newdf$Sub_metering_3];

# Use the png device to create the line graph.
png(file = "plot3.png");
with(newdf, plot(newdf$Time, newdf$Sub_metering_1, type = "l", main = "", 
                 ylab = "Energy sub metering", xlab = ""));
lines(newdf$Time, newdf$Sub_metering_2, type = "l", col = "red");
lines(newdf$Time, newdf$Sub_metering_3, type = "l", col = "blue");
legend("topright", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1);
dev.off();