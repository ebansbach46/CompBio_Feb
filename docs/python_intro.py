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

# 3.19.26
# pop pulls the last value or file out and save it and remove it from the origional list, allows you to process it and put it back into the stack
mixed.remove("start")
print(mixed)  # just deleted the value from the list
last = mixed.pop("start") # if leave .pop() empty it chooses the last one, and saves it so you can put it back in later
print(last)


# list comprehension
#like a for loop in one line
print(mixed)

# x is indexing var
[x for x in mixed] # pulls x val out of mixed
# mixed is the list

[x for x in mixed if isinstance(x,str)]
# ask for each element in mixed if its an instance of being a chracter string, if so it will return them
# in the if statement is where you can do operations

######################################
# disctionaries
######################################
# key = name of position in dictionary, the value is whats stored in that position

# key = first, value = john
# can store files in here
# manually coding a dictionary
md = {
    "first":"John",
    "last":"Smith",
    "year": 2017,
    "status":"active"

}

# creating a dictionary w a constructor function
md2 = dict(first = "john", last = "Smith")
print(md)

type(md)  # what type is this; tells us its a dictionary
len(md)   # gives you  the length, aka how long is the dictionary

# data types within a dictionary
dataTypes = {
    "string":"thing",
    "integer": 3,
    "float": 3.14342,
    "list":[1,2,3,"a"],
    "boolean":False

}
# has 5 idff data dypes in this dict

#calling values by using key name in brackets
dataTypes["string"]  # returns value associated w/ it, so will get thing; if call "list" it returns the things in the list

# built in method works too
dataTypes.get("boolean")

#returns all keys and values using methods in dictionary
dataTypes.keys()
dataTypes.values()

# return as a list of tuples
dataTypes.items()

# add element
dataTypes["age"] = 36  
print(dataTypes)

# changing value within a dictionary
dataTypes["age"] = 35

############################################
# numpy
# in therminal:
# conda install numpy
# import numpy as np

# if conda not running; pip install (or pip3)

# creating a numpy array
arr1 = np.array([0,1,2,3,4,5,6,7,8,9])
# array is a function within np; its not a method
# its the array funcntion thats specifically in np package
print(arr1)

arr1[3]
arr1[-1]  # last element
arr1[:3]  # doesn't incl the third place
arr1[1:5]

arr1[1:8:3] #  the 3 in the [] gives every third element in array

# 2d array (akamatrix in r)
arr2 = np.array([[1,2,3],[4,5,6],[7,8,9]])   # encodes a 3 x 3 array
# crreats a list of lists, then conerts it into a numpy array
print(arr2)

arr2[2,2]  # element in 2,2 position, which is 9
# goes zero, one, two
arr2[:,2]  # all values in the last column
arr2[2,:] # all values in row 3
# : = placeholder for everything

arr2[0:2, 0:2] # gives a 2x2 subset of the array (upperleft corner)-a 2d slice of the array

# 3d array
# 2x2x2
arr3 = np.array([[[1,2],[3,4]],[[5,6],[7,8]]])
print(arr3)

# 3d indexing
arr3[1,0,1]  #first layer, zeroith row, first column

# will have to create new environments for geospatial

# dimensions
# if pull dataset out of file, tells you the dimensions of the array
arr1.ndim  # gives you the dimensions
arr2.ndim  # 2 dimensions
arr2.ndim  # 3 dimensions

# shape of an array
arr1.shape  
arr2.shape # [2,2] only one , is 2d
arr3.shape  # 2 , is 3d

# data types
arr2.dtype # tells whats stored in the array (int64) = integer  (float for decimal numbers)
arr2.astype(str)  # str = string
# took numeric array and converted them all to strings (catagorical)

# reshaping an array
arr1.shape
arr1.reshape(2,5)  # 2 rows, 5 col -> 2d array

# 3d array to 2d
arr3.shape  # confirms its 3d array
arr3.reshape(4,2)
# dimensions have to be divisible by the orig number of values

# combining arrays
first = np.array([1,2,3])
second = np.array([4,5,6,7,8,9])

longArray = np.concatenate([first, second])
print(longArray)

# select axis for higher dimensions (dims)
newStack = np.concatenate([arr2, arr2], axis = 0)
print(newStack)
newStack2 = np.concatenate([arr2, arr2], axis = 1)  # now 3x6

# stacking arrays
newStack = np.stack([arr2, arr2])
print(newStack)
# have created a third axis 
newStack.shape
# 2x3x3 -> 3d now

# splitting arrays
np.array_split(arr1, 2)  # integer value 2 tells where to split the arrays, into 2 equal parts
np.array_split(arr1, 2, axis = 0)  # if splitting 3d array can decide which axis to split, this is only a 1d array though

# random numbers
from numpy import random
# random = does random number generatng
random.seed(seed = 100)

random.randint(50) # gives a random value from 0 to 50

random.rand(50) # gives us 50 values from 0 to 1

random.rand(50, 5, 10) # create 5x10 2d array populated w 50 random values

random.choice(arr1) # random number from arr1

random.choice(arr1, size = (3,3)) # creating a new 3x3 array, populated randomly from arr1

random.choice([0,1], p = [.3, .7], size = 100) # create a binary matrix/array
# pull from 0,1 array 100 times, but zeros pulled w/ probability of 30%, vice versa
