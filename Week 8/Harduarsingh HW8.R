################################################
# Intro to data science, Standard Homework Heading
#
# Student name: Rayanna Harduarsingh
# Homework number: 8
# Date due: 10/18/20
#
# Attribution statement: (choose only one)
# 1. I did this homework by myself, with help from the book and the professor

# Run these three functions to get a clean test of homework code
dev.off() # Clear the graph window
cat('\014')  # Clear the console
rm(list=ls()) # Clear user objects from the environment

install.packages("ggplot2")
library(ggplot2)

#A. Use install.packages() and library() to put the psych package into memory. Like many packages, psych contains data sets that can be used for exercises and demonstrations. We will be using the sat.act data set which contains data on college entrance exams. Use the appropriate functions to summarize the sat.act data.
install.packages("psych")
#installing the psych package
library(psych)
#storing psych package into library
satdf <- sat.act
#storing dataset into new variable "satdf"
summary(satdf)
#summarzing the data set
View(satdf)
#viewing the entire data set

#B. We will be using four variables from this data set: ACT as the outcome variable, as well as gender, age, and education as the predictors. Create bivariate scatterplots (X- Y) plots for each of the predictors with the outcome. In each case, put ACT scores on the Y-axis.

genderplot<-ggplot(df, aes(x=gender, y=ACT)) + geom_point() + stat_smooth(method = "lm", col="purple") + labs(x='gender', y='ACT')
genderplot
#creating bivariate scatter plots with gender on the x axis and ACT on the y axis and also adding a best fit line.
ageplot<-ggplot(df, aes(x=age, y=ACT)) + geom_point() + stat_smooth(method = "lm", col="yellow") + labs(x='age', y='ACT')
ageplot
#creating bivariate scatter plots with age on the x axis and ACT on the y axis and also adding a best fit line.
educationplot<-ggplot(df, aes(x=education, y=ACT)) + geom_point() + stat_smooth(method = "lm", col="red") + labs(x='education', y='ACT')
educationplot
#creating bivariate scatter plots with education on the x axis and ACT on the y axis and also adding a best fit line.

#C. Next, create one regression model predicting ACT scores from the three predictors. Refer to page 202 in the text for syntax and explanations of lm( ). Make sure to include all three predictors in one model – NOT three different models each with one predictor.
lmOut<-lm(formula =ACT~gender+education+age, data=satdf) 
#creating a regression model where lm tells gender, education, and age to predict ACT.
summary(lmOut)

#D. Report the adjusted R-Squared in a comment. Which of the predictors are statistically significant in the model? In a comment, report the coefficients (AKA slopes or B-weights) for each predictor that is statistically significant. Do not report the coefficients for predictors that are not significant.
#The adjusted R-Squared says that gender, age, and education could account for 2.72% of the variability in ACT scores. Education is the most statistically significant coefficient with the highest value of all three coefficients. 

#E. Write a block comment that explains your overall interpretation of the model. Mention all predictors that were tested and provide examples that explain the meaning of the coefficient for any predictors that were significant.
# The predictors we used were gender, education, and age. The R-squared value is not really high and is mostly closer to 0 which can mean that there is not such a strong relationship between the variables. However, when looking at the education coefficient, education had the strongest value of 47%. Education will have a huge factor (47%) that will affect/increase the ACT scores. Gender had a negative value and age was only about 1.6% so these predicitors are not strong nor do they have a strong predictor sense on the ACT scores.

#F. Create a one-row data frame like this: predDF <- data.frame(gender=2, education=2, age=20) and use it with the predict( ) function to predict the resulting ACT score.

predDF<- data.frame(gender=2,	education=2,	age=20)
#one-row data frame 
predict(lmOut, predDF, type="response") 
#predicting the ACT score

#G. Create two additional linear models, one with SATV and one with SATQ as the outcome variable.

lmOut2<-lm(formula =SATV~gender+education+age, data=satdf) 
#regression linear model for predicting SATV scores
summary(lmOut2)
lmOut3<-lm(formula =SATQ~gender+education+age, data=satdf) 
#regression linear model for predicting SATQ scores
summary(lmOut3)

#H. Review the quality of all three models. What can you learn from this analysis?
#From all three models, the R-squared value was relatively low and so all three variables, gender, education, and age accounts for such little variability in ACT scores. It may not be much to make an accurate prediction, but the education coefficient came out the strongest in each model so we can infer that education does affect the scores on the ACT/SAT.
















