###
###
###  484/584 Intro to ML
###        Assignemnt 4
###
####################################################
##  Due Wed Sep 28 11:00pm
##
##
##  Write R code that performs tasks lited below.
##  Use this text file as template. Submit on Brightspace
##  under "Assessment" -> "Assignemnt 4".
##
##  Refer to  video Ch4Lab-1,2,3 and 4.
##  This assignment can be completed by changing
##  few lines from the code found in
##  "Logistic Regression" under "ISLR Heart Data" sectoin in the class Website.
##  (Covered in Ch4Lab-4.)


# 1. ----------------
#    Load heart.csv from https://nmimoto.github.io/datasets/.
#    There's no link on the page, and the file must be load directly.
#    Make sure you are using "tidyverse" package and
#    function read_csv() instead of read.csv().


# 2. ----------------
#    In the dataset, remove column "X1".
#    Rename "AHD" column as "resp" and move it to the 1st column
#    Make sure following columns have class
#    "factor": "Sex", "ChestPain", "Fbs", "RestECG", "ExAng", "Thal"
#    remove rows that has NA.


# 3. ----------------
#    Using seed "1534", separate the dataset into a
#    training set with 250 observations
#    and a testing set with 47 observations.
#    Separate the training set into 5-folds of
# $    50 obs each.



# 4. ----------------
#    In Ch4Lab-4 video, only the model that takes in all
#    column were investigated.
#    search for best Logistic Regression model that
#    gives highest validation AUC.



# 5. ----------------
#    Using your best model from (4), perform the final Training/Test fit.
#    What is the test AUC?
#    Is your test AUC in reasonable range?


# 6. ----------------
#    For somebody who is actually using your 'best' logistic regression model
#    to predict the presense of the heart disease, recommend
#    the value of threshold (b/w .1 - .9).
#    You must come up with your own cost function for (TP, TN, FP, FN).


