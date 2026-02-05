### 2.5.26 Functions
# start first half of the homework day before, come in w questions and finish the hw in class
# functional programing-create used defined functions (smth going in, smth happen, smth come out which does another thing, etc; contain solutions for problems)
# OOP programing- object oriented; create an object that has attributes which can do things to itself

#functional programming
#function called "function"
#function(make up your own arguments and inpupts)
#eg. my_func <- function(x=1, y=2) #the header of the function; {} the body of the function
```
{out <- y/2}
function has its own local env so x=1 iinside the function is different than a global variable x <- 1; global var exists outside the function function()
return (inside the function)
return(out) #can only output one thing, return object out 
z <- list(out, out1) #then outputs 2 things
to run this, call the function:
z <- my_func(x=2, y=3) #run this function with a loop to run the actual function more than once!

```

# A demo of user definied funcions in R
# E Bansbach
# 2.5.26

#########################################
# looking at existing functions
sum(3,2) #function
3+2 #arithmetic operator-is actually a function
# the plus sign is a function
