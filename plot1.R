
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

hist(as.numeric(subdata$Global_active_power),xlab = "Global Active Power(kilowatts)", col="red", main = "Global Active Power")

dev.copy(png,file="plot1.png")
dev.off()

plot(subdata$DateTime, subdata$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")


