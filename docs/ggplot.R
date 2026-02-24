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

##################
#2.24.26 ggplot II

#create fig then stitch them together better if plots are of diff data/figure types

p1 <- ggplot(data=d, mapping=aes(x=displ, y=cty)) +
  geom_point() +
  theme_bw() +
  xlim(0, 8) +
  ylim(0, 50)
print(p1)

p1

# renaming x and y axis, repositioning legends
p2 <- ggplot(data=d, mapping=aes(x=fl, fill=fl)) +
  geom_bar() +
  labs(fill = "Fuel Type", x = "Fuel Type", y = "Count", title = "My Plot") +
  theme(legend.position = "top") # "left, right, bottom"
  #theme(legend.position = c(.2, .8))  # uses x and y coord system for legend position
p2

# theme() = access aesthetic themes

# save plot (in plot window), can save figure as a pdf,  format etc.
# save figures as pdf!!!! makes for very high resolution
# then if save the pdf as a tif, get good quality for publications

# multi-panel plots
install.packages("patchwork")
install.packages("ggthemes")
library("ggthemes")
library("patchwork")

g1 <- ggplot(data = d) +
  aes(x= displ, y = cty) +
  geom_point() +
  geom_smooth()
g1

g2 <- ggplot(data = d) +
  aes(x = fl) +
  geom_bar(fill = "tomato", color = "black") 
g2

g3 <- ggplot(data = d) +
  aes(x = displ) +
  geom_histogram(fill = "royalblue", color = "black")
g3

g4 <- ggplot(data = d) +
  aes(x = fl, y = cty, fill = fl) +
  geom_boxplot() +
  theme(legend.position = "none")  # this is how to remove a legend
g4

# add two panels together
g1 + g2

# plot three plots
g1 + g2 + g3 + plot_layout(ncol = 1)
# can specify the layout w/ plot_layout(), asks for # col and rows like a mat

# change relative area of each plot
g1 + g2 + plot_layout(ncol = 1, heights = c(2,1))
# top figure is twice as tall as the bottom figure

# in the other dimension
g1 + g2 + plot_layout(ncol = 2, widths = c(1,2))
# right fig is twice as wide as fig 1

# want white space btw plots, add a spacer
g1 + plot_spacer() + g2

# nested layouts
g1 + {
  g2 + {   # g2 goes down a level in size; g2 is nested within g1
    g3 +
      g4 +
      plot_layout(ncol = 1)  #associated w g3 and g4; g3 and g4 nested within g2
    
  }
} + 
  plot_layout(ncol = 1) # associated w/ overall plot

# - operator for subtrack placement
g1 + g2 - g3 + plot_layout(ncol = 1)
# subtract operation creats a full sized plot g3 underneath or to the right
# g1 and g2 smaller while g3 is larger

# using | pike and \ forward slash
(g1 | g2 | g3)/g4    # creats a fraction of tables

(g1 | g2 | g3)/g4 + plot_annotation("Title Here",
  caption = "made this patchwork")

#  adding tags - tagging multipanal plot
g1 / (g2 | g3) +
  plot_annotation(tag_levels = "A")  # figures labeled A, B, C, etc

g1 / (g2 | g3) +
  plot_annotation(tag_levels = "a")   # lowercase

g1 / (g2 | g3) +
  plot_annotation(tag_levels = "1")

####################################################
# multi panel plots with facet
# facet is part of ggplot
m1 <- ggplot(data = d) +
  aes(x = displ, y = cty) +
  geom_point() +
  geom_smooth(method = "lm")

# using facet grid
m1 + facet_grid(class ~ fl)  # requires 2 variables, one variable is a function of the other

# if want to change the scaling of x/y axis
m1 + facet_grid(class ~ fl, scales = "free_y")
# y axis scale on their own for each row

m1 + facet_grid(class ~ fl, scales = "free")
# x and y axis scale on their own

# facet with only one variable
m1 + facet_grid(.~class)  # look at all data as a function of class, the "." acts as a placeholder

# another way to do it
m1 + facet_grid(class~.)
   # changes orientation of the figure

# facet wrap- doesn't allow more than 1 variable
m1 + facet_wrap(~class)

m1 + facet_wrap(~class + fl) # has every combination

m1 + facet_wrap(~class + fl, drop = F) # keeps empty panals/combos that don't exist



