# statistical machine learning
# 4.16.26

```
principal component analysis (PCA)
-doesn't know the correct values to begin with
-unsupervised
-understand variance, and partition them into 2 (or 2-3) synthetic variables
-dimensionality reduction
-NMDS similar
-PCA linear classifier assumes a normal distribution
-dont know the difference, have lots of variables

IDs: 1, 2,3,4
Class: 0,0,1,1
x1:
x2:
xg:
-want to reduce x var into 2-3 var, and spits out pc's
PC1 = a1x1 + a2x2...agxg
PC2
PC1 on x axis, PC2 on y axis
looking for a large value-if poitive its a positive relationship, vce versa
-variance will start to drop off (variance in %%)


####################################################

Random forest-knows the correct values to begin with
-random categories
-supervised
-classifier- know the variable group memberships ahead of time creating trainer data, 
and take in new data and classify it based off of the trainer data
-uses decision trees
-can tell you if your variables arent good, if you dont get data from this

-logical statement for each node of decision tree (eg. x1 < 3)
-ask for every value in x1 if its less than 3: if yes its a leaf if not it hits other statements and keeps asking questions
-keep going until only end up with leaves

-what if there were more than 1 tree
-takes random variabales
D1  ID sample 1, 1, 4, 2
x3 
x5
bootstrapping
-for each one a separate decision tree is created
-each tree diff b/c each tree seeing different data
D1000
-predict group membership

```

# For reproducible results
set.seed(1)

# Packages used today
library(ggplot2)
library(psych)        # Bartlett's test
library(randomForest) # Random forest
# install psych and random

# Data
data(iris)
str(iris)

# Data
iris_num <- iris[, 1:4]
iris_species <- iris$Species

round(cor(iris_num), 2) # correlation matrix for numeric data set
# 1.00 == 100% correlation

bart <- cortest.bartlett(cor(iris_num), n = nrow(iris_num)) # gave it the group membership here
bart
# tells you if correlation matrix differ from og/other data set

# fit the pca model:
pca <- prcomp(iris_num, center = TRUE, scale. = TRUE) # numeric data set w no membership values here (iris_num)
summary(pca)
# gives proportion of variance for each pca
# PCA2 give 22.85% of variance
# 3% of variance is not a lot PCA3

# ccalculate eigen values
eig <- pca$sdev^2
pve <- eig / sum(eig)

pca_var_table <- data.frame(
  PC = paste0("PC", 1:length(eig)),
  Eigenvalue = round(eig, 3),
  PVE = round(pve, 3),
  CumPVE = round(cumsum(pve), 3)
)
pca_var_table
# principle variance explained = PVE
# cumulative PVE
# high eigen = correlated with greater variance (right?)

# scree plot
plot(eig, type = "b", pch = 19,
     xlab = "Principal component",
     ylab = "Eigenvalue",
     main = "Scree plot (iris PCA)")
# scree plots have an elbow
# take pc 1 and 2; leave 3 and 4 behind

# broken stick test
broken_stick <- function(p) sapply(1:p, function(k) sum(1/(k:p)) / p)
bs <- broken_stick(ncol(iris_num))

retain <- data.frame(
  PC = paste0("PC", 1:length(pve)),
  ObservedPVE = round(pve, 3),
  BrokenStick = round(bs, 3),
  Keep = pve > bs
)
retain
# tells you which pc's to use and leave behind
# only keep pc1 here, but we are gonna keep pc2 for now for fun

# looking at the pc values:
head(pca$x)
# loadings (weights or coefficients)= a, and the scores we look at
# scores are the points on the plot, loadings describe how importantp a variable is to the variance
# head(pca$x) gives us the scores for each id
# ID # is the colum on the left [1,], etc

# pca$rotation

# make the plot
scores <- as.data.frame(pca$x)
scores$Species <- iris_species

plt <- ggplot(scores, aes(PC1, PC2, color = Species)) +
  geom_point(size = 2.6, alpha = 0.85) +
  theme_minimal() +
  labs(title = "PCA on iris", subtitle = "PCA is unsupervised; species used only for coloring")

plt + stat_ellipse() # 95% CI

# only looking at pc2 - hard to see any difference in this data, but you can see the diff w pc1
# ellipses = 95% confidnece interval


man <- manova(cbind(PC1, PC2) ~ Species, data = scores)
summary(man, test = "Pillai")
# man = manova test
# p val less than 0.05 -> there is a signif diff based on the pca test

# loadings tell you what are the most significant
# .8 -> highly important to the pc, aka where the greatest separation is coming from
# petal length and width were the biggest contributor
# negative loading value - take the absolute value, negative implies negative relationship


##############################################################
# Random forests

set.seed(42)
id_train <- sample(seq_len(nrow(iris)), size = 0.7 * nrow(iris))
train <- iris[id_train, ] # the data set were going to train the model on (70% of data)
test  <- iris[-id_train, ] # the data set thats new data to the model (30% of data)

# random classifier - our model
set.seed(123)
rf <- randomForest(
  Species ~ ., data = train, # species as a function of everything thats in there ( . = all the other data)
  ntree = 500,
  mtry = 2,  # # of features were selecting for; use square root of the number of features you have; sq root of 4 is 2, so mtry = 2
  importance = TRUE
)
rf
# OOB out of bag error
# confusion matrix = whether the algorithim got group classification correct
# vesicolor 33 correctly identified as versicolor, 4 identified incorrect

# evaluate:
pred <- predict(rf, newdata = test) # creating predictions on the new data
conf <- table(Observed = test$Species, Predicted = pred)
conf
# putting in the new data that we held out into the model

# how accurate was the model - the % accuracy of the model based on the test data
acc <- mean(pred == test$Species)
acc
#0.955 is pretty good accuracy

# oob plot
plot(rf, main = "Random forest OOB error vs number of trees")
# plot # of trees and error associated w/ each iteration calculated
# steep increase then plateau quickly
# probably only needed 100 trees (it plateaued quickly)

# importance
importance(rf)
# each variable for rows
# look at mean decrease accuracy and gini
# want high accuracy and gini
# accuracy: how well each variable contributed to the prediction power
# gini: how well it contributed to the predictive separation into each class
# both used to determine which variables mattered most to the classification

# importance plot
varImpPlot(rf)
# things that are further to the right are more important
# accuracy: petal length and width most important
# gini: petal length and width most important

