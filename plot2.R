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
# Open a png graphics device
png(file="plot2.png")

#####
# Create the plot
with(tmp,plot(dt,Global_active_power,type="l",ylab="Global Active Power (Kilowatts)",xlab=""))

#####
# Close the png graphics device
dev.off()