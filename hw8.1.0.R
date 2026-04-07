# Homework 8
# 3.4.26

# For loops and randomizaton tests
# null-no diff (h0)
# H1 is diff

# randomization tests lecture #21
# use sample to shuffle
# 'read in data' use as backbone


library(ggplot2)
set.seed(1000)

# 1)
times <- 100
n_vec <- sample(0:2, 100, replace = TRUE)
counter <- 0

n_sum <- function(n_vec){
  for (i in 1:times){
    if(n_vec[i] == 0){
      counter <- counter + 1 
    }
  }
  return(counter) 
}

n_sum(n_vec)

# 2)
#sub_vec <- n_sum
for (i in n_vec(n_sum)){
  n_sum[i, ] <- n_sum[i, ] + i

}

n_sum <- function(n_vec){
  for (i in n_vec(n_sum)){
  n_sum[i, ] <- n_sum[i, ] + i

}
return(n_sum)
}
##############
for (i in n_sum(n_vec)){
  n_vec[i, ] <- n_vec[i, ] + i

}
###
for (i in 1:times){
  n_vec[i, ] <- n_vec[i, ] + i


}

# 3)
row = 2
col = 3

mat_func <- function(nrow=2, ncol=3){
  mat <- matrix(nrow=nrow, ncol = ncol)
  for (i in 1:nrow){
    for (j in 1:ncol) {
      mat[i,j] <-j*i
  
    }
  
  }
  return(mat)
} 

mat_func(10,6)

#print(mat_func) 
#print(mat)

# 4)
library(ggplot2)
set.seed(1000)
# a)
group1 <- 2
group2 <- 7
group3 <- 10

groups <- c(rep("group1",2), rep("group2", 7), rep("group3", 10))


####### idk: the 'read me'
read_data <- function(z=NULL) {

  if(is.null(z)){
    x_obs <- 1:20
    y_obs <- x_obs + 10*rnorm(20)
    df <- data.frame(x_obs, y_obs)
  } 
  else { 
    df <-read.table(file=z, header=TRUE, sep=",")}

return(df)
}
