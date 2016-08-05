---
layout: post
title: Increasing Sequence
---

### Increasing Triplet Subsequence
Given an unsorted array return whether an increasing subsequence of length 3 exists or not in the array. Formally the function should:

* Return true if there exists i, j, k 
* such that arr[i] < arr[j] < arr[k] given 0 ≤ i < j < k ≤ n-1 else return false.
* Your algorithm should run in O(n) time complexity and O(1) space complexity.

Example 1: Given [1, 2, 3, 4, 5], return true. 

Example 2: Given [5, 4, 3, 2, 1], return false.

**Code:**

{% highlight python %}
class Solution(object):
    def increasingTriplet(self, nums):
        """
        :type nums: List[int]
        :rtype: bool
        """
        first = second = sys.maxsize
        for i in nums:
            if i <= first:
                first = i
            elif i <= second:
                second = i
            else:
                return True
        return False
{% endhighlight %}


### Longest Increasing Subsequence
Given an unsorted array of integers, find the length of longest increasing subsequence.

For example,
Given [10, 9, 2, 5, 3, 7, 101, 18],
The longest increasing subsequence is [2, 3, 7, 101], therefore the length is 4. Note that there may be more than one LIS combination, it is only necessary for you to return the length.

Your algorithm should run in O(n2) complexity.

**Analysis:**

1. Use dynamic programming.
2. Set the original value of each slot to be 1.
3. If there's any previous number (index j) smaller than the current number (index i), result[i] = max(result[i], result[j]+1)

**Code:**
{% highlight python %}
class Solution(object):
    def lengthOfLIS(self, nums):
        """
        :type nums: List[int]
        :rtype: int
        """
        if len(nums) <= 1:
            return len(nums)
        
        result = [1]*len(nums)
        for i in range(1, len(nums)):
            for j in range(i):
                if nums[j] < nums[i]:
                    result[i] = max(result[i], result[j]+1)
        
        return max(result)
{% endhighlight %}
