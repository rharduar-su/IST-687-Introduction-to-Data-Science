################################################
# Intro to data science, Standard Homework Heading
#
# Student name: Rayanna Harduarsingh
# Homework number: 7
# Date due: 10/11/20
#
# Attribution statement: (choose only one)
# 1. I did this homework by myself, with help from the book and the professor

# Run these three functions to get a clean test of homework code
dev.off() # Clear the graph window
cat('\014')  # Clear the console
rm(list=ls()) # Clear user objects from the environment

install.packages("tidyverse")
install.packages("ggplot2")
install.packages("ggmap")
install.packages("maps")
install.packages("mapproj")
install.packages("readr")
#installing necessary packages

library(tidyverse)
library(ggplot2)
library(ggmap)
library(maps)
library(mapproj)
library(readr)
#storing and loading packages into library

##Step 1: Load and repair the median income data##

#A. Download the provided MedianZIP.csv file from Blackboard and read into R-studio into a dataframe called “mydata”. Use read_csv() from the tidyverse package to simplify later steps!
file <- "https://s3.amazonaws.com/blackboard.learn.xythos.prod/5956621d575cd/4466787?response-cache-control=private%2C%20max-age%3D21600&response-content-disposition=inline%3B%20filename%2A%3DUTF-8%27%27MedianZIP.csv&response-content-type=text%2Fcsv&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20201011T150000Z&X-Amz-SignedHeaders=host&X-Amz-Expires=21600&X-Amz-Credential=AKIAYDKQORRYTKBSBE4S%2F20201011%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=5dfb727ea635005297ba9799716ee9d3f82b488da14e026f38e02bf36c8d7385"
mydata <- read.csv(file)
#reading the csv file
mydata

#B. Find and fix the missing data in the Mean column by substituting the value from the Median column in place of the missing mean values. Add a comment explaining why the median is a reasonable replacement for the mean.
View(mydata)
#getting a view of the dataset
mydata[is.na(mydata$Mean) == TRUE,] 
#finding the missing values 
mydata$Mean[is.na(mydata$Mean)] <- mydata$Median[is.na(mydata$Mean)] 
#replacing the missing values in Mean column with the Median column 
#Median is a reasonable replacement because it gives a better representation of central tendency than average. It doesn't depend on all the values in the dataset, hence affected by any outliers. 

#C. Examine the data with View( ) and add comments explaining what each column contains. Add a comment explaining why the first 2391 zip codes look weird.
View(mydata) 
#The zip column contains the zipcodes, the Median column contains the median income, the mean column contains the mean income, and the population column is the population in the zipcode.
zipcode <- mydata[1:2391,]
#channeling first 2391 rows
zipcode
#They look weird because the first 2391 zip codes only have 4 digits and after it has the normal 5 digit zip code. 

##Step 2: Merge the median income data with the detailed zipcode data##

#D. Download and then read the "us_zip_code_latitude_and_longitude.csv" dataframe, into a dataframe named zipcodes.
file2 <-"https://s3.amazonaws.com/blackboard.learn.xythos.prod/5956621d575cd/11336415?response-cache-control=private%2C%20max-age%3D21600&response-content-disposition=inline%3B%20filename%2A%3DUTF-8%27%27us_zip_code_latitude_and_longitude.csv&response-content-type=text%2Fcsv&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20201011T150000Z&X-Amz-SignedHeaders=host&X-Amz-Expires=21600&X-Amz-Credential=AKIAYDKQORRYTKBSBE4S%2F20201011%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=e65921d2f57f745cdc42a57796bac8751d5885fbe0e3cafa5fdd18fd8bdc0aac"
zipcodes <- read.csv(file2)
#reading the csv file
zipcodes
View(zipcodes)
#E. Merge the data frame “mydata” with the zipcodes dataframe (using the ‘zip’ attribute from both dataframes), storing the resulting dataframe in ‘dfNew’.
dfNew <- merge(mydata,zipcodes, by="zip") #merging the income data with the zipcode data together and storing it 'dfNew'.
View(dfNew)
#F. Review the structure of dfNew and explain the attributes in that dataframe
#merging mydata and zipcodes combined the two data frames and their columns and rows they both had in common. Using their common zipcode column, we were able to combine and correspond both frames into one that include the mean, median, and pop from my data and city, state, latitude, longitude, timezone, daylightsavings, and geopoint into now dfNew.

##Step 3: Merge the new dataset with stateName.csv data##

#G. You will find stat eNames.csv on Blackboard. Use it similarly to Step2.

file3 <- "https://s3.amazonaws.com/blackboard.learn.xythos.prod/5956621d575cd/4466786?response-cache-control=private%2C%20max-age%3D21600&response-content-disposition=inline%3B%20filename%2A%3DUTF-8%27%27stateNames.csv&response-content-type=text%2Fcsv&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20201011T150000Z&X-Amz-SignedHeaders=host&X-Amz-Expires=21600&X-Amz-Credential=AKIAYDKQORRYTKBSBE4S%2F20201011%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=695e9ea4673ee3fd466afa19685d42f1ba678fb6610603184a4b2fe351443a78"
usstates<- read_csv(file3) 
#read the csv file
View(usstates)
dfNew <- merge(usstates,dfNew, by="state") 
#merging the states data with dfNew to now include state name
view(dfNew)

##Step 4: Visualize the data##

#F. Plot points (on top of a map of the US) for each zipcode (don’t forget to library ggplot2 and ggmap). Have the color represent the mean
us <- map_data("state")
dfNew$name<-tolower(dfNew$name)
map<- ggplot(us, aes(map_id = name)) #ggplot for adding the data and map_id for specifying the data for map
map<- map + geom_point(aes(x=long, y=lat, group=state, color=Mean))  #specifying longitude and latitude and make the color represent the mean
map

#G. Add a block comment that criticizes the resulting map. It’s not very good.
##map is not properly layed out or organized and no insights or assumptioms can be derived from the map

##Step 5: Use aggregate() to Make a Data Frame of State-by-State Income##

dfNew$Total <- dfNew$Mean*dfNew$Pop
dfSimple = aggregate(dfNew[c("Pop", "Total")],
                     by = list(dfNew$state_name),
                     FUN = sum) dfSimple$name <- dfSimple$Group.1
dfSimple$Group.1 <- NULL

#H. Add a comment describing what each line of code does. Make sure to describe how many rows there are in dfSimple (and why there are that many rows).

#I. Create a new variable on dfSimple called income. Calculate income by dividing Total by Pop. This will provide the average income for each state.
dfSimple$income<-dfSimple$Total/dfSimple$Pop
#this is creating a new column to calculate average income by state population

##Step 6: Use ggplot and ggmap to shade a map of the U.S. with average income##

#J. Copy the ggplot code from Step 4. In the initial ggplot statement, you will need to use your new data frame, so substitute dfSimple in place of dfNew. Additionally, instead of using geom_point to plot points, use this aesthetic to fill the polygons with a color for each state. Make sure to expand the limits correctly and that you have used coord_map appropriately.
us<- map_data("state")
map2<- ggplot(dfSimple) + aes(map_id=name)) + geom_polygon() #plotting the map using name
map2<- map2 + geom_map(map = us,aes(fill=income)) #create the map using income for each state
map2<- map2 + geom_point(aes(x=long,y=lat)) 
map2<-map2+ expand_limits(x=lat, y=long) #expanding the limits and defining x and y 
map2<-map2+coord_map()+ ggtitle("Map of US Income") #coord_map and add title
map2








