# 2.19.26
# ggplot

# call the function "ggplot"
# data - data seet
# aes layer does mapping 
# geom funcion= geomes (can have more than 1), describes the type of figure being created (scatter, bar,etc)
# everything else is optional

# aes - aesthetics, or any additional things needed to be added (eg error bars)
# position - 0 to 1 coord system on x and y system
# facet functin- make multiple data plots all stuck together

# can store whole figure into an object; can add other things together then (eg multipanel figures)
   # can add things to p1 after doing its original plot (eg wanna add error bars)
   # can only call the figure when you want to, not everytime u run the code

# START CODE HERE
##########################################################

# required packages for this script
library(ggplot2)

# type this into console 
# install.packages("ggthemes")
# install.packages("patchwork")

library(ggthemes)
library(patchwork)

# load our dataset (mpg)
d <- mpg

# our first call to ggplot: histogram
ggplot(data = d) + 
  aes(x = hwy) + 
  geom_histogram() # add (+) a layer, do carriage return 


# change colors of histogram
ggplot(data = d) + 
  aes(x = hwy) + 
  geom_histogram(fill ="slateblue4", color = "black")
# can load color palletes externally eg veradise (website)

# density plot
ggplot(data = d) +
  aes(x = hwy) +
  geom_density(fill = "mintcream")

# scatter plt
ggplot(data = d) +
  aes(x = displ, y = hwy) +
  geom_point() +
  geom_smooth() +
  geom_smooth(method = "lm", col = "red")   # lm = linear model

# box plot
ggplot(data = d) +
  aes(x = fl, y = cty) +
  geom_boxplot(fill = "thistle", color = "thistle")   # color = color of outline

# basic barplot
ggplot(data = d) +
  aes(x = fl) +
  geom_bar()
# need to make a df for medians, etc; calc summary stats then call on it to add those elements to plot
# use dplier to calc those values (summary stats)

# barplot with y response
x_treatment <- c("control", "low", "high")
y_response <- c(12, 2.5, 22)
summary_data <- data.frame(x_treatment, y_response)
ggplot(data = summary_data) +
  aes(x = x_treatment, y = y_response) +
  geom_col(fill = c("grey50", "goldenrod", "goldenrod"), color = "black")

# plotting curves
my_vec <- seq(1,100, by = 0.1)

# plot a simple function
d_frame <- data.frame(x = my_vec, y = sin(my_vec))

# plot lines
ggplot(data = d_frame) +
  aes(x = x, y = y) +  # the second x is the one you created in the df
  geom_line()

d_frame <- data.frame(x = my_vec, y = dgamma(my_vec, shape = 5, scale = 3))
d_frame   # prints df to console

ggplot(data = d_frame) +
  aes(x = x, y = y) +
  geom_line()

# themes and fonts
p1 <- ggplot(data = d, mapping = aes(x = displ, y = cty)) +
  geom_point()

p1  # prints the figure

# these are 2 different ways to do the same thing
p1 + theme_classic()
p1 <- ggplot(data = d, mapping = aes(x = displ, y = cty)) +
  geom_point() + 
  theme_classic()

p1 + theme_minimal()
p1 + theme_linedraw()
p1 + theme_dark()
p1 + theme_base()
p1 + theme_void()
p1 + theme_par()

# changing font size and type
p1 + theme_classic(base_size=30, base_family="serif")

# code for adding additional fonts
library(extrafont)
font_import()   # imports all system fonts (run once)


# using other fonts for presentations
p1 + theme_classic(base_size=35, base_family="Chalkduster")

# coordinate flipping in ggplot
p2 <- ggplot(data=d, mapping=aes(x=fl, fill=fl)) +
  geom_bar()
p2
# fill=fl -> random colors

p2 + coord_flip() + 
  theme_grey(base_size = 20, base_family = "sans")

# setting x and y limits
p1 <- ggplot(data=d, mapping=aes(x=displ, y=cty)) +
  geom_point() +
  theme_bw() +
  xlim(0, 8) +
  ylim(0, 50)
print(p1)
