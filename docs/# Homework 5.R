# Homework 5
# 2.11.2026
# Elizabeth Bansbach

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

