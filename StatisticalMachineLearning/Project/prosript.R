qt(0.975,441)

install.packages("sparklyr")
library(sparklyr)
ml_corr(deepsolar[,-c(1:2)])

library(corrplot)
install.packages("corrplot")
x<-deepsolar[,-c(1:2)]
corrplot(x)
x<-(x[,-(x$voting_2016_dem_win)])
cor(x)
str(x)
x$voting_2016_dem_win
which(colnames(x)=="voting_2012_dem_win")
x<-x[,-c(75)]

cor(x[1:10])
#y=table(x$average_household_income,x$per_capita_income)

cor((x$land_area+x$water_area),x$total_area) #Remove total area
cor(x$employ_rate,(x$employed/(x$employed+x$unemployed)))# Remove employee rate
cor(x$average_household_income,x$per_capita_income) #remove per capita income
#Remove "voting_2016_dem_win"  as it is dependent on "voting_2016_dem_percentage" and "voting_2016_gop_percentage" .Similarly,"voting_2012_dem_win" is dependent on "voting_2012_dem_percentage" and "voting_2012_gop_percentage". So we can remove both the win variables.
cor(x$population_density,(x$population/(x$land_area+x$water_area))) #Remove population density as it is highly correlated when dividing population by land and water variables.

which(colnames(x)=="occupation_construction_rate")
which(colnames(x)=="cooling_degree_days")

?rows
x[,c(59:70)]
rowsum(x[,c(59:70)])
rows
cor(x$occupancy_vacant_rate,(1-(x$household_count/x$housing_unit_count)))#Remove occupancy_vacant_rate
cor(x[,c(50:58)])

#We can remove all the variables related to state variable (i.e) "electricity_price_residential",electricity_price_commercial,
#electricity_price_industrial,electricity_price_transportation,electricity_price_overall,electricity_consume_residential,
#electricity_consume_commercial,electricity_consume_industrial,electricity_consume_total

#For the race related variables, 

#for loop
```{r iterations}

cl <- parallel::makeCluster(2)
doParallel::registerDoParallel(cl)

# replicate the process a number of times 
R <- 5 
out <- matrix(NA, R, 7) 
colnames(out) <- c("ClassificationTree","LogisticRegression","RandomForest","Bagging","Boosting","Supportvector", "best") 
out <- as.data.frame(out) 

#for ( r in 1:R ) {  

foreach(r =1:R) %dopar% {
  
  #We will split the training data further into training and validation data
  M<-nrow(trainingdata)
  trainnum<-sample(1:M,size = 0.75*M)
  valnum<-setdiff(1:M,trainnum)
  train<-trainingdata[trainnum,]
  validation<-trainingdata[valnum,]
  
  
  
  # classification tree
  fit1<-rpart(train$solar_system_count~.,data=train)
  pred1<-predict(fit1, type = "class",newdata = validation)
  table1<-table(validation$solar_system_count,pred1)
  table1
  accuracy1<-sum(diag(table1))/sum(table1)
  
  
  
  #Logistic Regression
  deepsolarSdval$solar_system_count<-recode(deepsolarSdval$solar_system_count,'low'=0,'high'=1)
  trainLogisticR<-train
  validationLogisticR<-validation
  
  trainLogisticR$solar_system_count<-recode(trainLogisticR$solar_system_count,'low'=0,'high'=1)
  validationLogisticR$solar_system_count<-recode(validationLogisticR$solar_system_count,'low'=0,'high'=1)
  
  fit2<-glm(trainLogisticR$solar_system_count~.,data=trainLogisticR,family = "binomial")
  summary(fit2)
  #Prediction object is created using prediction function 
  predObj<-prediction(fitted(fit2),trainLogisticR$solar_system_count)
  
  #Sensitivity and Specificity calculation for optimal threshold value 
  sens<-performance(predObj,"sens") 
  spec<-performance(predObj,"spec") 
  tau<-sens@x.values[[1]] 
  #Sum of Sensitivity and Specificity 
  sensSpec<-sens@y.values[[1]] + spec@y.values[[1]] 
  #Finding the maximum of Sum of Sensitivity and Specificity 
  best<-which.max(sensSpec) 
  
  pred2<-predict(fit2,type = "response",newdata = validationLogisticR)
  
  #Classification for optimal threshold 
  pred2<-ifelse(pred2>tau[best],1,0) 
  table2<-table(validationLogisticR$solar_system_count,pred2)
  accuracy2<-sum(diag(table2))/sum(table2)
  
  #Random Forest
  fit3<-randomForest(train$solar_system_count~.,data=train, importance=TRUE)
  pred3<-predict(fit3, type = "class",newdata = validation)
  table3<-table(validation$solar_system_count,pred3)
  accuracy3<-sum(diag(table3))/sum(table3)
  
  #Bagging
  
  fit4<-bagging(solar_system_count~.,data = train)
  pred4<-predict(fit4, type = "class",newdata = validation)
  table4<-table(validation$solar_system_count,pred4$class)
  accuracy4<-sum(diag(table4))/sum(table4)
  
  #Boosting
  fit5<-boosting(solar_system_count~.,data = train)
  pred5<-predict(fit5, type = "class",newdata = validation)
  table5<-table(validation$solar_system_count,pred5$class)
  accuracy5<-sum(diag(table5))/sum(table5)
  
  #Support Vector Machines
  fit6<-ksvm(solar_system_count~.,data = train)
  pred6<-predict(fit6, newdata = validation)
  table6<-table(validation$solar_system_count,pred6)
  accuracy6<-sum(diag(table6))/sum(table6)
  
  out[r,1] <- accuracy1  
  out[r,2] <- accuracy2 
  out[r,3] <- accuracy3  
  out[r,4] <- accuracy4 
  out[r,5] <- accuracy5  
  out[r,6] <- accuracy6
  
  #To check the iteration number
  print(r) 
}
```



#########################
```{r iterations}

cl <- parallel::makeCluster(2)
doParallel::registerDoParallel(cl)

# replicate the process a number of times 
R <- 5 
#out <- matrix(NA, R, 7) 
#colnames(out) <- c("ClassificationTree","LogisticRegression","RandomForest","Bagging","Boosting","Supportvector", "best") 

out <- matrix(NA, R, 2) 
colnames(out) <- c("ClassificationTree", "best") 
out <- as.data.frame(out) 

#for ( r in 1:R ) {  

foreach(r =1:R) %dopar% {
  library(rpart)  
  
  #We will split the training data further into training and validation data
  M<-nrow(trainingdata)
  trainnum<-sample(1:M,size = 0.75*M)
  valnum<-setdiff(1:M,trainnum)
  train<-trainingdata[trainnum,]
  validation<-trainingdata[valnum,]
  
  
  
  # classification tree
  fit1<-rpart(train$solar_system_count~.,data=train)
  pred1<-predict(fit1, type = "class",newdata = validation)
  table1<-table(validation$solar_system_count,pred1)
  table1
  accuracy1<-sum(diag(table1))/sum(table1)
  
  
  out[r,1]<-accuracy1
  
  #To check the iteration number
  print(r) 
  parallel::stopCluster(cl)
}
```