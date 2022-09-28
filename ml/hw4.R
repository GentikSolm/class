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
library(tidyverse)
initial_heart <- read_csv(file = "https://nmimoto.github.io/datasets/heart.csv")

# 2. ----------------
#    In the dataset, remove column "X1".
#    Rename "AHD" column as "resp" and move it to the 1st column
#    Make sure following columns have class
#    "factor": "Sex", "ChestPain", "Fbs", "RestECG", "ExAng", "Thal"
#    remove rows that has NA.

heart <- initial_heart %>%
    #!!! X1 doesnt exist, removing "index" instead
    select(-"index")  %>%            # remove col named "index"
    rename(resp = AHD) %>%             # rename the column
    relocate(resp) %>%               # move "resp" to 1st column
    # Turn these columns to <factor> instead of <double>
    mutate(resp = as.factor(resp),
           Sex = as.factor(Sex),
           ChestPain = as.factor(ChestPain),
           Fbs = as.factor(Fbs),
           RestEsG = as.factor(RestECG),
           ExAng = as.factor(ExAng),
           Thal = as.factor(Thal))

summary(heart)
dim(heart)
sum(is.na(heart))
# If there is na in the data, run below
heart <- heart %>% na.omit()
dim(heart)

# 3. ----------------
#    Using seed "1534", separate the dataset into a
#    training set with 250 observations
#    and a testing set with 47 observations.
#    Separate the training set into 5-folds of
# $    50 obs each.

Orig <- heart      # Entire Data set (have to be data.frame)
train.size <- 250   # num of rows for training set
test.size <-  47    # num of rows for testing set
my.seed <- 1534     # give a seed
source('https://nmimoto.github.io/R/ML-00.txt')

# Visualizations dont help on this many dimensions
ix_no = (Train.set$resp=="No")
ix_yes = (Train.set$resp=="Yes")
plot(Train.set$RestBP[ix_no], Train.set$Chol[ix_no], xlab="RestBp", ylab="Chol")
lines(Train.set$RestBP[ix_yes], Train.set$Chol[ix_yes], col="red", type="p")

# 4. ----------------
#    In Ch4Lab-4 video, only the model that takes in all
#    column were investigated.
#    search for best Logistic Regression model that
#    gives highest validation AUC.

library(caret)
library(pROC)

AUCs <- MSE.valid <- matrix(0, 5, 2)
colnames(AUCs) = c("Train AUC", "Valid AUC")
print(CV.train)
for (k in 1:5) {
    Fit00 <- glm(resp ~ Sex+ChestPain+RestBP+Oldpeak+Slope+Ca+Thal, family=binomial, data=CV.train[[k]])
    #Fit00 <- glm(resp ~ ., family=binomial, data=CV.train[[k]])
    #- Extract fitted response (training)
    Train.prob = predict(Fit00, type ="response")  # fitted responses
    #- Predict in Validation Set
    Valid.prob = predict(Fit00, newdata=CV.valid[[k]], type="response")
    #- Check the training set accuracy
    # Train.pred = ifelse(Train.prob > threshold, "Yes", "No")  # Turn the fitted values to Up/Down using threshold of .5
    # Valid.pred = ifelse(Valid.prob > threshold, "Yes", "No")
    # CM.train <- confusionMatrix(factor(Train.pred),  factor(as.matrix(CV.train.resp[[k]])), positive="Yes")
    # CM.valid  <- confusionMatrix(factor(Valid.pred), factor(as.matrix(CV.valid.resp[[k]])), positive="Yes")
    AUCs[k,] <- round(c(auc(factor(as.matrix(CV.train.resp[[k]])), Train.prob, levels=c("No", "Yes")),
                        auc(factor(as.matrix(CV.valid.resp[[k]])), Valid.prob, levels=c("No", "Yes"))), 4)
}
AUCs

Av.AUCs = apply(AUCs, 2, mean)
names(Av.AUCs) = c("Av.Train AUC", "Av.Valid AUC")
Av.AUCs

# 5. ----------------
#    Using your best model from (4), perform the final Training/Test fit.
#    What is the test AUC?
#    Is your test AUC in reasonable range?

Fit05 <- glm(resp ~ Sex+ChestPain+Chol+RestECG+ExAng+Ca+Thal, family=binomial, data=Train.set)
Fit00 = Fit05

#- Extract fitted response (training)
Train.prob =predict(Fit00, type ="response")
head(Train.prob)

#- Predict in Test Set
Test.prob = predict(Fit00, newdata=Test.set, type="response")
head(Test.prob)

