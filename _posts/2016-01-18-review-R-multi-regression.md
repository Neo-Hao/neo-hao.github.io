---
layout: post
title: Review on How to Use R - Multiple Regression
---

<div class="message">
  As I am catching up with learning more things in Computational Intelligence, I found that I almost forgot everything about R. This post is only to help myself to do a little bit summary, and keep me from forgeting R so fast. Most examples used in the summary come from Data Science Specialization on Coursera.
</div>

### Building the Model

There's nothing special about building a model for multiple regression. The only one thing to notice is when there are factor independent variables.

{% highlight r %}
# get data
install.packages("datasets")
library("datasets")
library("dplyr")
data(swiss)
swiss <- mutate(swiss, CatholicBin = 1 * (Catholic > 50))

# get model 1: no interaction term
fit <- lm(Fertility~Agriculture + factor(CatholicBin), data = swiss)
# see coef
coef(fit)

# get model 2: with interaction term
fit <- lm(Fertility~Agriculture + factor(CatholicBin) + Agriculture*factor(CatholicBin), data = swiss)
# see coef
coef(fit)
{% endhighlight %}

Plot the model by factor variable.

{% highlight r %}
# plot the model by group CatholicBin
g <- ggplot(swiss, aes(x = Agriculture, y = Fertility, colour = factor(CatholicBin)))
g <- g + geom_point(size = 6, color = "black") + geom_point(size = 4)
g <- g + xlab("% in Agriculture") + ylab("Fertility")
g
{% endhighlight %}

<img style="margin-bottom: 20px; margin-top: 20px; width: 70%;"  src="http://neo-hao.github.io/public/img/multi-regression-1.jpeg">

### Diagnostics

Residual values can not be used for comparison across analyses. Some efforts in standardizing residuals:
* rstandard
* rstudent

Residual vs Fitted Value: Detection of poor model fit and heteroskedasticity
<img style="margin-bottom: 20px; margin-top: 20px; width: 70%;"  src="http://neo-hao.github.io/public/img/simple-regression-2.jpeg">

QQ plot: Detection of normality of the errors
<img style="margin-bottom: 20px; margin-top: 20px; width: 70%;"  src="http://neo-hao.github.io/public/img/simple-regression-3.jpeg">

Residual vs Leverage: Detection of highly influential points and possible error points
<img style="margin-bottom: 20px; margin-top: 20px; width: 70%;"  src="http://neo-hao.github.io/public/img/simple-regression-5.jpeg">


