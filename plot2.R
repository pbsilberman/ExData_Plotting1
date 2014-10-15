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

# Convert the Global_active_power column from factor to numeric.
newdf$Global_active_power <- as.numeric(levels(newdf$Global_active_power))[newdf$Global_active_power];

# Using the png device, create the line graph.
png(file = "plot2.png");
with(newdf, plot(newdf$Time, newdf$Global_active_power, type = "l", 
                 ylab = "Global Active Power (kilowatts)", xlab = ""));
dev.off();