threshold = .68   # pick a threshold

    #- Check the training set accuracy
    library(caret)
    Train.pred = ifelse(Train.prob > threshold, "Yes", "No")  # Turn the fitted values to Up/Down using threshold of .5
    Test.pred  = ifelse(Test.prob  > threshold, "Yes", "No")
    CM.train <- confusionMatrix(factor(Train.pred), factor(as.matrix(Train.resp)), positive="Yes")
    CM.test  <- confusionMatrix(factor(Test.pred),  factor(as.matrix(Test.resp)),  positive="Yes")

    CM.train            # Training set result
    CM.train$table      # output just the table

    CM.train[["byClass"]][["Sensitivity"]]
    CM.train[["byClass"]][["Specificity"]]

    CM.test             # Testing set
    CM.test$table      # output just the table

    # Test set result
    #               Reference
    # Prediction      No Yes
    #        No     1437  62         [Specificity][  ]  = TrueNeg / sum of col
    #        Yes       0   1         [  ][Sensitivity]  = TruePos / sum of col

    colSums(CM.test$table) / sum(colSums(CM.test$table))    # % of Actual Yes/No
    rowSums(CM.test$table) / sum(rowSums(CM.test$table))    # % of predicted Yes/No


###----------------------------
#- 3b Output ROC curve and AUC for all threshold
library(pROC)
    #- Training Set
    plot.roc(factor(as.matrix(Train.resp)),  Train.prob, levels=c("No", "Yes"))
    # point corresponding to CM.train
    abline(h=CM.train[["byClass"]][["Sensitivity"]], v=CM.train[["byClass"]][["Specificity"]], col="red")
    auc.train = auc(factor(as.matrix(Train.resp)), Train.prob, levels=c("No", "Yes"))
    text(.2, .2, paste("Train AUC=",round(auc.train, 3)))

    #- Test Set
    plot.roc(factor(as.matrix(Test.resp)),  Test.prob, levels=c("No", "Yes"))
    # point corresponding to CM.test
    abline(h=CM.test[["byClass"]][["Sensitivity"]], v=CM.test[["byClass"]][["Specificity"]], col="red")
    auc.test = auc(factor(as.matrix(Test.resp)), Test.prob, levels=c("No", "Yes"))
    text(.2, .2, paste("Test AUC=",round(auc.test, 3)))

    c(auc.train, auc.test)



layout(matrix(1:2, 1, 2))
    plot.roc(factor(as.matrix(Train.resp)),  Train.prob, levels=c("No", "Yes"))
    text(.2, .2, paste("Train AUC=",round(auc.train, 3)))
    plot.roc(factor(as.matrix(Test.resp)),  Test.prob, levels=c("No", "Yes"))
    text(.2, .2, paste("Test AUC=",round(auc.test, 3)))
    layout(1)



plot(AUCs[,2], col="red", ylim=c(.5,1))
lines(AUCs[,1], type="p")
abline(h=auc.test)

AUCs
Av.AUCs
c(auc.train, auc.test)


# I believe the AUC is in a reasonable range at .912 train and .909 test


# 6. ----------------
#    For somebody who is actually using your 'best' logistic regression model
#    to predict the presense of the heart disease, recommend
#    the value of threshold (b/w .1 - .9).
#    You must come up with your own cost function for (TP, TN, FP, FN).

cost.list = c(0,0,3,2)/5           # order of (TP, TN, FP, FN)
threshold.list = seq(0.01,.99,.01)    # grid for threshold
cost=0
library(caret)      # for confusionMatrix
for (i in 1:length(threshold.list)){

    threshold = threshold.list[i]

    #- Check the training set accuracy
    Test.pred  = ifelse(Test.prob  > threshold, "Yes", "No")
    CM.test  <- confusionMatrix(factor(Test.pred),
                                factor(as.matrix(Test.resp)),
                                positive="Yes")
    TP = CM.test$table[2,2]   # True  Pos
    TN = CM.test$table[1,1]   # True  Neg
    FP = CM.test$table[2,1]   # False Pos
    FN = CM.test$table[1,2]   # False Neg

    cost[i] = sum(c(TP, TN, FP, FN) * cost.list)
}
plot(threshold.list, cost, xlab="threshold")

cost.list
which.min(cost)
min(cost)
threshold.list[which.min(cost)]

# Model:
summary(Fit00)

# I recommend using a threshold of .68, as demonstrated in the code, as that results in
# very vew False positives, with some false negatives. This test can be used to confirm for
# with very high certianty that someone may have the given disease

