### intro to python 
# 3.17.26
# E Bansbach
## want minoconda python interpreter session

# installing libraries:
# pip = install manager for regular python (nonminiconda)
# where it says conda -> use pip (regular/system python)
# in terminal:
# conda activate spacetime
# conda install numpy
# conda install pandas

# pip also still not installing- same issue as w/ conda

# conda install matplotlib
# conda install scipy

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
# every package has a smaller abbreviation that goes w each package (np, pd, plt)

# usually only run code line by line if your debugging

#np.mean()

##################################
# objects, methods, and functions:
##################################
print("I love python")

greeting = "Hello"
print(greeting)

scaler = 6  # integer value
out = scaler * 3  # doing mth w/ an object
print(out)

myList = [34, 7, 98]  # create a list
# list objects have methods associated w them
myList.append(33)  #.append is the method; changed the object within itself, appending data in a list (mutates it)
# commmon to use append method in a for loop
print(myList)

len(myList)  # gives you the length of the list; performing a function on the list here
# Length function

# data structures
#----------------------------------------
# make a list of colors
a_list = ["blue", "green", "red"]
print(a_list)

# indexing into a list:
a_list[0]  # every index in python starts w/ 0 (the first object or element is 0)
print(a_list[0])

first_element = a_list[0]
print(first_element)

# looking at data types
nums = [1,2,5,8]
chars = ["a","b","c"]
boolean = [True, True, False]

# mixed lists of data types
mixed = [1,2, True, "blue", 5]
print(mixed)

# checking data types
type(nums[0])  # have to index to determine if integer, character, otherwise it will just say list
# type returns highest level objectt type

# negative indexing
mixed[-1]  # returns the last element in the list
print(mixed[-1])
print(mixed[-3])  # returns third to last (aka the third element from the right); prints True

# ranged indexing 
mixed[1:4]   # takes first second and third element, and not the fourth
# first is inclusive, last is not inclusive (included)
print(mixed[1:4])
print(mixed[:4])  # starts at the beginning automatically
print(mixed[2:])   # starting point to the end

# is an item in the list
1 in mixed   # True, the element is in there

# changing elements
print(mixed[4])
mixed[4] = "green"
print(mixed[4])

mixed.insert(0, "start")
# put in the zeroith place put "start"; doesn't change the element it inserts it into the position you want it to be
# puts "start" as the new zeroith place, it was inserted into a specific position without overwriting

# other methods
# extend
# remove (the opposite of insert, pick the position you want to remove)
# pop - adds smth to the end
# clear - deletes elements
# can look up methods associated w/ a list object too
