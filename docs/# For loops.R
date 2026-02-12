# For loops
# basic codin with for loops
# 2.10.2026 and 2.12.2026
# E Bansbach

# creating a basic for loop:
for (i in 1:5) {
  cat("stuck in a loop", "\n")
  cat(3 + 2, "\n")
  cat(runif(1), "\n")

}

# "\n" = character space

my_dogs <- c("chow", "akita", "malamute", "husky", "samoyed")
for (i in 1:length(my_dogs)){
  cat("i = ", i, "my_dogs[i] =", my_dogs[i], "\n")


}

# i = counter variable, shows up in consule as i = ...

my_bad_dogs <- NULL
for (i in 1:length(my_bad_dogs)){
  cat("i =", i, "my_bad_dogs[i] =", my_bad_dogs[i], "\n")

}

for (i in seq_along(my_dogs)){
  cat("i =", i, "my_dogs[i] =", my_dogs[i], "\n")

}

# seq_along is better to use inside for loops

####### 2.12.2026 #####

# Tips:
# Tip 1: Don't do thiings in a loop if you don't need to:

for (i in seq_along(my_dogs)){
  print(my_dogs[i])
  my_dogs[i] <- toupper(my_dogs[i]) # converted to uppercase then stored as uppercase
  
}

my_dogs
tolower(my_dogs) # vectorized; lowered them all in one go
toupper(my_dogs)
# put smth at the end of the loop, or if vectorized smth do that before putting it in the loop
# aka keep things out of the loop that aren't necessary -> increases speed of running script


# Tip 2: Don't change dimensions in the loop
my_dat <- runif(1)
my_dat
for (i in 2:10){   # looping through loop 9 times
  temp <- runif(1)
  my_dat <- c(my_dat, temp) # my_dat plus temp, concaconated in a vector; loop 1 have single value x, loop 2 have x and increase size by 1, etc; increases "linearly" creating 9 other vectors increasing by 1, giving an exponential graph of t vs O
  #cat("loop numer=", i, my_dat[i], "\n")
  print(my_dat)

}


# Tip 3: 
# Don't write a loop if you can vectorize it (kinda related to tip 1)
# vectorize is much faster than if loop everything
# DON'T do this:
my_dat <- 1:10
for (i in seq_along(my_dat)){
  my_dat[i] <- my_dat[i] + my_dat[i]^2
  cat("loop number =",i,"vector element=", my_dat[i], "\n")
# i is loop number and my_dat[i]] is vector element
  
}
# vectors are easily vectorized

# Do this:
z <- 1:10
z <- z + z^2   # this is very fast and efficient bc not looping through anything


# Tip 4:
# i = counter variable
# remember the difference between i and z[i]
# variable z, indexing i into it; use i to index into variables
z <- c(10,2,4)
for (i in seq_along(z)){
  cat("i =",i,"z[i] =",z[i],"\n")

}


# Tip 5:
# cost efficiency thing
# maybe you only want to run even things, don't want to have to loop through everything
z <- 1:20
for (i in seq_along(z)){
  if(i %% 2 ==0) next
  print(i) # only prints the odd i's (division w remainder by , if reminder equals 0 (==0) then skip)

}

# can also do this for things that are only TRUE


# Tip 5:
# create single loop to go through log growth model
# look at the parameter space of the logistic growth model with a for loop 
# first create variables


# START OF FUNCTION
log_growth <- function(N_0 = 250, r= 0.75, k= 1200, t_step = 1, t_final = 20, e = 2.71828){
##############################################################################
# FUNCTION: logistic growth model
# PURPOSE: use an equation to create a logistic growth model representing a population size
# INPUTS: numeric value for N0, r, K, e, and t_step and t_final
# OUTPUT: Population size at a certain time
# Purpose of the function: To plot a population size over a fixed amount of time, with a carrying capacity to create a logistic growth model
#N_0 <- runif(1, min = 0, max = 9999) # generate random numbers for N_0
  
# Inputs:
N_0 <- 250
r <- .75
k <- 1200
e <- 2.71828
  
t_step <- 1
t_final <- seq(from = 0, to = 20, by= t_step)
####################
# Outputs:
N_t <- (k/(1 + ((k - N_0)/N_0)*e^(-r*t_final))) 
  
df <- data.frame(N_t = N_t, t_step = t_final) 
print(df)
  
plot(N_t, xlab="Time (years)", ylab="Population Size")
  
return(my_out)
}
########################################################3
# END FUNCTION



r_vec <- seq(0,1, by = .05)  # vector of little r's
container_vec <- rep(NA, length(r_vec)) # rep() = repeat      # storage for max(n)

for (i in seq_along(r_vec)){
  print(r_vec[i]) # this acts like a check
  temp_df <- log_growth(r = r_vec[i])
  max_n <- max(temp_df$N_t)  # might need to change N_t to population or smth- this takes the max value of the population vector- you can do averages, mins, etc
  #print(max_n)
  container_vec[i] <- max_n # storage is important and happening here! everytime you loop through and max value is chnging you still have the first value in there 

}

growthDF <- data.frame(r = r_vec, N_t  = container_vec)
container_vec
head(growthDF)
# Why am I getting NA values???

plot(x = growthDF$r, y = growthDF$N_t)  # this is supposed to look like log growth model, why does it look linear?


