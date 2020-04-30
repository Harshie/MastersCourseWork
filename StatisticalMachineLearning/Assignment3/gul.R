nstall.packages("nnet",repos = "http://cran.us.r-project.org")
library(nnet)
Multinomial Logistic_fit<-multinom(classes ., data = data_training,maxit =300)
# Validation Data Prediction
Logistic_predicted <- predict(Multinomial Logistic_fit, type = "class", newdata =
                                data_validation)
# Cross Tabulation Creation
Logistic tabulation<- table(data_validationSclasses,Logistic_predicted)
# Accuracy of the prediction of validation dataset
Logistic_accuracy <- sum(diag(Logistic_tabulation))/sum(Logistic_tabulation)

# Random Forest
# installing randomForest package for multinomial logistic regression
install.packages("randomForest",repos = "http://cran.us.r-project.org")
library(randomForest) #library calling for random forest
# Random Forest model is fit on training data
fit random forest <- randomForest(classes ., data = data_training, importance TRUE)
# Validation Data prediction
random_predicted <- predict(fit_random_forest, type = "class", newdata = data_validation)
#Cross Tabulation creation
random tabulation <- table(data_validationSclasses,random_predicted)
# Accuracy of the prediction of validation data set
random_accuracy <- sum(diag(random_tabulation))/sum(random tabulation)
# Adding the accuracy output on validation dataset of both method to a list
accuracy <-c(Multinomial_logistic_Regression=Logistic_accuracy,random_forest=random_accuracy)
accuracy

###

#Finding the accuracy of the best model on the test data
bestmodel <- names( which.max(accuracy) ) #We get the name of the best model whose

