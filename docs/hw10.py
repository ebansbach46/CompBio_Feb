## Homework 10
## 3.25.26

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

# Question 1

myList = ["summer", "winter", 3, 5, [6,7,8]]
print(myList)

# 1
third_element = myList[2]
print(third_element)

# 2
listWithinList = myList[4][2]
print(listWithinList)

# 3
myList.append(True)
print(myList)
# .append adds a data type (character string, integer, bolean variables, etc) onto the end of a list

myList.remove([6,7,8])
print(myList)
# .remove removes a data type from a list. You explicitly indicate the item you want removed from the list


## Question 2
myDict = {
    1: "January",
    2: "February",
    3: "March",
    4: "April",
    5: "May"
}
# 1
keys = myDict.keys()

# 2
myDict.values()

# 3
type(myDict)
# this tells you the data type in the dictionary, which is a dictionary

len(myDict)
# this gives me the length of my dictionary, how many pairs of values are in it

# 4
myDict[6] = "June"
print(myDict)
# This added another pair to my dictionary, 6: "June"

# 5
myDict.pop(1, "January")
print(myDict)

## Question 3
from numpy import random

arr1 = random.uniform(low=0, high=1, size = (100))
print(arr1)

# 1
arr1[-10:]

# 2
arr1.dtype 
arr1.astype(str)
arr1.astype(float)
arr1.dtype

# 3
arr2D = arr1.reshape(10, 10)
print(arr2D)

# 4
arr_bin1 = random.choice([0, 1], p=[.8, .2], size=(100))
arr_bin = arr_bin1.reshape(10,10)
print(arr_bin)

# 5
np.stack((arr2D, arr_bin))
