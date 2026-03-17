# Homework 7

library(dplyr)
library(tidyverse)
data(iris)
str(iris)
class(iris)

# 1) There are 5 different variables and 150 observations
# 2) There are 56 observations and 3 variables
iris1 <- iris%>%
  filter(Species != "setosa" & Sepal.Length > 6 & Sepal.Width > 2.5)
str(iris1)
# there are 56 observations and 5 variables

# 3)
iris2 <- iris1%>%
  select(Species, Sepal.Length, Sepal.Width)
str(iris2)
# there are 56 observations and 3 variables

# 4)
iris3 <- iris2%>%
  arrange(desc(Sepal.Length))
head(iris3)

# 5)
iris4 <- iris3%>%
  mutate(iris3, Sepal.Area=Sepal.Length*Sepal.Width)
str(iris4)
# theres 56 observations and 4 variables

# 6)
iris5 <- iris4%>%
  summarise(avg.Sepal.Width = mean(Sepal.Width), avg.Sepal.Length = mean(Sepal.Length),
  avg.Sepal.Area = mean(Sepal.Area), samp.size = n())
print(iris5)

# 7)
iris6 <- iris4%>%
  group_by(Species)%>%
  summarise(Average.Sepal.Length = mean(Sepal.Length), Average.Sepal.Width = mean(Sepal.Width),
  Average.Sepal.Area = mean(Sepal.Area), samp.size = n())
print(iris6)

# 8)
irisFinal <- iris%>%
  filter(Species != "setosa" & Sepal.Length > 6, Sepal.Width > 2.5)%>%
  select(Species, Sepal.Length, Sepal.Width)%>%
  arrange(desc(Sepal.Length))%>%
  mutate(Sepal.Area = Sepal.Length*Sepal.Width)%>%
  group_by(Species)%>%
  summarise(Average.Sepal.Length = mean(Sepal.Length), Average.Sepal.Width = mean(Sepal.Width),
  Average.Sepal.Area = mean(Sepal.Area), samp.size = n())
print(irisFinal)
str(irisFinal)

# 9)
irisLong <- iris%>%
  pivot_longer(cols=c(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width),
  names_to="Measure", values_to="Value")
str(irisLong)
print(irisLong)
head(irisLong)
