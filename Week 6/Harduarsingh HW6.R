##Intro to data science, Standard Homework Heading
#
# Student name: Rayanna Harduarsingh
# Homework number: 6
# Date due: October 4th, 2020
#
# Attribution statement: (choose only one)
# 1. I did this homework by myself, with help from the book and the professor


##Step 1: Make a copy of the data##


#A. Copy the built-in “airquality” data frame into a new data frame called “air.” Your new data frame, air, contains a so-called multivariate time series: a sequence of measurements on four variables captured repeatedly over time.
air <- airquality 
#copying built-in datagram into new data frame
View(air)

#B. What is the “interval” of these data (in other words, at what frequency were the variables measured)? Put your answer in a comment.

#The interval is every day. The data is measured daily from May 1973 to September 1973.


##Step 2: Clean-up the NAs with Missing Data Mitigation##

#C. Write a comment describing how that statement works.
air$Ozone[is.na(air$Ozone)]
#this statement locates and lists the missing values for the Ozone column.

#D. Write three more statements to report missing data for the other variables.
air$Solar.R[is.na(air$Solar.R)] #checking the missing values for the Solar. R column
air$Wind[is.na(air$Wind)] #checking the missing values for the Wind column
air$Temp[is.na(air$Temp)] #checking the missing values for the Temperature column

#E.Install the imputeTS package and use na_interpolation( ) on your four variables. Don’t forget that you need to save the results back to the air data frame.

install.packages("imputeTS", dependencies = TRUE)
#install the package imputeTS
#had to include dependencies because it could find the package zoo
library(imputeTS)
#storing 'imputeTS in the library.
air$Ozone <-na_interpolation(air$Ozone) #using neighboring points to guess the missing values in the Ozone column
air$Solar.R <-na_interpolation(air$Solar.R) #using neighboring points to guess the missing values in the Solar.R column
air$Wind <-na_interpolation(air$Wind) #using neighboring points to guess the missing values in the Wind column
air$Temp <-na_interpolation(air$Temp) #using neighboring points to guess the missing values in the Temp column
#instead of using na.interpolation, I got a return saying na_interpolation better fits modern R code style guidelines so I simply replaced the "." for "_". The functionality stays the same. 

#F.Rerun the code from C and D above to check that all missing data have been fixed.
air$Ozone[is.na(air$Ozone)] #checking the missing values for the Ozone column and now checking if the missing data have been fixed
air$Solar.R[is.na(air$Solar.R)] #checking the missing values for the Solar. R column and now checking if the missing data have been fixed
air$Wind[is.na(air$Wind)] #checking the missing values for the Wind column and now checking if the missing data have been fixed
air$Temp[is.na(air$Temp)] #checking the missing values for the Temperature column and now checking if the missing data have been fixed

##Step 3: Use ggplot to explore the distribution of each variable##
install.packages('ggplot2')
#install the package ggplot2
library(ggplot2)
#storing the package ggplot2 into library


#G. Create a histogram for Ozone. Be sure to add a title.
gozone <-ggplot(air) + aes(x = Ozone) + geom_histogram(binwidth = 20)  #creating a histogram for the data in Ozone column 
gozone + ggtitle("Ozone Distribution") #adding a title to the histogram

#H.Create histograms of each of the other three variables with ggplot( ). Which parameter do you need to adjust to make the other histograms look right?

gsolar <-ggplot(air) + aes(x = Solar.R) + geom_histogram(binwidth = 15)  #creating a histogram with Solar.R data and add title
gsolar + ggtitle("Solar Distribution")

gwind <-ggplot(air) + aes(x = Wind) + geom_histogram(binwidth = 10)  #creating a histogram with Wind data and add title
gwind + ggtitle("Wind Distribution")

gtemp <-ggplot(air) + aes(x = Temp) + geom_histogram(binwidth = 5)  #creating a histogram with Temp data and add title
gtemp + ggtitle("Temp Distribution")

#I think the parameter you need to adjust is the binwidth to make the histograms look right

##Step 4: Explore how the data changes over time##

#I. These data were collected in 1973. Run the following line of code and write a comment that describes what it does:

air$Date <- as.Date(paste("1973", airquality$Month, airquality$Day, sep="-"))
air$Date

#This creates a column that combines 1973, the Month, and the Date and separated with a dash ("-") and converts it into a numeric date format.

#J. Now create a line chart, with Date on the X-axis and Ozone on the Y-axis.

ggOzone <- ggplot(air, aes(x=Date)) +geom_line(aes(y=Ozone)) #creating a linechart with Ozone variation through the different days
ggOzone + ggtitle("Ozone Variation")

#K. Next create time series graphs of each of the other three variables. Change the color of the line plots (any color you want).

ggSolar <- ggplot(air, aes(x=Date), colors="blue") +geom_line(aes(y=Solar.R), color="orange") #creating a time series graph and adding a color and title
ggSolar + ggtitle("Solar Variation")

ggWind <- ggplot(air, aes(x=Date)) +geom_line(aes(y=Wind), color="blue") #creatinf a time series graph and adding a color and title
ggWind+ ggtitle("Wind Variation")

ggTemp <- ggplot(air, aes(x=Date),color="red") +geom_line(aes(y=Temp),color="green") #creating a time series graph and adding a color and title
ggTemp + ggtitle("Temp Variation")

#L. Generate a bar chart of average temperate per month. Be sure to have a good title
avgTemp <- ggplot(air, aes(x=Month, y=Temp)) + geom_col()
avgTemp + ggtitle("Average Temp Per Month")
#creating a bar char and adding a title

#M. Finally, create a scatter plot, showing Wind on the x axis, Temp on the y axis, and having the color and size of the point represent Ozone
g <- ggplot(air, aes(x=Wind, y=Temp)) + geom_point(aes(color='red'))
g + ggtitle('Wind and Temp')

#creating a scatter plot and adding a color and title

#N. Interpret these visualizations – what insight can you explain?

#Global warming is drastically increasing as temperature is constantly rising and ozone decreasing.


