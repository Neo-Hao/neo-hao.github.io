 ---
layout: post
title: Combination Problem
---

### The Basics of Combination Problems

1. Combination problem is typically solved using DFS.
2. The tricky part about combination problems is whether repetition is allowed.
3. The solutions to combination problems are generally similar.


### Leetcode Question 39
Given a set of candidate numbers (C) and a target number (T), find all unique combinations in C where the candidate numbers sums to T. The same repeated number may be chosen from C unlimited number of times.

Note:

* All numbers (including target) will be positive integers.
* The solution set must not contain duplicate combinations.

For example, given candidate set [2, 3, 6, 7] and target 7, A solution set is: 
{% highlight python %}
[
  [7],
  [2, 2, 3]
]
{% endhighlight %}

**Analysis:**

1. Usage of the same number is allowed.
2. No duplications.

**Code:**
{% highlight python %}
class Solution(object):
    def combinationSum(self, candidates, target):
        """
        :type candidates: List[int]
        :type target: int
        :rtype: List[List[int]]
        """
        result = []
        candidates.sort()
        self.comb(candidates, 0, [], target, result)
        return result
    
    def comb(self, candidates, start, path, target, result):
        if target == 0:
            result.append(path)
            return
        if target < 0:
            return
        
        for i in range(start, len(candidates)):
            self.comb(candidates, i, path + [candidates[i]], target - candidates[i], result)
{% endhighlight %}


### Leetcode Question 40
Given a collection of candidate numbers (C) and a target number (T), find all unique combinations in C where the candidate numbers sums to T. Each number in C may only be used once in the combination.

Note:
* All numbers (including target) will be positive integers.
* The solution set must not contain duplicate combinations.

For example, given candidate set [10, 1, 2, 7, 6, 1, 5] and target 8, A solution set is: 
{% highlight python %}
[
  [1, 7],
  [1, 2, 5],
  [2, 6],
  [1, 1, 6]
]
{% endhighlight %}

**Analysis:**

1. Each number in C may only be used once in the combination.

**Code:**
{% highlight python %}
class Solution(object):
    def combinationSum2(self, candidates, target):
        """
        :type candidates: List[int]
        :type target: int
        :rtype: List[List[int]]
        """
        candidates.sort()
        result = []
        self.comb(candidates, 0, [], target, result)
        return result
    
    def comb(self, candidates, start, path, target, result):
        if target == 0:
            result.append(path)
            return
        if target < 0:
            return
        
        for i in range(start, len(candidates)):
            if i > start and candidates[i] == candidates[i-1]:
                continue
            self.comb(candidates, i+1, path + [candidates[i]], target-candidates[i], result)
{% endhighlight %}


### Leetcode Question 216
Find all possible combinations of k numbers that add up to a number n, given that only numbers from 1 to 9 can be used and each combination should be a unique set of numbers.

Example:

Input: k = 3, n = 9

Output: [[1,2,6], [1,3,5], [2,3,4]]

**Code:**
{% highlight python %}
class Solution(object):
    def combinationSum3(self, k, n):
        """
        :type k: int
        :type n: int
        :rtype: List[List[int]]
        """
        nums = [i for i in range(1, 10)]
        result = []
        self.comb(nums, 0, [], result, n, k)
        return result
    
    def comb(self, nums, start, path, result, target, k):
        if target == 0 and len(path) == k:
            result.append(path)
            return
        if target < 0:
            return
        
        for i in range(start, len(nums)):
            self.comb(nums, i+1, path+[nums[i]], result, target-nums[i], k)
{% endhighlight %}


### Leetcode Question 216
Given an integer array with all positive numbers and no duplicates, find the number of possible combinations that add up to a positive integer target.

Example:

nums = [1, 2, 3], target = 4

The possible combination ways are:
{% highlight python %}
(1, 1, 1, 1)
(1, 1, 2)
(1, 2, 1)
(1, 3)
(2, 1, 1)
(2, 2)
(3, 1)
{% endhighlight %}

Note that different sequences are counted as different combinations. Therefore the output is 7.

**Analysis:**

1. Use dynamic programming.
2. The key relationship is combs[i] += combs[i - num], i is a number smaller or equal to target, while num is a number in the given list.

**Code:**
{% highlight python %}
class Solution(object):
    def combinationSum4(self, nums, target):
        """
        :type nums: List[int]
        :type target: int
        :rtype: int
        """
        nums, combs = sorted(nums), [1] + [0] * (target)
        for i in range(1, target + 1):
            for num in nums:
                if num  > i: 
                    break
                if num == i: 
                    combs[i] += 1
                if num  < i: 
                    combs[i] += combs[i - num]
        return combs[-1]
{% endhighlight %}
