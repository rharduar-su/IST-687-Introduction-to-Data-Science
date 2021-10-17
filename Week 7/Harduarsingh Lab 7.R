###Part 1###

#1

install.packages("ggplot2")
install.packages("maps")
install.packages("ggmap")
install.packages("mapproj")
#installing packages

library(ggplot2); library(maps); library(ggmap); library(mapproj)
#storing package in library

us <- map_data("state") map
#this is finding a map to be used by ggplot and in this case we want the states
us$state_name <- tolower(us$region)
#changing all uppercase letters to lowercase in the region column and storing value into new variable us$state_name 
map <- ggplot(us, aes(map_id= state))
#creating a ggplot where map_id equals state name and storing into variable 'map'
map <- map + aes(x=long, y=lat, group=group) +
  geom_polygon()
#creating a polygon with x axis as longitude and y as latitude and group equaling group column
map <- map + expand_limits(x=us$long, y=us$lat)
#defining the x and y for the map
map <- map + coord_map() + ggtitle("USA Map") 
#projecting a portion of the earth onto a flat 2D plane and making sure the map does not return distorted or stretched
map

#2
map + aes(x=long, y=lat, group=group) + geom_polygon(fill='white', color='black')
#editing the map to make sure each state is outlined to for better visual

#3
ny_counties <- map_data("county","new york")
#finding a map and in this case it is from the county and state
ggplot(ny_counties) + aes(long,lat, group=group) + geom_polygon()
#creating a ggplot for ny_counties, defining aesthetic, and add a polygon visual
#4
ggplot(ny_counties) + aes(x=long, y=lat, group=group) + geom_polygon(fill='white', color='black')
#Editing map to also have counties outlined

#5
head(ny_counties)
#return the first 6 rows

###Part 2###

#6
install.packages("readr")
library(readr)

file <- "https://s3.amazonaws.com/blackboard.learn.xythos.prod/5956621d575cd/5888822?response-cache-control=private%2C%20max-age%3D21600&response-content-disposition=inline%3B%20filename%2A%3DUTF-8%27%27nyData.csv&response-content-type=text%2Fcsv&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20201008T150000Z&X-Amz-SignedHeaders=host&X-Amz-Expires=21600&X-Amz-Credential=AKIAYDKQORRYTKBSBE4S%2F20201008%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=c4325f35c6536d6c7b5532a5e62264cbba969233e2b298b54319ce400f9f5bfc"
file
nyData <- read.csv(file)
nyData
#here I copied the CSV url into a variable called file, then used the read.csv command to read and import the csv file and then copied into a new variable called nyData.

#7
mergeNY <- merge(ny_counties,nyData, all.x=TRUE,by.x="subregion",by.y="county")
mergeNY
#merge the ny_counties data and nyData together

#8
head(mergeNY)
#return the first six rows

#9

ggplot(mergeNY) + aes(long,lat, group=group) + geom_polygon()
#creating polygon for mergeNY 
ggplot(mergeNY) + aes(x=long, y=lat, group=group) + geom_polygon(fill=mergeNY$pop2000, color='black')
#specifying the fill to only pull from pop2000 column 

