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

install.packages("tidyverse")
library(tidyverse)   # install.packages(tidyverse")
concrete <- read_csv("https://nmimoto.github.io/datasets/concrete.csv")
attach(concrete)

# In this assignment, we will fit CCS column with polynomial
# regression using Age column.
# In IntroR-W3 example, "medv" was the response variable,
# and "lstat" was the predictor.
# This means that all "$medv" in IntroR-W3_CrossValidation.txt
# should be replaced
# with "$CCS", and all "$lstat" should be replaced with "$Age".
plot(Age, CCS)


# 2. ----------------
#    Using seed "8346", separate the dataset into a
#    training set with 850 observations
#    and a testing set with 180 observations.  Separate
#    the training set into 5-folds of
# $    170 obs each.
original <- concrete
train_size <- 850
test_size  <- 180
resp_col_name  <- "CCS"
num_folds  <- 5
rand_seed  <- 8346

set.seed(rand_seed)
ix <- sample(1:nrow(original))
original_2  <- original[ix, ]
train_set  <- original_2[1:train_size, ]
train_resp  <- original_2[1:train_size, resp_col_name]
test_set  <- original_2[(train_size+1):(train_size+test_size), ]
test_resp  <- original_2[(train_size+1):(train_size+test_size), resp_col_name]

install.packages("cvTools")
library("cvTools")
set.seed(rand_seed)

folds  <- cvFolds(nrow(train_set), K = num_folds)

cv_train      <- list(train_set[folds$which != 1, ])
cv_train_resp <- list(train_resp[folds$which != 1, 1])
cv_valid      <- list(train_set[folds$which == 1, ])
cv_valid_resp <- list(train_resp[folds$which == 1, 1])

for (k in 2:num_folds) {
    cv_train[[k]]      <- train_set[folds$which != k, ]
    cv_train_resp[[k]] <- train_resp[folds$which != k, 1]
    cv_valid[[k]]      <- train_set[folds$which == k, ]
    cv_valid_resp[[k]] <- train_resp[folds$which == k, 1]
}

# 3. ---------------
#    Using k=3 for the k-fold CV, plot scatterplot of Age vs CCS.
#    Plot Training set with open black circle,
#    and Validation set with solid red circle.
#    (You can use section 1 of the example)
k <- 3
plot(cv_train[[k]]$Age, cv_train[[k]]$CCS, xlab = "lstat", ylab = "medv")
lines(cv_valid[[k]]$Age, cv_valid[[k]]$CCS, type = "p", col = "red", pch = 19)

# 4. ----------------
#    For each of the k-fold, (k=1,...5), fit CCS
#    using 3rd degree polynomial of Age.
#    (You can use (section 2.a for k=1,...5) or (section 2.b for deg.poly=3)
#    List values of Training MSE and Validation MSE for each fold.
#    How many observations were there in each training set?
#    How many observations were there in each validation set?

deg_poly  <-  3
k  <-  1:5


# 5. ----------------
#    Produce deg.poly vs MSE.valid plot, for CCS vs Polinomial of Age.
#    (You can use section 2.b)
#    Using the plot, decide on the best value of deg.poly.



# 6. ----------------
#    Perform the final test fit using the test set.
#    Note this time the entire Training set (850 obs) is the Training set, and
#    Test set (180 obs) is the Test set.
#    What is the final test MSE?
#    qhat is the mathematical equation of the your final polynomial?
