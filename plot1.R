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

## Plot the 1st Plot
hist(dat$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

## Save the visualalisation to plot1.png with specified wifth and height
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()