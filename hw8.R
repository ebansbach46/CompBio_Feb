# Homework 8
# 3.4.26

library(ggplot2)
set.seed(1000)

# Question 1
zero_sum <- function(num_vec){
  counter <- 0

  for (i in seq_along(num_vec)){
    if (num_vec[i] == 0){
      counter <- counter + 1
    }

  }
  return(counter)
}

zero_vec <- sample(0:10, 100, replace = TRUE)
num_zero <- zero_sum(zero_vec)
print(num_zero)

# Question 2
sum_zero <- sum(zero_vec == 0)
print(sum_zero)

# Question 3 **********************************************
row_col_mat <- function(x = 3, y = 4){
  r_vec <- c(1:x)
  c_vec <- c(1:y)
  mat <- matrix(n_row = x, n_col = y)
  
  
  for (i in r_vec){
    for (j in c_vec){
      mat[i,j] <- r_vec[i] * c_vec[j]
    }
  }
  return(mat) 
}
print(row_col_mat())

# Question 4
# a)
data1 <-rnorm(n = 3, mean = 10)
data2 <-rnorm(n = 3, mean = 20)
data3 <-rnorm(n = 3, mean = 30)

group <- c(rep(data1))

df <- data.frame(
  
)