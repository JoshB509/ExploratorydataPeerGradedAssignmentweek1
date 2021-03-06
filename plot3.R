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

## Creating plot 3
with(dat, {
  plot(dat$Sub_metering_1~dat$dateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(dat$Sub_metering_2~dat$dateTime,col='Red')
  lines(dat$Sub_metering_3~dat$dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Save the visualalisation to plot3.png with specified wifth and height
dev.copy(png,"plot3.png", width=480, height=480)
dev.off()