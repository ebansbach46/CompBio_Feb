# Basics of SQL
# 2.26.26

library(tidyverse)
library(sqldf)
install.packages("sqldf")

# read in the data set
species_clean <- read.csv("site_by_species.csv")

getwd() # find current working directory
setwd() # tell it what file location want to find it, change working directory to correct repo

var_clean <- read.csv("site_by_variables.csv")
head(species_clean)

# start with operations/functions on just one file
# subsetting rows
# dplyr: use filer()
species <- filter(species_clean, Site < 30) # get all of the sites less than 30
species
var <- filter(var_clean, Site < 30)

# look online at SQL commands

# SQL method- first need to specify a query you'll use, then run the sqldf()
query <- "SELECT Site, Sp1, Sp2, Sp3 FROM species WHERE Site < '30'"
# SELECT specific columns, FROM a specific data/object, WHERE filters out for a condition

sqldf(query)

#dplyr for subsetting columns
edit_species <- species %>%
  select(Site, Sp1, Sp2, Sp3)

edit_species2 <- species %>%
  select(1,2,3,4) # calling on column names/positions are equivelant

# query the entire table
query <- "SELECT * FROM species"
a <- sqldf(query)

# renaming columns
# in dplyr you would just use rename()
species <- rename(species, Long=Longitude.x., Lat=Latitude.y.)
head(species)

# if doing this in SQL, you can use the AS command
query <- "SELECT Long AS Longitude FROM species"
sqldf(query)

# pull out all the numeric columns
num_species <- species%>%
  mutate(letters=rep(letters, length.out=length(species$Site)))
num_species <- select(num_species, Site, Long, Lat, Sp1, letters)
num_species

num_species_edit <- select(num_species, where(is.numeric)) # look and keep anything that is numeric, removing letters colm
num_species_edit

# pivot longer to lengthen data, decreasing the number of columns and increasing the number of rows
# may see gather()/spread() in other code, but thats outdated
species_long <- pivot_longer(edit_species, cols=c(Sp1, Sp2, Sp3), names_to="ID") # Sp1 to Sp3 are columns being put into rows, making a column that doesn't preexist o yet so ID has  ""
species_wide <- pivot_wider(species_long, names_from=ID) # colum is preexisting 

# Aggregation of data, getting kinds of calculations from data
#SQL
query <- "SELECT SUM(Sp1+Sp2+Sp3) FROM species_wide GROUP BY SITE" # gives sum by occurance
sqldf(query)

query <- "SELECT SUM(Sp1+Sp2+Sp3) AS Occurence FROM species_wide GROUP BY SITE"
sqldf(query)

# 2 file operations joining data sets together
# joining things can often be left/right/union joins
# tidyverse dplyr cheat sheet

# start with clean versions of these variables
edit_species <- species_clean%>%
  filter(Site<30)%>%
  select(Site, Sp1, Sp2, Sp3, Sp4, Longitude.x., Latitude.y.)
edit_var <- var_clean%>%
  filter(Site<30)%>%
  select(Site, Longitude.x., Latitude.y., BIO1_Annual_mean_temperature)
# left join stitching the matching rows from file B to file A -it requires a matching/marker column to link the 2 data sets
left <-left_join(edit_species, edit_var, by="Site")
right <- right_join(edit_species, edit_var, by="Site")

inner <- inner_join(edit_species, edit_var, by="Site") # retains the rows that match btw both files, it loses a lot of info if they aren't matching

# full joins are the opposite retaining all values, but you have a trade-off of having lots of NA's instead of missing data
full <- full_join(edit_species, edit_var, by="Site")

#SQL method for joining data
query <- "SELECT * FROM edit_var RIGHT JOIN edit_species ON edit_var.Site=edit_species.Site;"
x <- sqldf(query)

