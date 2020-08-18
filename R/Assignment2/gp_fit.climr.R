#' Fit basic statistical models to climate data
#'
#' @param obj An object of class \code{climr} from \code{\link{load_clim}}
#' @param fit_type The type of model required, either linear regression (\code{lm}), loess, or smoothing spline (\code{smooth.spline})
#'
#' @return Returns a list of class \code{climr_fit} which includes the model details as well as the data set and fit type used
#' @seealso \code{\link{load_clim}}, \code{\link{plot.climr_fit}}
#' @export
#' @importFrom magrittr "%$%"
#' @importFrom stats "lm" "loess" "smooth.spline" "optim"
#' @importFrom mvtnorm "dmvnorm"
#'
#' @examples
#' ans1 = load_clim('SH')
#' ans2 = fit(ans1, 'lm')
#'@export
gp_fit <- function(obj, type = c('Nelder-Mead', 'BFGS', 'SANN','Brent')) {
  UseMethod('gp_fit')
}
#'@export

gp_fit <- function(obj,type = c('Nelder-Mead', 'BFGS', 'SANN','Brent')){

  # Calling the regression function with required values.

  #data2<-obj
  #methodtype<-'BFGS'
  #methodtype<-type



  x<-scale(obj$clim_year$year)[,1]
  y<-scale(obj$clim_year$temp)[,1]
  x_g <- pretty(x, n = 100)

  #calling the function
  regression<-regression_fit(x_g,x,y,4,type)

  return(regression)

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

    # Calculate predicted values
    #pred_lm  = X_g %*% solve(t(X)%*%X, t(X)%*%y)

    # Find best hyperparameters
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

    # Output so it can be plotted
    out <- list(model = pred_gp,
                time_grid=x_g,
                data = obj$clim_year,
                fit_type = type)
    class(out) <- 'climr_gp_fit'

    #invisible(out)
    return(out)
  }

}

