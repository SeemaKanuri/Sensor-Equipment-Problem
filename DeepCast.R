#The following package will be used:

#cluster for computing pam and for analyzing cluster silhouettes
#factoextra for visualizing clusters using ggplot2 plotting system
#NbClust for finding the optimal number of clusters



data("train")

library(caret)
set.seed(123)
idx <- createDataPartition(y=train$Passed, p=0.7, list = FALSE)
training <- train[idx,]
test <- train[-idx,]

training_data <- scale(training[-7])
summary(training_data)

#develop a mode <- three clusters
train.kmeans <- kmeans(training_data[,-7], centers =10, iter.max = 1000)
train.kmeans

train.kmeans$centers

training$cluster <- as.factor(train.kmeans$cluster)
head(training)
table(training$Passed, training$cluster)

##install.packages("NbClust")
library(NbClust)

#no of cluster nc
nc <- NbClust(training_data, min.nc = 2, max.nc = 15, method = "kmeans")
nc
nc$Best.nc

par(mfrow=c(1,1))
best <- table(nc$Best.nc[1,])

barplot(best, xlab = '#no of clusters', ylab = "criteria", main=" cluster we can go in analysing the given data set")

#install.packages("cluster")

library(cluster)
distance <- dist(training_data)
sk <- silhouette(train.kmeans$cluster, distance)
plot(sk)



