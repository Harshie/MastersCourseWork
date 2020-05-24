hyptisdata<-read.csv("Hyptis.csv",header = T)
x<-hyptisdata[,1:7]
D<- dist(x, method="euclidean")

#2a

#q=2
mds2<-cmdscale(D,k=2,eig = TRUE)

sum(abs(mds2$eig[1:2]))/sum(abs(mds2$eig[1:(length(mds3$eig)-1)]))
#0.7340443

#q=3
mds3<-cmdscale(D,k=3,eig = TRUE)

sum(abs(mds3$eig[1:3]))/sum(abs(mds3$eig[1:(length(mds3$eig)-1)]))
#0.8592943

#q=4
mds4<-cmdscale(D,k=4,eig = TRUE)
mds4$eig

D

sum(abs(mds4$eig[1:4]))/sum(abs(mds4$eig[1:(length(mds4$eig)-1)]))
#0.9657085

#plotting
#q=2
plot(mds2$points[,1],mds2$points[,2],type = "n",xlab = "",ylab = "",main="Classical metric")
text(mds2$points[,1],mds2$points[,2],hyptisdata[,8],cex=1,col = c("black","blue","red","green"))

#2b
library(MASS)
?sammon
sammon2<-sammon(D,k=2,niter = 100)
sammon2$stress

sammonstress<-c()
k<-10
for(i in 1:k){
  sammonstress<-c(sammonstress,sammon(D,k=i)$stress)
}
plot(x=c(1:k),y=sammonstress,type = "b", xaxp=c(1,k, k-1), ylab="Stress", xlab="Number of dimensions")

#Kruskal 

kruskalstress<-c()

for(i in 1:k){
  kruskalstress<-c(kruskalstress,isoMDS(D,k=i)$stress)
}
plot(x=c(1:k),y=kruskalstress,type = "b", xaxp=c(1,k, k-1), ylab="Stress", xlab="Number of dimensions")

kruskal2<-isoMDS(D,k=2)

#2c
install.packages("vegan")
library(vegan)

proc12<-procrustes(mds2$points,sammon2$points)
proc23<-procrustes(sammon2$points,kruskal2$points)
proc31<-procrustes(kruskal2$points,mds2$points)

plot(proc12)
plot(proc23)
plot(proc31)

plot(proc12,kind = 2)
plot(proc23,kind = 2)
plot(proc31,kind = 2)

#2d
library(mclust)
thyroid1<-data.frame(thyroid)


res1<-Mclust(x,G=1:8)
summ<-summary(res1)

res1$BIC
plot(res1,what = "BIC",legendArgs=list(x="topleft",cex=0.5,horiz=T))

plot(res1,what = "classification")

#plot(res1,what="uncertainty")

#plot(res1$uncertainty,type="h")

table(hyptisdata[,8],summ$classification)
adjustedRandIndex(hyptisdata[,8],summ$classification)

