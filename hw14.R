# Homework 14
# 4.22.26

library(tidyverse)
library(ggplot2)
library(psych)        
library(randomForest)
set.seed(1)

bee_data <- read_csv("Burnham_field_data_pathogens_wide.csv")
head(bee_data)

data(mpg)
head(mpg)
str(mpg)
```
PCA: numeric variables only, run bartletts before u run the pca(
  explicitly state dataset, question, hypotphpesis controlvs treatment design is good
)
incl interretation of plots/results for each step
random for: think about what response/predictors  make sens, calc oob error
```
# PCA ###########################################################
#Create a figure showing PC1 and PC2 with 95% CI ellipses
#Do you see good separation of your groups on either axis?

mpg_num <- mpg[, 8:9]  # og line
mpg_num <- mpg[, c(3,4,5,8,9)]


round(cor(mpg_num), 2)
bart <- cortest.bartlett(cor(mpg_num), n = nrow(mpg_num))
bart

pca <- prcomp(mpg_num, center = TRUE, scale. = TRUE) 
summary(pca)

###
eig <- pca$sdev^2
pve <- eig / sum(eig)

pca_var_table <- data.frame(
  PC = paste0("PC", 1:length(eig)),
  Eigenvalue = round(eig, 3),
  PVE = round(pve, 3),
  CumPVE = round(cumsum(pve), 3)
)
pca_var_table

###########
mpg_cyl <- mpg$cyl  # og
mpg_year <- mpg$year
mpg_manufacturer <- mpg$manufacturer


scores <- as.data.frame(pca$x)
scores$cyl <- mpg_cyl  # og
scores$manufacturer <- mpg_manufacturer 

#
pca_plot <- ggplot(scores, aes(PC1, PC2, color = manufacturer)) +  
  geom_point(size = 2.6, alpha = 0.85) +
  theme_minimal() +
  labs(title = "Car Manufacturers (mpg) PCA")

pca_plot + stat_ellipse()

# There is some variation in separation along the x-axis (PC1), but for the y-axis (PC2) there is not much separation occuring

pca_plot2 <- plot(eig, type = "b", pch = 19,
  xlab = "Principal component",
  ylab = "Eigenvalue",
  main = "Scree plot (MPG PCA)")


broken_stick <- function(p) sapply(1:p, function(k) sum(1/(k:p)) / p)
bs <- broken_stick(ncol(mpg_num))
retain <- data.frame(
  PC = paste0("PC", 1:length(pve)),
  ObservedPVE = round(pve, 3),
  BrokenStick = round(bs, 3),
  Keep = pve > bs
)
retain


## One PC is needed 
## Due to the steep difference in values on the scree plot for PC1 and PC2, and smaller eigen values for other PCs, the variance was explained by both of the PCs
## The bartletts test had a p-value of 2.044721e-272, which is statistically significant, showing there is a difference between groups  
    
pca$rotation
  
## The variables contributing the most to PC1 are displ, cyl, cty, and hwy
## The variable contributing the most to PC2 is year
  
  
  
# Random forest #######################################################
set.seed(42)
mpg$manufacturer<-as.factor(mpg$manufacturer)
class(mpg$manufacturer)

id_train <- sample(seq_len(nrow(mpg)), size = 0.7 * nrow(mpg))
train <- mpg[id_train, ]
test  <- mpg[-id_train, ]

# confusion matrix
set.seed(123)
rf <- randomForest(
  manufacturer ~ ., data = train,
  ntree = 500,
  mtry = 2,
  importance = TRUE
)
rf

###
pred <- predict(rf, newdata = test)
conf <- table(Observed = test$hwy, Predicted = pred)
conf

plot(rf, main = "Random forest OOB error vs city mpg")

importance(rf)

# OOB estimate of error rate = 24.54%
  
## Based on my confusion matrix, it was somewhat accurate at classifying, some car manufacturers were classified very accurately while others were less accurate
## The more abundant a car manufacturer it generally was more accurate when classified, and vice versa  

## Variables the most important based on:
## Mean Decrease Accuracy: model was the greatest value, then displ, drv, cty, then class.
## Mean Decrease Gini: model had the greatest value, then displ, class, cty, and highway.

# Summary and Output:
## My two models agreed a little bit on variable importance. Year was the most important with the PCAs but was only minorly important for random forest.
## model, displ, class, and fl were the most important variables for random forest, while displ, cyl, cty, hwy, and year were the most importat for the PCAs

## The random forest broke down the data more specifically for each car manufacturer, providing more data for each manufacturer, 
## while the PCA test only provided data for some of the variables for each PCA test, which seemed to get at more of an overview for each manufacturere, 
## while you could see much more variance in the data for many variables for each manufacturer with random forest
