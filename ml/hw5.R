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

library(MASS)                # install.packages("MASS")
library(tidyverse)           # install.packages("tidyverse")
super <- read_csv(file = "https://nmimoto.github.io/datasets/superconduct.csv")
attach(super)


# 2. ----------------
#    In the dataset, remove column "X1".
#    Rename "critial_temp" column as "resp" and move it to the 1st column
#    Since this data is too large, take a random sample of 1200 rows
#    using seed "1234". (Similarly to what was done in Ch6 Lab-4 Super0).

super <- super %>%
    #!!! X1 doesnt exist
    rename(resp = critical_temp) %>%
    relocate(resp)

my.seed <- 1234
set.seed(my.seed)
super <- super[sample(nrow(super), 1200), ]

# 3. ----------------
#    Using seed "1234", separate the dataset into a training set with 1000 observations
#    and a testing set with 200 observations.  Separate the training set into 5-folds of
#    200 obs each.

Orig <- super
train.size <- 1000
test.size <- 200
source('https://nmimoto.github.io/R/ML-00.txt')

# Output (all data.frame):
Train.set      #  Train.resp
Test.set       #  Test.resp
CV.train[[k]]  #  CV.train.resp[[k]]
CV.valid[[k]]  #  CV.valid.resp[[k]]

length(CV.train) # 5 folds

# 4. ----------------
#    Using lm() function, perform regular OLS (multiple regression) on
#    entire training set.  Your model should include all variables available.
#    How many predictor is in the model?
#    Use the model to predict "resp" in the test set.
#    Report training RMSE and test RMSE.

Fit1 <- lm(resp ~., data=Train.set) # All variables
summary(Fit1) ## With 82 columns, 1 being resp, there are 81 predictors. However, of these
# Only around 27 of these columns seem to hold statistical significance in comparison
# to the response variable

Train.fitted = predict(Fit1, newdata=Train.set)
Test.pred    = predict(Fit1, newdata=Test.set)

plot( Train.fitted, as.matrix(Train.resp), xlab="Fitted", ylab="Actual",main="Final Test.set fit")
lines(Test.pred, as.matrix(Test.resp), type="p", xlab="Fitted", ylab="Actual", col="red", pch=20)
abline(0,1)

library(caret)
OLS <- data.frame(
  tr.RMSE      = caret::RMSE(Train.fitted, as.matrix(Train.resp)),
  tr.Rsquare   = caret::R2(  Train.fitted,           Train.resp),
  test.RMSE    = caret::RMSE(Test.pred,    as.matrix(Test.resp)),
  test.Rsquare = caret::R2(  Test.pred,              Test.resp)
)

# Training RMSE and test RMSE
OLS

# 5. ----------------
#    Using cv.glmnet() function in glmnet package, use 5-fold CV to determine
#    best value of lambda to use for LASSO Regression.
#    Then use that value to fit LASSO to entire training set.
#    Your model should contain all varialbes in the dataset.
#    Then use the model to predict "resp" in the test set.
#    Report training RMSE and test RMSE.

library(glmnet)

set.seed(my.seed)
x <- model.matrix(resp ~. , Train.set)[,-1]
x.train <- model.matrix(resp ~., Train.set)[,-1]
x.test  <- model.matrix(resp ~., Test.set)[,-1]
y <- Train.set$resp

CV.for.lambda <- cv.glmnet(x, y, alpha = 1, nfolds=5)
CV.for.lambda$lambda.min
FitLasso <- glmnet(x, y, alpha = 1, lambda = CV.for.lambda$lambda.min)
coef(FitLasso)
summary(Fit1)


# 6. ----------------
#    Compare coeficients of OLS to LASSO, side by side.
#    Indicate the parameters that is suppresed significantly (by your eye).

cbind(coef(Fit1), coef(FitLasso))
# Some parameters were significantly supressed
# Including but not limited to:
#   mean_atomic_mass
#   wtd_mean_atomic_mass
#   wtd_gmean_atomic_mass
#   entropy_atomic_mass
#   mean_fie
#   wtd_gmean_fie
#   wtd_gmean_fie
#   wtd_gmean_atomic_radius
#   entropy_Density

# Get training / validation fit
Train.fitted <- as.vector(predict(FitLasso, x.train))
Test.pred   <- as.vector(predict(FitLasso, x.test))

# Plot Y vs Yhat
plot( Train.fitted, as.matrix(Train.resp), xlab="Fitted", ylab="Actual",main="Final Test.set fit")
lines(Test.pred, as.matrix(Test.resp), type="p", xlab="Fitted", ylab="Actual", col="red", pch=20)
abline(0,1)


# 7. ----------------
#    Did LASSO regression improve training fit compared to OLS?
#    How about test fit?

Lasso <- data.frame(
  tr.RMSE      = caret::RMSE(Train.fitted, as.matrix(Train.resp)),
  tr.Rsquare   = caret::R2(  Train.fitted,           Train.resp),
  test.RMSE    = caret::RMSE(Test.pred,    as.matrix(Test.resp)),
  test.Rsquare = caret::R2(  Test.pred,              Test.resp)
)
Lasso

OLS
# Similarly to as in class, the Lasso regression is very similar in comparison to
# OLS. The test RMSE is slightly better in Lasso, and slightly worse in test RSquare
# This still shows how powerfull lasso is, since we did not have to manually assign which
# paramaters to use, this makes it much more straight forward to use, and we can even use it
# to determine what variables have significant impacts on the response variable
