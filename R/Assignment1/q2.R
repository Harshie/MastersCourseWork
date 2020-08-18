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

flights_2<-flights%>%
  subset(origin=="EWR" & dest =="LAX")%>%
  transform(., carrier = factor(carrier,levels=c("UA","VX","AA") ))

#------------------------------------------------
# Q2.b)
#------------------------------------------------

# Create a barplot where the bars show the number of flights from 'EWR' to 'LAX' for 
# each of the carriers.  Save the plot as 'plot_1.pdf".

# Solution

plot_1<-ggplot(flights_2, aes(x = carrier))+
  geom_bar()+
  geom_text(stat='count',aes(label=stat(count)),vjust=-1)+
  xlab('Carriers') +
  ylab('Flights Count') +
  ggtitle('Number of flights from EWR to LAX')+
  theme(plot.title = element_text(hjust = 0.5))

plot_1  
ggsave(plot_1, file = 'plot_1.pdf', width = 12, height = 8)
#------------------------------------------------
# Q2.c)
#------------------------------------------------

# Calculate the average air time for each carrier for flights from 'EWR' to 'LAX'.
# Plot the estimated densities for each of the underlying empirical distributions 
# (i.e. 1 figure with 3 continuous lines, each corresponding to a different carrier).
# Save the plot as "plot_2.pdf".

# Solution


avg_air_time<-flights_2%>%
  aggregate(air_time~carrier, data=.,FUN =  'mean' )


plot_2<-ggplot(flights_2, aes(x=air_time, color=carrier))+
  geom_density()+
  xlab('Air time of Carriers') +
  ylab('Density') +
  ggtitle('Flights from EWR to LAX')+
  theme(plot.title = element_text(hjust = 0.5))+
  scale_colour_discrete(name = "Carriers")+
geom_vline(data=avg_air_time, aes(xintercept=air_time, color=carrier)),
           linetype="dashed")

plot_2
ggsave(plot_2, file = 'plot_2.pdf', width = 12, height = 8)

#We can also mark the mean line of each density plot using the avg_air_time values of the carriers by using geom_line, say using
# + geom_vline(data=avg_air_time, aes(xintercept=air_time, color=carrier))
  
#------------------------------------------------
# Q2.d)
#------------------------------------------------

# When producing the plot for Q2.c) the following warning message appears:
# "Removed 45 rows containing non-finite values (stat_density)."

# Why did we get this warning message?  
# Answer: We are getting the warning messages as there are few air_time that are with a value NA. So, while plotting the variable, ggplot is 
#         neglecting those rows and triggering a warning message for those rows.
# 
#Warning message:
#  Removed 45 rows containing non-finite values (stat_density). 
# The warning message stated that it has neglected 45 rows which contain non-finite values.

 length(which(is.na(flights_2$air_time)))
#[1] 45
#This shows that the warning message was due to NA values in air_time variable.

# What could be done to avoid this message?
# Answer: We can either remove those rows with NA values in air_time before plotting, if removing doesn't affect the analysis of the dataset.
#         Else, we can use geom_density(na.rm = TRUE) which will neglect those rows without affecting the dataset.
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


speed<- function(dataset){
  dataset%>%
    within(.,speed<-distance%>%divide_by(air_time%>%divide_by(60)))
}

flights_2<- flights_2%>%speed

plot_3<-ggplot(flights_2,aes(as.factor(month),speed))+
  geom_boxplot()+
  xlab('Month') +
  ylab('Speed') +
  ggtitle('Speed per Month')+
  theme(plot.title = element_text(hjust = 0.5))

plot_3
ggsave(plot_3, file = 'plot_2.pdf', width = 12, height = 8)



#------------------------------------------------
# Q2.f)
#------------------------------------------------

# Create multiple scatterplots to visually explore how delay at departure affects 
# delay at arrival by carriers ('EWR' to 'LAX' only).
# The scatterplots share the same y-axis but have different x-axes and different points 
# colours.
# Save the plot as "plot_4.pdf".

# Solution

plot_4<-ggplot(flights_2, aes(x = dep_delay, y = arr_delay, colour = carrier)) +
  geom_point(na.rm = TRUE)+
  scale_color_discrete("Carriers")+
  facet_wrap(~carrier,scales = 'free_x')+
  xlab('Departure Delay') +
  ylab('Arrival Delay') +
  ggtitle('Affect of Departure Delay on Arrival Delay by carriers from EWR to LAX')+
  theme(plot.title = element_text(hjust = 0.5))

plot_4
ggsave(plot_4, file = 'plot_4.pdf', width = 12, height = 8)

#Here, I have added na.rm = TRUE in geom_point() to neglect the rows with NA values which 
#avoids triggering of warning message as we came across in part 2d.
# End -------------------------------------------