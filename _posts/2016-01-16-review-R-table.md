---
layout: post
title: Review on How to Use R - data.table
---

<div class="message">
  As I am catching up with learning more things in Computational Intelligence, I found that I almost forgot everything about R. This post is only to help myself to do a little bit summary, and keep me from forgeting R so fast. Most examples used in the summary come from Data Science Specialization on Coursera.
</div>

### data.Table Package

This is an important package because it runs much faster than data frame (well, it is written in C). data.table accepts all functions that work on data.frame.

This is how you create a data.table. The process is almost the same as creating a data frame.

{% highlight r %}
table = data.table(x = rnorm(9), y = rep(c("a", "b", "c"), each = 3), z = rnorm(9))
# keys can make things faster
setkey(table, y)
table['a'] # subset data using certain value of the key
{% endhighlight %}

Basic operations are as the followings:

{% highlight r %}
# subset by row
table[2,]
table[c(2,3),]
table[table$y = "a",]

# notices: this doesn't subset by column
table[,c(2,3)]

# you can pass functions that run on columns directly
table[, list(mean(x), sum(z))]
table[,table(y)] # get a table of y col
table[,w:=z^2] # add a new col named w, value of w = (value of z)^2
table[, m={tmp <- (x+z); log2(tmp+5)}] # add a new col named m, value of m ...
table[, a:= x > 0]
table[, b:= mean(x + w), by = a]
{% endhighlight %}

Merge two tables by key.

{% highlight r %}
table1 <- data.table(x= c('a', 'b', 'c', 'd'), y = 1:4)
table2 <- data.table(x = c('a', 'b', 'e'), z= 5:7)
setkey(table1, x)
setkey(table2, x)
merge(table1, table2)
{% endhighlight %}