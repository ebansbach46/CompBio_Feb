# probability distributions
# 4.21.26
# E Bansbach

```
discrete or continuous

discrete-modeling a process
K on x axis
discrete probabilities
functional outcome, more process based
like coin flips
kinda like a bar graph/histogram


continuous-normal distribution
bound from negative to positive infinity
more of the actual probability density function

-normal distribtuion; its center = mu, and st dev of the 2 parameters

4 things you can ask the distribution
1-probability density function pdf-how likely a value is to occur at any one of the points
2-cumulative density function (cdf)-like a population log graph levels off at the top
-probability of x being less than or equal to some value p(x<3)
3-Q quantile function-the inverse of p-> calc alpha values like 95% confidence intervals
4-R func-random # generation, take parameters of a distribution and output n numbers drawn from, creating synthetic values

other continuous distributions:
  -gamma, takes a shape and scale parameters, an estimate of the mean (mu = shape*scale)
   the variance = (shape*scale)^2
   bound 0 to positive infinity, and zero isn't included; can't use data with negative values or values of 0
   looks like a negative exponential-used for right skewed data
-beta distribution: bound 0 to 1, is continuous
  takes shape 1 and shape 2 (alpha and beta), get exponential or U shape or normal distribution
  very versitile with the types of graphs u can make
  if modeling probability, beta distributions best to make confidence intervals 
  good for probabilities and percentages

-discrete distributions:
-binomial: random var x and have integers on x axis, bound to infinity (must be discrete)
  at any point whats the probbability of having 2 of something
  used to model events (and other catagorical operations)
  sucess/failure -success = heads, failure = tails
  measuring x # of successes in y # of trials
-negative binomial: looks the same as binomial, but looks at it from a different direction
  models the # of trials you need to get one success
  more of a time based distribution
-possomd: k = random variable (x axis), probability on y axis
  has right skewed  look
  lambda = main param, average # of events for a given interval (a rate)
  large lamda - normal; small lamda exponential
  good for count data
```


# playing with prob. distributions in R

############################
# Function: my_histo
# Purpose: creates a ggplot histogram
# Requires: ggplot
# Input: x = a numeric vector
#        data_type= "cont" or "disc"
# Output: a ggplot histogram
############################
library(ggplot2)
my_histo <- function(x=NULL,data_type="cont") {
  if(is.null(x)) x=runif(1000)
  df <- data.frame(x=x) 

# if data are continuous bounded (0,1), adjust bins for histogram  
  if (data_type=="cont" & min(df$x) > 0 & max(df$x) < 1) {
  p1 <- ggplot(data=df) +
    aes(x=x) +
    geom_histogram(boundary=0,
                   binwidth=1/30,
                   color="black",
                   fill="goldenrod") +
    scale_x_continuous(limits=c(0,1))}  

  
# if data are continuous, but not bounded (0,1), use
# ggplot default bins
  if (data_type=="cont" & (min(df$x) < 0 | max(df$x) > 1)) {
  p1 <- ggplot(data=df) +
    aes(x=x) +
    geom_histogram(color="black",
                   fill="goldenrod")}

     
  

# if data are discrete integers, 
#  use geom_bar to create a histogram
if (data_type=="disc") {
  p1 <- ggplot(data=df) + 
    aes(x=x) +
    geom_bar(color="black",fill="goldenrod") }
  
print(p1)
} 
my_histo()   # random uniform distrib
my_histo(data_type="disc",x=rpois(1000,lambda=0.2)) # pass random # generator like plassond (lambda)
my_histo(data_type="cont",x=runif(1000))
my_histo(data_type="cont",x=rnorm(n=1000,mean=0,sd=1)) # standard normal distrib

