#Lab 11

##Breakout 1
setwd("/Users/rayannaharduarsingh/Downloads")
install.packages("tidyverse")
install.packages("readr")
install.packages("quanteda")
install.packages("tm")
library(tidyverse)
library(readr)
library(quanteda)
library(tm)

#1.
file <- ("https://s3.amazonaws.com/blackboard.learn.xythos.prod/5956621d575cd/13115404?response-cache-control=private%2C%20max-age%3D21600&response-content-disposition=inline%3B%20filename%2A%3DUTF-8%27%27ClimatePosts.csv&response-content-type=text%2Fcsv&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20201105T150000Z&X-Amz-SignedHeaders=host&X-Amz-Expires=21600&X-Amz-Credential=AKIAYDKQORRYTKBSBE4S%2F20201105%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=06a62218efe2b83d55925ba1499bd437fe93d7ad4e7fd042b30a74291fc09a97")
textDF <- read_csv(file)
View(textDF)
#reading file and storing into textDF

#2.
str(tweetDF)
#This dataset contains tweets about climate change 
#The ID variable is the username of the perosn. 
#The Skeptic variable ranges from 0-1 and with 1 being that they are skeptic about climate change. 
#The Tweet variable is the user's tweet

#3.
tweetCorpus <- corpus(textDF$Tweet, docnames = textDF$ID)
#creating a bag of words and removing the stopwords like english because it is unecessary 

#4.
tweetDFM <- dfm(tweetCorpus, remove_punct =TRUE, remove = stopwords("english"), )
#creating a document-feature matrix of the tweet corpus

#5.
tweetDFM
#we see there are 18 documents, and a sparsity of 93.2% meaning there are a lot of blank values or 0s

#6.
set.seed(11)
#generating a sequence of random numbers to be reproduced
textplot_wordcloud(tweetDFM, min_count = 1)
#creating a wordcloud, climate is the biggest word

##Breakout 2##

#7. 
m <- as.matrix(tweetDFM)
varA <- rowSums(m)
varA
#varA is basically a word count and shows the frequency of how many times each word appeared

#8.

postCounts <-rowSums(m)
textDF$postCounts <- postCounts
#adding postCounts as a new variable in textDF dataframe
View(textDF)

##Breakout 3##

#9.

posWords <- scan("positive-words.txt", character(0),)
#scanning positive words file and storing it into posWords and separting by n 
negWords <- scan("negative-words.txt", character(0), sep = "\n")
#scanning negative words file and storing it into negSords and separting by n

#10.
wordCounts <- colSums(m)
#columns sums of m
wordCounts <- sort(wordCounts, decreasing=TRUE)
#sorting wordCounts

#11. 
str(wordCounts)
head(wordCounts)
#seeing how much each word appears in decreasing order

#12.
matchedP <- match(names(wordCounts), posWords, nomatch = 0)
matchedP
sum(matchedP != 0)


#13.
#there are 12 non-zero counts and the non-zero are the matches of the names of postive word counts.

#14.
matchedN <- match(names(wordCounts), negWords, nomatch = 0)
matchedN
sum(matchedN != 0)
#there are 17 non-zero counts and these are the matches of the names of negative word counts.


