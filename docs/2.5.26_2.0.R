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
