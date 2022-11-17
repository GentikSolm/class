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
# Using CCS as resp
library(tidyverse)   # install.packages(tidyverse")
concrete <- read_csv("https://nmimoto.github.io/datasets/concrete.csv")
concrete <- as_tibble(concrete)

concrete <- concrete %>%
    rename(resp = CCS) %>%             # rename the column
    relocate(resp)

concrete.means <- concrete %>% mutate_each(mean)
concrete.means
concrete.SDs   <- concrete %>% mutate_each(sd)
concrete.SDs
concrete <- tibble((concrete - concrete.means)/concrete.SDs)

attach(concrete)
# 2. ----------------
#    Using seed "8346", separate the dataset into a training set with 850 observations
#    and a testing set with 180 observations.  Separate the training set into 5-folds of
#    170 obs each.
my.seed <- 2356
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

Fit1 <- lm(resp ~., data=Train.set) # All variables
summary(Fit1) 

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

# 4. ----------------
#    Using Cross Validation, fit Neueal Network model with
#    all variables in the dataset, using 1 hidden layer with 3 nodes.
#    Make sure the dataset you feed into NN is scaled.
#    Report av. training RMSE and av. validation RMSE.

library(neuralnet)
sigmoid <- function(x) 1 / (1 + exp(-x))

layout(matrix(1:6, 2, 3, byrow=TRUE))    # to plot 5 in 1 page
CVFitDiagnosis <- numeric(0)
for (k in 1:5) {
    set.seed(my.seed)
    Fit00 = neuralnet::neuralnet(resp ~.,            # Columns for NN
                                 CV.train[[k]],
                                 hidden=3,             # Vector of ints specifying neurons per hidden node
                                 learningrate=1e-5,    # used by backpropagation
                                 act.fct=sigmoid,
                                 linear.output=TRUE)   # This should be TRUE for regression
    #--- Get training / validation fit
    Train.fitted = predict(Fit00, newdata=CV.train[[k]], type="vector")
    Valid.fitted = predict(Fit00, newdata=CV.valid[[k]], type="vector")

    #--- Plot Y vs Yhat
    plot( Train.fitted, as.matrix(CV.train[[k]]$resp), xlab="Fitted", ylab="Actual",main=paste("K=",k))
    lines(Valid.fitted, as.matrix(CV.valid[[k]]$resp), type="p", xlab="Fitted", ylab="Actual", col="red", pch=20)
    abline(0,1)

    library(caret)            # install.packages("caret")
    CVFitDiagnosis1 <- data.frame(
                                  tr.RMSE   = caret::RMSE(Train.fitted, as.matrix(CV.train[[k]]$resp)),
                                  tr.Rsquare  = caret::R2(Train.fitted,           CV.train[[k]]$resp),
                                  val.RMSE  = caret::RMSE(Valid.fitted, as.matrix(CV.valid[[k]]$resp)),
                                  val.Rsquare = caret::R2(Valid.fitted,           CV.valid[[k]]$resp)
    )
    CVFitDiagnosis <- rbind(CVFitDiagnosis, CVFitDiagnosis1)
}
layout(1)
CVFitDiagnosis
Av.CVFitDiagnosis = apply(CVFitDiagnosis, 2, mean)
Av.CVFitDiagnosis

# 5. ----------------
#    Look for better model by changing the number of hidden layers
#    and number of nodes. (Use CV and look at av. valid. RMSE.)

nets = list(
    c(3,3),
    c(7),
    c(7,7),
    c(10,5,2)
)

for (layer in nets){

    CVFitDiagnosis2 <- numeric(0)
    CVFitDiagnosis2 <- tryCatch({
        for (k in 1:5) {
            set.seed(my.seed)
            Fit00 = neuralnet::neuralnet(resp ~.,            # Columns for NN
                                         CV.train[[k]],
                                         hidden=layer,
                                         threshold=.1,
                                         stepmax=1e+8,
                                         learningrate=1e-5,    # used by backpropagation
                                         act.fct=sigmoid,
                                         linear.output=TRUE)   # This should be TRUE for regression
            #--- Get training / validation fit
            Train.fitted = predict(Fit00, newdata=CV.train[[k]], type="vector")
            Valid.fitted = predict(Fit00, newdata=CV.valid[[k]], type="vector")

            library(caret)            # install.packages("caret")
            CVFitDiagnosis1 <- data.frame(
                                          tr.RMSE   = caret::RMSE(Train.fitted, as.matrix(CV.train[[k]]$resp)),
                                          tr.Rsquare  = caret::R2(Train.fitted,           CV.train[[k]]$resp),
                                          val.RMSE  = caret::RMSE(Valid.fitted, as.matrix(CV.valid[[k]]$resp)),
                                          val.Rsquare = caret::R2(Valid.fitted,           CV.valid[[k]]$resp)
            )
            CVFitDiagnosis2 <- rbind(CVFitDiagnosis2, CVFitDiagnosis1)
        }
        CVFitDiagnosis2
    },
    error=function(cond){return(NA)})
    if(typeof(CVFitDiagnosis2) == 'list'){
        CVFitDiagnosis2
        Av.CVFitDiagnosis2 = apply(CVFitDiagnosis2, 2, mean)
        print(layer)
        print(Av.CVFitDiagnosis2)
        print('-----')
    } else {
        print(layer)
        print('Failed to converge')
        print('-----')
    }
}


