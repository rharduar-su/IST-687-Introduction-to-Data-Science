##Intro to data science, Standard Homework Heading
#
# Student name: Rayanna Harduarsingh
# Homework number: 10
# Date due: November 1st, 2020
#
# Attribution statement: (choose only one)
# 1. I did this homework by myself, with help from the book and the professor

# Run these three functions to get a clean test of homework code
dev.off() # Clear the graph window
cat('\014')  # Clear the console
rm(list=ls()) # Clear user objects from the environment

###Part 1: Load and condition the data###

#A. The diamonds data set is in the ggplot2 package, so make sure you library( ) that package. While you’re at it, you will also need to install( ) and library( ) kernlab.

install.packages('ggplot2')
install.packages('kernlab')
install.packages("caret")
install.packages("e1071")
library(ggplot2)
library(kernlab)
library(caret)
library(e1071)

data("diamonds")

#B. There are five cuts of diamonds: Fair, Good, Very Good, Premium, and Ideal. To simplify our classification task we will focus only on Premium and Ideal. So, create a new dataframe with just Premium and Ideal cuts. Use that dataframe for subsequent work.

bestDiamonds <- data.frame(diamonds[diamonds$cut == "Premium" | diamonds$cut == "Ideal", ])
View(bestDiamonds)
#creating a new dataframe of diamonds that filters only Premium and Ideal cut diamonds. 

#C. Update the dataframe’s cut attribute to be a factor with just two choices (Premuim and Ideal).

bestDiamonds <- data.frame(diamonds[diamonds$cut == "Premium" | diamonds$cut == "Ideal", ])

#D. The clarity and color variables in the data frame are “ordered factors.” That means that for some analytical purposes (like this one) you can convert the factor level directly into a number and it will make sense. Use as.numeric( ) to accomplish that.

bestDiamonds$clarity <- as.numeric(bestDiamonds$clarity)
#converting clarity values into numeric value
bestDiamonds$color <- as.numeric(bestDiamonds$color)
#converting color values into numeric value and using unlist because it is an atomic vector

#E. Write a block comment describing the meaning of each variable in the data frame.
help("diamonds")
#There are 10 variables in the diamonds data frame. 
#Price is the price of the diamond in US dollars (lowest $326 and highest $18,823).
#Carat is the weight of the diamonds ranging from 0.2-5.01.
#Cut is the quality of the cut with 5 rankings of Fair, Good, Very Good, Premium, and Ideal.
#Color is the colour of the diamond from D(best) to J(worst).
#Clarity is a measurement of how clear the diamond is (I1 (worst), SI2, SI1, VS2, VS1, VVS2, VVS1, IF (best)).
#X is the length of the diamond in mm ranging from 0-10.74
#Y is the width of the diamond in mm ranging from 0.58.9
#Z is the depth of the diamond in mm ranging from 0-31.8
#Depth is the total depth percentage of the diamond- z / mean(x, y) = 2 * z / (x + y) (43–79)
#Table is the width of top of diamond relative to the widest point.


###Part 2: Create training and test data sets###

#F. Using techniques discussed in class, create two datasets – one for training and one for testing.


nrows <- nrow(bestDiamonds)
nrows
#checking the number of rows in the data frame and storing into a variable to be used for training and testing dataset. 

cutPoint <- floor(nrows/3*2)
cutPoint
#diving the data set into 2/3

randIndex <- sample(1:nrows)
head(randIndex)
#creating a randomized set of indicies by sampling

trainD <- bestDiamonds[randIndex[1:cutPoint],]
#training dataset
str(trainD)
testD <- bestDiamonds[randIndex[(cutPoint+1):nrows],]
#testing dataset
str(testD)


#G. Use the dim( ) function to demonstrate that the resulting training data set and test data set contain the appropriate number of cases.

dim(trainD)
dim(testD)
#showing the dimensions of the data structure

###Part 3: Build a Model using ksvm( )###

#H. Build a support vector model using the ksvm( ) function using all of the variables to predict cut. Once you have specified the model statement and the name of the training data set, you can use the same parameters as shown on page 237 of the text
#book: kernel= "rbfdot", kpar = "automatic", C = 5, cross = 3, prob.model = TRUE

ksvm(cut ~ ., data=trainD, kernel = "rbfdot", kpar = "automatic", C = 5, cross = 3, prob.model = TRUE )