switch(bestmodel,
       random forest = {
         predicted Test_ random_forest <- predict(fit_random_forest, type ="class", newdata =
                                                    dat test)
         tabulated Test random forest <- table(dat_test$classes,
                                               predicted Test random forest)
         best model accuracy <-
           sum(diag(tabulated_Test_random_forest))/sum(tabulated_Test_random_forest)
         logistic = {
           predicted_Test_Logistic <- predict(Multinomial_Logistic_fit, type ="class", newdata =
                                                dat test)
           tabulated Test Logistic <- table(dat_testSclasses, predicted Test_Logistic)
           best model accuracy <-
             sum(diag(tabulated_Test Logistic))/sum(tabulated Test_Logistic)
           bestmodel # gives the name of the best model
           best model accuracy # gives the accuracy of the best model
          
           
           
            # replicate the process a number of times
           R<-100
           out_put <- matrix(NA,R,4) #Empty matrix of size 100x4 is created
           colnames(out_put) <- c("value_logistic", "value_randomforest", "bestmodel", "test")
          
           
            # 100 iterations
           for (r in 1:R ) {
             # Data Pre-processing
             keep <- sample(1:D, 5500)
             test <- setdiff(1:D, keep)
             dat <- Satellite[keep,]
             dat test <- Satellite[test,]
            
             
              len<-nrow(dat)
             training <- sample(1:len,size = 0.75*len)
             validation <- setdiff(1:len,training)
             data_training<- Satellite[training.]
             data_validation <- Satellite[validation.]
            
              ###
             #Multinomial logistic Regression
             # Fitting multinomial logistic regression on training data
             Multinomial Logistic_fit<-multinom(classes., data = data_training,maxit =300)
             # Validation Data Prediction
             Logistic_predicted <- predict(Multinomial_Logistic_fit, type = "class", newdata =
                                             data_validation)
             # Cross Tabulation Creation
             Logistic_tabulation <- table(data_validationSclasses,Logistic_predicted)
             # Accuracy of the prediction of validation dataset
             Logistic_accuracy <- sum(diag(Logistic_tabulation))/sum(Logistic_tabulation)
             # Random Forest
             # Random Forest model is fit on training data
             fit random forest <- randomForest(classes ., data = data_training, importance = TRUE)
             # Validation Data prediction
             random predicted <- predict(fit_random_forest, type = "class", newdata = data_validation)
             #Cross Tabulation creation
             random tabulation <- table(data_validationSclasses,random_predicted)
             # Accuracy of the prediction of validation data set
             Logistic_accuracy <- sum(diag(Logistic_tabulation))/sum(Logistic_tabulation)
             # Random Forest
             # Random Forest model is fit on training data
             fit random_forest <- randomForest(classes ., data = data_training, importance TRUE)
             # Validation Data prediction
             random_predicted <- predict(fit_random_forest, type = "class", newdata = data_validation)
             #Cross Tabulation creation
             random_tabulation <- table(data_validationSclasses,random_predicted)
            
             
             
              # Accuracy of the prediction of validation data set
             random_accuracy<- sum(diag(random_tabulation))/sum(random_tabulation)
             # Adding the accuracy output on validation dataset of both method to a list
             accuracy <-
               c(Multinomial_logistic_Regression=Logistic_accuracy,random_forest-random accuracy)
             # Multinomial Logistic Regression validation accuracy is stored in first column of the
             #matrix
             out put[r,1] <-Logistic_accuracy
             # Random Forest Model validation accuracy is stored in the second column of the matrix
             out put[r,2] <-random_accuracy
             # Using the model which did best on validation data to predict the test data
             bestmodel <- names( which.max(accuracy) ) #We get the name of the best model whose
             switch(bestmodel,
                    random_forest = {
                      predicted Test random_forest <- predict(fit_random_forest, type = "class", newdata =
                                                                dat test)
                      tabulated Test_random_forest <- table(dat_testSclasses,
                                                            predicted Test random_forest)
                      best model accuracy <-
                        sum(diag(tabulated_Test_random_forest))/sum(tabulated_Test random_forest)
                    }.
                    logistic = {
                      predicted_Test Logistic <- predict(Multinomial_Logistic_fit, type = "class", newdata
                                                         = dat_test)
                      tabulated Test Logistic <- table(dat_testSclasses, predicted_Test Logistic)
                      best_model_accuracy <-
                        sum(diag(tabulated Test Logistic))/sum(tabulated Test Logistic)
                      bestmodel # gives the name of the best model
                      best_model_accuracy # gives the accuracy of the best model
                      out put[r,3] <- bestmodel # name of best model is saved in third column of the matrix
                      # best model accuracy on test data is stored in the fourth column of the matrix
                      out_put[r,4] <- best_model_accuracy
                    }
                    
                    
                    output<-data.frame(out_put) # ouput matrix is converted to data frame
                    table(outputSbestmodel) #Counting the number of times the model is selected best in 100
                    #iterations
                    outputStest <- as.numeric(as.character(outputStest)) # test accuracy output converted to
                    #numeric
                    outputSvalue_logistic <- as.numeric(as.character(outputSvalue_logistic))
                    outputSvalue_randomforest <- as.numeric(as.character(outputSvalue_randomforest))
                    tapply(output[,4], output[,3], summary) #Best model summary and it's corresponding test
                    
                    
                    ###BOX PLOT
                    
                    boxplot(outputStest-outputSbestmodel.ylab = "accuracy",
                            xlab="bestmodel",main="Test Accuracy") #box plot
                    stripchart(outputStest- outputSbestmodel, add = TRUE, vertical = TRUE,
                               method = "jitter", pch = 19, col = adjustcolor("magenta3", 0.2))
                    
                    ###MAT PLOT
                    
                    matplot(output[, 1:2], type = "o", pch 1, cex 0.5, Ity 2,
                            col = c("deepskyblue3", "magenta3"),ylab-"accuracy",
                            xlab = "No.of Iterations",main="Validation accuracy")
                    abline(h = c(mean(output[, 1]), mean(output[, 2])),
                           col c("deepskyblue3", "magenta3"))
                    legend("right", col = c("deepskyblue3", "magenta3"), pch = 1,
                           Ity = 1, legend = c("multinomial logistic regression","random_forest"), bty = "n")