library(lubridate)

#preprocessing
steps<-read.csv("activity.csv")
steps$date<-ymd(steps$date)
steps$date<-factor(steps$date)
steps$interval<-factor(steps$interval)

#Total steps per day
steps_pd<-tapply(steps$steps, steps$date, sum, na.rm=TRUE)
steps_pint<-tapply(steps$steps, steps$interval, sum, na.rm=TRUE)

for (i in levels(steps$interval)) { 
  d<-steps[steps$interval==i,]
  m<-median(d$steps, na.rm=TRUE)
  d$steps[is.na(d$steps)] = m
  steps[is.na(steps$steps) & steps$interval==i,]$steps<-m
}

write.table(steps, file="fixed_data")