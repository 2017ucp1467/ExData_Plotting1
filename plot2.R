library(data.table)

DF<-fread('household_power_consumption/data.txt', na.strings = '?')
DF[,DateTime:= as.POSIXct(paste(Date,Time), format='%d/%m/%Y %H:%M:%S')]
DF[,Global_active_power:= lapply(.SD, as.numeric), .SDcols=c('Global_active_power')]
pow_DF<- DF[(DateTime>='2007-02-01') & (DateTime<= '2007-02-02')]

png('plot2.png', width = 480, height = 480)

plot(x= pow_DF[,DateTime]
     ,y=pow_DF[,Global_active_power], 
     type = "l", xlab="",ylab= 'Global Active Power (kilowatts)')

dev.off()