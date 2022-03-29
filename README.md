
# Mbalance

An R package for Mahalanobis balancing.

<!-- badges: start -->
<!-- badges: end -->

## Overview

This R package implements the Mahalanobis balancing method for estimating average treatment effect or average treatment effect in the controlled or treated group that is proposed in our paper: . It includes Mahalanobis balancing and high-dimensional Mahalanobis balancing method. 

- `MB()` produces an estimate of average treatment effect (ATE) or average treatment effect in the controlled or treated group (ATC or ATT).
- `hdMB()` produces an estimate of average treatment effect (ATE) or average treatment effect in the controlled or treated group (ATC or ATT) in high-dimensional data.


## Installation

You can install the development version of MBalance from [GitHub](https://github.com/) with:

``` r
if (!require("devtools")){
    install.packages("devtools")
}
devtools::install_github("yimindai0521/Mbalance")
```

## Usage Examples

We illustrate the usage of MBalance package using simple synthetic datasets.

``` r
library(MBalance)
##MB
##estimating ATE##
##generating data
set.seed(0521)
data        <- si.data()
result1     <- MB(x = data$X, treat = data$Tr, group1 = 1, outcome = data$Y, method = "MB")
result2     <- MB(x = data$X, treat = data$Tr, group1 = 0, outcome = data$Y, method = "MB")

##an estimate of ATE
result1$AT - result2$AT

##estimating ATT
result3     <- MB(x = data$X, treat = data$Tr, group1 = 1, group2 = 0, outcome = data$Y, method = "MB")

##an estimate of ATT
result3$AT - mean(data$Y[data$Tr == 0])

##hdMB
##estimating ATE in high-dimensional data##
##generating data
set.seed(0521)
data        <- si.data(sample.size = 200, dimension = 200)
dimension   <- dim(data$X)[2]

##choosing variable
hdMB1       <- hdMB(x = data$X, treat = data$Tr, group1 = 1, outcome = data$Y, method = "MB")
hdMB1$GMIM
threshold   <- 28
index1      <- rank(hdMB1$GASMD) >= (dimension - threshold + 1)

##choosing variable
hdMB2       <- hdMB(x = data$X, treat = data$Tr, group1 = 0, outcome = data$Y, method = "MB")
hdMB2$GMIM
threshold   <- 30
index2      <- rank(hdMB2$GASMD) >= (dimension - threshold + 1)

##an estimate of ATE
result4     <- MB(x = data$X[,index1], treat = data$Tr, group1 = 1, outcome = data$Y)
result5     <- MB(x = data$X[,index2], treat = data$Tr, group1 = 0, outcome = data$Y)
result4$AT - result5$AT
```

