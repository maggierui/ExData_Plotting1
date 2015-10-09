##Read data from the txt file
electricity_stat<-read.table("household_power_consumption.txt",sep=";",header=TRUE)

##convert Date to POSIXlt format
converted_stat<-data.frame()
converted_stat[,1]<-list(strptime(electricity_stat[,1],"%d/%m/%Y", tz=''))

##Subset data to dates of "2007-02-01" and "2007-02-02"
converted_sub<-data.frame()
converted_sub<-subset(converted_stat,Date=="2007-02-01"|Date=="2007-02-02")

##Convert variables "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", and "Sub_metering_2" from factor to character
dat<-data.frame()
dat<-converted_sub
for(i in 3:8){
	dat[,i]<-as.character(dat[,i])
}

##Clean data -- get rid of all observations with missing value "?"
dat<-dat[dat$Global_active_power!="?"&dat$Global_reactive_power!="?"&dat$Voltage!="?"&dat$Global_intensity!="?"&dat$Sub_metering_1!="?"&dat$Sub_metering_2!="?",]

##Convert variables "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", and "Sub_metering_2" to numeric
for(i in 3:8){
	dat[,i]<-as.numeric(dat[,i])
}

##Combine Date and Time
dat_1<-data.frame()
dat_1<-dat
dat_1$DateTime<-as.POSIXct(paste(dat_1$Date,dat_1$Time),format="%Y-%m-%d %H:%M:%S")

##Plot 2
png(file="plot2.png",width=480,height=480)
plot(dat_1$DateTime,dat$Global_active_power,type="l",xlab=NA, ylab="Global Active Power (killowatts)")
dev.off()