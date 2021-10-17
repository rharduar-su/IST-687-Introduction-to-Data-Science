################################################
# Intro to data science, Standard Homework Heading
#
# Student name: Rayanna Harduarsingh 
# Homework number: 9
# Date due: 10/27/20 
#
# Attribution statement: (choose only one)
# 1. I did this homework by myself, with help from the book and the professor. x

# Run these three functions to get a clean test of homework code
dev.off() # Clear the graph window
cat('\014')  # Clear the console
rm(list=ls()) # Clear user objects from the environment

#loading the titantic data set and copying it into new variable badboat.

load("/Users/rayannaharduarsingh/Downloads/titanic.raw.Rdata")
badboat <- titanic.raw

###Part 1: Explore Data Set###

#A. Use the View( ) command to examine the badboat dataframe; write a block comment describing what you see. Is this a sparse matrix?

View(badboat)
#viewing the badboat dataframe
#I would say this is a sparse matrix because many values are zero, or in this case 'no'.

#B. Count the people in each category of the Survived variable, using the table( ) command.

table(badboat$Survived)
#the table function allows us to create a mini dataset or tabular results for a given list of variable factors. 
#Here we created a table for those individuals who have survived or not. 
#No: 1490
#Yes: 711

#C. Express the results of problem 2 as percentages by sending the results of the table( ) command into the prop.table( ) command

prop.table(table(badboat$Survived))*100
#creating a prop table for those who have survived or not by sending the results of the first table() command and then I multiplied it by 100 to convert the decimal into a percentage. 

#D. Using the same techniques, show the percentages for the Class, Sex, and Age variables as well.

prop.table(table(badboat$Class))*100 #creating a prop table for those who are 1st, 2nd, or 3rd class or Crew and then I multiplied it by 100 to convert the decimal into a percentage.
prop.table(table(badboat$Sex))*100 #creating a prop table for those who are Male or Female and then I multiplied it by 100 to convert the decimal into a percentage.
prop.table(table(badboat$Age))*100 #creating a prop table for those who are adult or child and then I multiplied it by 100 to convert the decimal into a percentage.


#E. Show a “contingency table” (a 2 x 2 matrix) of percentages for the Age and Sex variables together. Write a block comment about what you see.

prop.table(table(badboat$Age, badboat$Sex))*100
#creating a prop table but for two variables. 
#There was a significant fewer amount of adult Females than adult Males on the Titanic. 
#There were also not so much children on board. 

###Part 2: Coerce the data frame into transactions###

#F. Install and library two packages: arules and arulesViz.
install.packages("arules")
library(arules)
#installing arules package and storing it in the library
install.packages("arulesViz")
library(arulesViz)
#installing arulesViz package and storing it in the library

#G. Coerce the badboat data frame into a sparse transactions matrix (called badboatX).

badboatX <- as(badboat, "transactions") #mining the itemset and coercing the badboat data framr into a sparse transaction matrix and naming it badboatX

#H. Use the inspect( ), itemFrequency( ), and itemFrequencyPlot( ) commands to explore the contents of badboatX.

inspect(badboatX) 
#showing the contents of the data object by inspecting badboadX
#shows each item (500) along with their class, sex, age, survival, corresponding to a transaction ID
itemFrequency(badboatX) 
#returning the distinct occurences
#no survival rate was very high, more people in 3rd class, way more adults than children, more males than females.
itemFrequencyPlot(badboatX) #showing how frequent items occur

#I. Explain the difference between badboat and badboatX in a block comment.
#badboatX was coerced into a transactions so all the data was listed. Each item had a line with their corresponding information listed an ID. BadBoat is a simple, organized table that divides all the variables into columns and filling in the necessary data.



###Part 3: Use arules to discover patterns###
#Support is the proportion of times that a particular set of items occurs relative to the whole dataset. Confidence is proportion of times that the consequent occurs when the antecedent is present. See the review on the next page.

#J. Use apriori to generate a set of rules with support over 0.005 and confidence over 0.5, and trying to predict who survived (so need to define the rhs).

rules1 <- apriori(badboatX, parameter = list(support=0.005, confidence=0.5), appearance = list(rhs="Survived=Yes"))
#generating rules using apriori with a support of 0.005 which refers to frequent occurence of something, a confidence of 0.5 which refers to the porporation of time for rhs, and then trying to predict who survived so we defined rhs with survived=yes.

#K. Use inspect()to review of the ruleset.

inspect(rules1)
#there are 14 rules that were created. 

#L. If you wanted to be certain to have survived the Titanic disaster, what kind of person would you want to have been? Use the output of inspect( ) or inspectDT( ) to figure out the answer. Write a block comment describing what you found.

inspectDT(rules1)
#Adult Females in 1st class were most likely to have survived the Titantic, as well as female children. 


#fun fact but sad fact the Titantic unfortunately sank on my birthday April 15th. :(







