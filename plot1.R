library('data.table')

DF<-fread('household_power_consumption/data.txt', na.strings = '?')
DF[,Date:=lapply(.SD, as.Date, '%d/%m/%Y'), .SDcols=c('Date')]
DF[,Global_active_power:= lapply(.SD, as.numeric), .SDcols=c('Global_active_power')]
pow_DF<- DF[(Date>='2007-02-01') & (Date<= '2007-02-02')]

png('plot1.png', width = 480, height = 480)

hist(pow_DF$Global_active_power, col = 'red', main='Global Active Power', xlab = 'Global Active Power (kilowatts)')

dev.off()