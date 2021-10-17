################################################
# Intro to data science, Standard Homework Heading
#
# Student name: Rayanna Harduarsingh
# Homework number: 11
# Date due: 11/08/20
#
# Attribution statement: (choose only one)
# 1. I did this homework by myself, with help from the book and the professor

# Run these three functions to get a clean test of homework code
dev.off() # Clear the graph window
cat('\014')  # Clear the console
rm(list=ls()) # Clear user objects from the environment

setwd("/Users/rayannaharduarsingh/Desktop")
install.packages("tidyverse")
install.packages("readr")
install.packages("quanteda")
library(tidyverse)
library(readr)
library(quanteda)

##Part 1: Load and visualize the text file##

#A. There is a plain text file on Blackboard called TheRoadNotTaken.txt. Read in this file using the scan( ) function. Here’s the code:

file.choose()
charVector <- scan("TheRoadNotTaken.txt", character(0), sep = "\n")
#scanning new file into charVector

#B. Transform charVector into a document-feature matrix, using the corpus() and dfm() functions. Do not forget to remove stop words:

charVector <- corpus(charVector)
#creating a bag of words using corpus function
charVector <- dfm(charVector, remove_punct =TRUE, remove = stopwords("english"), )
#creating a document-feature matrix and removing stopwords or the unecessary words

#C. Plot a word cloud (hint: use textplot_wordcloud)
textplot_wordcloud(charVector, min_count = 1)
#creating a word cloud for charVector


##Part 2: Create a sorted list of word counts from the speech##

#D. These lines of code will create a named list of word counts by frequency. Hint: use the functions as.matrix() and colSums()

m <- as.matrix(charVector)
m
#viewing the word text as a matrix
wordCounts <- colSums(m)
wordCounts <- sort(wordCounts, decreasing=TRUE)
wordCounts
#getting the sum of each time a word appears

#E. Explain in a comment what you observed in the sorted list of word counts.

#I was able to a complete list of all the words in the text and how many times each word appeared, excluding the stop words of course. 
#The most frequent word was 'one' appearing 3 times. 

##Part 3: Match the speech words with positive and negative words##

#F. Read in the list of positive words (using the scan function), as well as the negative words. There should be 2006 positive words and 4783 negative words.

posWords <- scan("/Users/rayannaharduarsingh/Desktop/positive_words.txt", character(0), sep = "\n")
posWords <- posWords[-1:-8]
View(posWords)
#scanning positive words file and storing it into posWords and separting and removing random text
negWords <- scan("negative-words.txt", character(0), sep = "\n")
negWords <- negWords[-1:-8]
View(negWords)
#scanning negative words file and storing it into negWords and separting and removing random text

#G. Here’s a code example for matching the words from the speech (stored in wordCounts) to the list of positive words (stored in posWords):

matchedP <- match(names(wordCounts), posWords, nomatch = 0)
matchedP

#Write comments explaining this code. Then, create a similar line of code to match the speech to the negative words.

#We are matching all the names in the wordCounts to the positive words and words that don't have a match will return a 0.

matchedN <- match(names(wordCounts), negWords, nomatch = 0)
matchedN

#H. Examine the contents of matchedP. What does each non-zero entry contain? How does that relate to WordCounts and posWords?

#Each non-zero entry contains the index number of the matched words from posWords to wordCounts. It gives us perspective to what the unique words are.

#I. Use R to print out which positive words were in the speech.

allWords <- data.frame(Words = names(wordCounts), Frequency = wordCounts, Positivem = matchedP, Negativem = matchedN)
View(allWords)
#creating a more organized data frame that lists all the negative and positive words in the speech

pWords <- allWords[allWords$Positivem]
View(pWords)
#filtering out all the positive words from the speech

#J. Use R to print out the total number of positive words were there in the speech?

pCounts <- sum(allWords$Positivem)
pCounts
#getting the sum of the all the positive matched words

#K. Repeat that process for the negative words you matched. Which negative words were in the speech?

nWords <- allWords[allWords$Negativem]
View(nWords)

#filtering out the negative matched words column

nCounts <- sum(allWords$Negativem)
nCounts
#getting a total count of all the negative matched words

#L. Write a comment describing what you found for matching positive and negative words.
# I found for positive words there was better and fair in both and bent and worn for negative words.



