# file batch processing on multi-files
# 4.28.26 notes

# summarizes files into tables

# batch_proc new repo

#########################################################
# load libraries
library(upscaler)
# in console: add_folder()   # sets up directory
# in console: add_folder("CleanedData/ToyDataFiles") #in cleaned data folder creating a new folder within it

build_function("create_toy_data_files")
# function is created in the functions folder

# paste the function below into this file, replace the auto function thing generated in it
```
# --------------------------------------
# FUNCTION create_toy_data_files
# required packages: none
# description: build set of toy .csv files
# inputs: number of files,max rows,max col
# outputs: a set of .csv files in a new subfolder
########################################
create_toy_data_files <- function(nrow=NULL,
                               ncol=NULL,
                               nfiles=NULL){
  
  # assign parameter defaults
  if (is.null(nrow) | is.null(ncol) | is.null(nfiles)){
    nrow=10
    ncol=9
    nfiles=6
  }
  
  # build file labels
  file_labels <- upscaler::create_padded_labels(n=nfiles,
                                      string="Toy_Data",
                                      suffix=".csv") 
  
  # run for loop
  
  for (i in 1:nfiles) {
    df <- as.data.frame(matrix(runif(nrow*ncol),
                               nrow=nrow,
                               ncol=ncol))
    write.table(df,file=paste("CleanedData/ToyDataFiles/",
                              file_labels[i],sep=""),
                              sep=",")
    
  }
  
  
  
  
  return()
  
} # end of function CreateToyDataFiles
# --------------------------------------
# create_toy_data_files()
```

###########################################
build_function("crunch_data")
build_function("filebatchr")

# remove template in crunch data, replace w/ the notes
# same thing in filebatchr

# looking at toydatafiles:
# looking at crunchdata: analysis is done in this file
# function body, where you do your calculations and statistical analysis
# filebatchr-looks at multiple files, needs a function to be passed to it (aka crunchdata)
# functions use other functions, cleanly pass operations, passing outputs of functions into other functions
# maybe does some looping


# driver/main script/file
library(upscaler)
library(ggplot)
# initial ops
set_up_log()
source_batch(folder = "Functions")

# create data
create_toy_data_files(nrow = 15, ncol = 10, nfiles = 8)  

# create global variables
file_names <- as.list(list.files(pattern="\\.csv$",
           path="CleanedData/ToyDataFiles",
           full.names=TRUE))
crunch_cols <- list(4,5)
param_names <- list("avg","skew","weird")
# finds everything that is contained that ends in ".csv" that lives in cleaned data toy data files
# can do this w/ ".tif", or pull from repositories

# file.names -> type into console
# gives the full path of the file

crunch_cols <- list(4, 5)  # originally just "crunch"

param_names <- list("avg", "skew", "weird")
######################### ########################## ##############################

z <- lapply(file_names, read.table, sep = ",")
z  # a list of opened csv files, aka df's that live in a list
lapply(z, crunch_data)  # list within a list
# gives outputs for summary stats like avg, skew, and weird for each file


# do the work in a for loop
output_df <- as.data.frame(matrix(rep(NA,length(file_names)*length(param_names)),nrow=length(file_names),ncol=length(param_names)))
names(output_df)=param_names

nobs <- rep(NA,length(file_names)) # empty vector for row counts
for (i in 1:length(file_names)) {
  df <- read.table(file=file_names[[i]],
                   header=TRUE,
                   sep=",")
  . <- crunch_data(df=df,  # "." good for reserved data sets that are temporary
                   crunch_cols=unlist(crunch_cols),
                   param_names=param_names)

  output_df[i,] <- .
  nobs[i] <- nrow(df)
}
output_df

# add initial metadata columns (ID,filename,nobs)
output_df <- cbind(ID=1:length(file_names),file=basename(unlist(file_names)),nobs=nobs,output_df)

output_df

# one line to do this all, lapply takes 2 lines, the loop was lots of code
filebatchr(file_names=file_names,
                fun=crunch_data,
                crunch_cols=crunch_cols,
                param_names=param_names)
# function names have same name as global variable; one is global variable the other is local
# much cleaner to have this one line in the driver scripts