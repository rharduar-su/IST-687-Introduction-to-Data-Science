###Part 1###

install.packages('stringr')
#installing string package
install.packages('ggplot2')
#installing ggplot package for economics dataset
library(stringr)
#storing stringr in library
library(ggplot2)
#storing ggplot in library
str(economics)
#converting economics data set into a string

#1.
myPlot <- ggplot(economics, aes(x=date)) 
myPlot <- myPlot + geom_line(aes(y=psavert))
myPlot
#creating a basic plot and setting the x axis to the data and y to equal the personal savings rate
#You get it to draw in the plot window by typing 'myPlot'.

#2.
help('economics')
#the psavert variable is the personal savings rate. 

#3.

#Psavert reached its max in about 1975.
#Psavert reached its min in about 2006.

#4.
max_psavert<- which.max(economics$psavert)
economics[max_psavert,]
#getting the year in which the personal savings rate was highest by using which.max to retrieve the max
min_psavert<- which.min(economics$psavert)
economics[min_psavert,]
#getting the year in which the personal savings rate was lowest by using which.min to retrieve the min

#5. 
myPlot <- myPlot + geom_line(aes(y=psavert), color='green')
myPlot
#getting the plot line to be displayed in green using geom_line, specifying the axis, and defining the color. 

#6. 

myPlot <- myPlot + ggtitle("Personal Savings Rate: 1967-2014")
myPlot
#adding a title to the plot using ggtitle

#7.

myPlot<- myPlot +geom_line(aes(y=uempmed), color= 'red') + geom_line(aes(y=psavert), color= 'green')
myPlot

#adding a new axis for the variable unemployed and making it red

#8
myPlot <- myPlot + ggtitle("Personal Savings Rate and Median Duration of Unemployment: 1967-2014")
myPlot  

#adding a new title, replacing the old one, to incorporate both psavert and unemped variables

###Part 2###

#9
myPlot<- myPlot + ylab("uneployment") 
myPlot<- myPlot + xlab("Year")
myPlot<- ylab("uneployment") + xlab("Year")

#modifying the axis labels to now be the year and unemployment in myPlot

#10
econ <- economics
#storing economics dataset into new variable called econ
econ$year <- substr(econ$date, start=0, stop=4) 
econ$year
#takes the first four digits of that date, hence returning the year
econ$year <- as.numeric(econ$year) 
econ$year
#converting the year into numeric format
econ$mystery <- round(econ$year/10)*10
#rounds the year to the the nearest 10 (ex: 1967 is rounded to 1970)
agg = aggregate(econ,
                by = list(econ$mystery),
                FUN = mean) 
agg$mystery <- agg$Group.1
agg$decades <- agg$mystery #renaming myster
#this function is grouping the year by every 10 years 

#11
g <- ggplot(agg, aes(x=decades, y=unemploy)) + geom_col()
g

#creating a bar chart using geom_col() and specifying our x and y axis

#12
ggplot(economics, aes(x=unemploy, y=psavert)) + geom_point(aes(color='red'))

#creating a scatter plot, specifying our x and y axis, and color coding our scatter points. 

#13
#In the 2000-6000 unemployed range, there is a higher personal savings rate. 
#In the 6000-10000 unemployed range, the personal savings rate is scattered. 
#In the 10000-16000 unemployed rnage, the personal savings rate seems to be decreasing. 
#We can educately guess that the higher the unemployment, the lower the personal savings rate.


             


            


