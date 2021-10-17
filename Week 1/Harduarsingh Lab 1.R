#1. This command simply adds all the numbers between 1-10 inclusively. 
1+2+3+4+5+6+7+8+9+10
#2. This command creates a variable called "myNumbers" and stores a vector that contains integers between 1-10 inclusively.
myNumbers <- c(1,2,3,4,5,6,7,8,9,10)
#3. This command results in the sum of the vector myNumbers.
sum(myNumbers)
#4. This command creates a variable called myNewNumbers and stores the vector myNumbers after it adds 10 to each number in the vector
myNewNumbers <- myNumbers + 10
myNewNumbers
#5. This command outputs the sum of 11-20 inclusively
sum(c(11:20))
#6. This command outputs the sum of 1-100 inclusively
sum(c(1:100))

##############
#End of Breakout 1
#############

#7. Here we are just making sure we have the variable "myNumbers" with a vector of 10 numbers 1-10 inclusively.
myNumbers <-c(1:10)
#8. These commands find the mean, median, the maximum value, the minimum value, and length of the vector myNumbers
mean(myNumbers)
median(myNumbers)
max(myNumbers)
min(myNumbers)
length(myNumbers)

#10. This command goes through each number in the vector and output TRUE > 5 or FALSE < 5
myNumbers > 5

#11. This will create a variable called bigNum and store a vector which has the numbers > 5 from our vector myNumbers
bigNum <- myNumbers[myNumbers > 5]
bigNum

#12. This command provides an explanation for the mean command
?mean
help("mean")

#13. This command provides an explanation for the if and control commands
help("if")
help("Control")
#This will run a conditional statement to check if the sum of the vector myNumbers > 40. If it is true it will print the statement "The sum is greater than 40"
if (sum(myNumbers) > 40) print("The sum is greater than 40.")

##########
#End of Breakout 2
##########
