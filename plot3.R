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
png(file="plot3.png")

#####
# Create the plot
with(tmp,plot(dt,Sub_metering_1,type="l",ylab="Energy sub metering",xlab=""))
with(tmp,lines(dt,Sub_metering_2,col="red"))
with(tmp,lines(dt,Sub_metering_3,col="blue"))
legend("topright",pch="__",col("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#####
# Close the png graphics device
dev.off()