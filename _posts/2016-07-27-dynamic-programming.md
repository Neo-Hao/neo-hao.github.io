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

**Analysis:**

1. s can be segmented multiple times at multiple positions.
2. dp[i] represents whether a string of length i can be segmented to match words in the dictionary.

**Code:**
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

**Analysis:**

1. Use a set as the sliding window to traverse from the beginning to the end. Use start and end as two pointers to mark the longest string.

**Code:**
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


### Lettcode Question 55
Given an array of non-negative integers, you are initially positioned at the first index of the array.

Each element in the array represents your maximum jump length at that position.Determine if you are able to reach the last index.

For example:

A = [2,3,1,1,4], return true.

A = [3,2,1,0,4], return false.

**Analysis:**

1. Use a variable to track the maximum jump. Traverse nums and update maximum jump at each individual in the list. If maximum jum reaches the end or beyond, return true.

**Code:**
{% highlight python %}
class Solution(object):
    def canJump(self, nums):
        """
        :type nums: List[int]
        :rtype: bool
        """
        if len(nums) == 1:
            return True
        
        farthest = [0]*len(nums)
        maxj = nums[0]
        
        for i in range(1, len(nums)):
            if i <= maxj:
                farthest[i] = i + nums[i]
                maxj = max(farthest[i], maxj)
        
        if maxj >= len(nums)-1:
            return True
        else:
            return False
{% endhighlight %}


### Leetcode Question 53
Find the contiguous subarray within an array (containing at least one number) which has the largest sum.

For example, given the array [−2,1,−3,4,−1,2,1,−5,4], the contiguous subarray [4,−1,2,1] has the largest sum = 6.

**Analysis:**

1. The current max to include the current number = max(The prior max, 0) + The current number

**Code:**
{% highlight python %}
class Solution(object):
    def maxSubArray(self, nums):
        """
        :type nums: List[int]
        :rtype: int
        """
        maxlist = [0]*len(nums)
        maxlist[0] = nums[0]
        
        for i in range(1, len(nums)):
            maxlist[i] = max(maxlist[i-1], 0) + nums[i]
        
        return max(maxlist)
{% endhighlight %}


### Leetcode Question 152
Find the contiguous subarray within an array (containing at least one number) which has the largest product.

For example, given the array [2,3,-2,4], the contiguous subarray [2,3] has the largest product = 6.

**Analysis:**

1. Multiplication becomes tricky when negative numbers are involved.
2. Two lists are in need: one to hold the max product so far when including the current number, the other to hold the min product so far when including the current number.
3. The max product so far when including the current number = max(max(Prior max product*num[i], Prior min product*num[i]), num[i])

**Code:**
{% highlight python %}
class Solution(object):
    def productExceptSelf(self, nums):
        """
        :type nums: List[int]
        :rtype: List[int]
        """
        if nums == []:
            return []
        
        result = [1]*len(nums)
        for i in range(1, len(nums)):
            result[i] = result[i-1]*nums[i-1]
        
        num = 1
        for i in range(len(result)-1, -1, -1):
            result[i] *= num
            num *= nums[i]
        
        return result
{% endhighlight %}


### Leetcode Question 238
Given an array of n integers where n > 1, nums, return an array output such that output[i] is equal to the product of all the elements of nums except nums[i].

Solve it without division and in O(n).

For example, given [1,2,3,4], return [24,12,8,6].

**Code:**
{% highlight python %}
class Solution(object):
    def productExceptSelf(self, nums):
        """
        :type nums: List[int]
        :rtype: List[int]
        """
        if nums == []:
            return []
        
        result = [1]*len(nums)
        for i in range(1, len(nums)):
            result[i] = result[i-1]*nums[i-1]
        
        num = 1
        for i in range(len(result)-1, -1, -1):
            result[i] *= num
            num *= nums[i]
        
        return result
{% endhighlight %}


### Leetcode Question 357
Given a non-negative integer n, count all numbers with unique digits, x, where 0 ≤ x < 10n.

Example:
Given n = 2, return 91. (The answer should be the total numbers in the range of 0 ≤ x < 100, excluding [11,22,33,44,55,66,77,88,99])

**Analysis:**

1. When n == 0, return 1. I got this answer from the test case.
2. When n == 1, _ can put 10 digit in the only position. [0, ... , 10]. Answer is 10.
3. When n == 2, _ _ first digit has 9 choices [1, ..., 9], second one has 9 choices excluding the already chosen one. So totally 9 * 9 = 81. answer should be 10 + 81 = 91
4. When n == 3, _ _ _ total choice is 9 * 9 * 8 = 684. answer is 10 + 81 + 648 = 739
5. When n == 4, _ _ _ _ total choice is 9 * 9 * 8 * 7 ...
6. When n == 10, _ _ _ _ _ _ _ _ _ _ total choice is 9 * 9 * 8 * 7 * 6 * 5 * 4 * 3 * 2 * 1
7. When n == 11, _ _ _ _ _ _ _ _ _ _ _ total choice is 9 * 9 * 8 * 7 * 6 * 5 * 4 * 3 * 2 * 1 * 0 = 0

**Code:**
{% highlight python %}
class Solution(object):
    def countNumbersWithUniqueDigits(self, n):
        """
        :type n: int
        :rtype: int
        """
        if n == 0:
            return 1
        
        result = [0]*(n+1)
        result[0] = 1
        result[1] = 10
        for i in range(2, n+1):
            tmp = 9
            f_num = 9
            for j in range(i-1):
                tmp *= f_num
                f_num -= 1
            result[i] = result[i-1] + tmp
        
        print(result)
        return result[-1]
{% endhighlight %}

### Leetcode Question 198
You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed, the only constraint stopping you from robbing each of them is that adjacent houses have security system connected and it will automatically contact the police if two adjacent houses were broken into on the same night.

Given a list of non-negative integers representing the amount of money of each house, determine the maximum amount of money you can rob tonight without alerting the police.