musicdata<-read.csv("data_spotify_songs.csv",header = T)
pairs(musicdata,gap = 0,pch=19,col=adjustcolor(1,0.4))

data1<-musicdata[,c(-2,-3)]
pairs(data1,gap = 0,pch=19,col=adjustcolor(1,0.4))

data2<-data1[,-1]
pairs(data2,gap = 0,pch=19,col=adjustcolor(1,0.4))
fit3<-kmeans(data2,centers = 3)
fit3
symb<-c(15,16,17,18,19,20)
col<-c("darkorange2","deepskyblue3","magenta3","burlywood","aquamarine2","chocolate4")

fit2<-kmeans(data2,centers = 2)
fit2

fit4<-kmeans(data2,centers = 4)
fit4

fit5<-kmeans(data2,centers = 5)
fit5

fit6<-kmeans(data2,centers = 6)
fit6

pairs(data2,gap=0,pch=symb[fit2$cluster],col=adjustcolor(col[fit2$cluster],0.4),main="Cluster 2")
pairs(data2,gap=0,pch=symb[fit3$cluster],col=adjustcolor(col[fit3$cluster],0.4),main="Cluster 3")
pairs(data2,gap=0,pch=symb[fit4$cluster],col=adjustcolor(col[fit4$cluster],0.4),main="Cluster 4")
pairs(data2,gap=0,pch=symb[fit5$cluster],col=adjustcolor(col[fit5$cluster],0.4),main="Cluster 5")
pairs(data2,gap=0,pch=symb[fit6$cluster],col=adjustcolor(col[fit6$cluster],0.4),main="Cluster 6")

data2

#Normalizztion
meanval<-apply(data2,2,mean)
sdval<-apply(data2,2,sd)
datanew<-scale(data2,meanval,sdval)

#Now Clustering again
fit2n<-kmeans(datanew,centers = 2)
fit2n
fit3n<-kmeans(datanew,centers = 3)
fit3n
fit4n<-kmeans(datanew,centers = 4)
fit4n

fit5n<-kmeans(datanew,centers = 5)
fit5n

fit6n<-kmeans(datanew,centers = 6)
fit6n

pairs(datanew,gap=0,pch=symb[fit2n$cluster],col=adjustcolor(col[fit2n$cluster],0.4),main="Cluster 2")
pairs(datanew,gap=0,pch=symb[fit3n$cluster],col=adjustcolor(col[fit3n$cluster],0.4),main="Cluster 3")
pairs(datanew,gap=0,pch=symb[fit4n$cluster],col=adjustcolor(col[fit4n$cluster],0.4),main="Cluster 4")
pairs(datanew,gap=0,pch=symb[fit5n$cluster],col=adjustcolor(col[fit5n$cluster],0.4),main="Cluster 5")
pairs(datanew,gap=0,pch=symb[fit6n$cluster],col=adjustcolor(col[fit6n$cluster],0.4),main="Cluster 6")

#Calculating Euclidean distance
distance1<-dist(datanew)
dist1<-dist(datanew,method = "euclidean")^2
help("dist")

#CH Index
k<-15
wss<-bss<-rep(NA,k)
for (i in 1:k) {
  fitCH<- kmeans(datanew,centers = i,nstart = 50)
  wss[i]<-fitCH$tot.withinss
  bss[i]<-fitCH$betweenss
}

#computing CH Index
N<-nrow(datanew)
ch<-(bss/(1:k-1))/(wss/(N-1:k))
ch[1]<-0

plot(1:k,ch,type = "b",ylab = "CH",xlab = "K",main="calinski index")

#silhouette
library("cluster")
sil2<- silhouette(fit2n$cluster,dist1)
sil3<- silhouette(fit3n$cluster,dist1)

fit2n
#fit2nn<-kmeans(datanew,centers = 2,nstart = 50)

plot(sil2,col=adjustcolor(col[1:2],0.3),main="SIL K=2")
plot(sil3,col=adjustcolor(col[1:3],0.3),main="SIL K=3")

#External Validation
library(e1071)

data1$genre

type<-c("rock","pop","acoustic")
tab<-table(fit2n$cluster,data1$genre)
tab
classAgreement(tab)

#k=3
tab3<-table(fit3n$cluster,data1$genre)
tab3
classAgreement(tab3)
