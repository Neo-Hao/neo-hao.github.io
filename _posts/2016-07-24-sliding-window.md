---
layout: post
title: Sliding Window
---

### Sliding Window

1. Sliding window strategy is usually applied to searching tasks in a sequence. The target is usually a sublist.

### Leetcode Question 209
Given an array of n positive integers and a positive integer s, find the minimal length of a subarray of which the sum ≥ s. If there isn't one, return 0 instead.

For example, given the array [2,3,1,2,4,3] and s = 7, the subarray [4,3] has the minimal length under the problem constraint.

**Code:**

{% highlight python %}
class Solution(object):
    def minSubArrayLen(self, s, nums):
        """
        :type s: int
        :type nums: List[int]
        :rtype: int
        """
        i = j = total = 0
        result = sys.maxsize
        
        while j < len(nums):
            total += nums[j]
            j+= 1
            
            while total >= s:
                result = min(result, j-i)
                total -= nums[i]
                i += 1
        
        if result == sys.maxsize:
            return 0
        else:
            return result
{% endhighlight %}