data <- read.table("household_power_consumption.txt",skip=1,sep=";")

names(data) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
subData <- subset(data,data$Date=="1/2/2007" | data$Date =="2/2/2007")

subData$Date <- as.Date(subData$Date, format="%d/%m/%Y")
subData$Time <- strptime(subData$Time, format="%H:%M:%S")
subData[1:1440,"Time"] <- format(subData[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subData[1441:2880,"Time"] <- format(subData[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

plot(subData$Time,subData$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
with(subData,lines(Time,as.numeric(as.character(Sub_metering_1))))
with(subData,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
with(subData,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

title(main="Energy sub-metering")

dev.copy(png, filename="plot3.png")
dev.off()