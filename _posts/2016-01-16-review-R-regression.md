---
layout: post
title: Review on How to use R - Simple Regression
---

<div class="message">
  As I am catching up with learning more things in Computational Intelligence, I found that I almost forgot everything about R. This post is only to help myself to do a little bit summary, and keep me from forgeting R so fast. Most examples used in the summary come from Data Science Specialization on Coursera.
</div>

### Simple Linear Regression

Data source - Galton' height data

Model construction is as the following:

{% highlight r %}
# get data
install.packages("UsingR")
library("UsingR")
data(diamond)

# get model 1: Intercept hard to interpret
fit <- lm(price~carat, data = diamond)
# see coef
coef(fit)

# get model 2: Intercept easy to interpret
fit <- lm(price~ I(carat - mean(carat), data = diamond)
# see coef
coef(fit)

# plot the model
g <- ggplot(diamond, aes(x = carat, y = price))
g <- g + xlab("Mass")
g <- g + ylab("Price")
g <- g + geom_point(size = 7, color = "black", alpha = 0.5)
g <- g + geom_point(size = 5, color = "blue", alpha = 0.2)
g <- g + geom_smooth(method = "lm", color = "black")
g
{% endhighlight %}

<img style="margin-bottom: 20px; margin-top: 20px; width: 70%;"  src="http://neo-hao.github.io/public/simple-regression-1.jpeg">

Prediction is as the following. The data has to go into the model as a data frame with the variables that have the same name.

{% highlight r %}
# get predicted value
predict(fit, newdata = data.frame(carat = c(0.16, 0.27, 0.34)))
# get predicted value with confidence interval
predict(fit, newdata = data.frame(carat = 0.16), interval="confidence")
{% endhighlight %}

> <a href="http://stats.stackexchange.com/questions/16493/difference-between-confidence-intervals-and-prediction-intervals" target="_blank">The difference between a prediction interval and a confidence interval is the standard error</a>. The standard error for a confidence interval on the mean takes into account the uncertainty due to sampling. The line you computed from your sample will be different from the line that would have been computed if you had the entire population, the standard error takes this uncertainty into account.

> The standard error for a prediction interval on an individual observation takes into account the uncertainty due to sampling like above, but also takes into account the variability of the individuals around the predicted mean. The se for the prediction interval will be wider than for the confidence interval and hence the prediction interval will be wider than the confidence interval.

Plot the prediction interval and confidence interval with 95%. 

{% highlight r %}
newx = data.frame(x = seq(min(x), max(x), length = 100))
p1 = data.frame(predict(fit, newdata= newx,interval = ("confidence")))
p2 = data.frame(predict(fit, newdata = newx,interval = ("prediction")))
p1$interval = "confidence"
p2$interval = "prediction"
p1$x = newx$x
p2$x = newx$x
dat = rbind(p1, p2)
names(dat)[1] = "y"
g = ggplot(dat, aes(x = x, y = y))
g = g + geom_ribbon(aes(ymin = lwr, ymax = upr, fill = interval), alpha = 0.2)
g = g + geom_line()
g = g + geom_point(data = data.frame(x = x, y=y), aes(x = x, y = y), size = 4)
g
{% endhighlight %}

Residuals related evaluations are as the followings:

{% highlight r %}
# The mean squared error (MSE) is the mean of the square of the residuals
mse <- mean(resid(fit)^2)
mse
# Root mean squared error (RMSE) is then the square root of MSE
rmse <- sqrt(mse)
rmse
# Residual sum of squares (RSS) is the sum of the squared residuals
rss <- sum(residuals(fit)^2)
rss
# Residual standard error (RSE) is the square root of (RSS / degrees of freedom)
rse <- sqrt(rss / fit$df.residual)
rse
# get standardized residual
{% endhighlight %}

Residuals related plots are as the followings:

{% highlight r %}
plot(fit)
{% endhighlight %}

<img style="margin-bottom: 20px; margin-top: 20px; width: 70%;"  src="http://neo-hao.github.io/public/simple-regression-2.jpeg">

<img style="margin-bottom: 20px; margin-top: 20px; width: 70%;"  src="http://neo-hao.github.io/public/simple-regression-3.jpeg">

<img style="margin-bottom: 20px; margin-top: 20px; width: 70%;"  src="http://neo-hao.github.io/public/simple-regression-4.jpeg">

<img style="margin-bottom: 20px; margin-top: 20px; width: 70%;"  src="http://neo-hao.github.io/public/simple-regression-5.jpeg">