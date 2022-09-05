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
lapply(data, class) # All are numberic
    # None are qualitative

# 3. ----------------
#    Plot scatterplot and histogram of the column "CCS".
attach(data)
plot(CCS)
hist(CCS)

# 4. ----------------
#    Plot scatterplot of "Water" vs "CCS", and "Age" vs "CCS".
#    Variable "CSS" has to be on the Y-axis.
plot(Water, CCS)
plot(Age, CCS)

# 5. ----------------
#    Fit multivariate regression model with OLS using lm() funciton.
#    CCS is the response variable.  Use all other columns as
#       covariates in the model.
#    How good is the fit?  Any variable that should be removed from the model?
reg <- lm(sqrt(CCS) ~ . - Fine - Coarse, data = data)
summary(reg)
    # Removed Fine and Coarse, as they did not have much effect on the fit

# 6. ----------------
#    In (5) above, is there any indication of non-linearity?  Data supports the
#    assumption of the regression model?  (Hint: Check residual plot)

plot(reg)
    # Similar to the plots showin in the ch2 video, the data seems to be
    # non-linear. It does not support the assumption of regressiom model
