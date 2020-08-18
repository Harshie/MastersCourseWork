#' Plot statistical model output to the climate data
#'
#' @description Plot climr_gp_fit output for the Gaussian Regression process
#'
#' @param x Output from the \code{\link{gp_fit}} function
#' @param ... Other arguments to plot (not currently implemented)
#'
#' @return Displaying the Gaussian process regression plot of the NASA dataset for the years running from 1880-2020.
#'
#' @seealso \code{\link{load_clim}}, \code{\link{fit}}, \code{\link{gp_fit}}
#'
#' @export
#' @import ggplot2
#' @importFrom stats "sd"
#' @importFrom tibble "tibble"
#' @importFrom viridis "scale_color_viridis"
#'
#' @examples
#' data1 = load_clim('NH')
#' data2 = gp_fit(data1,type="BFGS")
#' plot(data2)
#'


plot.climr_gp_fit<-function(x,...){

    # Unscaling the x and y values for plotting the results back on the natural scale.

    # Calculating center and scaling values for year variable
      mean1 <- mean(x$x$year)
      sd1 <- sd(x$x$year)

    # Calculating center and scaling values for temperature variable
      mean2 <- mean(x$x$temp)
      sd2 <- sd(x$x$temp)

    # Unscaling the time grid and predicted value based on the caluclated mean and standard deviation values.
      time_grid1<-(x$regression$time_grid*sd1)+mean1
      pred_gp1<-(x$regression$model*sd2)+mean2

    # Creating a tibble for plotting these calculated values
      fits<-tibble(time_grid1,pred_gp1)

    # Finally creating a ggplot with the values calculated above
      ggplot(x$x, aes(x$x$year, x$x$temp)) +
        geom_point(aes(colour = x$x$temp)) +
        theme_bw() +
        xlab('Year') +
        ylab('Temperature anomaly') +
        geom_line(data = fits, aes(x = time_grid1, y = pred_gp1, colour = pred_gp1)) +
        theme(legend.position = 'None') +
        scale_color_viridis()

}
