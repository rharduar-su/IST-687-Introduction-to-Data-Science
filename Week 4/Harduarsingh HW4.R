################################################
# Intro to data science, Standard Homework Heading
#
# Student name: Rayanna Harduarsingh
# Homework number: 4
# Date due: 09/20/20
#
# Attribution statement: (choose only one)
# 1. I did this homework by myself, with help from the book and the professor

# Run these three functions to get a clean test of homework code
dev.off() # Clear the graph window
cat('\014')  # Clear the console
rm(list=ls()) # Clear user objects from the environment

###Part A: Write a function to compute statistics for a vector of numeric values.###

#1. new function that gets a numeric vector as its input argument and returns a list of statistics about that vector as the output.
vectorStats <- function(numVector)
{
  listOfStats <- c(mean(numVector),
                   median(numVector))
  return(listOfStats)
}
#this function calculates the mean and median for a vector of numeric values and returns the values in a vector called listOfStats

#2. Test your function by calling it with the numbers one through ten
vectorStats(1:10)
#this tests the function by going through each number 1-10

#3. Enhance the vectorStats() function to add the max, min and standard deviation to the output.
vectorStats <- function(numVector)
{
  listOfStats <- c(mean(numVector),
                   median(numVector),
                   max(numVector),
                   min(numVector),
                   sd(numVector))
  return(listOfStats)
}
#here we added to the function we created earlier for calculating a list of statistics and this time we added the maximum, minimum, and standard deviations statistics of the numeric values.

#4. Retest your enhanced function by calling it with the numbers one through ten:
vectorStats(1:10)
#testing the new function by going through each number in 1-10

###Part B: Sample repeatedly from the airquality built-in data frame###

#5. Copy the airquality data frame:
myAQdata <- airquality
#loading the airquality data frame into new vector 'myAQdata'
View(myAQdata)
#viewing the data in myAQdata upclose
help(airquality)
#The AirQuality data set shows the daily air quality measurements in the state of New York from the course of May 1st to September 30th in 1973. The data frame has 153 observations with 6 variables: Ozone(numeric) where it takes the mean ozone in parts per billion(ppb) from 1300 to 1500 hours at Roosevelt Island, Solar.R(numeric) which is solar readition in Langleys(lang) in the frequency band 4000-7700 Angstroms from 0800 to 1200 hours at Central Park, Wind(numeric) which is the average wind speed in miles per hour(mph) at 0700 and 1000 hours at LaGuardia Airport, Temp(numeric) which is the maximum daily temperature in degrees Farenheit at La Guardia Airport, Month (numeric) 1-12 and finally Day(numeric) 1-31 which is used to define the day the air quality was recorded on.

#6. Sample five observations from myAQdata$Wind
sample(myAQdata$Wind, size=5, replace = TRUE)
#sampling data from the Wind column 5 times

#7. 7. Call your vectorStats( ) function with a sample of five observations from myAQdata$Wind.

vectorStats(sample(myAQdata$Wind, size=5, replace=TRUE))
#here we called the vectorStats function we created earlier with the 5 sampled data values we got from #6.

#8. Use the replicate( ) function to repeat your sampling ten times. The first argument to replicate( ) is the number of repeats you want. The second argument is the little chunk of code you want repeated.

replicate(10,vectorStats(sample(myAQdata$Wind, size=5, replace=TRUE)))
#repeating the sample 10 times

#9. Write a comment describing why every replication produces a different result.
#we get different results because the sampling process is random and never exact which is why we get random or unlike samples each time

#10. Rerun your replication, this time doing 1000 replications and storig the output of the replicate.
windSamples <- replicate(1000,vectorStats(sample(myAQdata$Wind, size=5, replace=TRUE)))

#replicating the sample 1000 times and storing the result into new vector. I called the new vector of the samples "windSamples"

#11. Generate a histogram of the means (stored from the previous replicate)

hist(mean(windSamples))

#creating a histogram to display the means of the windSamples
#I thought this was an easier way to create a histogram as the replication and sample statement was stored into 'windSamples'

#12. Repeat the replicated sampling, but this time, raise your sample size from 5 up to 50. How does that affect your histogram?
windSamples <- replicate(1000,vectorStats(sample(myAQdata$Wind, size=50, replace=TRUE)))
hist(mean(windSamples))

#I did not notice a difference in my histogram and I think this is because of the Law of Large Numbers. Running a statistical process a large number of times, it will converge on a stable result and find that the distribution of sampling means start to create a normal distribution, which is what I saw both times in my histogram. 


