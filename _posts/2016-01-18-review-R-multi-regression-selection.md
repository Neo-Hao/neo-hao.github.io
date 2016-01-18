---
layout: post
title: Review on How to Use R - Coefficient Selection of Multiple Regressions
---

<div class="message">
  As I am catching up with learning more things in Computational Intelligence, I found that I almost forgot everything about R. This post is only to help myself to do a little bit summary, and keep me from forgeting R so fast. Most examples used in the summary come from Data Science Specialization on Coursera.
</div>

### General Rules

1. Omitting variables will result in bias in the coefficients of interest - unless the omitted variables are uncorrelated with the included ones.

2. Including variables that should not be included will increase standard errors of the regression variables.

### Variance Inflation Factor (VIF)

VIF is the easiest way to measure the effects when 2nd general rule applies. If the newly included variables are highly correlated with some variables that are already in the model, there would be concerns for multicolinearity. A VIF of 1 means that there is no correlation among the kth predictor and the remaining predictor variables, and hence the variance of bk is not inflated at all. The general rule of thumb is that VIFs exceeding 4 warrant further investigation, while VIFs exceeding 10 are signs of serious multicollinearity requiring correction.

Getting VIF in R is very easy.

{% highlight r %}
# get data
install.packages("datasets")
library("datasets")
library("dplyr")
data(swiss)
swiss <- mutate(swiss, CatholicBin = 1 * (Catholic > 50))

# get model 1: no interaction term
fit <- lm(Fertility~Agriculture + factor(CatholicBin), data = swiss)
vif(fit)
{% endhighlight %}

### Nesting Model Comparison

Nested likelyhood ratior tests can be used to test for model selection when the models of interest are nested and without lots of parameters differentiating them.

{% highlight r %}
# when there are 2 models
fit1 <- lm(Fertility~Agriculture, data = swiss)
fit3 <- update(fit1, Fertility~Agriculture + Examination + Education)
lrtest(fit1, fit3)
# when there are more than 2 models
fit1 <- lm(Fertility~Agriculture, data = swiss)
fit3 <- update(fit1, Fertility~Agriculture + Examination + Education)
fit5 <- update(fit1, Fertility~Agriculture + Examination + Education + factor(CatholicBin) + Infant.Mortality)
anova(fit1, fit3, fit5)
{% endhighlight %}

