```
readr = import and read tabular data
#tidyr- good for messy data to make ttidy each column is  a variable, each row is an observation, each cell is a single value
dplur does grammer for data manipulation (add new variables etc
stringr provies grammer for character/string manipulation
ggplot2 figures

SQL with sqldf package - search for trends/patterns in large datasets

posit cheatsheets

```
 
## dplyr lecture
# 2.25.26 (wednesday)
# dply is going to be used for data manipulation and structure your df
# filer(), arrange(), select(), summarize(), group_by(), mutate()

# start w/ built-in data set
library(tidyverse)
# filter and lag taken up by stats function; theres duplicates, so dplyr are going to mask the stats versions of filter and lag
# to specify the package your using, call on the package name
dplyr::filter()
stats::filter()

data(starwars)
class(starwars) # tells you the structure of the data
# tbl = table, similar to df, but they do less things (are less general)

head(starwars) # provides first 6 rows of dataset into console
tail(starwars) # last 6 rows
glimpse(starwars) # shows each column name and some basic info like what data type each column is

# cleaning up data set
# Base r has complete.cases function -> removes any rows with NA

# indexing has the form of [rows, columns]
starwarsClean<-starwars[complete.cases(starwars[,1:10]),] #first 10 colm
# starwarsClean, and starwars are both objects
# [] means indexing
# can check for NA w/ is.na()
is.na(starwarsClean[,1]) # looking through rows in first colm
anyNA(starwarsClean[,1:10]) # runs through the whole thing- are there any NA?

# filterr() function - subsets observations by their values
# uses <, <=, >=, ==, !
# logical operators like & and |
# filter automatically excludes NA, must ask specifically it to include NA if you want them
filter(starwarsClean, gender=="masculine" & height < 180) # str need to use " "

filter(starwarsClean, gender=="masculine", height < 180, height > 100)

filter(starwars, eye_color %in% c("blue", "brown")) #%in% is it applicable to multiple columns- eye colors blue OR brown
#filters for multiple different conditions: %in%


# arrange() reorder rows
arrange(starwarsClean, by=height) # arrange in ascending order by default, arrangeing " " by height
arrange(starwarsClean, by=desc(height)) # desc does by descending order
arrange(starwarsClean, height, desc(mass)) # additional columns will break ties in preceding columns

# select() choose variables based on their names/columns
starwarsClean[1:10,] # in base r
select(starwarsClean, 1:10)
# these two functions are equivalent
select(starwarsClean, name:homeworld) # select from column locations, select columns between name and homeworld
select(starwarsClean, -(films:starships)) # subsetting everything except these variables

# rrearrange columns
select(starwarsClean, homeworld, name, gender, species, everything())
# order things based on the order of these columns

select(starwarsClean, contains("color")) # looks at every column name and pulls out anything w color so hair color eye color
# contains() requires character strings, " "

# rename columns
select(starwars, haircolor=hair_color) # new name first it changes the second one
# haircolor is new, hair_color is old

# mutate() function creates new variables with functions of existing variables
# create a new column thats just the height divided by mass
mutate(starwarsClean, ratio=height/mass) # take height mass and divide them
# it takes the values and adds it to a new column at the end

starwars_lbs <- mutate(starwarsClean, mass_lbs=mass*2.2)

# you can use transmute() to just have the new variable that you want;just a single column
transmute(starwarsClean, mass_lbs=mass*2.2)

# summarize() and group_by() - collapse many values down to a single summary
summarize(starwarsClean, meanHeight=mean(height))
# summarize() wont work if dataset isn't clean, like if theres any NA present
summarize(starwars, meanHeight=mean(height))
# to fix that:
summarize(starwars, meanHeight=mean(height, na.rm=TRUE), TotalNumber=n())
# used 87 rows to get the mean height value, and removed rows with NA's

# use group_by() for additional calculations
starwarsGender <- group_by(starwars, gender)
summarize(starwarsGender, meanHeight=mean(height, na.rm=TRUE), number=n())
# seperate by feminin masc and NA values, then mean height is calc for the avg for each of the 3 groups

# pipe statements - use pipe operator which is %>%, or |>
# something that will chain together diff functions or actions in a particular sequence
# these are sequences of actions that will change your dataset
# its going to pass intermediate results onto the next function in your sequence
# use if you have one object but want to do a bunch of things to this one object
# avoid using this when you need to manipulate more than one object, or if there are
#     meaningful intermediate objects
# formatting: always have a space before it and usually an automatic indent
starwarsClean%>%
  group_by(gender)%>%
  summarize(meanHeight=mean(height, na.rm=TRUE), number=n())

