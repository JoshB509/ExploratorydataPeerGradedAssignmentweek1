## Read the CSV into a vector and define the collumn classes
dat <- read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Remove the blank values
dat <- dat[complete.cases(dat),]

## Filter out all dates except 1st Feb 2007 to 2nd Feb 2007
dat <- dat[dat$Date %in% c("1/2/2007","2/2/2007"),]

## Change the Date col to date format Day, Month Year
dat$Date <- as.Date(dat$Date, "%d/%m/%Y")

## Combine Date and Time column
dateTime <- paste(dat$Date, dat$Time)

## Remove Date and Time column to be replaced with new formatted datetime 
dat <- dat[ ,!(names(dat) %in% c("Date","Time"))]

## Add DateTime column
dat <- cbind(dateTime, dat)

##Format datetime col to correct datetime format
dat$dateTime <- as.POSIXct(dateTime)

## Creating plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(dat, {
  plot(Global_active_power~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~dateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

## Save the visualalisation to plot4.png with specified wifth and height
dev.copy(png,"plot4.png", width=480, height=480)
dev.off()