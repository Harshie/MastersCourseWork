# Extract the results
sig_sq = exp(optim_res$par[1])
rho_sq = exp(optim_res$par[2])
tau_sq = exp(optim_res$par[3])

# Create covariance matrices
C = sig_sq * exp( - rho_sq * outer(x, x, '-')^2 )
Sigma = sig_sq * exp( - rho_sq * outer(x, x, '-')^2 ) + tau_sq * diag(length(x))

# Create predictions
pred_gp = C %*% solve(Sigma, y)

####################
#abc1 <- function(obj,type = c('Nelder-Mead', 'BFGS', 'SANN','Brent')){

  # Calling the regression function with required values.

  data2<-data1
  type<-'BFGS'
  #methodtype<-type



  x<-scale(data2$clim_year$year)[,1]
  y<-scale(data2$clim_year$temp)[,1]
  x_g <- pretty(x, n = 100)

  #calling the function
  regression<-regression_fit(x_g,x,y,4,type)
  print(regression)
  #return(regression)


  # Extract the results
  sig_sq = exp(regression$par[1])
  rho_sq = exp(regression$par[2])
  tau_sq = exp(regression$par[3])


  time_grid = pretty(x, n = 100)

  # Create covariance matrices
  C = sig_sq * exp( - rho_sq * outer(time_grid, x, '-')^2 )
  Sigma = sig_sq * exp( - rho_sq * outer(x, x, '-')^2 ) + tau_sq * diag(length(x))

  # Create predictions
  pred_gp = C %*% solve(Sigma, y)

  plot(time_grid,pred_gp)

  # get center and scaling values
  m1 <- mean(data1$clim_year$year)
  s1 <- sd(data1$clim_year$year)

  # get center and scaling values
  m2 <- mean(data1$clim_year$temp)
  s2 <- sd(data1$clim_year$temp)

  valval1<-((val* s1) + m1)
  time_grid1<-(time_grid*s1)+m1
  pred_gp1<-(pred_gp*s2)+m2

  plot(data2$clim_year$year,data2$clim_year$temp,xlab = "Girth",ylab = "Height",main = "Height vs Girth")
  lines(time_grid1,pred_gp1,col = 'darkorange2', lty = 'dotted', lwd=2)


    #plot(time_grid1,pred_gp1)


#}
# Define criterion to be minimised in Gaussian process regression
gp_criterion = function(p,x,y) {
  sig_sq = exp(p[1])
  rho_sq = exp(p[2])
  tau_sq = exp(p[3])
  Mu = rep(0, length(x))
  Sigma = sig_sq * exp( - rho_sq * outer(x, x, '-')^2 ) + tau_sq * diag(length(x))
  ll = dmvnorm(y, Mu, Sigma, log = TRUE)
  return(-ll)
}


regression_fit = function(x_g, x, y, p = 1, method = 'BFGS')
{
  # Create design matrices
  x_rep = matrix(rep(x, p+1), ncol = (p+1), nrow = length(x))
  X = sweep(x_rep, 2, 0:p, '^')
  X_g_rep = matrix(rep(x_g, p+1), ncol = (p+1), nrow = length(x_g))
  X_g = sweep(X_g_rep, 2, 0:p, '^')


  # Find best hyperparameters
  optim_res = optim(rep(0, 3), gp_criterion, x = x, y = y, method = method)






  return(optim_res)
}




temp2<-abc1(data1,'BFGS')
#############


# Extract the results
sig_sq = exp(temp2$par[1])
rho_sq = exp(temp2$par[2])
tau_sq = exp(temp2$par[3])


time_grid = pretty(data1$clim_year$year, n = 100)

# Create covariance matrices
C = sig_sq * exp( - rho_sq * outer(time_grid, data1$clim_year$year, '-')^2 )
Sigma = sig_sq * exp( - rho_sq * outer(data1$clim_year$year, data1$clim_year$year, '-')^2 ) + tau_sq * diag(length(data1$clim_year$year))

# Create predictions
pred_gp = C %*% solve(Sigma, data1$clim_year$temp)

fits <- tibble(time_grid, pred = pred_gp)


ggplot(data1$clim_year, aes(year, temp)) +
  geom_point(aes(colour = temp)) +
  theme_bw() +
  xlab('Year') +
  ylab('Temperature anomaly') +
  geom_line(data = fits, aes(x = time_grid, y = pred, colour = pred)) +
  theme(legend.position = 'None') +
  scale_color_viridis()

plot(data1$clim_year$year,data1$clim_year$temp,xlab = "Girth",ylab = "Height",main = "Height vs Girth")
lines(data1$clim_year$year,pred_gp,col = 'darkorange2', lty = 'dotted', lwd=2)

