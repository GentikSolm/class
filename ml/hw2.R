###
###
###  484/584 Intro to ML
###        Assignemnt 2
###
####################################################
##  Due Wed Sep 7 11:00pm
##
##
##  Write R code that performs tasks lited below.
##  Use this text file as template. Submit on Brightspace
##  under "Assessment" -> "Assignemnt 2".
##
##  Refer to Intro-R Regression video.
##  For particular function, you may have to google.


# 1. ----------------
#    Load concrete.csv from https://nmimoto.github.io/datasets/.
#    There's no link on the page. Load it directly to R using source() command.
#    Make sure you are using "tidyverse" package and function read_csv() instead
#    of read.csv().
require("tidyverse")
library(readr)

data <- read_csv("https://nmimoto.github.io/datasets/concrete.csv")

# 2. ----------------
#    What is the class of each columns?  Is there any qualitative variable?


# 3. ----------------
#    Plot scatterplot and histogram of the column "CCS".


# 4. ----------------
#    Plot scatterplot of "Water" vs "CCS", and "Age" vs "CCS".
#    Variable "CSS" has to be on the Y-axis.


# 5. ----------------
#    Fit multivariate regression model with OLS using lm() funciton.
#    CSS is the response variable.  Use all other columns as
#       covariates in the model.
#    How good is the fit?  Any variable that should be removed from the model?


# 6. ----------------
#    In (5) above, is there any indication of non-linearity?  Data supports the
#    assumption of the regression model?  (Hint: Check residual plot)
