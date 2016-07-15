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


### Lettcode Question 3
Given a string, find the length of the longest substring without repeating characters.

Examples:

1. Given "abcabcbb", the answer is "abc", which the length is 3.
2. Given "bbbbb", the answer is "b", with the length of 1.
3. Given "pwwkew", the answer is "wke", with the length of 3. Note that the answer must be a substring, "pwke" is a subsequence and not a substring.

Analysis:

1. Dynamic programming is the solution for this type of problems.
2. Use a set as the sliding window to traverse from the beginning to the end. Use start and end as two pointers to mark the longest string.
3. As long as there is the need to traverse the whole strong or list to find the answer, dynamic programming could be the potential solution.

Code:
{% highlight python %}
class Solution(object):
    def lengthOfLongestSubstring(self, s):
        aSet = set()
        maxlen = 0
        start = 0
        end = 0
        
        while (start < len(s) and end < len(s)):
            if (s[end] not in aSet):
                aSet.add(s[end])
                end += 1
                maxlen = max(maxlen, end - start)
            else:
                aSet.discard(s[start])
                start += 1
            print(aSet)
        
        return maxlen
{% endhighlight %}


### Leetcode Question 198
You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed, the only constraint stopping you from robbing each of them is that adjacent houses have security system connected and it will automatically contact the police if two adjacent houses were broken into on the same night.

Given a list of non-negative integers representing the amount of money of each house, determine the maximum amount of money you can rob tonight without alerting the police.


### Leetcode Question 53
Find the contiguous subarray within an array (containing at least one number) which has the largest sum.

For example, given the array [−2,1,−3,4,−1,2,1,−5,4],
the contiguous subarray [4,−1,2,1] has the largest sum = 6.


### Leetcode Question 152
Find the contiguous subarray within an array (containing at least one number) which has the largest product.

For example, given the array [2,3,-2,4],
the contiguous subarray [2,3] has the largest product = 6.