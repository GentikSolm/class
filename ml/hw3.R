###
###
###  484/584 Intro to ML
###        Assignemnt 3
###
####################################################
##  Due Wed Sep 14 11:00pm
##
##
##  Write R code that performs tasks lited below.
##  Use this text file as template. Submit on Brightspace
##  under "Assessment" -> "Assignemnt 3".
##
##  Refer to Intro-R Cross Validation video.
##  This assignment can be completed by changing few lines in
##  IntroR-W3_CrossValidation.txt file.



# 1. ----------------
#    Load concrete.csv from https://nmimoto.github.io/datasets/
#    using the command below.  There's no link on the page, and the file must be
#    load directly.  Make sure you are using "tidyverse" package and
#    function read_csv() instead of read.csv().

library(tidyverse)   # install.packages(tidyverse")
Concrete <- read_csv("https://nmimoto.github.io/datasets/concrete.csv")

# In this assignment, we will fit CCS column with polynomial regression using Age column.
# In IntroR-W3 example, "medv" was the response variable, and "lstat" was the predictor.
# This means that all "$medv" in IntroR-W3_CrossValidation.txt should be replaced
# with "$CCS", and all "$lstat" should be replaced with "$Age".



# 2. ----------------
#    Using seed "8346", separate the dataset into a training set with 850 observations
#    and a testing set with 180 observations.  Separate the training set into 5-folds of
$    170 obs each.



# 3. ----------------
#    Using k=3 for the k-fold CV, plot scatterplot of Age vs CCS.
#    Plot Training set with open black circle, and Validation set with solid red circle.
#    (You can use section 1 of the example)



# 4. ----------------
#    For each of the k-fold, (k=1,...5), fit CCS using 3rd degree polynomial of Age.
#    (You can use (section 2.a for k=1,...5) or (section 2.b for deg.poly=3)
#    List values of Training MSE and Validation MSE for each fold.
#    How many observations were there in each training set?
#    How many observations were there in each validation set?



# 5. ----------------
#    Produce deg.poly vs MSE.valid plot, for CCS vs Polinomial of Age.
#    (You can use section 2.b)
#    Using the plot, decide on the best value of deg.poly.



# 6. ----------------
#    Perform the final test fit using the test set.
#    Note this time the entire Training set (850 obs) is the Training set, and
#    Test set (180 obs) is the Test set.
#    What is the final test MSE?
#    What is the mathematical equation of the your final polynomial?

