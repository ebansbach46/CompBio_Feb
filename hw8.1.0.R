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

n_sum <- function(n_vec){
  counter <- 0
  for (i in 1:times){
    if(n_vec[i] == 0){
      counter <- counter + 1 
    }
  }
  return(counter) 
}

n_sum(n_vec)

# 2)
sum_zero <- sum(n_vec == 0)
print(sum_zero)

# 3)
mat_func <- function(row=6, col=3){
  mat <- matrix(nrow=row, ncol = col)
  for (i in 1:row){
    for (j in 1:col) {
      mat[i,j] <-j*i
  
    }
  
  }
  return(mat)
} 

mat_func()

# 4)
library(ggplot2)
set.seed(1000)
# a)
group1 <- 2
group2 <- 7
group3 <- 10

groups <- c(rep("group1",2), rep("group2", 7), rep("group3", 10))
print(groups)

z <- c(runif(2) + 1, runif(7) + 6, + runif(10) + 14)
print(z)

df <- data.frame(grouping = groups, res=z)
print(df)

obs_means <- tapply(df$res,df$grouping,mean)###
print(obs_means)

# b)
library(dplyr)
shuffler <- function(df){
  reshuff <- sample(df$res)
  df2 <- data.frame(
    groups = df$grouping,
    response = reshuff
  )
  summary <- df2 |>
    group_by(groups) |>
    summarize(meanResponse = mean(response))

  return(summary$meanResponse)
}
shuffler(df)

# c)
n_run <- 100
df2 <- data.frame(
  rep = 1:n_run,
  group1mean = NA,
  group2mean = NA,
  group3mean = NA

)

for (i in 1:n_run){
  group_means_rep <- shuffler(df)
  df2$group1mean[i] = group_means_rep[1]
  df2$group2mean[i] = group_means_rep[2]
  df2$group3mean[i] = group_means_rep[3]

}

g1 <- data.frame(mean = df2$group1mean)   
g2 <- data.frame(mean = df2$group2mean)
g3 <- data.frame(mean = df2$group3mean)

# d
g1 <- ggplot(data = df2, aes(x = group1mean)) +
  geom_histogram(bins = 20, fill = "cornflowerblue", color = "black") +
  labs(title = "Group 1 Reshuffled Means",
       x = "Mean values",
       y = "Count")
print(g1)

g2 <- ggplot(data = df2, aes(x = group2mean)) +
  geom_histogram(bins = 20, fill = "darksalmon", color = "black") +
  labs(title = "Group 2 Reshuffled Means",
       x = "Mean values",
       y = "Count")
print(g2)

g3 <- ggplot(data = df2, aes(x = group3mean)) +
  geom_histogram(bins = 20, fill = "darkolivegreen3", color = "black") +
  labs(title = "Group 3 Reshuffled Means",
       x = "Mean values",
       y = "Count")
print(g3)
