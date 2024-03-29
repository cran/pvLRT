% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pvlrt-object-S3-methods.R
\name{logLik.pvlrt}
\alias{logLik.pvlrt}
\title{Overall Log-likelihood for a pvlrt object}
\usage{
\method{logLik}{pvlrt}(object, type = "full-zip", ...)
}
\arguments{
\item{object}{a \code{pvlrt} object, which is the output of the function
\link{pvlrt} or one of its wrappers such as \link{lrt_zi_poisson},
\link{lrt_poisson} and \code{lrt_vanilla_poisson}.}

\item{type}{Type of model and hypothesis combination.
Available choices are "full-poisson", "null-poisson", "full-zip" (default), and
"null-zip". See details.}

\item{...}{other input parameters. Currently unused.}
}
\value{
An object of class \link[stats]{logLik}. See Details.
}
\description{
Overall Log-likelihood for a pvlrt object
}
\details{
The function extracts the overall log-likelihood and degrees of freedom
(the number of estimated parameters) from a \code{pvlrt} object. There are
four possible choices of distribution and hypothesis combinations, supplied
through the argument \code{type}, with the default being \code{type = "full-zip"}.
In a "full" model the signal parameters lambdas are estimated for all cells
in the contingency table from the data (subject to the condition lambda >= 1), whereas under a "null"
model each lambda is fixed at 1 for each cell. In a "zip" model
(type = "full-zip" and type = "null-zip") the log-likelihood under a zero-inflated
Poisson model with estimated or supplied zero inflation parameters (
through \code{zi_prob} in \link{pvlrt}) is returned. The degrees of freedom
reflects whether the zero-inflation parameters are estimated. Note that if
an ordinary Poisson LRT is run either by setting \code{zi_prob = 0} in
\link{pvlrt} or equivalently through \link{lrt_poisson} then "full-zip" and
"null-zip" refer to zero-inflated poisson models with presepecified
zero-inflation probabilities equal to 0. Thus, in such cases the results
with type = "full-zip" and type =  "null-zip" are identical to
type = "full-poisson" and type = "null-poisson"
respectively. See examples.
}
\note{
The overall log likelihood must be computed during the original pvlrt run. This is
ensured by setting  \code{return_overall_loglik = TRUE}, and
\code{parametrization = "lambda"} (or \code{parametrization = "rrr"}) while running pvlrt().
}
\examples{

# 500 bootstrap iterations (nsim) in each example below
# are for quick demonstration only --
# we recommended setting nsim to 10000 (default) or bigger

set.seed(100)
# estimates zero inflation probabilities
test1 <- pvlrt(statin46, nsim = 500)
logLik(test1)
AIC(test1)
BIC(test1)

# compare with and without zero inflation
BIC(logLik(test1, type = "full-zip"))
BIC(logLik(test1, type = "full-poisson"))

# ordinary poisson model
## equivalent to pvlrt(statin46, zi_prob = 0, nsim = 500)
test2 <- lrt_poisson(statin46, nsim = 500)

all.equal(logLik(test2, "full-zip"), logLik(test2, "full-poisson"))

}
\seealso{
\link{pvlrt}; \link[stats]{AIC}
}