#I. Write a block comment that summarizes what you learned from the book about those parameters. The two parameters of greatest interest are C=5 and cross=3.

#cut~. is specifying the variable (in this case cut) we are using in the model and ~ separates the left-hand side of the expression from the right hand side. 
#The dot (.) is a shorthand that tells R to use all of the other variables in the dataframe to try to predict cut.
#data=trainD is specifying the dataset we are using and in this case we're using the dataset we trained trainD
#kernel=rbfdot lets us project the low-dimensional problem into higher-dimensional space. 
#It refers to the radial basis function. It takes the set of inputs from each row in a data set and calculates a distance value based on the combination of the many variables in the row.
#kpar refers to a variety of parameters that can be used to control the operation of the radial basis function kernel. 
#C refers to the cost of constraints. We can force any mistakes to be more or less costly and have more influence. 
#In this case, we have a cost of 5 which is pretty high so we may have fewer mistakes. It creates a very close margin between two points.
#Cross refers to the cross-validation that the algorithm uses. We specified it to be 3. 
#With prob.model=TRUE, it's saying we are using our cross validation of 3 in order to generate the probabilities associated with whether a diamond is ideal or premium.
#It solves the problem of over-fitting. It helps create a model that is more likely to generalize other data. 
#Our cross validation error is 0.08 and so since its pretty low, this is good for predictions.


#J. Store the output of the kvsm( ) run in a variable and then echo that variable to the console. You will know that you are on the right track if your cross-validation error is reported in the neighborhood of 0.08. The other output information is mainly diagnostic and is not of great concern at this time.
svmModel <- ksvm(cut ~ ., data=trainD, kernel = "rbfdot", kpar = "automatic", C = 5, cross = 3, prob.model = TRUE )
svmModel

#storing svm model into variable svmModel/

###Part 4: Predict Values in the Test Data and Create a Confusion Matrix###

#K. Use the predict( ) function to validate the model against test data. Store the predictions in a variable names svmPred.

svmPred <- predict(svmModel,testD)
#predicting the test data set to validate the model against the test data using predict
summary(svmPred)

#L. The svmPred object contains a list of classifications either for “Premium” or “Ideal”. Review the contents of svmPred using str( ) and head( ).
str(svmPred)
#getting a structure of the prediction
head(svmPred)
#getting the first row of the prediction

#M. Create a confusion matrix (a 2 x 2 table) that compares svmPred to the contents of testData$cut.

cmatrix <- confusionMatrix(svmPred, testD$cut)
#creating a confusion matrix to list a table comparing svmPred and testData in the cut variable
cmatrix

#N. Calculate an error rate based on what you see in the confusion matrix. See pages 243-244 for more information.

(cmatrix[2,1] + cmatrix[1,2]*100) / (cmatrix[1,1] + cmatrix[1,2] + cmatrix[2,1] + cmatrix[2,2])

#O. Compare your calculations with the confusionMatrix() function from the caret package.

#it compares similarily with our prediction output as there is a high specificity which relates to the accuracy. 
#P. Explain, in a block comment, why it is valuable to have a “test” dataset that is separate from a “training” dataset?

#If we don't seperate test and training dataset, there will be overfitting and we will not be able to generalize our model for other use. 
#The model will only call to and be specific or reference the training set so it's important to test our model on data that hasn't been tested yet and to get more accurate results.

#Power Expert Mode: Use lm( ) to reproduce what you did above with ksvm( )
model1 <- lm(formula = cut ~ clarity, data=bestDiamonds)
model1


randIndex <- sample(1:dim(bestDiamonds)[1])
cutPoint2_3 <-floor(2*dim(bestDiamonds)[1]/3)
trainData <- bestDiamonds[randIndex[1:cutPoint2_3],]
testData <- bestDiamonds[randIndex[(cutPoint2_3+1):dim(bestDiamonds)[1]],]

class(trainData)
svmOutput <- ksvm(cut ~., data=trainData, kernel="rbfdot", kpar = "automatic",C=5, cross=3,prob.model=TRUE)

alphaindex(svmOutput)[[1]][alpha(svmOutput)[[1]]<0.5]
trainData[5951,]

svmPred <-predict(svmOutput, testData, type ="response")
svmPred



compTable <- data.frame(testData[,2], svmPred)
table(compTable)
str(compTable)

confusionMatrix(svmPred, testData$cut)


