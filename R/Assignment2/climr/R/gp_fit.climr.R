#' Fit basic statistical models to climate data
#'
#' @description Fitting the model for the Gaussian Regression process and returning a list of values for plotting.
#'
#' @param obj An object of class \code{climr} from \code{\link{load_clim}}
#' @param type The type of method required, either Nelder-Mead (\code{Nelder-Mead}), Broyden-Fletcher-Goldfarb-Shanno (\code{BFGS}) , Simulated Annealing (\code{SANN}) or Brent method (\code{Brent})
#'
#' @return Returns a list of class \code{climr_gp_fit} which includes the model details as well as the data set and method type used
#' @seealso \code{\link{load_clim}}, \code{\link{plot.climr_gp_fit}}
#' @export
#' @importFrom magrittr "%$%"
#' @importFrom stats  "optim"
#' @importFrom mvtnorm "dmvnorm"
#'
#' @examples
#' data1 = load_clim('NH')
#' data2 = gp_fit(data1,type="BFGS")
#'@export

gp_fit <- function(obj, type = c('Nelder-Mead', 'BFGS', 'SANN','Brent')) {
  UseMethod('gp_fit')
}

#'@export

gp_fit.climr <- function(obj,type = c('Nelder-Mead', 'BFGS', 'SANN','Brent')){

  # Calling the regression function with required values.
    fit_arg <- match.arg(type)

  # Scaling the data before fitting the Gaussian Process Regression
    x<-scale(obj$clim_year$year)[,1]
    y<-scale(obj$clim_year$temp)[,1]
    x_g <- pretty(x, n = 100)

  #calling the regression fit with required values.
    regression<-regression_fit(x_g,x,y,fit_arg)

  # Creating a list with the regression output and dataset
    out<-list(x=obj$clim_year,regression=regression)
    class(out) <- 'climr_gp_fit'

  return(out)


}


# Define criterion to be minimized in Gaussian process regression
gp_criterion = function(p,x,y) {
    sig_sq = exp(p[1])
    rho_sq = exp(p[2])
    tau_sq = exp(p[3])
    Mu = rep(0, length(x))
    Sigma = sig_sq * exp( - rho_sq * outer(x, x, '-')^2 ) + tau_sq * diag(length(x))
    ll = dmvnorm(y, Mu, Sigma, log = TRUE)
  return(-ll)
}


# Implementing the regression_fit function
regression_fit = function(x_g, x, y,method = 'BFGS')
{

  # Find best hyper parameters
    optim_res = optim(rep(0, 3), gp_criterion, x = x, y = y, method = method)

  # Extract the results
    sig_sq = exp(optim_res$par[1])
    rho_sq = exp(optim_res$par[2])
    tau_sq = exp(optim_res$par[3])

  # Create covariance matrices
    C = sig_sq * exp( - rho_sq * outer(x_g, x, '-')^2 )
    Sigma = sig_sq * exp( - rho_sq * outer(x, x, '-')^2 ) + tau_sq * diag(length(x))

  # Create predictions
    pred_gp = C %*% solve(Sigma, y)

  # Output the list to the calling procedure
    out <- list(model = pred_gp,
              time_grid=x_g,
              fitted_type = method)


  return(out)
}







