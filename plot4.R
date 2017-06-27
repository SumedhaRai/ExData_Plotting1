
## files, a total of eight files in the top-level folder of the repo.

if (!file.exists("./Data")) 
    
{dir.create("./Data")}

downloadURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

downloadFile <- "./Data/household_power_consumption.zip"

householdFile <- "./Data/household_power_consumption.txt"

##

if (!file.exists(householdFile)) {
    
    download.file(downloadURL, downloadFile)
    
    unzip(downloadFile, overwrite = T, exdir = "./Data")
    
}

data <- read.table("./Data/household_power_consumption.txt",header=TRUE,sep=";",na.strings = "?")

subdata <- subset(data,strptime(data$Date, "%d/%m/%Y") >= "2007-02-01" & strptime(data$Date, "%d/%m/%Y") < "2007-02-03")

DateTime <-strptime(paste(subdata$Date, subdata$Time, sep=" "),"%d/%m/%Y %H:%M:%S")

subdata <- cbind(DateTime, subdata)

par(mfrow=c(2,2))

plot(subdata$DateTime, subdata$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

plot(subdata$DateTime, subdata$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

plot(subdata$DateTime, subdata$Sub_metering_1, type = "l", xlab = "", col="black",
     ylab = "Energy sub metering")
points(subdata$DateTime, subdata$Sub_metering_2,type = "l", col="red")
points(subdata$DateTime, subdata$Sub_metering_3,type = "l", col="blue")
legend("topright", col =c("black","red","blue"), lty=c(1,1,1),lwd=c(2,2,2),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
plot(subdata$DateTime, subdata$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global Reactive Power")

dev.copy(png,file="plot4.png")
dev.off()

