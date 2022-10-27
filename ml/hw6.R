#
##
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
library('datasets')
data(iris)
library(tidyverse)
Iris <- as_tibble(iris)
attach(Iris)
Iris



# 2. ----------------
#    In the dataset, mutate entries of "Species" column as "Yes" if Species were
#    equal to "versicolor", and as "No" otherwise.
#    Rename "Species" column as "resp" and move it to the 1st column.
Iris['Species'] <- ifelse(Iris['Species'] == 'versicolor', "Yes", "No")

# Veryifyin correct mutation
sum(Iris['Species'] == 'Yes')

Iris  <- Iris %>%
    mutate(Species=as.factor(Species)) %>%
    rename(resp = Species) %>%
    relocate(resp)


# 3. ----------------
#    Using seed "1234", separate the dataset into a training set with 125 observations
#    and a testing set with 25 observations.  Separate the training set into 5-folds of
#    25 obs each.
my.seed <- 1234
set.seed(my.seed)

train.size <- 125
test.size <- 25
Orig <- Iris
source('https://nmimoto.github.io/R/ML-00.txt')

# Output (all data.frame):
Train.set      #  Train.resp
Test.set       #  Test.resp
CV.train[[k]]  #  CV.train.resp[[k]]
CV.valid[[k]]  #  CV.valid.resp[[k]]

length(CV.train) # 5 folds

# 4. ----------------
#    Fit the "resp" column with Logistic Regression using all remaining columns in
#    the model.  No need to use CV training/validation, just Training / Testing fit is fine.
#    What is the test AUC of the model?

set.seed(my.seed)
Fit01 <- glm(resp ~., family=binomial, data=Train.set )
summary(Fit01)
coef(Fit01)
library(pROC)
Valid.prob <- predict(Fit01, Test.set, type='response')
logreg.auc = auc(Test.set$resp, Valid.prob, levels=c("No", "Yes"))
logreg.auc # .881

# 5. ----------------
#    Repeat (4) using Decision Tree model (Grow and Prune).  How many
#    terminal node is in your tree?  What is the test AUC?

library(tree)
set.seed(my.seed)
tree1 = tree(resp~., Train.set)
summary(tree1)
tree1

plot(tree1)
text(tree1, pretty=0, cex=1)

# Check the training fit and test prediction
Valid.prob    = predict(tree1, Test.set, type="class")

# I have no idea what the proper way to do this was, After 2 hours of searching how to properyl get AUC from categorical
# resp, i founds this, and it seems to work so im using it
roc.tree = roc(response=Test.set$resp, predictor=factor(Valid.prob, ordered=TRUE), plot=FALSE)

# No pruning needed, tree is already at 5 nodes.
grow.auc = auc(roc.tree)
grow.auc # .8571

# 6. ----------------
#    Repeat (4) using Support Vector Machine with Lienar Kernel, and Radial Kernel.
#    Use tune() function with Auto 5-fold CV to find the best parameter values
#    for each kernel. List parameter values here. What is the test AUC?
library (e1071)

set.seed(my.seed)
tuned.linear = e1071::tune(svm, resp~., data=Train.set, kernel ="linear",ranges=list(cost=c(0.01, 0.1, 1, 5, 10, 100, 1000)), scale=TRUE, tunecontrol=tune.control(cross=5))
linear.svm = tuned.linear$best.model
linear.pred = predict(linear.svm, Test.set, decision.values=TRUE)
linear.prob = attributes(linear.pred)$decision.values
linear.auc = pROC::auc(factor(as.matrix(Test.resp)), as.vector(linear.prob), levels=c("No", "Yes"))

summary(linear.svm)
# Paramater Values:
linear.svm$SV
# test AUC for Linear
linear.auc # .8413

set.seed(my.seed)
tuned.radial = e1071::tune(svm, resp~., data=Train.set, kernel ="radial",ranges=list(gamma = 2^(-1:4),cost=c(0.001, 0.01, 0.1, 1, 5, 10, 100, 1000)),scale=TRUE,tunecontrol=tune.control(cross=5))
radial.svm = tuned.radial$best.model
radial.pred = predict(radial.svm, Test.set, decision.values=TRUE)
radial.prod = attributes(radial.pred)$decision.values
radial.auc = pROC::auc(factor(as.matrix(Test.resp)), as.vector(radial.prod), levels=c("No", "Yes"))

summary(radial.svm)
# Paramater Values:
radial.svm$SV
# test AUC for radial
radial.auc # .9841

# 7. ----------------
#    Out of the models you fit in this assignment, which one is the best model,
#    and why?

# Radial seems to performed the best by a large margin, beating out almost all other AUCs by about 10 points. For easy comparison:
# in order of best to worst
radial.auc # .9841
linear.auc # .8413
grow.auc   # .8571
logreg.auc # .881


# 8. ----------------
#    For your best model chosen in (7), suggest the threshold value to use.
#    Copy the test confusion matrix for that threshould here.

# I would suggest a threshold of .8 for the radial SVM. The confusion matrix is
threshold <- .8
test.pred = ifelse(radial.prod > threshold, "No", "Yes")
CM.test <- caret::confusionMatrix(factor(test.pred), factor(as.matrix(Test.resp)), positive="Yes")
# Here we can see a very good confusion matrix, with only 2 wrong guesses out of 25, and an accuracy of .92
CM.test 
