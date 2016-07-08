---
layout: post
title: Dynamic Programming
---
### Leetcode Question 91
A message containing letters from A-Z is being encoded to numbers using the following mapping:
{% highlight python %}
	'A' -> 1
	'B' -> 2
	...
	'Z' -> 26
{% endhighlight %}
Given an encoded message containing digits, determine the total number of ways to decode it.For example, Given encoded message "12", it could be decoded as "AB" (1 2) or "L" (12). The number of ways decoding "12" is 2.

Analysis:

1.  The key to the problem is result[i] = result[i-1] + result[i-2]
2.  To take care of 0 case is tricky. The trick to make the code simple here is to prepare a result list that has the length of len(s)+1. result[0] = 1 stands for 1 way to decode an empty string. result[1] stands for the ways to decode a string that has length of 1.

Code:
{% highlight python %}
class Solution(object):
    def numDecodings(self, s):
        """
        :type s: str
        :rtype: int
        """
        if s == "":
            return 0
        if s[0] == '0':
            return 0
        
        result = [0]* (len(s)+1)
        result[0] = 1
        result[1] = 0 if s[0]=='0' else 1
        
        for i in range(2, len(s)+1):
            if int(s[i-1]) >= 1 and int(s[i-1]) <= 9:
                result[i] += result[i-1]
            if int(s[i-2:i]) >= 10 and int(s[i-2:i]) <= 26:
                result[i] += result[i-2]
        
        return result[len(s)]
{% endhighlight %}