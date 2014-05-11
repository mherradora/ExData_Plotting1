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
# Open a png graphics device
place <- getwd()
#theFile <- paste(place,"/plots/","plot1.png",sep="")
png(file="plot1.png")

#####
# Create the plot
hist(tmp$Global_active_power,
     main="Global Active Power",
     xlab="Global Active Power (Kilowatts)",
     col="red")


#####
# Close the png graphics device
dev.off()