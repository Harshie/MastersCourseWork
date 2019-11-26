green = c(1:6,1:6,1:6,1:6,1:6,1:6)
red = sort(green,decreasing = FALSE)
dice = data.frame(red,green)
dice$sum = dice$red + dice$green

counts= table(dice$sum)
counts = data.frame(counts)

counts$prob = counts$Freq / 36

Part A
0.13888889

0.02777778 + 0.08333333 +0.13888889+0.13888889+0.08333333+0.02777778
0.5

sample50 = sample(dice$sum,50,replace = TRUE)
prob50_table = table(sample50)
prob50=data.frame(prob50_table)
prob50$relfreq=prob50$Freq/50

Part2
0.14

0.02 + 0.14 + 0.14 + 0.04 + 0.02
0.36

sample500 = sample(dice$sum, 500,replace=TRUE)
prob500_table=table(sample500)
prob500 = data.frame(prob500_table)
prob500$relfreq = prob500$Freq/500

Part 3
0.162

0.162/0.14/0.13888889
