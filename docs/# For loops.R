# For loops
# basic codin with for loops
# 2.10.2026
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

