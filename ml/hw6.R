##
###
###  484/584 Intro to ML
###        Assignemnt 6 on Ch8 Decision Tree and
###                        Ch9 SVM
####################################################
##  Due Wed Oct 26 11:00pm
##
##
##  Write R code that performs tasks lited below.
##  Use this text file as template. Submit on Brightspace
##  under "Assessment" -> "Assignemnt 6".


# 1. ----------------
#    Load iris dataset that comes with R.
#    (Refer to Prelim file under iris section on Webpage)
#    Turn the dataset into tibble.

# 2. ----------------
#    In the dataset, mutate entries of "Species" column as "Yes" if Species were
#    equal to "versicolor", and as "No" otherwise.
#    Rename "Species" column as "resp" and move it to the 1st column.

# 3. ----------------
#    Using seed "1234", separate the dataset into a training set with 125 observations
#    and a testing set with 25 observations.  Separate the training set into 5-folds of
#    25 obs each.


# 4. ----------------
#    Fit the "resp" column with Logistic Regression using all remaining columns in
#    the model.  No need to use CV training/validation, just Training / Testing fit is fine.
#    What is the test AUC of the model?


# 5. ----------------
#    Repeat (4) using Decision Tree model (Grow and Prune).  How many
#    terminal node is in your tree?  What is the test AUC?


# 6. ----------------
#    Repeat (4) using Support Vector Machine with Lienar Kernel, and Radial Kernel.
#    Use tune() function with Auto 5-fold CV to find the best parameter values
#    for each kernel. List parameter values here. What is the test AUC?


# 7. ----------------
#    Out of the models you fit in this assignment, which one is the best model,
#    and why?


# 8. ----------------
#    For your best model chosen in (7), suggest the threshold value to use.
#    Copy the test confusion matrix for that threshould here.

