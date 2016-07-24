 ---
layout: post
title: Stack
---

### Leetcode Question 169

Given an array of size n, find the majority element. The majority element is the element that appears more than n//2 times. You may assume that the array is non-empty and the majority element always exist in the array.

**Analysis:**

1. Boyer-Moore Majority Vote algorithm: The essential concepts is you keep a counter for the majority number X. If you find a number Y that is not X, the current counter should deduce 1. The reason is that if there is 5 X and 4 Y, there would be one (5-4) more X than Y. This could be explained as "4 X being paired out by 4 Y". 

**Code:**

{% highlight python %}
class Solution(object):
    def majorityElement(self, nums):
        candidate, c = 0, 0
        for n in nums:
            if n == candidate:
                c += 1
            elif c == 0:
                candidate, c = n, 1
            else:
                c -= 1
        
        return candidate
{% endhighlight %}


### Leetcode Question 169

Given an integer array of size n, find all elements that appear more than ⌊ n/3 ⌋ times. The algorithm should run in linear time and in O(1) space.

**Code:**

{% highlight python %}
class Solution(object):
    def majorityElement(self, nums):
        """
        :type nums: List[int]
        :rtype: List[int]
        """
        if not nums:
            return []
        
        cand1, cand2, c1, c2 = 0, 1, 0, 0
        for n in nums:
            if n == cand1:
                c1 += 1
            elif n == cand2:
                c2 += 1
            elif c1 == 0:
                cand1, c1 = n, 1
            elif c2 == 0:
                cand2, c2 = n, 1
            else:
                c1, c2 = c1-1, c2-1
        
        return [n for n in (cand1, cand2) if nums.count(n) > len(nums)//3]
{% endhighlight %}