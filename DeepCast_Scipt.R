library(data.table)
library(psych)
library(mvtnorm)
library(caret)
library(PRROC)

X <- fread(input = "D:/DeepCast/SensorDeviceTestRuns.csv", sep = ",", header = T, showProgress = T)
X <- data.frame(X)
str(X)

summary(X)


head(X)

library(lubridate)
X$Date <- dmy(X$Test.Date)

X$Month <- as.factor(format(as.Date(X$Date),"%m"))
X$Day <- as.factor(format(as.Date(X$Date),"%d"))
X$Year <- as.factor(format(as.Date(X$Date),"%Y"))

X$Passed<-as.numeric(X$Passed)
#X$Passed <- as.factor(X$Passed)

hist(X$Liquid.1, 100)
hist(X$Liquid.2, 100)
hist(X$Liquid.3, 100)

Xgood <- X[X$Passed == 1,]
Xanom <- X[X$Passed == 0,]

# Total number of anomalies and Non-anomalies Rows in data
rowsTotal <- nrow(X)
anomaliesRowsTotal <- nrow(X[X$Passed == 0,])
nonanomaliesRowsTotal <- rowsTotal - fraudRowsTotal

anomaliesRowsTotal
nonanomaliesRowsTotal
rowsTotal


