library(foreach)
library(doParallel)
cl <- parallel::makeCluster(7)
doParallel::registerDoParallel(cl)

R<-4
xx<-matrix(NA, R, 4) 
colnames(xx)<-c("A","B","C","D")
{

xx<-foreach(r =1:R,.combine = rbind) %dopar% {
  
  xx1<-0.89
  xx2<-0.79
  xx3<-0.69
  xx4<-0.59
  xx5<-c(r,0.11+r,0.23+r,0.45+r,0.49+r)
}
parallel::stopCluster(cl)
}
