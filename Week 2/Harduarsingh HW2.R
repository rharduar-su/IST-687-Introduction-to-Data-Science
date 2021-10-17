################################################
# IST687, Standard Homework Heading
#
# Student name: Rayanna Harduarsingh
# Homework number: 2
# Date due: 9/6/20 
#
# Attribution statement: (choose only one)
# 1. I did this homework by myself, with help from the book and the professor

# Run these three functions to get a clean test of homework code
dev.off() # Clear the graph window
cat('\014')  # Clear the console
rm(list=ls()) # Clear user objects from the environment

# Set working directory 


##Step 1: Explore mpg

#A. What is the mean mpg?

summary (myCars)

#20.09

#B. What is the value of the highest mpg?

summary (myCars)

#33.90


#C. What is the value of the lowest mpg?

summary (myCars)

#10.40

#D. Create a sorted dataframe based on mpg and store it in mtCarsSorted; Use order()

mtCarsSorted <- order(myCars$mpg)


##Step 2: Which car has the highest HP?

#E. Is higher or lower HP best?

#F. Which car has the highest hp?

which.max(myCars$hp) 

# 31 Maserati Bora

#G. Which car has the lowest hp?

which.min(myCars$hp)

# 19 Honda Civic


##Step 3. Calculate a combination of mpg and hp

#H. Run scaledMPG <- scale(myCars$mpg, center=0, scale=T)

scaledMPG <- scale(myCars$mpg, center=0, scale=T)

#I. 

# It transforms a vector of numbers into an arrange that have the same relationship that is comparable to other vectors by taking the standardized value for each element in the data set. For the command above, it is scaling the vector of my Cars for mpg centering it and scaling it to be in a smaller number. 

#J. Copy that command and modify it to create a new, scaled version of myCars$hp. 

scaledHP <- scale(myCars$hp, center=0, scale=T)

#K. Combine the two scaled measurements by adding them. Explain in a comment how and why this works. 

myCars$scaledSum <- scaledMPG + scaledHP

#This works by simply adding the new variables we created (the scaled versions) and combining these two columns together. This combination results in the creation of one new variable that contains both scaled variables we created earlier. 

#J. Which car has the highest combination of mpg and hp?

which.max(myCars$hp + myCars$mpg)

# 31 Maserati Bora

#K. Create a sorted list of cars, based on the combined mpg and hp.  

sort(myCars$scaledSum)
 
