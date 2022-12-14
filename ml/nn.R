###
###
### Boston Data (MASS) - Newral Network (Regression)
###                         with 5-fold Cross Validation
###   ver 0.0.4
###
#################################



###-------------------------------------------------
###--- 0. Preliminary

# Using Boston3 from https://nmimoto.github.io/R/boston0.txt
library(MASS)                # install.packages("MASS")
library(tidyverse)           # install.packages("tidyverse")
Boston <- as_tibble(Boston)
Boston

# Rename "medv" column as "resp" to streamline analysis.
Boston2 <- Boston %>% rename(resp=medv) %>% relocate(resp)
Boston2

# turn "chas" column into 0/1 factor
Boston3 <- Boston2 %>% mutate( chas=as.factor(chas) )
Boston3


Boston4 <- Boston2 %>% mutate(chas=as.numeric(chas), rad=as.numeric(rad))
Boston4

# Scalse all variables to be used in NN
Boston5 <- Boston2 %>% mutate_each(base::scale)
Boston5

# Same as above, but this way you keep means and SD for unscaling
Boston.means <- Boston2 %>% mutate_each(mean)
Boston.means
Boston.SDs   <- Boston2 %>% mutate_each(sd)
Boston.SDs
Boston6 <- tibble((Boston2 - Boston.means)/Boston.SDs)
Boston6

###
###  NN requres all input to be numeric, and each columns to be scalsed.
###  So "chas" column being a factor will be an problem.
###


# Importance List by Chisq test

  # top list:
  # 3  4  6 10
  # "zn" "indus" "nox"   "rad"

  # bottom list
  # c(7, 8, 9, 13)
  # "rm"    "age"   "dis"   "black"

  #1  resp    (dbl)   <- used to be "medv". Response variable (Y).
  #2  crim    (dbl)
  #3  zn      (dbl)
  #4  indus   (dbl)
  #5  chas    (factor)
  #6  nox     (dbl)
  #7  rm      (dbl)
  #8  age     (dbl)
  #9  dis     (dbl)
  #10 rad     (dbl)
  #11 tax     (dbl)
  #12 ptratio (dbl)
  #13 black   (dbl)
  #14 lstat   (dbl)



# check to see if Boston3 has NA
Orig <- Boston6

#- Check for N/A in data. Remove if there's any.
  summary(Orig)
  sum(is.na(Orig))
  # If there is na in the data, run below
  dim(Orig)
  Orig <- Orig %>% na.omit()
  dim(Orig)



###-------------------------------------------------
###--- 1. Data Separation (Copied from Rtut-CV)
### Divide Dataset to Training and Testing and Set up k fold CV
Orig <- Orig                 # Entire Data set (have to be data.frame)
train.size <- 400            # num of rows for training set
test.size <- 106             # num of rows for testing set
my.seed <- 3231              # give a seed

  ###
  ### This line replaces the AAAA to BBBB chunk
  source('https://nmimoto.github.io/R/ML-00.txt')
  ###

# Output (all data.frame):
#   Train.set      /  Train.resp
#   Test.set       /  Test.resp
#   CV.train[[k]]  /  CV.train.resp[[k]]
#   CV.valid[[k]]  /  CV.valid.resp[[k]]


#--- plot Training and Test for visualization
fold = 2
plot(CV.train[[fold]]$lstat,  CV.train[[fold]]$resp, xlab="lstat", ylab="Response (medv)")
lines(CV.valid[[fold]]$lstat, CV.valid[[fold]]$resp, type="p", col="red", pch=19)




###-------------------------------------------------
###--- 2. Newral Network with manual CV

library(neuralnet)
sigmoid <- function(x) 1 / (1 + exp(-x))

layout(matrix(1:6, 2, 3, byrow=TRUE))    # to plot 5 in 1 page
CVFitDiagnosis <- numeric(0)
for (k in 1:5) {

  set.seed(my.seed)
  Fit00 = neuralnet::neuralnet(resp ~.,            # <===== Try using different set of columns here
                             CV.train[[k]],
                             hidden=3,             # <===== Try different num of nodes here
                             learningrate=1e-2,    # <===== For numerical problem try changing number here
                             act.fct=sigmoid,
                             linear.output=TRUE)   # This should be TRUE for regression
                             # linear.output FALSE means activation function is applied to output node
  # summary(Fit00)
  # plot(Fit00)  # Use only if NN is small enough (hidden <10)

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


  ##
  ##  Try Fit00 with hidden=5, c(5,5).
  ##  Try Fit00 with linear output=FALSE
  ##  Try running above couple of times with same setting.
  ##        You get slightly diffrent number due to random starting point for parameters.
  ##


  ##
  ##  Av. val.RMSE is the summary for how good this model is fitting over all CV
  ##     (try hidden= 3, 6, 10 to see how tr.RMSE vs valRMSE picture changes)
  ##  You can also use Av. val.Rsquares.  Both of them does not have penalty over number of parameters in the model.
  ##





###-------------------------------------------------
###--- 3. NN final fit with Train set

## [ Train.set 400     ]     [Test.set 106]
## [80][80][80][80][80]
library(neuralnet)            # install.packages('neuralnet', repos='https://cran.case.edu/')
sigmoid <- function(x) 1 / (1 + exp(-x))

set.seed(my.seed)
Fit01 = neuralnet::neuralnet(resp ~.,
                             Train.set,
                             hidden=3,
                             learningrate=1e-2,
                             act.fct=sigmoid,
                             linear.output=TRUE)
                             # linear.output FALSE means activation function is applied to output node

summary(Fit01)
# plot(Fit01)  # Use only if NN is small enough (hidden <10)

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
CVFitDiagnosis
Av.CVFitDiagnosis


##
##  Use test.RMSE or test.Rsquare as summary of the model fit.  These numbers does not have penalty for having more parameters.
##





##------------------------
## 3. unscaling the fitted response to compare RMSE
##
##  To compare test.RMSE with other models, you need to UNscale Test.fitted.
##  Sinc Rsquare is unit-invariant, you can compare test.Rsquare with other models directly.
##

Train.fitted = predict(Fit01, newdata=Train.set, type="vector")
Test.fitted = predict(Fit01, newdata=Test.set, type="vector")
Train.resp = Train.set$resp
Test.resp = Test.set$resp

Train.fitted.unscaled <- Boston.means$resp[1] + Train.fitted * Boston.SDs$resp[1]
Train.resp.unscaled   <- Boston.means$resp[1] + Train.resp   * Boston.SDs$resp[1]
Test.fitted.unscaled  <- Boston.means$resp[1] + Test.fitted  * Boston.SDs$resp[1]
Test.resp.unscaled    <- Boston.means$resp[1] + Test.resp    * Boston.SDs$resp[1]

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


##
##  Use test.RMSE or test.Rsquare as summary of the model fit.  These numbers does not have penalty for having more parameters.
##

