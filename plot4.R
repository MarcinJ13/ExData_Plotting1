
# Peer reviewed assignment for week 1 of Exploratory Data Analysis course on Coursera.
# Author: Marcin Jankowski

#====================== OBTAIN DATA =================

#read file
powcom = read.csv("household_power_consumption.txt",sep = ";")

#create subset for specified dates (2007-02-01 and 2007-02-02)
powcom2 = powcom[as.Date(powcom$Date, "%d/%m/%Y") %in%  c(as.Date("01/02/2007", "%d/%m/%Y"),as.Date("02/02/2007", "%d/%m/%Y")),]

#remove original set to release memory
rm(powcom)


#====================== CONVERT DATA =================


#convert columns (this is again as the same powcom name)
powcom = data.frame (
Date = as.Date(powcom2$Date, "%d/%m/%Y"),
Time = as.character(powcom2$Time),
Global_active_power = as.numeric(levels(powcom2$Global_active_power))[powcom2$Global_active_power],
Global_reactive_power = as.numeric(levels(powcom2$Global_reactive_power))[powcom2$Global_reactive_power],
Voltage= as.numeric(levels(powcom2$Voltage))[powcom2$Voltage],
Global_intensity= as.numeric(levels(powcom2$Global_intensity))[powcom2$Global_intensity],
Sub_metering_1= as.numeric(levels(powcom2$Sub_metering_1))[powcom2$Sub_metering_1],
Sub_metering_2= as.numeric(levels(powcom2$Sub_metering_2))[powcom2$Sub_metering_2],
Sub_metering_3= powcom2$Sub_metering_3
)


#====================== PLOT RESULTS =================

# Plot4 - 4 subplots
png(filename = "plot4.png",  width = 480, height = 480)
#set layout
par(mfrow=c(2,2))
#first (top-left) subplot
plot(as.POSIXct(paste(powcom$Date,powcom$Time)), powcom$Global_active_power,type="n", xlab="", ylab="Global Active Power (kilowatts)")
lines(as.POSIXct(paste(powcom$Date,powcom$Time)), powcom$Global_active_power)
#second (top-right) subplot
plot(as.POSIXct(paste(powcom$Date,powcom$Time)), powcom$Voltage,type="n", xlab="datetime", ylab="Voltage")
lines(as.POSIXct(paste(powcom$Date,powcom$Time)), powcom$Voltage)
#third (bottom-left) subplot
plot(as.POSIXct(paste(powcom$Date,powcom$Time)), powcom$Sub_metering_1,type="n", xlab="", ylab="Energy sub metering")
lines(as.POSIXct(paste(powcom$Date,powcom$Time)), powcom$Sub_metering_1, col="gray50")
lines(as.POSIXct(paste(powcom$Date,powcom$Time)), powcom$Sub_metering_2, col="red")
lines(as.POSIXct(paste(powcom$Date,powcom$Time)), powcom$Sub_metering_3, col="blue")
legend("topright", col=c("gray50","red","blue"), lwd=c(2,2,2), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
#third (bottom-right) subplot
plot(as.POSIXct(paste(powcom$Date,powcom$Time)), powcom$Global_reactive_power,type="n", xlab="datetime", ylab="Global_reactive_power")
lines(as.POSIXct(paste(powcom$Date,powcom$Time)), powcom$Global_reactive_power)
dev.off()


#====================== END =================