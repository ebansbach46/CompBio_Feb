## 2.3.26 Class Notes

## writing data frames
write.csv(df3, "data/my_dataframecsv")

data <- read.csv("data/my_dataframe.csv")

data$var_a

# distinction btw DFs and Mat Dims

z_mat <- matrix(data = 1:30, ncol = 3, byrow = T)

z_dframe <- as.data.frame(z_mat) # turn into DF

str(z_mat)
str(z_dframe)

head(z_dframe)
head(z_mat) #subset of matrix-show positional indexing [x,]  x=all empty rows/columns

z_mat[1,1] #first element in first column
z_dframe[2,2] #not best way to do this
z_dframe$V2[2] #do it this way for data frame

# column referencing
z_dframe$V1
z_dframe[,3] #give column
z_mat[,3]

# one dimension referencing
z_mat[2]
z_dframe[2] #gives the second vector
#coerced things into atomic vector when in one dimension, don't shorthand

# missing data in DFs and matricies
zd <- runif(10) #gives 10 values
zd

#add a couple of missing values
zd[c(5,7)] <- NA
print(zd)

# complete cases
complete.cases(zd)

# filter for only True
zd[complete.cases(zd)]

# which positions are missing?
which(complete.cases(zd))
#shows indexes w/ a complete case

# not complete cases is ! - good for filtering data and running diagnostics on data
which(!complete.cases(zd))

# missing data in a matrix
m <- matrix(1:20, nrow = 5) #values 1-20
print(m)

# add missing data
m[1,1] <- NA
m[5,4] <- NA
m
#to do this in one line
m[c(1,5),c(1,4)] <- NA   #these #s arent right
m

m[complete.cases(m),]
#given it 1 position in 2D field, the , maintains dimensionality
#gives only the rows which all values are held here

# now get only complete cases for only certain columns
m[complete.cases(m[,c(1,2)]),] #specfify structure want complete cases for
#drops first row

m[,c(1,2)]

complete.cases(m[,c(1,2)])

# no drops
m[complete.cases(m[,c(2,3)]),] #no drops
m[,c(2,3)]


m[complete.cases(m[,c(3,4)]),] #drops row 4
m[,c(3,4)]

#c(1,4)... drops 1 and 4


# Subsetting mats and data frames
m <- matrix(data=1:12, nrow=3)

dimnames(m) <- list(paste("Species",LETTERS[1:nrow(m)],sep=""),paste("Site", 1:ncol(m))) #refer to notes for end of the line of code
dimnames(m) <- list(paste("Species",LETTERS[1:nrow(m)],sep=""),paste("Site",1:ncol(m),sep=""))

ncol(m)
nrow(m)
print(m)

LETTERS[1:nrow(m)]

# element wise subsetting
m[1:2, 3:4] #useing multiple col and rows
m[c("Species A", "Species B"),c("Site 3", "Site 4")]

m[1:2,] #rows 1 and 2
m[,3:4]  #colm 3 and 4

# using logical for subsetting
colSums(m) #sums for each col
colSums(m) > 15
colSums(m) >= 15
# gives boolean output
# if wanted to select for those cols:
sums <-colSums(m)
sums[sums > 15]
##colSums(m)[colSums(m) > 15] does same thing as line 118 aka line above this

rowSums(m)

m[rowSums(m)==22, ] # == pulls out only that one row
m

m[!rowSums(m)==22, ]

m[,"Site1"]
m[,"Site1"]<3

# data curation
# put metadata within csv file!
# in csv: use # to create notation for each column
# write the start and stop of sections

my_data <- read.table(file="path/testData.csv",
                    header=TRUE,
                    sep=",",
                    comment.char="#") # # signals using # as comments

#testData is the csv file name

head(my_data)

