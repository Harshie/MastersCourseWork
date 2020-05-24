install.packages("miceadds")
library(miceadds)


load.Rdata(filename="32ndDail_FifthSession_BinaryVotes.Rdata","votingdata")
?dist
length(votingdata[,1])
sm(votingdata[1])
install.packages("nomclust")
library(nomclust)
install.packages("ade4")
library(ade4)
?ade4
citation("ade4")

str(votingdata)



votingdata$Environment<-as.numeric(as.character(factor(votingdata$Environment,levels = c(1,2),labels = c(1,0))))
votingdata$RentFreeze<-as.numeric(as.character(factor(votingdata$RentFreeze,levels = c(1,2),labels = c(1,0))))
votingdata$SocialWelfare<-as.numeric(as.character(factor(votingdata$SocialWelfare,levels = c(1,2),labels = c(1,0))))
votingdata$GamingAndLotteries<-as.numeric(as.character(factor(votingdata$GamingAndLotteries,levels = c(1,2),labels = c(1,0))))
votingdata$HousingMinister<-as.numeric(as.character(factor(votingdata$HousingMinister,levels = c(1,2),labels = c(1,0))))
votingdata$FirstTimeBuyers<-as.numeric(as.character(factor(votingdata$FirstTimeBuyers,levels = c(1,2),labels = c(1,0))))
install.packages("ade4")
library(ade4)
dist1<-dist.binary(votingdata,method = 1)
?dist.binary
##Hierarchical clustering
votingavg<-hclust(dist1,method = "average")

plot(votingavg)

#Single
votingSingle<-hclust(dist1,method = "single")

plot(votingSingle)

#Complete
votingcomplete<-hclust(dist1,method = "complete")

plot(votingcomplete)


#Simple Matching
dist2<-dist.binary(votingdata,method = 2)

votingavg2<-hclust(dist2,method = "average")

plot(votingavg2)

#Single
votingSingle2<-hclust(dist2,method = "single")

plot(votingSingle2)

#Complete
votingcomplete2<-hclust(dist2,method = "complete")

plot(votingcomplete2)

##Cutree of simple Matching 
#k=2
votinghcl2<-cutree(votingavg2, k = 2)
table(votinghcl2)
summary(votinghcl2)

#k-3
votinghcl<-cutree(votingavg2, k = 3)
table(votinghcl)

#1b
install.packages("LCA")
library("poLCA")
install.packages("poLCA")
colnames(votingdata)
f<-cbind(Environment,RentFreeze,SocialWelfare,GamingAndLotteries,HousingMinister,FirstTimeBuyers)~1
f1<-cbind("Environment","RentFreeze","SocialWelfare","GamingAndLotteries", "HousingMinister","FirstTimeBuyers")~1

poLCA2<-poLCA(f,data = votingdata +1,nclass = 2,graphs = TRUE,na.rm = TRUE,maxiter = 1000)
poLCA3<-poLCA(f,data = votingdata +1,nclass = 3,graphs = TRUE,na.rm = TRUE,maxiter = 1000)
poLCA4<-poLCA(f,data = votingdata +1,nclass = 4,graphs = TRUE,na.rm = TRUE,maxiter = 1000)

# Since the BIC value of class =2 is lower compared with other class 3 and 4, we can see that the class 2 is optimal.


#1c
#k=2
votinghcl2<-cutree(votingavg2, k = 2)
table(votinghcl2)

library(e1071)
classAgreement(table(votinghcl2))

tab<-table(votinghcl2,poLCA2$predclass)
classAgreement(tab)

#1D
TDnames<-read.csv("TDs_names_parties.csv",header = T)

#classAgreement(table(poLCA2$predclass,TDnames[,1]))
table(poLCA2$predclass,TDnames[,1])

table(poLCA2$posterior)
poLCA2$predclass



table(poLCA2$predclass,TDnames$Party)


data("carcinoma")
rm(carcinoma)
