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

mse_train <- mse_valid <- matrix(0, 5)
for (k in 1:5) {
    fit01 <- lm(CCS ~ poly(Age, deg_poly), data = cv_train[[k]])
    summary(fit01)
    #--- CV Training MSE
    mse_train[k] <- mean(fit01$residuals^2)
    #--- CV Validation MSE
    fit01_pred <- predict(fit01, newdata = cv_valid[[k]])
    mse_valid[k] <- mean((cv_valid[[k]]$CCS - fit01_pred)^2)
}
# MSE
print(mse_train)
print(mse_valid)

# Observations in training set
nrow(cv_train[[2]])
# Observations in validation set
nrow(cv_valid[[1]])

# 5. ----------------
#    Produce deg.poly vs MSE.valid plot, for CCS vs Polinomial of Age.
#    (You can use section 2.b)
#    Using the plot, decide on the best value of deg.poly.

mse_train <- mse_valid <- matrix(0, 5, 10)
for (deg_poly in 1:10) {
    for (k in 1:5) {

        fit01 <- lm(CCS ~ poly(Age, deg_poly), data = cv_train[[k]])
        summary(fit01)
        #--- CV Training MSE
        mse_train[k, deg_poly] <- mean(fit01$residuals^2)
        #--- CV Validation MSE
        fit01_pred <- predict(fit01, newdata = cv_valid[[k]])
        mse_valid[k, deg_poly] <- mean((cv_valid[[k]]$CCS - fit01_pred)^2)
    }
}

av_mse_train <- apply(mse_train, 2, mean)
av_mse_valid <- apply(mse_valid, 2, mean)
cbind(av_mse_train, av_mse_valid)


# Plot Average MSE
plot(av_mse_train, type = "o", ylab = "MSE")
lines(av_mse_valid, type = "o", col = "red")
legend(2, 40, lty = 1, c("Train MSE", "Valid MSE"), col = c("black", "red"))

# The best value of deg_poly is 4, since
#   both av_mse_train and av_mse_valid flatline after 4,
#   and are closest together at 4

# 6. ----------------
#    Perform the final test fit using the test set.
#    Note this time the entire Training set (850 obs) is the Training set, and
#    Test set (180 obs) is the Test set.
#    What is the final test MSE?
#    qhat is the mathematical equation of the your final polynomial?

deg_poly <- 4

fit05 <- lm(CCS ~ poly(Age, deg_poly), data = train_set)
summary(fit05)
#- CV Training MSE
mse_train <- mean(fit05$residuals^2)
#- CV Validation MSE
pred <- predict(fit05, newdata = test_set)
mse_test <- mean((test_set$CCS - pred)^2)

cbind(mse_train, mse_test)


# Plot the fit
plot(train_set$Age, train_set$CCS, xlab = "Age",
     ylab = "CCS", main = "Final Model")
lines(test_set$Age, test_set$CCS, col = "red", type = "p", pch = 19)
ix  <-  sort(train_set$Age, index.return = TRUE)$ix
lines(train_set$Age[ix], fit05$fitted[ix], lwd = 2, col = "blue")
text(30, 49, paste("d=", deg_poly, ": MSE.train=", round(mse_train, 2)))
text(30, 46, paste("          MSE.test=", round(mse_test, 2)), col = "red")

# Final MSE
print(mse_test)
# Mathmatical Equiation of final polynomial
summary(fit05)
