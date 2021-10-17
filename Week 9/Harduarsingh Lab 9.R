###Breakout 1###

install.packages('arules')
install.packages('arulesViz')

library(arules)
library(arulesViz)

data (Groceries) # Load data into memory 
myGroc <- Groceries # Make a copy for safety 
summary(myGroc) # What is the structure?

#1
#The item labels are (1) frankfurter, (2) sausage, and (3) liver loaf.

#2. 
itemFreq <- itemFrequency(myGroc)
itemFreq
str(itemFreq)
#this displays the internal structure of each of the items
sortFreq <- sort(itemFreq)
head(sortFreq)
tail(sortFreq)
#milk is the most frequently purchased item

#3.
itemFrequencyPlot(myGroc, topN=20)
#the y axis is measuring the relative item frequency; how frequent an item is purchased

#4. 
rules1 <- apriori(myGroc, 
          parameter=list(supp=0.0008, conf=0.55),
          control=list(verbose=F),
          appearance=list(default="lhs",rhs=("bottled beer")))
rules1

#5.
inspect(rules1)
#the support for each rule is really low so for each item with beer do not occur often. 
#the confidence shows the probability of beer being in each basket
#the last 4th rule has a 1.0 confidence so 100% chance there is beer in the basket of soda liqour and wine.

#6.
rules2 <- apriori(myGroc, 
                  parameter=list(supp=0.0005, conf=0.55),
                  control=list(verbose=F),
                  appearance=list(default="lhs",rhs=("bottled beer")))
inspect(rules2)
#we now have 14 rules and different items being showed such as milk, yogurt, vegetables, and other common items.
#beer is not so much bought with some of these new items

####Breakout 2 ####

#7. 
mtattr <- mtcars[,c('cyl', 'vs', 'am', 'gear', 'carb')]
mtattr$cyl <- as.factor(mtattr$cyl)
mtattr$vs <- as.factor(mtattr$vs)
mtattr$am <- as.factor(mtattr$am)
mtattr$gear <- as.factor(mtattr$gear)
mtattr$carb <- as.factor(mtattr$carb)
mtattr$mpg <-"Bad"
mtattr$mpg[mtcars$mpg > 25] <- 'Good'
mtattr$mpg <- as.factor(mtattr$mpg)

#8. 
str(mtattr)

#9
mtmatr <- as(mtattr,'transactions')

#10
rules3 <- apriori(mtmatr,
                  parameter = list(supp=0.25, conf=0.80, minlen=4),
                  appearance = list(default='lhs', rhs='mpg=Bad'),
                  control = list(verbose=F))
inspect(rules3)





