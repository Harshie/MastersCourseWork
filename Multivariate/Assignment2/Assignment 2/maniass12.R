### 2 A

plants<- read.csv("Hyptis.csv")

#metric classical scaling for q=4
loc<- cmdscale(dist(plants[,-8]), k=4, eig=T)

#proportion  of  variation  accounted  for  by  each  value  of q=2,3,4,5,6,7,8
var <- rep(0,7)

for(i in 2:8){
  var[i-1] <- sum(abs(loc$eig[1:i]))/sum(abs(loc$eig))}

#plot of the variance explained by dimensions
plot(2:8,var,main="Varinace Explained",xlab="Dimension",ylab="Proportion",type="b",lwd=2, pch=19)

#plot of the two dimensional configuration resulting from the application of classical metric scaling
ggplot(aes(x = loc$points[,1] , y = loc$points[,2],label=Location, color = Location), data = plants) + 
  geom_text(show.legend = FALSE, fontface="bold" ) +
  labs(title="Classical Metric Scaling", x="Coordinate 1",y="Coordinate 2")+
  theme(plot.title = element_text(hjust = 0.5,face="bold"))

### 2 B

#checking for optimal q for Sammon and Kruskal
sam_stress <- rep(0,7)
kru_stress <- rep(0,7)

for(i in 2:8){
  sam_loc<- sammon(dist(plants[,-8]), k=i) 
  kry_loc<- isoMDS(dist(plants[,-8]), k=i)
  sam_stress[i-1] <- sam_loc$stress
  kru_stress[i-1] <- kry_loc$stress}

#plot of Sammon and Kruskal stress 
par(mfrow=c(1,2))
plot(2:8,sam_stress,main="Sammon Stress",xlab="Dimension",ylab="Stress",type="b",lwd=2, pch=19)
plot(2:8,kru_stress,main="Kruskal Stress",xlab="Dimension",ylab="Stress",type="b",lwd=2,pch=19)
#Sammon with desired q=4
loc2 <- sammon(dist(plants[,-8]),k=4)

#Kruskal with desired q=4
loc3 <- isoMDS(dist(plants[,-8]),k=4)

#overlaying the resulting two dimensional configurations on the classical scaling configuration plot
ggplot() + 
  geom_text(aes(x = loc$points[,1] , y = loc$points[,2],label=row.names(plants), color = Location), data = plants, fontface= "bold") +
  geom_text(aes(x = loc2$points[,1] , y = loc2$points[,2],label=row.names(plants), color = Location), data = plants, fontface= "bold") +
  geom_text(aes(x = loc3$points[,1] , y = loc3$points[,2],label=row.names(plants), color = Location), data = plants, fontface= "bold" ) +
  labs(title="Classical, Sammon & Kruskal MDS", x="Coordinate 1",y="Coordinate 2")+
  theme(plot.title = element_text(hjust = 0.5,face="bold"))

#### 2 C

#checking configuration matching
proc12 <- procrustes(loc$points,loc2$points)
proc23 <- procrustes(loc2$points,loc3$points)
proc31 <- procrustes(loc3$points,loc$points)

par(mfrow=c(2,3),oma=c(0,0,3,0))

#matching configurations
plot(proc12,main="Classical vs Sammon")
plot(proc23,main="Sammon vs Kruskal")
plot(proc31,main="Kruskal vs Classical")

#matching configurations residuals
plot(proc12,kind=2,main="Classical vs Sammon")
plot(proc23,kind=2,main="Sammon vs Kruskal")
plot(proc31,kind=2,main="Kruskal vs Classical")


##### 2 D

#fit a range of models with G= 1 to G= 8
res = Mclust(plants[,-8], G=1:8, prior=priorControl())
summ = summary(res)
summ

#plot the BIC values
res$BIC
plot(res, what="BIC", legendArgs = list(x="bottomleft", cex=0.8))

#cross-tabulation and adjusted rand index
table(plants[,8], summ$classification)
adjustedRandIndex(plants[,8], summ$classification)