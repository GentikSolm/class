###
###
###  484/584 Intro to ML
###        Assignemnt 1
###
####################################################
##  Due Wed Aug 31 11:00pm
##
##
##  Write a R code that performs tasks lited below.
##  Use this text file as template. Submit on Brightspace
##  under "Assessment" -> "Assignemnt 1".
##
##  Refer to Intro to R-studio video list for basic idea of how to
##      do these tasks.
##  For particular functions, you may have to google.


#------------------------------
# 1. Write a R code that calculates the probability that (X > 4) when X is
#    a chi-squared disribution with degrees of freedom 5.


# 2. Write a R code that calculates the 78th percentile of chi-square
#    distribution with degrees of freedom 5.


# 3. Generate random sample of size 1000 from chi-square distribution with
#    degrees of freedom 5.  Set seed to "1234" right before the generation.


# 4. Plot histogram of above sample.


# 5. Overlay theoretical pdf of Chi-square with df 5 over the
##      histogram plot above.
#    Overlayed pdf must be in green, and must span entire x
#       axis of the histogram.


# 6. Use following code to generate 100 by 30 matrix:

  set.seed(653)
  D <- rexp(3000, 1 / 5)
  X <- matrix(D, 100, 30)

# Write a code that looks up 3rd colummn, from row 10 to 20.



# 7. Write a code that counts how many rows in the 25th column is
#       greater than 5.



# 8. Create a new matrix Y by the follwing rule: If a row of Matrix X has entry
#    less than 7 on the 15th column, then all column for that row should be
#    included in new matrix Y.  What are the dimentions of Y?
