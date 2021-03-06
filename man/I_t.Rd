% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Hasegawa2016.R
\name{I_t}
\alias{I_t}
\alias{I_t.2}
\title{Estimated information based on the data}
\usage{
I_t(data_ref, data_check, rho, gamma)

I_t.2(data_ref, data_check, rho, gamma)
}
\arguments{
\item{data_ref}{Input reference dataset which provides the survival curves for the estimation. It could be some dataset entirely external to \code{data_check}. This dataset should include at lease the 3 variables: \code{survival} for the time to event or censoring, \code{delta} as the event indicator, and \code{trt} for the treatment assignment indicator. It will perfectly fit the output dataset from the \code{data.trim} functions.}

\item{data_check}{Input dataset to check the estimated information. It should follow the sample format as \code{data_ref}, which includes three variables: \code{survival}, \code{delta} and \code{trt}.}

\item{rho}{First power parameter for the Fleming-Harrington weight which weighs on the early departures: \eqn{S(t^-)^\rho(1-S(t^-))^\gamma}.}

\item{gamma}{Second power parameter for the Fleming-Harrington weight which weighs on the late departures: \eqn{S(t^-)^\rho(1-S(t^-))^\gamma}.}
}
\value{
The returned value is the calculated information estimated from the input dataset \code{data_check} using the survival function estimated from \code{data_ref}.
}
\description{
Estimate the information based on the data, which is the numerator of the information fraction.
}
\details{
The \code{I_t} function estimates the information up to the maximum follow-up time in the data of \code{data_check}, which is identical to the numerator of the information fraction proposed by Hasegawa (2016):\eqn{ \hat{P}_1(t)\hat{P}_0(t)\int_0^t W(t,s)^2N(t,ds)}. Note that the datasets \code{data_check} and \code{data_ref} input here are output data from \code{data.trim} functions, or any datasets including \code{survival} as time to event or censoring, \code{delta} as event indicators, and \code{trt} denotes treatment assignment (1 is treatment, 0 is control). Note that \code{I_t.2} is another option which is slightly different from the one proposed in Hasegawa(2016), but is identical to the estimate of variance of the weighted log-rank test, which considers the total at-risk set \eqn{R(t)} and treatment arm \eqn{R_1(t)}: \eqn{\int_0^t\frac{R_1(s)R_0(s)}{R(s)^2}W(t,s)^2N(t,ds)}.
}
\examples{
# install.packages("devtools")
# library(devtools)
# install_github("keaven/nphsim")
library(nphsim)
eps<-2 # delayed effect
p<-0.5 #treatment assignment
b<-30 # an intrinsic parameter to decide the number of intervals per time unit
tau<- 18 # end of the study
R<-14 # accrual period [0,R]
omega<- tau-R
lambda<-log(2)/6 # control group risk hazard
theta<-0.7 # hazard ratio
lambda.trt<- lambda*theta #hazard after the change point for the treatment arm
rho<- 0 # parameter for the weights
gamma<-1 #parameter for the weights
alpha<-0.025 #type 1 error
beta<-0.1 #type 2 error
# First we decide the sample size:
size_FH <- sample.size_FH(eps,p,b,tau,omega,lambda,lambda.trt,rho, gamma,alpha,beta)
n_FH <-size_FH$n
n_event_FH<-size_FH$n_event
accrual.rt<-n_FH/R # the needed arrual rate
#Generate data accordingly, use eta=1e-5 to inhibit censoring
data_temp <- nphsim(nsim=1,lambdaC=lambda, lambdaE = c(lambda,lambda.trt),
                  ssC=ceiling(n_FH*(1-p)),intervals = c(eps),ssE=ceiling(n_FH*p),
                                   gamma=accrual.rt, R=R, eta=1e-5, fixEnrollTime = TRUE)$simd

#Obtain the full information at the final stage based on the generated data
#Trim the data upto the final stage when n_event_FH events have been observed
data_temp1 <-data.trim.d(n_event_FH,data_temp)[[1]]
I_t(data_temp1,data_temp1,rho,gamma) # the estimated information at the final stage
#Trim the data upto certain event numbers at the interim stage when 60\% of the events have been observed. Have been trimed once to get data_temp1, no need to add additional variables, thus set the third argument to be F.
I_t.2(data_temp1,data_temp1,rho,gamma) # If we consider the change of the at-risk set, which is not necessary to be a fixed probability.
data_temp2 <- data.trim.d(ceiling(0.6*n_event_FH),data_temp1,F)[[1]]
I_t(data_temp1,data_temp2,rho,gamma) # Use the full dataset data_temp to provide the survival function, and check the estimated information for the trimmed data set data_temp2 with only 60\% of the planned events have been observed.
I_t.2(data_temp1,data_temp2,rho,gamma) # If we consider the change of the at-risk set, which is not necessary to be a fixed probability.

}
\references{
Hasegawa, T. (2016). Group sequential monitoring based on the weighted log‐rank test statistic with the Fleming–Harrington class of weights in cancer vaccine studies. Pharmaceutical statistics, 15(5), 412-419.
}
\seealso{
\code{\link{data.trim}}
}
\author{
Lili Wang
}
