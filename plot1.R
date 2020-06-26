library('data.table')

DF<-fread('household_power_consumption/data.txt', na.strings = '?')
pow_DF<- DF[Date %in% c('1/2/2007', '2/2/2007')]
pow_DF[,Date:=lapply(.SD, as.Date, '%d/%m/%Y'), .SDcols=c('Date')]
pow_DF[,Global_active_power:= lapply(.SD, as.numeric), .SDcols=c('Global_active_power')]


png('plot1.png', width = 480, height = 480)

hist(pow_DF$Global_active_power, col = 'red', main='Global Active Power', xlab = 'Global Active Power (kilowatts)')

dev.off()