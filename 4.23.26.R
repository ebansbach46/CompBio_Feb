# strategic coding tools
# 4.23.26

# ----
library(pracma)
library(devtools)
# install.packages("devtools")
install_github("n/gotelli/upscaler")
install_github("hadley/pryr")
install_github("ebansbach46/upscalar_demo")
library(pryr)
library(pracma)
library(upscaler)

# users owners downloads   -> github folder


# folder structure
add_folder()  # folders added to the environment
# original data = raw data, data from pcr machine, field notes etc; should never be touched!!!!!
# source them into terminal then clean them up

# functions; contain functions that are sourced and driven by the driver script, contain inputs and outputs
# rmarkdown: contain notes or statistical report 
# outputs: tables, other data sets etc, statistical outputs
# plots: specifically for figures
# scripts: where other scripts live; python scripts, etc, scripts you want to have version control for
# add_folder("any name for a folder")
add_folder("Documents")

# help(package="upscaler") -> into console

metadata_template(file = "OriginalData/MyData.csv")  # created a csv file in the folder

data_table_template(data_frame = NULL, file_name = "Outputs/TableA.csv") #use a df for the data input
#df=null -> sets up a fake example for u

# padding label names
create_padded_labels(n=10,  strings="Species", suffix=".txt")
# have to change name of file everytime its in a loop which is annoying, n = how many label names you want
# suffix= tif txt file etc

# RDS files
# rds allows u to save an R object to disk and reload it
# load disk and data set comems back into memory
x <- runif(10)
saveRDS(object = x, file = "DataObjects/x.rds") # file = where u want to save it

x <- NULL
x

# restore x file:
restored_x <- readRDS(file="DataObjects/r.rds")
x <- readRDS(file="DataObjects/r.rds")
x

# logger system
set_up_log() # generates a txt file called "log file" 
set_up_log(user_seed=100) # set up random # seed
echo_log_console(TRUE) # things in the logger go into console
l("log message entered to the screen")
echo_log_console(FALSE) # turns off echo
l("message only stored in file")

set_up_log(overwrite_log=FALSE) # won't overwrite the other log, will have separate different log files

# progress bar for a for loop (how long it takes smth to run)
for (k in 1:100){
  show_progress(bar(k))
  Sys.sleep(0.075)
}

l("ended loop with no error")

# generate an error and end loop w/ an error
for (k in 1:100){
  show_progress(bar(k))
  Sys.sleep(0.075)
  if(k==52)print(ghost) # this throws an error
}
l("ended loop with an error")
# in log, tells you when the loop broke and ended

#pryr package
set_up_log(overwrite=FALSE)
for (i in 1:100){
    show_progress_bar()
  l(paste('memory_used=',trunc(mem_used()/10^6),
          " MB;"," i=",i,sep=''))
  z <- runif(n=10^i)
}

# build functions; takes a list of "character strings" for the functions you want to build and stores them in the function folder
build_function(c("select_recipes",
                 "write_shopping_list",
                 "buy_groceries",
                 "cook_meal",
                 "serve_meal",
                 "clean_up"))

source_batch("Functions") # sources all functions in function folder
# it also tells you which functions were sourced in the console