# 6. ----------------
#    Perform the final Training/Test fit using the model in (4) or (5).
#    Report training RMSE and test RMSE.

library(neuralnet)            # install.packages('neuralnet', repos='https://cran.case.edu/')
sigmoid <- function(x) 1 / (1 + exp(-x))

set.seed(my.seed)
Fit01 = neuralnet::neuralnet(resp ~.,
                             Train.set,
                             hidden=7,
                             learningrate=1e-5,
                             threshold=.1,
                             stepmax=1e+8,
                             act.fct=sigmoid,
                             linear.output=TRUE)
                             # linear.output FALSE means activation function is applied to output node

summary(Fit01)
plot(Fit01)

#--- Get training / validation fit
Train.fitted = predict(Fit01, newdata=Train.set, type="vector")
Test.fitted  = predict(Fit01, newdata=Test.set, type="vector")

#--- Plot Y vs Yhat
plot( Train.fitted, as.matrix(Train.set$resp), xlab="Fitted", ylab="Actual",main="Final Test.set Fit")
lines(Test.fitted,  as.matrix(Test.set$resp), type="p", xlab="Fitted", ylab="Actual", col="red", pch=20)
abline(0,1)

library(caret)            # install.packages("caret")
FinalFitDiagnosis <- data.frame(
  tr.RMSE   = caret::RMSE(Train.fitted,  as.matrix(Train.set$resp)),
  tr.Rsquare  = caret::R2(Train.fitted,            Train.set$resp),
  test.RMSE  = caret::RMSE(Test.fitted,  as.matrix(Test.set$resp)),
  test.Rsquare = caret::R2(Test.fitted,            Test.set$resp)
)
FinalFitDiagnosis

## Compare to
Av.CVFitDiagnosis


# 7. ----------------
#    Scale back the predicted Test set response of (6), and
#    re-calculate the test RMSE.
#    Compare it to the Test RMSE from (3). Which model has more
#    prediction power?  Which model is easier to interprete?

Train.fitted = predict(Fit01, newdata=Train.set, type="vector")
Test.fitted = predict(Fit01, newdata=Test.set, type="vector")
Train.resp = Train.set$resp
Test.resp = Test.set$resp

Train.fitted.unscaled <- concrete.means$resp[1] + Train.fitted * concrete.SDs$resp[1]
Train.resp.unscaled   <- concrete.means$resp[1] + Train.resp   * concrete.SDs$resp[1]
Test.fitted.unscaled  <- concrete.means$resp[1] + Test.fitted  * concrete.SDs$resp[1]
Test.resp.unscaled    <- concrete.means$resp[1] + Test.resp    * concrete.SDs$resp[1]

plot( Train.fitted.unscaled, as.matrix(Train.resp.unscaled), xlab="Fitted", ylab="Actual",main="Final Test.set fit - Unscaled")
lines(Test.fitted.unscaled,  as.matrix(Test.resp.unscaled), type="p", xlab="Fitted", ylab="Actual", col="red", pch=20)
abline(0,1)

library(caret)            # install.packages("caret")
FinalFitDiagnosis.unsc <- data.frame(
  tr.RMSE   = caret::RMSE(Train.fitted.unscaled, as.matrix(Train.resp.unscaled)),
  tr.Rsquare  = caret::R2(Train.fitted.unscaled,           Train.resp.unscaled),
  test.RMSE  = caret::RMSE(Test.fitted.unscaled,  as.matrix(Test.resp.unscaled)),
  test.Rsquare = caret::R2(Test.fitted.unscaled,            Test.resp.unscaled)
)
FinalFitDiagnosis.unsc

# According to the output, the Rsquare for the NN is much higher, indicating that the NNs predictions account for much more variability in the data vs OLS
# The RSME is higher for the final fit unscaled, however this makes sense, and is more interpreteable, since this number
# is in terms of the original data, signifying that the error for our NN in predicting the resp value of CCS is around 6 units.
# If we use the linear regression fit, we cannot get a good feel for how much error there truely is in terms of the original units.
