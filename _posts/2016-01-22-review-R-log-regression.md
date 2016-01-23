---
layout: post
title: Review on How to Use R - Logistic Regressions
---

<div class="message">
  As I am catching up with learning more things in Computational Intelligence, I found that I almost forgot everything about R. This post is only to help myself to do a little bit summary, and keep me from forgeting R so fast. Most examples used in the summary come from Data Science Specialization on Coursera.
</div>

### Interpretation

Logistic regression is not very different from multiple regression.

{% highlight r %}
logFit <- glm(y~x, family = "binomial")
summary(logFit)
# get exp of coefficients
exp(logFit$coeff)
# get confidence interval of coefficient exp
exp(confint(logFit))
{% endhighlight %}

The only thing worth noting is the interpretation of coefficients in logistic regression model. Given the model as Y = Beta1 * X + Beta0, Beta1 is the log of Y's odds ratio for one increase in X. Therefore, it is usually better to get the exponential of Beta1, which stands for odds ratio change of Y given one increase in X.

### Model Comparison

Similar as comparing several multivariable linear regression.

{% highlight r %}
# compare this model with NULL model
anova(logFit, test="Chisq")
{% endhighlight %}

