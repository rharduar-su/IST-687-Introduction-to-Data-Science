#Lab 8

###Part 1###


#1. 
install.packages("MASS")
install.packages("ggplot2")

library(MASS)
library(ggplot2)

View(Boston)
help("Boston")
myScatter <- ggplot(Boston, aes(x=rm, y=medv)) + geom_point()
myScatter

#2.
myScatter + geom_smooth(method="lm", se=FALSE)

#3. 

crimScatter <- ggplot(Boston, aes(x=crim, y=medv)) + geom_point()
crimScatter
crimScatter + geom_smooth(method="lm", se=FALSE)

#4. 

#the x variable rm (average number of rooms per dwelling) produced a better and more straightforward scatter plot with an accurate best line of fit. The second x variable we tried crim, or crime, produced sort of a weird correlation. 

#5.
crime <-ggplot(Boston) + aes(x = crim) + geom_histogram(binwidth = 5)
crime
#some oddities would be the outliers in the histogram. The histogram is skewed to the extreme right, sort of an unbalanced histogram. 

#6. 
model1 <- lm(formula=repairs ~ oilChanges, data=oil)
lmOut <- lm(formula=medv ~ crim, data=Boston)
lmOut

###Part 2###

#7.
lmOut2 <- lm(formula=dis ~ crim + rm, data = Boston)
summary(lmOut2)

#8.
#Make sure to mention the p- value, the adjusted R-squared, the list of significant predictors and the coefficient for each significant predictor.
#There is a R-squared value of 0.1564 which means that 16% of crime accounts for the rm. The p value is also greater than 0.5 or in fact is a high value, so crime in the boston area is very likely to happen. 
#9.
predDF <- data.frame(crim = 0.26, dis=3.2, rm=6.2)

#10.
predict(lmOut, predDF)
#25.92516


