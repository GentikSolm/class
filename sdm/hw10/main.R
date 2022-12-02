placebo <- c(9243, 9671, 11792, 13357, 9055, 6290, 12412, 18806)
oldpatch <- c(17649, 12013, 19979, 21816, 13850, 9806, 17208, 29044)
newpatch <- c(16449, 14614, 17274, 23798, 12560, 10157, 16570, 26325)
patch <-cbind(placebo,oldpatch,newpatch)
patch
y <- newpatch - oldpatch
z <- oldpatch - placebo
boxplot(y/z)
# Boxplot for eight rations. There may be some outliers and the distribution is not
# symmetric, so the standard inference based on the normal assumption does not apply here.
theta <- mean(y)/mean(z)
# this gives us a plug-in estimate of ^θ. How good is this estimate? 
# Next we’ll use Jackknife and Bootstrap procedures to estimate θ.


n <- 8 #set the sample size
jack <- rep(0,n) #initialize the vector
for(j in 1:n) {
    jack[j] <- mean( y[-j]) / mean (z[-j]) #compute ^θ(i) for each i
}
jack
mean_jack <- mean(jack) #this is θ jack
bias_jack <- (n-1)*(mean_jack - theta) #this is the Jackknife estimate of Bias
est_jack <- theta - bias_jack #this is the Jackknife biased corrected estimate
cbind(theta,mean_jack,bias_jack, est_jack)


n <- 8
B <- 1000 #set the Bootstrap sample size
br <- rep(0,B) #initialize a space for the Bootstrap sample
for(b in 1:B) {
    index <- sample(1:n,r=T)
    br[b] <- mean(y[index])/ mean(z[index])
}
br

# Since we have no idea of the distribution of (Y,Z), we must use the non-parametric bootstrap procedure, 
# where the Bootstrap sample are drawn by a simple random sampling with replacement from the original sample data.
xbar_boot <- mean(br) #mean of all bootstrap means.
bias_boot <- theta - xbar_boot #estimate of the bias
cbind(theta,xbar_boot,bias_boot)
hist(br)
abline(v=theta,lty=1)
abline(v=xbar_boot,lty=2)

###Bootstrap 95% CI###
xbar_boot <- mean(br)
t_crit <- qt(.975,n-1)
SE_boot <- sqrt((1/(B-1))*sum((br - xbar_boot)^2)) #bootstrap standard error
LB <- xbar_boot - (t_crit*SE_boot)
UB <- xbar_boot + (t_crit*SE_boot)
cbind(LB,UB)

###95% Bootstrap Percentile CI###
LB_p <- sort(br)[25]
UB_p <- sort(br)[975]
cbind(LB_p,UB_p)




# Problem 2
A <- c(29.9, 11.4, 25.3, 16.5)
m <- length(A)
B <- c(26.6, 23.7, 28.5, 14.2, 17.9)
n <- length(B)
X <- append(A,B)
Xsum <- sum(X)
Asum <- sum(X[1:m])
Bsum <- Xsum - Asum
truediff <- Asum/m - Bsum/n
print("truediff")
truediff
abstruediff <- abs(truediff)
print("abstruediff")
abstruediff
perm <- 10000 #number of permutations
difflist <- matrix(0,perm,1) # initialize a matrix with
for(i in 1:perm) {
S <- sample(X,m)
pasum <- sum(S)
pbsum <- sum(X) - sum(S)
diff <- pasum/m - pbsum/n
difflist[i] <- diff
}
difflist <- sort(difflist)
Ltail <- sum(ifelse(difflist <= -abstruediff ,1,0))
Rtail <- sum(ifelse(difflist >= abstruediff ,1,0))
Pvalue <- (Ltail + Rtail)/perm
print("Pvalue")
Pvalue #two-tail p-value
hist(difflist)
abline(v= -abstruediff,lty=1)
abline(v= abstruediff,lty=2)


# Probelm 3
A <- c(24, 61, 59, 46, 43, 44, 52, 43, 58, 67, 62, 57, 71, 49, 54, 43, 53, 57, 49, 56, 33)
m <- length(A)
B <- c(42, 33, 46, 37, 43, 41, 10, 42, 55, 19, 17, 55, 26, 54, 60, 28, 62, 20,  53, 48, 37, 85, 42)
n <- length(B)
X <- append(A,B)
Xsum <- sum(X)
Asum <- sum(X[1:m])
Bsum <- Xsum - Asum
truediff <- Asum/m - Bsum/n
print("truediff")
truediff
abstruediff <- abs(truediff)
print("abstruediff")
abstruediff
perm <- 10000 #number of permutations
difflist <- matrix(0,perm,1) # initialize a matrix with
for(i in 1:perm) {
S <- sample(X,m)
pasum <- sum(S)
pbsum <- sum(X) - sum(S)
diff <- pasum/m - pbsum/n
difflist[i] <- diff
}
difflist <- sort(difflist)
Ltail <- sum(ifelse(difflist <= -abstruediff ,1,0))
Rtail <- sum(ifelse(difflist >= abstruediff ,1,0))
Pvalue <- (Ltail + Rtail)/perm
print("Pvalue")
Pvalue #two-tail p-value
hist(difflist)
abline(v= -abstruediff,lty=1)
abline(v= abstruediff,lty=2)
