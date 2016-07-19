---
layout: post
title: Dynamic Programming
---

### Signals to Use Dynamic Programming

1. Optimal substructure: If I could break a problem into smaller versions of it, and then combine solutions to the smaller problems, I'll have solved the problem at hand.
2. Overlapping subproblems: While solving those smaller problem that leads to the same repetitive calculation steps, we term these as overlapping sub problems. 

### Leetcode Question 139
Given a string s and a dictionary of words dict, determine if s can be segmented into a space-separated sequence of one or more dictionary words.

For example, given s = "leetcode", dict = ["leet", "code"].

Return true because "leetcode" can be segmented as "leet code".

Analysis:

1. s can be segmented multiple times at multiple positions.
2. dp[i] represents whether a string of length i can be segmented to match words in the dictionary.

Code:

{% highlight python %}
class Solution(object):
    def wordBreak(self, s, wordDict):
        """
        :type s: str
        :type wordDict: Set[str]
        :rtype: bool
        """
        table = {}
        for i in wordDict:
            table[i] = 1
        
        dp = [True] + [False]* len(s)
        for i in range(len(s)):
            for j in range(i, len(s)):
                if dp[i] and table.get(s[i:j+1], -1) != -1:
                    dp[j+1] = True
                    print(dp)
        
        return dp[-1]
{% endhighlight %}


### Leetcode Question 322
You are given coins of different denominations and a total amount of money amount. Write a function to compute the fewest number of coins that you need to make up that amount. If that amount of money cannot be made up by any combination of the coins, return -1.

Example 1:
coins = [1, 2, 5], amount = 11
return 3 (11 = 5 + 5 + 1)

Example 2:
coins = [2], amount = 3
return -1.

Note: You may assume that you have an infinite number of each kind of coin.

Analysis:

1. Sort the coins firstly.
2. Prepare a list of the needed coin numbers
3. An embedded loop of coins and money amount is necessary. For the first and smallest coin, replace the list with the number of this coin needed for an amount if possible. It means that "when possible, what is the min number of the needed coins using only the smallest coin".
4. For the next coin, do the same thing. However, its meaning is a little bit different now: when possible, what is the min number of the needed coins using both the smallest coin and the next coin.
5. As the loop goes on, the true min number of needed coins will be calculated if possible.

Code:
{% highlight python %}
class Solution(object):
    def coinChange(self, coins, amount):
        """
        :type coins: List[int]
        :type amount: int
        :rtype: int
        """
        coins.sort()
        need = [0] + [amount+1]*amount
        
        for c in coins:
            for i in range(c, amount+1):
                need[i] = min(need[i], need[i-c]+1)
        
        if need[-1] > amount:
            return -1
        else:
            return need[-1]
{% endhighlight %}


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

1. Use a set as the sliding window to traverse from the beginning to the end. Use start and end as two pointers to mark the longest string.

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