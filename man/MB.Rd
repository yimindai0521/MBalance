% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/MB.R
\name{MB}
\alias{MB}
\title{Mahalanobis balancing}
\usage{
MB(
  x,
  treat,
  group1,
  group2 = NA,
  outcome,
  method = "MB",
  delta.space = c(0.1, 0.01, 0.001, 1e-04, 1e-05, 1e-06),
  iterations = 1000
)
}
\arguments{
\item{x}{covariates.}

\item{treat}{treatment indicator vector.}

\item{group1}{see Details.}

\item{group2}{see Details, Default: NA.}

\item{outcome}{outcome vector.}

\item{method}{a string that takes values in {"MB", "MB2", "kernelMB"}. See Details. Default: 'MB'.}

\item{delta.space}{tuning parameter in balancing. See Details. Default: c(1e-1, 1e-2, 1e-3, 1e-4, 1e-5, 1e-6).}

\item{iterations}{iteration time in optimization problem, Default: 1000.}
}
\value{
a MB object with the following attributes:
\itemize{
\item{AT:}{ the estimate of average treatment effect in group1 (i.e, \eqn{E(Y(group1))}).}
\item{weight:}{ the estimated Mahalanobis balancing weight.}
\item{GMIM:}{ Generalized Multivariate Imbalance Measure that defines in our paper.}
\item{delta:}{ the tuning parameter we choose.}
}
}
\description{
Mahalanobis balancing is a multivariate perspective of
approximate covariate balancing method to estimate average treatment
effect.
}
\details{
\code{group1} and \code{group0}
\itemize{
\item To estimate \eqn{E(Y (1))} (average treatment effect for group 1),
you need to set \code{group1} = 1 and ignore \code{group2}. Similarly,
To estimate \eqn{E(Y (0))} (average treatment effect for group 0),
you need to set \code{group1} = 0 and ignore \code{group2}.

\item To estimate average treatment effect on the control group \eqn{E(Y (1) | T = 0)},
you need to set \code{group1} = 1 and \code{group2} = 0. Similarly, To estimate
average treatment effect on the treated group \eqn{E(Y (0) | T = 1)},
you need to set \code{group1} = 0 and \code{group2} = 1.

\item This function is feasible when there are more than two groups.
}

\code{method} can be a valid string, including
\itemize{
\item "MB": We choose the weighting matrix \eqn{{W}_1=[diag(\hat{\Sigma})]^{-1}}
where \eqn{\hat{\Sigma}} denotes sample covariance matrix.
\item "MB2": We choose the weighting matrix \eqn{{W}_2={[\hat{\Sigma}]^{-1}}}
where \eqn{\hat{\Sigma}} denotes sample covariance matrix.
\item "kernelMB": Firstly, we modify our covariate to \eqn{X_i* = (\Phi(X_1,X_i), ..., \Phi(X_n,X_i))},
then we apply method "MB" to produce Mahalanobis balancing weights.
}

\code{delta.space} grid of values for the tuning parameter, a vector of
candidate values for the degree of approximate covariate balance. The default
is c(1e-1, 1e-2, 1e-3, 1e-4, 1e-5, 1e-6).
}
\examples{
##estimating ATE##
set.seed(0521)
data        <- si.data()
result1     <- MB(x = data$X, treat = data$Tr, group1 = 1, outcome = data$Y, method = "MB")
result2     <- MB(x = data$X, treat = data$Tr, group1 = 0, outcome = data$Y, method = "MB")

##an estimate of ATE
result1$AT - result2$AT

##estimating ATC##
result3     <- MB(x = data$X, treat = data$Tr, group1 = 1, group2 = 0, outcome = data$Y, method = "MB")

##an estimate of ATC
result3$AT - mean(data$Y[data$Tr == 0])

}
