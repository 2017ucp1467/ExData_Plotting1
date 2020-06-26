library(data.table)

DF<-fread('household_power_consumption/data.txt', na.strings = '?')
pow_DF<- DF[Date %in% c('1/2/2007', '2/2/2007')]
pow_DF[,DateTime:= strptime(paste(Date,Time, sep = ' '), format='%d/%m/%Y %H:%M:%S')]
pow_DF[,Global_active_power:= lapply(.SD, as.numeric), .SDcols=c('Global_active_power')]

png('plot2.png', width = 480, height = 480)

plot(x= pow_DF[,DateTime]
     ,y=pow_DF[,Global_active_power], 
     type = "l", xlab="",ylab= 'Global Active Power (kilowatts)')

dev.off()