###
###
###  484/584 Intro to ML
###        Assignemnt 5 on Ch6 Regularization
###
####################################################
##  Due Wed Oct 12 11:00pm
##
##
##  Write R code that performs tasks lited below.
##  Use this text file as template. Submit on Brightspace
##  under "Assessment" -> "Assignemnt 5".
##
##  Refer to  video Ch6Lab-1,2,3 and 4.
##  This assignment can be completed by copying the code found in
##  "Regularlization" under "MASS Boston Data" sectoin in the class Website.
##  (Covered in Ch6 Lab-3 Boston3)


# 1. ----------------
#    Load superconduct.csv from https://nmimoto.github.io/datasets/.
#    There's no link on the page, and the file must be load directly.
#    Make sure you are using "tidyverse" package and
#    function read_csv() instead of read.csv().


# 2. ----------------
#    In the dataset, remove column "X1".
#    Rename "critial_temp" column as "resp" and move it to the 1st column
#    Since this data is too large, take a random sample of 1200 rows
#    using seed "1234". (Similarly to what was done in Ch6 Lab-4 Super0).


# 3. ----------------
#    Using seed "1234", separate the dataset into a training set with 1000 observations
#    and a testing set with 200 observations.  Separate the training set into 5-folds of
#    200 obs each.


# 4. ----------------
#    Using lm() function, perform regular OLS (multiple regression) on
#    entire training set.  Your model should include all variables available.
#    How many predictor is in the model?
#    Use the model to predict "resp" in the test set.
#    Report training RMSE and test RMSE.


# 5. ----------------
#    Using cv.glmnet() function in glmnet package, use 5-fold CV to determine
#    best value of lambda to use for LASSO Regression.
#    Then use that value to fit LASSO to entire training set.
#    Your model should contain all varialbes in the dataset.
#    Then use the model to predict "resp" in the test set.
#    Report training RMSE and test RMSE.


# 6. ----------------
#    Compare coeficients of OLS to LASSO, side by side.
#    Indicate the parameters that is suppresed significantly (by your eye).


# 7. ----------------
#    Did LASSO regression improve training fit compared to OLS?
#    How about test fit?

