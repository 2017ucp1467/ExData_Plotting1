library(data.table)

DF<-fread('household_power_consumption/data.txt', na.strings = '?')
pow_DF<- DF[Date %in% c('1/2/2007', '2/2/2007')]
pow_DF[,Global_active_power:= lapply(.SD, as.numeric), .SDcols=c('Global_active_power')]
pow_DF[,Global_reactive_power:= lapply(.SD, as.numeric), .SDcols=c('Global_reactive_power')]
pow_DF[,DateTime:= strptime(paste(Date,Time, sep = ' '), format='%d/%m/%Y %H:%M:%S')]
pow_DF[,Sub_metering_1:= lapply(.SD, as.integer), .SDcols=c('Sub_metering_1')]
pow_DF[,Sub_metering_2:= lapply(.SD, as.integer), .SDcols=c('Sub_metering_2')]
pow_DF[,Sub_metering_3:= lapply(.SD, as.integer), .SDcols=c('Sub_metering_3')]
pow_DF[,Voltage:= lapply(.SD, as.numeric), .SDcols=c('Voltage')]


png('plot4.png', width = 480, height = 480)
par(mfrow=c(2,2))

#plot 4.1
plot(x= pow_DF[,DateTime]
     ,y=pow_DF[,Global_active_power], 
     type = "l", xlab="",ylab= 'Global Active Power (kilowatts)')
#plot 4.2
plot(x = pow_DF[,DateTime], y= pow_DF[,Voltage],
     type = 'l',xlab='datetime',ylab = 'Voltage')

#plot 4.3
plot(x=pow_DF[,DateTime], y= pow_DF[,Sub_metering_1],
     type = 'l',xlab='',ylab = 'Energy sub metering')
lines(x= pow_DF[,DateTime], y= pow_DF[,Sub_metering_2], col= 'red')
lines(x= pow_DF[,DateTime], y= pow_DF[,Sub_metering_3], col= 'blue')

legend('topright',col = c('black','red','blue'),
       c('sub_metering_1','sub_metering_2','sub_metering_3'),
       lty = c(1,1), bty = 'n', cex = .5)

#plot 4.4
plot(x= pow_DF[,DateTime]
     ,y=pow_DF[,Global_active_power], 
     type = "l", xlab="",ylab= 'Global_reactive_power')

dev.off()