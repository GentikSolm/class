###
###
###  484/584 Intro to ML
###        Assignemnt 7 on Ch10 Neural Network
###
####################################################
##  Due Wed Nov 16 11:00pm
##
##
##  Write R code that performs tasks lited below.
##  Use this text file as template. Submit on Brightspace
##  under "Assessment" -> "Assignemnt 7".


# 1. ----------------
#    Load concrete.csv from https://nmimoto.github.io/datasets/ as a tibble.
library(tidyverse)   # install.packages(tidyverse")
concrete <- read_csv("https://nmimoto.github.io/datasets/concrete.csv")
concrete <- as_tibble(concrete)
attach(concrete)
concrete


# 2. ----------------
#    Using seed "8346", separate the dataset into a training set with 850 observations
#    and a testing set with 180 observations.  Separate the training set into 5-folds of
#    170 obs each.
my.seed <- 8346
set.seed(my.seed)
train.size <- 850
test.size <- 180
Orig <- concrete
source('https://nmimoto.github.io/R/ML-00.txt')

# Output (all data.frame):
Train.set      #  Train.resp
Test.set       #  Test.resp
CV.train[[k]]  #  CV.train.resp[[k]]
CV.valid[[k]]  #  CV.valid.resp[[k]]

length(CV.train) # 5 folds

# 3. ----------------
#    Perform Training/Test fit of multiple regression with all variables
#    Use all training set to fit, and predict the response variable in the test set.
#    Report training RMSE and test RMSE.


# 4. ----------------
#    Using Cross Validation, fit Neueal Network model with
#    all variables in the dataset, using 1 hidden layer with 3 nodes.
#    Make sure the dataset you feed into NN is scaled.
#    Report av. training RMSE and av. validation RMSE.


# 5. ----------------
#    Look for better model by changing the number of hidden layers
#    and number of nodes. (Use CV and look at av. valid. RMSE.)


# 6. ----------------
#    Perform the final Training/Test fit using the model in (4) or (5).
#    Report training RMSE and test RMSE.


# 7. ----------------
#    Scale back the predicted Test set response of (6), and
#    re-calculate the test RMSE.
#    Compare it to the Test RMSE from (3). Which model has more
#    prediction power?  Which model is easier to interprete?

