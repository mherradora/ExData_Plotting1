#####
# Load the data.table library
library(data.table)

#####
# Read the file with the information
tmp <- fread("household_power_consumption.txt")

#####
# Select only the cases of the dates in the project
tmp <- tmp[tmp$Date=="1/2/2007" | tmp$Date=="2/2/2007",]

#####
# Convert to numeric the variable Global_active_power
tmp[,Global_active_power:=as.numeric(Global_active_power)]

#####
# Create a variable pasting Date and Time
tmp[,dt:=paste(Date,Time)]

#####
# Transform the variable dt to POSIXct
tmp[,dt:=as.POSIXct(strptime(dt,format="%d/%m/%Y %H:%M:%S"))]

#####
# Transform the variables Sub_metering_1 and Sub_metering_2 to numeric
tmp[,Sub_metering_1:=as.numeric(Sub_metering_1)]
tmp[,Sub_metering_2:=as.numeric(Sub_metering_2)]

#####
# Open a png graphics device
png(file="plot4.png")

#####
# Create the plot
par(mfrow=c(2,2))
with(tmp,{
  plot(dt,Global_active_power,type="l",ylab="Global Active Power (Kilowatts)",xlab="")
  plot(dt,Voltage,type="l",ylab="Voltage",xlab="datetime")
  plot(dt,Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
  lines(dt,Sub_metering_2,col="red")
  lines(dt,Sub_metering_3,col="blue")
  legend("topright",pch="__",col("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  plot(dt,Global_reactive_power,type="l",xlab="datetime")
})


#####
# Close the png graphics device
dev.off()