############################
# Function: my_pdf
# Purpose: creates a ggplot probability density function
# Requires: ggplot
# Input: x = a numeric vector of x values
#        y = pdf values calculated for each value of x
#        data_type= "cont" or "disc"
# Output: a ggplot pdf
############################
my_pdf <- function(x=NULL,y=NULL,data_type="cont") {
  if(is.null(x) | is.null(y)) {
    x=seq(from=-3,to=3,length.out=100)
    y=dnorm(x) }
  
    df <- data.frame(x=x,y=y) 
    
    # for continuous distributions, 
    # plot the line for the pdf
    if(data_type=="cont") {
      p1 <- ggplot(data=df) +
        aes(x=x,y=y) +
      geom_line() +
        geom_area(fill = "cornflower blue") } 
    
    # for discrete distributions,
    # plot a bar for the probability at each value
    if (data_type=="disc") {
      p1 <- ggplot(data=df) + 
        aes(x=x,y=y) +
        geom_col(color="black",fill="cornflower blue") }
    print(p1)
}
my_pdf()
# y axis = density (how likely something is in a band), not values
my_x=seq(from=0,to=1,length.out=100) # take out 100 values
my_pdf(x=my_x,y=dbeta(x=my_x,shape1=15,shape2=10))
# calc the density of beta distrib (shape1=alpha,shape2=beta)

# density plassond distrib
my_pdf(x=0:10,y=dpois(x=0:10,lambda=1.1),data_type="disc")

# plossond #########################################
library(ggplot2)
library(MASS)
#-------------------------------------------------
# Poisson distribution
# Discrete X >= 0
# Random events with a constant rate lambda
# (observations per time or per unit area)
# Parameter lambda > 0

# "d" function generates probability density
hits <- 0:10
# density = lambda = 1
my_vec <- dpois(x=hits,lambda=1)
my_pdf(x=hits,y=my_vec,data_type="disc")

my_vec <- dpois(x=hits,lambda=2)
my_pdf(x=hits,y=my_vec,data_type="disc")

# now we have data, and we want to estimate the parameters
data <- c(100,100,104,99)
z <- fitdistr(data, "normal")
z
# z gives us the parameters, gives mean and st dev
# creating synthetic dataset:
hist(rnorm(n = 1000, mean=100.75, sd = 1.9))

# frog data
frog_data <- c(30.15,26.3,27.5,22.9,27.8,26.2)
frog_data
# fit normal to frog data:
z <- fitdistr(frog_data, "normal")
print(z)

## plot density func
x <- 1:100
frog_density <- dnorm(x=x, mean=26.8, sd=2.18) # dnorm= density normal distrib
# q plot
qplot(x, frog_density, geom="line")
# probability density

# gamma distrib
z <- fitdistr(frog_data, "gamma")
z  # gives us shape and rate
# gamma density
frog_gamma <-dgamma(x, shape=147.2, rate=5.5)
qplot(x, frog_gamma, geom="line")

# adding an outliar -> adds skewness
newFrogData <- c(frog_data, 0.05)
z <- fitdistr(newFrogData, "gamma")
z
frog_gamma <-dgamma(x, shape=0.8, rate=0.035)
qplot(x, frog_gamma, geom="line")


##############################################
# pasted from class notes-didnt cover
###########
sum(my_vec)  # sum of density function = 1.0 (total area under curve)

# sum is not quite 1 because we need more elements in hits:
hits <- 0:15
my_vec <- dpois(x=hits, lambda=2)
my_pdf(x=hits,y=my_vec,data_type="disc")
sum(my_vec)
# now the sum is correct

# for a Poisson distribution with lambda=2, 
# what is the probability that a single draw will yield X=0?

dpois(x=0,lambda=2)

# "p" function generates cumulative probability density; gives the 
# "lower tail" cumulative area of the distribution

hits <- 0:10
my_vec <- ppois(q=hits,lambda=2)
my_pdf(x=hits,y=my_vec,data_type="disc")


# for a Poisson distribution with lambda=2, 
# what is the probability of getting 1 or fewer hits?

ppois(q=1, lambda=2)


# We could also get this through dpois
p_0 <- dpois(x=0,lambda=2)
p_0
p_1 <- dpois(x=1,lambda=2)
p_1
p_0 + p_1


# The q function is the inverse of p
# What is the number of hits corresponding to 50% of the probability mass
qpois(p=0.5,lambda=2.5)
my_pdf(x=0:10,y=dpois(x=0:10,lambda=2.5),data_type="disc")

# but distribution is discrete, so this is not exact
ppois(q=2,lambda=2.5)

# finally, we can simulate individual values from a poisson
ran_pois <- rpois(n=1000,lambda=2.5)
my_histo(x=ran_pois,data_type="disc")


# for real or simulated data, we can use the quantile
# function to find the empirical  95% confidence interval on the data

quantile(x=ran_pois,probs=c(0.025,0.975))