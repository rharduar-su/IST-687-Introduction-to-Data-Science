###Part 1: Using the Starter Code###

install.packages("RCurl")
install.packages("jsonlite")
install.packages("stringr")
install.packages("sqldf")
#this is to install the packages for RCurl, JSONlite, stringr, and sqldf in order for our following commands to work

library(RCurl)
#this added RCurl to the library which is an interface that provides HTTP facilities and allows us to download files from the web
library(jsonlite)
#this added jsonlite to the library which is a JSON parser contains that allows us to stream, validate, and prettify JSON data
library(stringr)
#this added stringr to the library which allows our string, 'str', functions to run. 
library(sqldf)
#this added sqldf to the library which allows us to use SQL commands in-combination with R. When getting further into the questions, I thought SQL would be a much easier and simple approach.

dataset <- getURL("https://opendata.maryland.gov/resource/pdvh-tf2u.json") 
#this is storing the URL link into a variable called 'dataset'; the getURL function allows us to access the http source or URL of a webpage.
df <- jsonlite::fromJSON(dataset)
#fromJSON converts JSON content to R objects by reading it in a JSONformat and then makes it readable in R. This is also creating the dataset variable into a dataframe called "df" that we will now refer to. 
df$day_of_week <- str_trim(df$day_of_week)
#this removed removed whitespace from the start and end of the column "day of week" in the data set. 

#A. Explore the 'df' data frame
View(df)
str(df)
nrow(df)
ncol(df)
#B. Explain the dataset 
#This is a dataset that showcases vehicle collisions including the data the accident happened, the roads it occured on, if there were injuries, and much more. The dataset has 1000 rows which corresponds to each of the 18 columns: Case Number which represents a unique number assigned to each incident for identification, barrack which is the city or area name the incident occured in, accident date which is when the incident happened, the accident time which is what time the incident occured at, accident code which is the type of incident that happened, the day it happened (Mon-Sat), road and intersecting road the incident happened on, distance from the intersection and direction, city name, county code, the county name, vehicle count which is the number of vehicles that were involved, if any property was destructed, if there was an injury, and the status of each car's collision.  

###Part 2: Investigating the resulting data frame###

#C. How many accidents happen on Friday?
sqldf("select count(day_of_week) from df where day_of_week = 'FRIDAY'")
#151 accidents happened on Friday 

#D. What is the total number of accidents on Fridays where there were no injuries?
sqldf("select count(day_of_week) from df where day_of_week = 'FRIDAY' and injury='NO'")
#there were 102 accidents on Fridays with no injuries

#E. What is the total number of accidents on Fridays where there were injuries?
sqldf("select count(day_of_week) from df where day_of_week) = 'FRIDAY' and injurt='YES'")
#there were 49 accidents on Fridays with injuries

#F. Create a new data frame that only includes accidents with injuries that occurred on Fridays.
dfInjuries <- sqldf("select * from df where day_of_week = 'FRIDAY' and injury='YES'")

#G. Use the new data frame to calculate the mean number of vehicles involved in accidents with injuries on Fridays?
sqldf("select avg(vehicle_count) from dfInjuries where day_of_week = 'FRIDAY' and injury='YES'" )

#H. Make a histogram of the number of vehicles in accidents on Fridays. Add a comment describing the shape of the distribution.
carAcc <- sqldf("select vehicle_count from df where day_of_week = 'FRIDAY'and vehicle_count is not null")
carAcc 
x<-as.numeric((unlist(carAcc)))
hist(x)


