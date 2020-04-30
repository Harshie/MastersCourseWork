install.packages("kernlab")
library(kernlab)
data(spam)
spam
spamdata<- data.frame(spam)
str(spamdata)

#fit<-glm(spamdata$type ~.,data = spamdata,family = "binomial")
#summary(fit)

#library(dplyr)
#spamdata$type
#spamdata$type<-recode(spamdata$type,'spam'=1,'nonspam'=0)

spamdata1<-spamdata[,49:58]

str(spamdata1)
#Converting the factors to 0's and 1's
spamdata1$type<-recode(spamdata1$type,'spam'=1,'nonspam'=0)

#Fitting the model
fit1<-glm(spamdata1$type ~.,data = spamdata1,family = "binomial")
summary(fit1)

#Confidence Intervals and log-odds
# Extracting the coefficients
w <-coef(fit1)

#computing Odds
exp(w)

#Computing 95% confidence interval of w and odds
#extracting Standard Errors
sm<-summary(fit1)
se<-sm$coef[,2]

# compute confidence limits for w
wLB <-w - 1.96 * se
wUB <-w + 1.96 * se

# store coefficients and confidence limits
ci<- cbind(lb =wLB,w =w,ub =wUB)
ci 

#confidence Intervals for odds
exp(ci)

#Estimated log-odds
lg<-predict(fit1)
phat<-predict(fit1,type="response")


#Plotting
symb<-c(19,17)
col<-c("darkorange2","deepskyblue3")
plot(lg,jitter(phat,amount = 0.1),pch=symb[spamdata1$type +1],
     col = adjustcolor(col[spamdata1$type +1],0.7),cex = 0.7,
     xlab = "Log-odds",ylab="Fitted Probabilities")
#There is a steep increase in the plot. This might be due to w value close to infinity and it becomes difficult to calculate the slope for the curve. This shows that the model is so fitted that it cannot be inferred with those variables.

?performance
?warn
#Part B
tau<-0.5
p<-fitted(fit1)
head(p)
pred<-ifelse(p>tau,1,0)

#cross tabulation between observed and predicted
table(spamdata1$type,pred)

#ROCR
install.packages("ROCR")
library(ROCR)

predObj<-prediction(fitted(fit1),spamdata1$type)

perf<-performance(predObj,"tpr","fpr")
plot(perf)
abline(0,1,col="darkorange2",lty=2)


#Computing area under the curve
auc<-performance(predObj,"auc")


#Optimal threshold tau
sens<-performance(predObj,"sens")
spec<-performance(predObj,"spec")

tau<-sens@x.values[[1]]

sensSpec<-sens@y.values[[1]] + spec@y.values[[1]]
best<-which.max(sensSpec)
plot(tau,sensSpec,type="l")
points(tau[best],sensSpec[best],pch=19,col=adjustcolor("darkorange2",0.5))


tau[best]

#Classification for optimal tau
pred<-ifelse(fitted(fit1)>tau[best],1,0)
table(spamdata1$type,pred)
