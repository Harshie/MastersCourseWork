library(mlbench)
library(randomForest)
library(nnet)
install.packages("randomForest")

data("Satellite")
satellitedata<-data.frame(Satellite)

# this will re-order alphabetically class labels and remove spacing
satellitedata$classes <- gsub(" ", "_", satellitedata$classes)
satellitedata$classes <- factor( as.character(satellitedata$classes) )

# to have the same initial split
set.seed(19200349)
D <- nrow(Satellite)
keep <- sample(1:D, 5500)
test <- setdiff(1:D, keep)
dat <- satellitedata[keep,]
dat_test <- satellitedata[test,]

N<-nrow(dat)
train<-sample(1:N,size = 0.75*N)
val<-setdiff(1:N,train)
dat_train<-dat[train,]
dat_val<-dat[val,]

#Fitting the model
# multinomial logistic regression
fitLog<-multinom(classes~.,data = dat_train)

#Random Forest
fitRF <- randomForest(classes~., data = dat_train, importance=TRUE)

#Prediction

# Multinomial logistic regression
predLogR <- predict(fitLog, type = "class", newdata = dat_val)
tabValLog <- table(dat_val$classes, predLogR)
tabValLog
accLog <- sum(diag(tabValLog))/sum(tabValLog)

# Random Forest Prediction
predRF<-predict(fitRF,type = "class",newdata = dat_val)
tabValRF <- table(dat_val$classes, predRF)
tabValRF
accRF <- sum(diag(tabValRF))/sum(tabValRF)

# print accuracy
acc <- c(Mlogistic = accLog,RandomForest = accRF)
acc

# use the method that did best on the validation data 
# to predict the test data
best <- names( which.max(acc) )
switch(best,
       Mlogistic = {
         predTestLog <- predict(fitLog, type = "class", newdata = dat_test)
         tabTestLog <- table(dat_test$classes, predTestLog)
         accBest <- sum(diag(tabTestLog))/sum(tabTestLog)
       },
       RandomForest = {
         predTestRF<-predict(fitRF,type = "class",newdata = dat_test)
         tabTestRF <- table(dat_test$classes, predTestRF)
         accBest <- sum(diag(tabTestRF))/sum(tabTestRF)
         
       }
       
)
best
accBest


# replicate the process a number of times
R <- 100
out <- matrix(NA, R, 4)
colnames(out) <- c("val_logistic","val_RF", "best", "test")
out <- as.data.frame(out)

for ( r in 1:R ) {
  
  # split the data
  keep <- sample(1:D, 5500)
  test <- setdiff(1:D, keep)
  dat <- satellitedata[keep,]
  dat_test <- satellitedata[test,]
  
  N<-nrow(dat)
  train<-sample(1:N,size = 0.75*N)
  val<-setdiff(1:N,train)
  dat_train<-dat[train,]
  dat_val<-dat[val,]
  
  #Fitting the model
  # multinomial logistic regression
  fitLog<-multinom(classes~.,data = dat_train)
  
  #Random Forest
  fitRF <- randomForest(classes~., data = dat_train, importance=TRUE)
  
  #Prediction
  
  # Multinomial logistic regression
  predLogR <- predict(fitLog, type = "class", newdata = dat_val)
  tabValLog <- table(dat_val$classes, predLogR)
  tabValLog
  accLog <- sum(diag(tabValLog))/sum(tabValLog)
  
  # Random Forest Prediction
  predRF<-predict(fitRF,type = "class",newdata = dat_val)
  tabValRF <- table(dat_val$classes, predRF)
  tabValRF
  accRF <- sum(diag(tabValRF))/sum(tabValRF)
  
  # print accuracy
  acc <- c(Mlogistic = accLog,RandomForest = accRF)
  out[r,1] <- accLog
  out[r,2] <- accRF
  
  
  # use the method that did best on the validation data 
  # to predict the test data
  best <- names( which.max(acc) )
  switch(best,
         Mlogistic = {
           predTestLog <- predict(fitLog, type = "class", newdata = dat_test)
           tabTestLog <- table(dat_test$classes, predTestLog)
           accBest <- sum(diag(tabTestLog))/sum(tabTestLog)
         },
         RandomForest = {
           predTestRF<-predict(fitRF,type = "class",newdata = dat_test)
           tabTestRF <- table(dat_test$classes, predTestRF)
           accBest <- sum(diag(tabTestRF))/sum(tabTestRF)
           
         }
         
  )
  out[r,3] <- best
  out[r,4] <- accBest
  
  print(r)
}

# check out the error rate summary statistics
table(out[,3])
tapply(out[,4], out[,3], summary)
boxplot(out$test ~ out$best)
stripchart(out$test ~ out$best, add = TRUE, vertical = TRUE,
           method = "jitter", pch = 19, col = adjustcolor("magenta3", 0.2))

###MAT PLOT

matplot(out[,1:2], type = "o", pch= 1, cex= 0.5, Ity= 2,
        col = c("deepskyblue3", "darkorange2"),ylab="Accuracy",
        xlab = "Number of Iterations",main="Validation Accuracy")
abline(h = c(mean(out[,1]), mean(out[,2])),
       col= c("deepskyblue3", "darkorange2"))
legend(47,0.87, fill = c("deepskyblue3", "darkorange2"),
       legend = c("Multinomial Logistic Regression","Random Forest"), bty = "n")

