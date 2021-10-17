################################################
# Intro to data science, Standard Homework Heading
#
# Student name: Rayanna Harduarsingh
# Homework number: 3
# Date due:  9/13/20
#
# Attribution statement: (choose only one)
# 2. I did this homework with help from the book and the professor and these Internet sources:
##https://www.statmethods.net/input/missingdata.html

# Run these three functions to get a clean test of homework code
dev.off() # Clear the graph window
cat('\014')  # Clear the console
rm(list=ls()) # Clear user objects from the environment

#Step 1:  Use read_csv( ) to read a CSV file from the web into a data frame:

#A Use R code to read directly from a URL on the web. Store the dataset into a new dataframe, called dfStates
file <- "https://raw.githubusercontent.com/CivilServiceUSA/us-states/master/data/states.csv"
file
dfStates <- read_csv(file)

#Step 2.Create a new data frame that only contains states with Twitter URLs:

#B. Use View( ), head( ), and tail( ) to examine the dfStates data frame.

View(dfStates)
#Here displays the entire content (rows and columns) or metadata of the data frame. It shows a list of all 50 U.S states listing their corressponding information such as each state's nickname, the date they were founded, their national website, population, and much more.
head(dfStates)
#This showed the top 6 rows in the data frame
tail(dfStates)
#This showed the bottom 6 rows in the data frame

#C. Create a variable (called noTwitter) that has TRUE if a state is missing its Twitter URL:

noTwitter <- is.na(dfStates$twitter_url)
noTwitter

#D. Use the table( ) command to summarize the contents of noTwitter.

table(noTwitter)

#There are 35 states who have its twitter URL, but 15 states are missing its Twitter URL.

#E. Create a new data frame that contains only the states with Twitter URLs (store that dataframe in twitterStates:
twitterStates<-dfStates[!is.na(dfStates$twitter_url),]
twitterStates

#FUse the dim() command on twitterStates to confirm that the data frame contained 35 observations and 19 columns/variables.
dim(twitterStates)

#Step 3: Calculate the mean for each of the three numeric variables.

#G. The data frame contains three numeric variables. You can remind yourself of what they are by looking at the output of str(twitterStates). Calculate the mean for each of the numeric values.

str(twitterStates)
mean(twitterStates$admission_number)
mean(twitterStates$population)
mean(twitterStates$population_rank)

#H. Write a comment, noting the mean population for twitterStates.

#6532234

#I. Create another data frame containing the 15 states that do not have Twitter URLs. Find out the mean population of those 15 states. Compare that to the answer you recorded for problem H.

noTwitterStates <- dfStates[is.na(dfStates$twitter_url),]
mean(noTwitterStates$population)
#5790280
#The mean population of the states that don't have twitter URLs is much less than the states who do have twitter URLs.

#Step 4: Extract the Twitter handle from the URL.

#J. Use the gsub() command to remove the beginning part of the URL from the Twitter URLs. This command should work most of the time:
gsub("https://twitter.com/","", twitterStates$twitter_url)

#K. Take a close look at the output from the gsub( ) command in problem J. Explain the cause of the incorrect results in a comment.
#Some of the URL's still have the beginning part of the URL. This might be because the command read only the data who followed the format we wrote. For example, some of the links had "www" after and the command did read to those links with "www". It only followed the links who only have "https" without the "www".

#L. Assign the results of the gsub( ) command to a new variable on the data frame. Note that you do not have to repair the problems that you explained in problem J
twitterStates$handle <- gsub("https://twitter.com/","", twitterStates$twitter_url)

#M. The following function should work most of the time. Make sure to run this code before trying to test it. That is how you make the new function known to R. Add comments to each line explaining what it does:
getTwitterHandleFromURL <- function(URL) {
  fixTry1 <- gsub("https://twitter.com/","", URL)
  fixTry2 <- gsub("http://twitter.com/","", fixTry1) fixTry3 <- gsub("http://www.twitter.com/","", fixTry2) return(fixTry3)
}

#getTwitterHandleFromURL <- function(URL) defines that a function is being created
#fixTry1  removes the "https://twitter.com/" part from the URL
#fixTry2 this references the result from fixTry1 to remove "https://twitter.com/"
#fixTry3 this references the reult from fixTry2 to remove "http://www.twitter.com/"
#return(tryFix3) outputs the return value from the function

getTwitterHandleFromURL("http://www.twitter.com/ksgovernment")

#N. Run your new function on the Twitter URLs. Make sure to use a comment to explain the cause of any problems that remain unfixed:
getTwitterHandleFromURL(twitterStates$twitter_url)
#in the data set I found there is also a facebook url so the data is not completely accurate which causes an error for this command. As said in class, not all data is always accurate and consistent.

#O. Assign the results of problem M to a variable on the data frame:
twitterStates$handle <- getTwitterHandleFromURL(twitterStates$twitter_url)

#Expert mode
#We can use the data frames and variables we just created for analyzing states and as well as their social media presence. We can see how many states are heavy/popular on social media with the presence of a twitter link. We can look at their population stats and see which states with a twitter are more populated and draw possible conclusions (ex: more populated cities have a twitter.)
