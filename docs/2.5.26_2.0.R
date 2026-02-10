# 2.5.26 take 2: functions
sum(3,2)
3+2

`+`(3,2)

y <- 3
 `<-`(yy, 5)

print(read.table)

# Creating a function

# Start function called "Function name"
######################################################################3
# deliniates were inside a function

adder_subtractor <- function(x = 1, y = 2, z = TRUE){
# Name: adder_subtractor
# Operation: It does some random math depending on the value of z
# Inputs: (3 inputs): #what their defaults are and their variable types
  # x (numeric scaler value, default = 1): one of the numbers to be operated on
  # y (numeric scaler value, default =2): one of the numbers to be operated on
  # z (logical, default = TRUE): A switch to decide on subtracting or adding
# Outputs: numeric value resulting from addition or subtraction #dt, matrix, is it summary stats etc
  if(z == TRUE){
    out <- x + y
  }else{
    out <- x - y
  }

  

  return(out)

}
#######################################################################
# End of function


v <- adder_subtractor(x = 7, y=4) # this does everything in the function btw the ### ###, and can do more
v
adder_subtractor(x = 7, y = 4, z = FALSE)
adder_subtractor(x = 7, y = 4, operation = "division")

# can have functions within functions -"helper functions"

# Hardy Weinburgh Function

##################################################################
# START FUNCTION:
hardy_weinberg <- function(p = runif(1)){
#############################################3
  # FUNCTION: hardy_weinberg
  # operation: does a hardy weinberg equilibrium problem
  # input = p: allele frequency of dominant allele
  # output = q (reecessive): the frequencies of the three genotypes (fAA, fAB, fBB)
  
  q <- 1 - p  # defined q
  fAA <- p^2
  fAB <- 2*p*q
  fBB <- q^2

  # store data (in a vector) for output
  out_vec <- signif(c(q = q, p = p, AA = fAA, BB = fBB, AB = fAB), digits = 3)

  return(out_vec)  # return the values

  #print(c(q,p)) #side effect
  #print(sum(c(q,p)))

}

######################################################################
## END FUNCTION

hardy_weinberg()
hardy_weinberg(p = .3)


#### 2.10.2026
# global vs local parameters
my_func <- function(a = 3, b =4){
  z <- a + b # a and b are local
  return(z)

}

my_func()

b <- 4 #if b not contained in function, its a global variable and used locally without redefining is a big no
# solution: add b into the origional function or declare b locally

my_bad_func <- function(a = 3){
  z <- a + b
  b <- 8 # adding this, declared the variable, this fixed the problem; b now is local

  return(z)


}

my_bad_func()
# error: b not found; b is a local variable and hasn't been declared within the {}

#############33

my_bad_func <- function(a = 3){
  z <- a + b
  b <- 8 # adding this, declared the variable, this fixed the problem; b now is local

  return(z)


}

a <- 32
b <- 4

# first and second are local variables
my_func_2 <- function(first, second){
  z <- first + second
  return(z)

}


my_func_2(first = a, second = b) #global passed into the function through secondary local variables like first and second
# global variables are passed into the function through local variables
# declare global variables right above the function


######## Hardy Weinberg


# START FUNCTION:
hardy_weinberg <- function(p = runif(1)){
#############################################3
  # FUNCTION: hardy_weinberg
  # operation: does a hardy weinberg equilibrium problem
  # input = p: allele frequency of dominant allele
  # output = q (reecessive): the frequencies of the three genotypes (fAA, fAB, fBB)
  if (p > 1 | p < 0){
    return("Function Failure p must be greater than 0 but less than 1!")
  }



  q <- 1 - p  # defined q
  fAA <- p^2
  fAB <- 2*p*q
  fBB <- q^2

  # store data (in a vector) for output
  out_vec <- signif(c(q = q, p = p, AA = fAA, BB = fBB, AB = fAB), digits = 3)

  return(out_vec)  # return the values

  #print(c(q,p)) #side effect
  #print(sum(c(q,p)))

}

######################################################################
## END FUNCTION

hardy_weinberg()

hardy_weinberg(p = .3)

hardy_weinberg(p = 3) # This works mathematically but makes no sense

# reintroduce the "if" statement into the function- implied else, it is in bounds, continues on with the calculation
# gives feedback to the user

##########################################################################

# START FUNCTION:
hardy_weinberg <- function(p = runif(1)){
#############################################3
  # FUNCTION: hardy_weinberg
  # operation: does a hardy weinberg equilibrium problem
  # input = p: allele frequency of dominant allele
  # output = q (reecessive): the frequencies of the three genotypes (fAA, fAB, fBB)
  if (p > 1 | p < 0){
    stop("Function Failure p must be greater than 0 but less than 1!")
  }



  q <- 1 - p  # defined q
  fAA <- p^2
  fAB <- 2*p*q
  fBB <- q^2

  # store data (in a vector) for output
  out_vec <- signif(c(q = q, p = p, AA = fAA, BB = fBB, AB = fAB), digits = 3)

  return(out_vec)  # return the values

  #print(c(q,p)) #side effect
  #print(sum(c(q,p)))

}

######################################################################
## END FUNCTION

# stop = used for true error trapping, returns an actual error statment
hardy_weinberg(p = 2)
hardy_weinberg(p = .2)


##### Linear model - simple regression function ##############################
# START OF FUNCTION
fit_linear <- function(x = runif(20), y = runif(20)){
###############################################################################

# FUNCTION: fit_linear
# PURPOSE: fits a simple linear regression
# INPUTS: numeric vector of predictors x and response y
# OUTPUT: slope and p value
  
my_mod <- lm(y~x) # lm =  linear model, y as a function of x
  
# get values out
my_out <- c(slope=summary(my_mod)$coefficients[2,1],
p_value=summary(my_mod)$coefficients[2,4])
  
# plot the output
plot(x=x, y=y)
return(my_out)

}
###############################################################################
# END OF FUNCTION

# var1 and var2 not working
var1 <- 1:20
var2 <- 20:40
fit_linear(x, y)

fit_linear(x = var1, y = var2)

fit_linear()
# pass data or global var into the fit_linear() function



# START OF FUNCTION
fit_linear <- function(p = NULL){
###############################################################################

# FUNCTION: fit_linear
# PURPOSE: fits a simple linear regression
# INPUTS: numeric vector of predictors x and response y
# OUTPUT: slope and p value
if(is.null(p)){
  p <- list(x=runif(20), y = runif(20)) # this line is skipped if p is not null (false, only the "if" line (above) will be run)
}
  
my_mod <- lm(p$x~p$y) # fit the model

# get the outputs
my_out <- c(slope=summary(my_mod)$coefficients[2,1],
             p_value=summary(my_mod)$coefficients[2,4])
  
plot(x=p$x, y = p$y) # quick plot to check output
  
return(my_out)
}
########################################################3
# END FUNCTION

fit_linear()

my_parms <- list(x = 1:10, y = sort(runif(10)))
my_parms # sorted values from low to high -> will now get a signif p value

fit_linear(p = my_parms)

###################################################################
# for loops:
# z <- (NA...NA10) empty vector is used to store things that will be used in the for loop
# for(i in 1:10){}
# i = counter variable, i will be increasing for the loop from 1 to 10
# print(z[i])

# t <- x[i] + y[i] 
# t will change everytime it goes through the loop
# t      ### global variable

# z[i ] <- t 
# i  aka [i]] is an indexing variable

#for(my_var in 1:10)   can also do this, instead of i have a variable

