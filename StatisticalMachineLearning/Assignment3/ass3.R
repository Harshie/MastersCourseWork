install.packages("mlbench")
library(mlbench)
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


# load the packages for classification trees and 
# multinomial logistic regression
library(rpart)
library(nnet)


#Fitting the classifier to the training data using Classification tree and Multinomial Logistic Regression
# classification tree
fitClasstree<-rpart(satellitedata$classes ~ .,data=satellitedata,subset = keep)

# multinomial logistic regression
fitLog<-multinom(satellitedata$classes~.,data = satellitedata,subset = keep)

# classifying the validation using 'dat' observations
#
# classification tree
predClasstree <- predict(fitClasstree, type = "class", newdata = dat)
tabValCt <- table(dat$classes, predClasstree)
tabValCt
accCt <- sum(diag(tabValCt))/sum(tabValCt)

# logistic regression
predLogR <- predict(fitLog, type = "class", newdata = dat)
tabValLog <- table(dat$classes, predLogR)
tabValLog
accLog <- sum(diag(tabValLog))/sum(tabValLog)

# print accuracy
acc <- c(class_tree = accCt, logistic = accLog)
acc


# use the method that did best on the validation data 
# to predict the test data
best <- names( which.max(acc) )
switch(best,
       class_tree = {
         predTestCt <- predict(fitClasstree, type = "class", newdata = dat_test)
         tabTestCt <- table(dat_test$classes, predTestCt)
         accBest <- sum(diag(tabTestCt))/sum(tabTestCt)
       },
       logistic = {
         predTestLog <- predict(fitLog, type = "class", newdata = dat_test)
         tabTestLog <- table(dat_test$classes, predTestLog)
         accBest <- sum(diag(tabTestLog))/sum(tabTestLog)
       }
)
best
accBest


# replicate the process a number of times
R <- 100
out <- matrix(NA, R, 4)
colnames(out) <- c("val_class_tree", "val_logistic", "best", "test")
out <- as.data.frame(out)

for ( r in 1:R ) {
  
  # split the data
  keep <- sample(1:D, 5500)
  test <- setdiff(1:D, keep)
  dat <- satellitedata[keep,]
  dat_test <- satellitedata[test,]
  
  
  #Fitting the classifier to the training data using Classification tree and Multinomial Logistic Regression
  # classification tree
  fitClasstree<-rpart(satellitedata$classes ~ .,data=satellitedata,subset = keep)
  
  # multinomial logistic regression
  fitLog<-multinom(satellitedata$classes~.,data = satellitedata,subset = keep)
  
  # classifying the validation using 'dat' observations
  #
  # classification tree
  predClasstree <- predict(fitClasstree, type = "class", newdata = dat)
  tabValCt <- table(dat$classes, predClasstree)
  tabValCt
  accCt <- sum(diag(tabValCt))/sum(tabValCt)
  
  # logistic regression
  predLogR <- predict(fitLog, type = "class", newdata = dat)
  tabValLog <- table(dat$classes, predLogR)
  tabValLog
  accLog <- sum(diag(tabValLog))/sum(tabValLog)
  
  # accuracy
  acc <- c(class_tree = accCt, logistic = accLog)
  out[r,1] <- accCt
  out[r,2] <- accLog
  
  
  # use the method that did best on the validation data 
  # to predict the test data
  best <- names( which.max(acc) )
  switch(best,
         class_tree = {
           predTestCt <- predict(fitClasstree, type = "class", newdata = dat_test)
           tabTestCt <- table(dat_test$classes, predTestCt)
           accBest <- sum(diag(tabTestCt))/sum(tabTestCt)
         },
         logistic = {
           predTestLog <- predict(fitLog, type = "class", newdata = dat_test)
           tabTestLog <- table(dat_test$classes, predTestLog)
           accBest <- sum(diag(tabTestLog))/sum(tabTestLog)
         }
  )
  out[r,3] <- best
  out[r,4] <- accBest
  
  print(r)
}

install.packages("adabag")

library(foreach)
library(doParallel)
install.packages("doParallel")

#setup parallel backend to use many processors
cl <- parallel::makeCluster(2)
doParallel::registerDoParallel(cl)
[22:34, 27/04/2020] Mani: foreach(r =1:R) %dopar% {
  [22:34, 27/04/2020] Mani: }
parallel::stopCluster(cl)