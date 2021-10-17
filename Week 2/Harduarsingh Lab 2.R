#1
myIris <- iris
#2
help("iris")
#3
summary(myIris)
#4
myIris$Sepal.Length

#5
sort(myIris$Sepal.Length)
#6
order(myIris$Sepal.Length)
#7 sort organizes the values from lowest to highest and order returns the indices of the vector in a sorted order.
#8
sortedDF <- myIris[order(-myIris$Sepal.Length),]
sortedDF
#9
View(sortedDF)



###END OF BREAKOUT 1###

#10
help("scale")

#11
scale(myIris$Sepal.Length, center=0, scale=T)
#calculates the mean and standard deviation of the entire vector. 

#12
myIris$scaledSL <- scale(myIris$Sepal.Length, center=0, scale=T)

#13
myIris$scaledSW <- scale(myIris$Sepal.Width, center=0, scale=T)
myIris$scaledPL <- scale(myIris$Petal.Length, center=0, scale=T)
myIris$scaledPW <- scale(myIris$Petal.Width, center=0, scale=T)

#14
myIris$scaledSum <- myIris$scaledSL +
  myIris$scaledSW +
  myIris$scaledPL +
  myIris$scaledPW

#15
sortedDF <- myIris[order(-myIris$scaledSum),]
sortedDF
View(sortedDF)

###END OF BREAKOUT 2###







