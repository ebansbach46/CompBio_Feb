## Homework 4 
## 2.4.26
# Question 1
n_dims <- sample(3:10, 1)
n_dims

seq(from=1, to=n_dims^2)
n_dims2 <- seq(from=1, to=n_dims^2)
n_dims2

sample(n_dims^2)
shuffled <- sample(n_dims^2)

mat <- matrix(data=shuffled, nrow = n_dims, ncol=n_dims)
print(mat)

t_mat <- t(mat)
print(t_mat)
#the matrix values changed, as the values for row 1 are now the values in column 1, and so forth
#m_dframe <- as.data.frame(mat)


rowSums(t_mat)
### t_mat(rowSums(t_mat)==1,n_dims)
firstrow <- t_mat[1,]
print(sum(firstrow))
print(mean(firstrow))
lastrow <-t_mat[, n_dims]
print(sum(lastrow))
print(mean(lastrow))

##
eigen(t_mat,symmetric = FALSE, only.values = TRUE, EISPACK = FALSE)

m <- matrix(t_mat, nrow = n_dims, ncol = n_dims)
m

results <- eigen(m)
m
eigenvalues <- results$values
eigenvectors <- results$vectors
print(eigenvalues)
print(eigenvectors)
###eigen $values and $vectors are imaginary numbers
typeof(eigenvalues)
typeof(eigenvectors)
# they are complex

###### Question 2 ######################################################
my_matrix <- matrix(runif(0:1), nrow = 4, ncol = 4)
my_matrix

z <- runif(100, min=0, max=1)
my_logical <- z > 0.5
print(my_logical)

my_letters <- c("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z")
#my_letters <- letters # I think this line of code is uneccessary
my_letters 


my <- list(my_matrix[2,2], my_logical[2], my_letters[2])
print(my)

typeof(my_matrix)
typeof(my_logical)
typeof(my_letters)

typeof(c(my_matrix, my_logical, my_letters))
# the typeof function is only looking at one part of the list, not the 3 individul vectors
my_vector <- c(my_matrix[[1]], my_logical[[2]], my_letters[[3]])
print(my_vector)
# the data type of this vector has a double (my_matrix), character (my_logical), and character (my_letter) data types in the vector

##### Question 3 ###########################################
# need to create a df
column <- 
row <-

df <- data.frame(ncol = 2, nrow = 26)
print(df)

# When to use the sample function vs runif?
#my_unis <- sample(0:10, 26, replace = TRUE)
#print(my_unis)

my_unis <- runif(26, min=0, max=10)
my_unis
my_letters <- sample(LETTERS, 26)
my_letters
# NOW you create the df
df <- data.frame(my_unis, my_letters, stringsAsFactors=FALSE)
df
df[sample(length(my_unis), size = 4, replace = FALSE), 1] <- NA

which(!complete.cases(my_df$my_unis))

df <- df[order(df$my_letters),]

mean(df$my_unis, na.rm = TRUE)
##############################################################


