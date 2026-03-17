# looking at colors and color mapping in ggplot
# e bansbach
# 2.24.26 and 3.5.26

#############################################################
install.packages("colorspace")
install.packages("wesanderson")
install.packages("ggsci")
install.packages("devtools")
library(devtools)
devtools::install_github("wilkelab/cowplot")
devtools::install_github("clauswilke"/"colorblindr")
install.packages("colorspace", repos = "http://R-Forge.R-project.org")
devtools::install_github("clauswilke"/"colorblindr")


library(ggplot2)
library(ggthemes)
library(colorblindr)
library(colorspace)
library(wesanderson)
library(ggsci)



d <- mpg

my_cols <- c("green", "thistle", "tomato", "cornsilk", "chocolate")

demoplot(my_cols, "map")
demoplot(my_cols, "bar")
# other demoplot plot types: "scatter, heatmap, spine, perspective"
# allows you to see how color scemes look together

# working w/ black and white color schemes
# choose grey (0=black, 100=white)
my_greys <- c("grey20", "grey50", "grey80")
demoplot(my_greys, "bar")

my_greys2 <- grey(seq(from=0.1, to=0.9, length.out=10)) # 10 values all btw 0.1 to 0.9 for diff shades of grey
demoplot(my_greys2, "heatmap")

p1 <- ggplot(d, aes(x=as.factor(cyl), y=cty, fill=as.factor(cyl))) + geom_boxplot() # cyl = cylinder
plot(p1)

# default colors look identical in black/white
p1_des <- colorblindr::edit_colors(p1, desaturate)

plot(p1_des)

#as.factor calls on all the 4 cylinders, the 5 cliners; as.numeric

# set transparency of images using alpha
x1 <- rnorm(n=100, mean=0)
x2 <- rnorm(100, mean=2.7)

d_frame <-data.frame(v1=c(x1, x2)) # now 200 rows
lab <- rep(c("Control", "Treatment"), each=100) # also 200 rows; combine them
dframe <- cbind(d_frame, lab) # now have 200 colms
h1 <- ggplot(d_frame) + aes(x=v1, fill=lab) # histograms don't need a y axis; right now it doesn't know what shape it is adding data into so no plot is created
h1 + geom_histogram(position="identity", alpha=0.5, color="black") # color is refering to the outline of the histogram

# color customization
d <- mpg
# discrete classifications
#scale_fill_manual for boxplots or barplots
#scale_color_annual for points and lines

# boxplot with no color
p_fil <- ggplot(d) + aes(x=as.factor(cyl), y=cty) + geom_boxplot()
p_fil
# p_fil <-ggplot(d, aes(x=as.factor(cyl), y=cty)) + geom_boxplot() also does the same thing

# Boxplot w/ default ggplot fill
p_fil <-ggplot(d, aes(x=as.factor(cyl), y=cty, fill=as.factor(cyl))) + geom_boxplot()
p_fil
#now the color or the fill is based on the different categories of cylinders

# create custom color palette
my_cols <- c("red", "brown", "blue", "orange")
# boxplot w/ these custom colors
p_fil + scale_fill_manual(values = my_cols) # dont use default colors, use my colors
# if expecting to fill 4 categories, vector must be the same length, i.e have 4 colors

# scatterplot w/ no color
p_col <- ggplot(d) + aes(x=displ, y = cty)
p_col + geom_point(size=3)

# scatterplot with default ggplot colors
# uses "col" argument
p_col <- ggplot(d) + aes(x=displ, y=cty, col=as.factor(cyl)+geom_point(size=3))
p_col

#uses cstom colors requires "scale_color_manual"
p_col+scale_color_manual(values=my_cols)

##### look at ggplot 2 notes to fix the code

# continuous classification (gradient color scale)
p_grad <- ggplot(d) + aes(x=displ, y=cty, col=hwy) +geom_point(size=3)
p_grad
# as.factor -> discreet coloring

# custom sequential gradient (2-colors)
p_grad + scale_color_gradient(low="green", high="red")

# custom diverging gradient (3 colors)
mid <- median(d$cty)
p_grad + scale_color_gradient2(midpoint=mid, low="blue", mid="white", high="red")

# custom diverging gradient (with n colors)
p_grad + scale_color_gradientn(colors=c("blue", "green", "yellow", "purple", "orange"))

# color palettes
library(wesanderson)
print(wes_palettes)
#$ is for each column; they are df so can index

demoplot(wes_palettes$BottleRocket1, "pie")
# use $ to call on the theme you want to use
demoplot(wes_palettes[[2]][1:3], "bar")

# color brewer palettes
library(RColorBrewer)
display.brewer.all()
display.brewer.all(colorblindfrendly=TRUE)

demoplot(brewer.pal(4, "Accent"), "bar")
demoplot(brewer.pal(11, "Spectral"), "heatmap")

library(scales)
my_cols <- c("grey75", brewer.pal(3, "Blues"))
show_col(my_cols)

# generating a heat map
xVar <- 1:30
yVar <- 1:5
myData <- expand.grid(xVar=xVar,yVar=yVar)
head(myData)
zVar <- myData$xVar + myData$yVar + 2*rnorm(n=150) # 150 rows w 3 different colums
myData <- cbind(myData,zVar)
head(myData)

# default gradient colors in ggplot
p4 <- ggplot(myData) +
      aes(x=xVar,y=yVar,fill=zVar) +
  geom_tile()
print(p4)
# uses default gradient colors in ggplot
p4 + scale_fill_gradient2(midpoint=19, low="brown", mid=grey(0.8), high="darkblue") # at 19 is when it creates the midpoint color

# viridis
p4 + scale_fill_viridis_c()

# viridis has other themes you can change with options
# options (viridis, cividis magma, inferno, plasma)
p4 + scale_fill_viridis_c(option="inferno")
p4 + scale_fill_viridis_c(option="cividis")
p4 + scale_fill_viridis_c(option="plasma")


####
#use qmd file to write out and explain your code if the homework asks you to explain stuff
