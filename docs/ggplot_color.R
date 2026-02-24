# looking at colors and color mapping in ggplot
# e bansbach
# 2.24.26

#############################################################
install.packages("colorspace")
install.packages("wesanderson")
install.packages("ggsci")
install.packages("devtools")
library(devtools)
devtools::install_github("wilkelab/cowplot")
devtools::install_github("clauswilke"/"colorblindr")
install.packages("colorspace", repo = "http://R-Forge.R-project.org")

library(ggplot2)
library(ggthemes)
library(colorblindr)
library(colorspace)
library(wesanderson)
library(ggsci)
