#Lab 10


###Part 1###
install.packages("caret")
install.packages("kernlab")
library(caret)
library(kernlab)

data("GermanCredit")
subCredit <- GermanCredit[,1:10] 
str(subCredit)

#1. 
help("GermanCredit")
#1000 people are being observed for credit data that determines credit worthiness ('good' or 'bad') based on account status, duration, credit history, amount of loan, savings accounts, employment, and more.

#2. 
trainList <- createDataPartition(y=subCredit$Class,p=.40,list=FALSE)
#generatung a list of cases to include in the training data

#3. 
View(trainList)
str(trainList)
#a list or matrix of 400 indecies of row position integers correspdoning to the training data.

#4.

#It is a randomly chosen index by partition.Class.

#5.

trainSet <- subCredit[trainList,]
dim(trainSet)

#6.
testSet <- subCredit[-trainList,]
testSet


###Part 2###

#7.

durationBox <- ggplot(trainSet, aes(x=Class, y=Duration)) + geom_boxplot()
durationBox

#boxplot for Duration variable

amountBox <- ggplot(trainSet, aes(x=Class, y=Amount)) + geom_boxplot()

#boxplot for Amount variable

#8. Training SVM

svmModel <-ksvm(Class ~ ., data=trainSet, C=5, cross=3)
svmModel

#9. examining ksvm output object

#There is a cross valiadation error of 30% and so this a good model because it is a high rate.

#10.Predicitng the trianing cases
predOut <- predict(svmModel, newdata=testSet, type = "response")
predOut <- predict(svmModel, newdata=testSet)

table(predOut, testSet$Class)

#11. Examining predict object
str(predOut)

#12. Calculating the accuracy of the model

sum(diag(table(predOut, testSet$Class)))/sum(table(predOut, testSet$Class))

#13. Checking calcuation
confusionMatrix(predOut, testSet$Class)

