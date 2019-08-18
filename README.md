Fleming-Harrington class weighted log-rank tests and interim analysis
================
[Lili Wang](mailto:lilywang@umich.edu)
2019-08-18

Purpose
-------

This R package is to implement important works from Dr. Hasegawa (2014 and 2016) for Fleming-Harrington class weighted log-rank tests (FH-WLRT) sample size calculation and the information fraction monitoring for interim analysis (IA).

This R package will be improved and upgraded in the near future.

Install the package
-------------------

To install the R package from Github, you will need to install another R package "devtools". Please uncomment the codes to install them.

``` r
# install.packages("devtools")
# library(devtools)
# install_github("lilywang1988/IAfrac")
library(IAfrac)
#> Loading required package: data.table
```

Vignettes
---------

``` r
# Sample size calculation using an Example 1 from Hasegawa (2014)
 p<-2/3
  tau<-66
  omega<-18
  eps<-6
  m1=21.7  #median survival time for placebo group
  m2=25.8  # median survival time for treatment group
  lambda<-log(2)/m1
  lambda.trt<-log(2)*(m1-eps)/(m2-eps)/m1
  theta=lambda.trt/lambda
  alpha<-0.025
  beta<-0.1
  rho=0
  gamma=1
  b=30
  sample.size_FH(eps,p,b,tau,omega,lambda,lambda.trt,rho, gamma,alpha,beta)$n
#> [1] 1974
 #1974, identical to the paper's report
```

References
----------

1.  Hasegawa, T. (2014). Sample size determination for the weighted log‐rank test with the Fleming–Harrington class of weights in cancer vaccine studies. Pharmaceutical statistics, 13(2), 128-135.

2.  Hasegawa, T. (2016). Group sequential monitoring based on the weighted log‐rank test statistic with the Fleming–Harrington class of weights in cancer vaccine studies. Pharmaceutical statistics, 15(5), 412-419.

3.  Ye, T., & Yu, M. (2018). A robust approach to sample size calculation in cancer immunotherapy trials with delayed treatment effect. Biometrics, 74(4), 1292-1300.