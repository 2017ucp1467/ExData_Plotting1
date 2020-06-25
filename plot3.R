library(data.table)

DF<-fread('household_power_consumption/data.txt', na.strings = '?')
DF[,DateTime:= as.POSIXct(paste(Date,Time), format='%d/%m/%Y %H:%M:%S')]
DF[,Sub_metering_1:= lapply(.SD, as.integer), .SDcols=c('Sub_metering_1')]
DF[,Sub_metering_2:= lapply(.SD, as.integer), .SDcols=c('Sub_metering_2')]
DF[,Sub_metering_3:= lapply(.SD, as.integer), .SDcols=c('Sub_metering_3')]
pow_DF<- DF[(DateTime>='2007-02-01') & (DateTime<= '2007-02-02')]

png('plot3.png', width = 480, height = 480)

plot(x=pow_DF[,DateTime], y= pow_DF[,Sub_metering_1],
     type = 'l',xlab='',ylab = 'Energy sub metering')
lines(x= pow_DF[,DateTime], y= pow_DF[,Sub_metering_2], col= 'red')
lines(x= pow_DF[,DateTime], y= pow_DF[,Sub_metering_3], col= 'blue')

legend('topright',col = c('black','red','blue'),
       c('sub_metering_1','sub_metering_2','sub_metering_3'),
       lty = c(1,1), lwd = c(1,1))

dev.off()