# Reproducible Research: Peer Assessment 1


## Loading and preprocessing the data

For preprocessing purposes, the data is read into the variable `steps` and a factor is created
for the date.


```r
library(lubridate)
#preprocessing
steps<-read.csv("activity.csv")
steps$date<-ymd(steps$date)
steps$date<-factor(steps$date)
```


## What is mean total number of steps taken per day?
The histogram below illustrate the number of steps per day.


```r
steps_pd<-tapply(steps$steps, steps$date, sum, na.rm=TRUE)
hist(steps_pd)
```

![plot of chunk unnamed-chunk-2](PA1_template_files/figure-html/unnamed-chunk-2.png) 

On average, 9354.23 steps are taken per day with a median of 10395.

## What is the average daily activity pattern?
1.  The graph below plot the average number of steps per interval.


```r
steps_pint<-tapply(steps$steps, steps$interval, mean, na.rm=TRUE)
plot(steps_pint, type="l")
```

![plot of chunk unnamed-chunk-3](PA1_template_files/figure-html/unnamed-chunk-3.png) 

2. The interval with the maximum number of steps on average are:


```r
which.max(steps_pint)
```

```
## 835 
## 104
```


## Imputing missing values
1. Number of missing values.

Missing values are calculated as below:


```r
for (i in levels(steps$interval)) { 
  d<-steps[steps$interval==i,]
  m<-median(d$steps, na.rm=TRUE)
  d$steps[is.na(d$steps)] = m
  steps[is.na(steps$steps) & steps$interval==i,]$steps<-m
}
print(sum(is.na(steps$steps)))
```

```
## [1] 2304
```

After executing the above lines, the number of NA values are 2304.

## Are there differences in activity patterns between weekdays and weekends?
