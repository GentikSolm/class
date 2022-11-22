# Part 1
```R
m <- 1000
n <- 10
mu <- 10 
sig <- 2 
sample.matrix <- matrix(rnorm(m*n, mu, sig), nrow=m, ncol=n)
xmed.values <- apply(sample.matrix, 1, median)
par(mfrow=c(2,2))
hist(xmed.values, main = paste("Histogram for x-Median values, n=", n))

m <- 1000
n <- 40 
mu <- 10  
sig <- 2 
sample.matrix <- matrix(rnorm(m*n, mu, sig), nrow=m, ncol=n)
xmed.values <- apply(sample.matrix, 1, median)
hist(xmed.values, main = paste("Histogram for x-Median values, n=", n))
```

# Part 2
```R
N <- 1000
U1 <- runif(N,0,1)
THETA <- 2*pi*U1
U2 <- runif(N,0,1)
E <- -log(U2)
R <- sqrt(2*E)
X1 <- R*cos(THETA)
Y1 <- R*sin(THETA)
zmat <- cbind(X1,Y1) 
par(mfrow=c(4,3))
for(poprho in c(
           .9,
           .7,
           .5,
           .3,
           .1,
           0,
           -.1,
           -.3,
           -.5,
           -.7,
           -.9
           )){

    sigma <- matrix(c(1,poprho,poprho,1),2,2)
    zmatrix <- zmat%*%chol(sigma)
    X <- zmatrix[, 1]
    Y <- zmatrix[, 2]
    cor(X,Y)
    sim <- 23 
    rxy <- matrix(0,sim,1) 
    for(i in 1:sim) {
        n <- 30
        index <- sample(1:N,n,r=F)
        X1 <- X[index]
        Y1 <- Y[index]
        Xsq <- X1^2
        Ysq <- Y1^2
        XY <- X1*Y1
        Xcume <- sum(X1)
        Ycume <- sum(Y1)
        Xsqcume <- sum(Xsq)
        Ysqcume <- sum(Ysq)
        XYcume <- sum(XY)
        r <- (XYcume - (((Xcume)*(Ycume))/n))/(sqrt(Xsqcume - (Xcume^2/n))*sqrt(Ysqcume - (Ycume^2/n)))
        rxy[i] <- (1/2)*log((1+r)/(1-r))
    }
    hist(rxy, main=poprho)
    abline(v=poprho,lty=1)
}
```