# case_when() when want to do multiple conditional if else statements
starwarsClean%>%
  mutate(sp=case_when(species=="Human"~"Human", TRUE ~ "Non-human"))%>%
  select(name, sp, everything())
# look at species coumn, if each row is human label it as human
# , means if smth is not true label it as smth else
# if smth is non human, label it as something else

# this code isn't storing anything, so need to store it as an object
newdf <- starwarsClean%>%
  mutate(sp=case_when(species=="Human"~"Human", TRUE ~ "Non-human"))%>%
  select(name, sp, everything())
unique(starwarsClean$species)

glimpse(starwarsClean)
# each row is an individual, and have many colums (a long format)
# make dataset wide with pivot statements
# pivot from long to wide format using pivot_wider() or pivot_longer
wideSW <- starwarsClean%>%
  select(name,sex,height)%>%
  pivot_wider(names_from=sex, values_from=height, values_fill=NA)
wideSW
# takes the names from the sex column and making them into their own columns

pivotSW <- starwars%>%
  select(name, homeworld)%>%
  group_by(homeworld)%>%
  mutate(rn=row_number())%>%
  ungroup()%>%
  pivot_wider(names_from=homeworld, values_from=name)
# names from homeworld, values from name
pivotSW

wideSW%>%
  pivot_longer(cols=male:female, names_to="sex", values_to="height",
  values_drop_na=TRUE)

#########################################################################
# Homework 7

library(tidyverse)
data(iris)

class(iris)
# 1) There are 5 different variables and 150 observations
# 2) There are 56 observations and 3 variables
iris1 <- iris[complete.cases(iris[150,5]),]
#filter(iris, Species=="virginica", Species=="versicolor", Sepal.Length > 6, Sepal.Width > 2.5)
# virginica and versicolor with sepal lengths longer than 6 cm and sepal widths longer than 2.5 cm. 
filter(iris, Species=="virginica", Sepal.Length > 6, Sepal.Width > 2.5| Species=="versicolor", Sepal.Length > 6, Sepal.Width > 2.5)
#filter(iris, Species =="virginica")
#filter(iris, Species =="versicolor")
###########
iris1 <- filter(iris, Species=="virginica", Sepal.Length > 6, Sepal.Width > 2.5| Species=="versicolor", Sepal.Length > 6, Sepal.Width > 2.5)
select(iris1, -(Petal.Length:Petal.Width))

########################


filter(iris, Species=="versicolor", Sepal.Length > 6, Sepal.Width > 2.5)
filter(iris, Species=="virginica", Sepal.Length > 6, Sepal.Width > 2.5)

select(iris, -(Petal.Length:Petal.Width))%>%
  filter(iris, Species=="versicolor", Sepal.Length > 6, Sepal.Width > 2.5)%>%
  filter(iris, Species=="virginica", Sepal.Length > 6, Sepal.Width > 2.5)

iris1 <- iris %>%
  select(iris, -(Petal.Length:Petal.Width))%>%
  filter(iris, Species=="versicolor", Sepal.Length > 6, Sepal.Width > 2.5)%>%
  filter(iris, Species=="virginica", Sepal.Length > 6, Sepal.Width > 2.5)
# working on:
# changing column names; getting error Sepal.Length must be a logical vector, not a double vector
select(iris, sepal_length=Sepal.Length)
select(iris, sepal_width=Sepal.Width)
iris1 <- iris%>%
  filter(iris, Species=="versicolor", sepal_length > 6, sepal_width > 2.5)%>%
  filter(iris, Species=="virginica", sepal_length > 6, sepal_width > 2.5)%>%
  select(iris, -(Petal.Length:Petal.Width))
iris1

iris%>%
  filter(iris, Species=="versicolor", sepal_length > 6, sepal_width > 2.5)%>%
  filter(iris, Species=="virginica", sepal_length > 6, sepal_width > 2.5)%>%
  select(iris, -(Petal.Length:Petal.Width))

iris%>%
  select(iris, Species=="versicolor", sepal_length > 6, sepal_width > 2.5)%>%
  select(iris, Species=="virginica", sepal_length > 6, sepal_width > 2.5)%>%
  select(iris, -(Petal.Length:Petal.Width))

#####
iris0 <- filter(iris, Species=="virginica", Sepal.Length > 6, Sepal.Width > 2.5| Species=="versicolor", Sepal.Length > 6, Sepal.Width > 2.5)
iris0
iris1 <-select(iris0, -(Petal.Length:Petal.Width))
iris1

# 3)
iris2 <- group_by(iris1, Species, Sepal.Length, Sepal.Width)
select(iris2, Species, Sepal.Length, Sepal.Width)

  
  
  
  