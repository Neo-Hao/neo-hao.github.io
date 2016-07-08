---
layout: post
title: Bucket search
---

### Leetcode Question 219
Given an array of integers and an integer k, find out whether there are two distinct indices i and j in the array such that nums[i] = nums[j] and the difference between i and j is at most k.

Analytics:

1.  Use a dictionary with length of k+1 as the sliding window

Code:
{% highlight python %}
class Solution(object):
    def containsNearbyDuplicate(self, nums, k):
        """
        :type nums: List[int]
        :type k: int
        :rtype: bool
        """
        if nums == []:
            return False
        
        table = {}
        
        for i in range(len(nums)):
            if len(table) < k+1:
                if table.get(nums[i], -1) != -1:
                    return True
                else:
                    table[nums[i]] = 1
            else:
                del table[nums[i-k-1]]
                if table.get(nums[i], -1) != -1:
                    return True
                else:
                    table[nums[i]] = 1
        
        return False
{% endhighlight %}

### Leetcode Question 220
Given an array of integers, find out whether there are two distinct indices i and j in the array such that the difference between nums[i] and nums[j] is at most t and the difference between i and j is at most k.

Analysis:

1.  Use a dictionary with length of k as the sliding window, which is the same as the previous question.
2.  Map a group of values to the same bucket is the key to the bucket search. For this question, one solution is to map all values satisfy the following conditions to the same bucket: values // (t+1) == bucket

Code:
{% highlight python %}
import sys
class Solution(object):
    def containsNearbyAlmostDuplicate(self, nums, k, t):
        """
        :type nums: List[int]
        :type k: int
        :type t: int
        :rtype: bool
        """
        if t < 0 or k < 1:
            return False
        
        minimum = -sys.maxint - 1
        table = {}
        
        for i in range(len(nums)):
            val = nums[i] - minimum
            bucket = val // (t+1)
            
            if table.get(bucket, -1) != -1 or \
                (table.get(bucket-1, -1) != -1 and val - table[bucket-1] <= t) or \
                (table.get(bucket+1, -1) != -1 and table[bucket+1] - val <= t):
                    return True
            if len(table) >= k:
                bucket_first = (nums[i - k] - minimum) // (t+1)
                del table[bucket_first]
            table[bucket] = val
        
        return False
{% endhighlight %}