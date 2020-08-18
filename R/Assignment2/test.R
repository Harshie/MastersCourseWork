install.packages("stats")

# get center and scaling values
m <- apply(data4$data, 2, mean)
s <- apply(data4$data, 2, sd)



val<-data4$model
val2<- unscale(val)
valval<-t((t(val) * s[1]) + m[1])


plot(data4$data$year,data4$data$temp,xlab = "Girth",ylab = "Height",main = "Height vs Girth")
lines(valval, x_g,col = 'darkorange2', lty = 'dotted', lwd=2)


m1 <- mean(data1$clim_year$year)
s1 <- sd(data1$clim_year$year)



val<-data5$model
val2<- unscale(val)
valval1<-((val* s1) + m1)
xg1<-(x_g*s1)+m1

plot(data5$data$year,data5$data$temp,xlab = "Girth",ylab = "Height",main = "Height vs Girth")
lines(xg1,valval1,col = 'darkorange2', lty = 'dotted', lwd=2)

x_g2<-pretty(data5$data$temp,n=100)

plot(x_g2,valval1)


fits<-tibble(x_g,val)

ggplot(data5$data, aes(year, temp)) +
  geom_point(aes(colour = temp)) +
  theme_bw() +
  xlab('Year') +
  ylab('Temperature anomaly') +
  geom_line(data = fits, aes(x = x_g, y = val[,1], colour = pred)) +
  theme(legend.position = 'None') +
  scale_color_viridis()
