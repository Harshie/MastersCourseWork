

# Question 1

# For this question, load in the trees data set from the datasets package.
library(datasets)
head(trees)
treesdata<-data.frame(trees)
# This question is based on the materials of Weeks 1 & 2.  You should prepare your
# solution using only functions that have been introduced in these weeks.
# See the Assignment 1 document on Brightspace for details of the Question.

library(mvtnorm)

regression_fit<-function(x_g,x,y,p=1,method='BFGS'){
 
   X<-cbind(x)
   if(p>1){
      for(i in 2:p){
          X <- cbind(X, x^i)
      }
   }
   
   mod1 <- lsfit(X, y, intercept = FALSE)
   predPoly<-X%*%mod1$coefficients
   
   #Gaussian Process version
   answer_BFGS <- optim(c(0,0,0),x=x,y=y, fn=gp_criterion, method=method)
  
   # Let's compare fit!
   sig_sq <- exp(answer_BFGS$par[1])
   rho_sq <- exp(answer_BFGS$par[2])
   tau_sq <- exp(answer_BFGS$par[3])
   
   # Create covariance matrices
   C <- sig_sq * exp( - rho_sq * outer(x, x, '-')^2 )
   Sigma <- sig_sq * exp( - rho_sq * outer(x, x, '-')^2 ) + tau_sq * diag(length(x))
   
   # Now create predictions
   predGaussian <- C %*% solve(Sigma, y)
   
   return(list(predpoly=predPoly,predGaussian=predGaussian))
}




regression<-regression_fit(x_g,x,y,4)

pdf(file = 'regression.pdf')
plot(x,y,xlab = "Girth",ylab = "Height",main = "Height vs Girth")
lines(x, regression$predpoly, col = 'green', lty = 'dotted', lwd=4)
lines(x, regression$predGaussian, col = 'red', lty = 'dotted', lwd=4)
legend("bottomright", legend=c("Polynomial Regression", "Gaussian Process Regression"),
       cex=0.8,fill=c("green","red"),
       box.lty=2, box.lwd=2, box.col="blue")

dev.off()



# Define criterion to be minimised in Gaussian process regression
gp_criterion1 = function(p,x,y) {
  #cat(p[1],p[2],p[3])
  sig_sq = exp(p[1])
  rho_sq = exp(p[2])
  tau_sq = exp(p[3])
  #cat(sig_sq,rho_sq,tau_sq)
  Mu = rep(0, length(x))
  #print(length(x))
  #print("here")
  #print(outer(x, x, '-')^2 )
  #print("THere")
  #print(- rho_sq)
  #print(exp( - rho_sq * outer(x, x, '-')^2 ))
  #print("sigstart")
  #print(sig_sq)
  #print("sigends")
  #print("tau_sqstart")
  #print(tau_sq)
  #print("tau_sqend")
  #print(diag(length(x)))
  print("sig_sq")
  print(sig_sq)
  print("exp( - rho_sq * outer(x, x, '-')^2 )")
  print(exp( - rho_sq * outer(x, x, '-')^2 ))
  Sigma = sig_sq * exp( - rho_sq * outer(x, x, '-')^2 ) + tau_sq * diag(length(x))
  ll = dmvnorm(y, Mu, Sigma, log = TRUE)
  return(-ll)
}
answer_BFGS <- optim(c(0,0,0),x=x,y=y, fn=gp_criterion, method='BFGS')
answer_BFGS <- optim(c(0,0,0),fn= GP_ll2, method = 'BFGS')
?optim
# Implement your regression_fit function here.

gp_criterion = function(p,x,y) {
  sig_sq = exp(p[1])
  rho_sq = exp(p[2])
  tau_sq = exp(p[3])
  Mu = rep(0, length(x))
  Sigma = sig_sq * exp( - rho_sq * outer(x, x, '-')^2 ) + tau_sq * diag(length(x))
  ll = dmvnorm(y, Mu, Sigma, log = TRUE)
  return(-ll)
}

x<-scale(treesdata$Girth)[,1]
#Response variable
y<-scale(treesdata$Height)[,1]
#predictor variable
x_g <- pretty(x, n = 100)

p<-4
X<-cbind(x)
for(i in 2:p){
  X <- cbind(X, x^i)
}

mod1 <- lsfit(X, y, intercept = FALSE)
plot(x,y)
lines(x, outerpredpoly, col = 'green', lty = 'dotted', lwd=4)
outerpredpoly<-x_g%*%mod1$coefficients
#----

#a<-c(0,0,0)  
v<-c(0,0,0) 
par1<-c(v,X,y)
answer_BFGS <- optim(c(0,0,0), gp_criterion, method = 'BFGS')
# Let's compare fit!
sig_sq <- exp(answer_BFGS$par[1])
rho_sq <- exp(answer_BFGS$par[2])
tau_sq <- exp(answer_BFGS$par[3])

# Create covariance matrices
C <- sig_sq * exp( - rho_sq * outer(x, x, '-')^2 )
Sigma <- sig_sq * exp( - rho_sq * outer(x, x, '-')^2 ) + tau_sq * diag(length(x))

# Now create predictions
pred <- C %*% solve(Sigma, y)
lines(x, pred, col = 'green') 


# Create your plot here.
