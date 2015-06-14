---
layout: post
title: A Peek into Text Mining (III) - Data Visualization Step-by-Step Instructions
---

<div class="message">
  This article was written for <a href="http://blog.aace.org">blog of AACE</a> on May 27th, 2015
</div>

This post covers the details of how to use R to generate data visualizations. We will use <a href="https://github.com/Neo-Hao/TwitterHashtagR/blob/master/Data/edutech.csv">a sample data set that includes about 800 tweets using hashtag “#edutech”</a> for the purpose of explanation. To learn how this data set was collected read my post A Peek Into Text Mining: How To Collect Data From Twitter.

Text data has to be converted into a document-term matrix for analysis. To convert our sample data set into a document-term matrix, you need to do the following things: 

1. Copy and paste all the codes in the file <a href="https://github.com/Neo-Hao/TwitterHashtagR/blob/master/Data%20Conversion%20Tools/termDocumentMatrixConverter.R">termDocumentMatrixConverter.R</a> to your console of R, and run the codes.
2. Run the following code in R console. Please remember to replace the filename with the name of your file (without csv suffix).

{% highlight r %}
data <- vectorConvertor("edutech", TRUE)
data <- plainTextDocumentConverter(data)
data.tm <- TermDocumentMatrix(data)
{% endhighlight %}

Now your document-term matrix is saved in a variable called data.tm for future use. 

### Word Cloud

A word cloud is very helpful if you want to take a quick look at your data. To generate a word cloud, please run the following code in your R console:

{% highlight r %}
# word cloud
install.packages("wordcloud")
library(wordcloud)
# word cloud function can only be run on PlainTextDocument
wordcloud(data)
{% endhighlight %}

This code will generate a word cloud. The generation of the word cloud may take some time.

<img style="margin-bottom: 20px; margin-top: 20px; width: 70%;"  src="http://blog.aace.org/files/2015/05/wordcloud2.png">

### Cluster Tree

Cluster analysis is a way of finding association between items and bind nearby items into groups. A typical visualization technique is a tree diagram called dendrogram. Before applying hierarchical clustering to the data, we will need to remove the the terms that only appear once. When we get the clusters, we will need to plot it to see the dendrogram. All in all, run the codes in <a href="https://github.com/Neo-Hao/TwitterHashtagR/blob/master/Data%20Visualization%20Tools/hclusterofwords.R">hclusterofwords.R</a> file first, and then run the following code in your R console.

{% highlight r %}
hclusterofwords(data.tm)
{% endhighlight %}

Your dendrogram may look like this:

<img style="margin-bottom: 20px; margin-top: 20px; width: 70%;"  src="http://blog.aace.org/files/2015/04/cluster.png">

You are encouraged to learn more about clustering analysis <a href="http://statweb.stanford.edu/~tibs/ElemStatLearn/" target="_blank">here</a>.