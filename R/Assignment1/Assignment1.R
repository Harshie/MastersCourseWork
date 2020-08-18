### STAT40830 Assignment 1 ###

# Clean up the current environment
rm(list=ls())

# Make results reproducible
set.seed(12345)

#------------------------------------------------

# Question 1

# For this question, load in the trees data set from the datasets package.
library(datasets)
head(trees)

# This question is based on the materials of Weeks 1 & 2.  You should prepare your
# solution using only functions that have been introduced in these weeks.
# See the Assignment 1 document on Brightspace for details of the Question.

library(mvtnorm)

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

# Implement your regression_fit function here.


# Create your plot here.


#------------------------------------------------

# Question 2

# We will be using data from the nycflights13 package.
library(nycflights13)
head(flights)

library(magrittr)
library(ggplot2)

#------------------------------------------------
# Q2.a)
#------------------------------------------------

# Create a new dataset 'flights_2' that contains only the flights from 'EWR' to 'LAX'.
# Recast the 'carrier' variable as a factor, with levels in the following order:
# 'UA', 'VX', 'AA'.

# Solution 


#------------------------------------------------
# Q2.b)
#------------------------------------------------

# Create a barplot where the bars show the number of flights from 'EWR' to 'LAX' for 
# each of the carriers.  Save the plot as 'plot_1.pdf".

# Solution


#------------------------------------------------
# Q2.c)
#------------------------------------------------

# Calculate the average air time for each carrier for flights from 'EWR' to 'LAX'.
# Plot the estimated densities for each of the underlying empirical distributions 
# (i.e. 1 figure with 3 continuous lines, each corresponding to a different carrier).
# Save the plot as "plot_2.pdf".

# Solution


#------------------------------------------------
# Q2.d)
#------------------------------------------------

# When producing the plot for Q2.c) the following warning message appears:
# "Removed 45 rows containing non-finite values (stat_density)."

# Why did we get this warning message?  
# Answer:
# 

# What could be done to avoid this message?
# Answer:
# 

#------------------------------------------------
# Q2.e)
#------------------------------------------------

# Using the magrittr format, define a function called 'speed' that takes a flights 
# data.frame and adds a new column with value equal to the average speed in miles 
# per hour.
# Plot bloxplots for the speed by month, for all flights from 'EWR' to 'LAX'.
# Save the plot as "plot_3.pdf".

# Solution


#------------------------------------------------
# Q2.f)
#------------------------------------------------

# Create multiple scatterplots to visually explore how delay at departure affects 
# delay at arrival by carriers ('EWR' to 'LAX' only).
# The scatterplots share the same y-axis but have different x-axes and different points 
# colours.
# Save the plot as "plot_4.pdf".

# Solution


# End -------------------------------------------