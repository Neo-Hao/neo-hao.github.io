---
layout: post
title: Backtracking
---

### Backtracking

1. The basic idea of backtracking is to revert what you did after calling the same function recursively.


### Leetcode Question 46

Given a collection of distinct numbers, return all possible permutations. For example, [1,2,3] have the following permutations:
{% highlight python %}
[
  [1,2,3],
  [1,3,2],
  [2,1,3],
  [2,3,1],
  [3,1,2],
  [3,2,1]
]
{% endhighlight %}

Analysis:

1. Very typical backtracking problem.
2. Be careful when dealing with the recursive function that has list as a parameter.

Code:
{% highlight python %}
class Solution(object):
    def permute(self, nums):
        """
        :type nums: List[int]
        :rtype: List[List[int]]
        """
        result = []
        self.permute_helper(nums, 0, len(nums), result)
        return result
    
    def permute_helper(self, nums, start, end, result):
        if start == end -1:
            result.append(nums)
        else:
                temp = nums[current]
                nums[current] = nums[start]
                nums[start] = temp
                self.permute_helper(nums[:], start+1, end, result)
                temp = nums[current]
                nums[current] = nums[start]
                nums[start] = temp
{% endhighlight %}


### Leetcode Question 47

Given a collection of numbers that might contain duplicates, return all possible unique permutations. For example, [1,1,2] have the following unique permutations:
{% highlight python %}
[
  [1,1,2],
  [1,2,1],
  [2,1,1]
]
{% endhighlight %}

Analysis:

1. This question is essentially the same as the previous one. 
2. The duplications need to be checked to avoid redundant swaps.

Code:
{% highlight python %}
class Solution(object):
    def permuteUnique(self, nums):
        """
        :type nums: List[int]
        :rtype: List[List[int]]
        """
        result = []
        table = {}
        self.permute(nums, 0, len(nums), result, table)
        return result
    
    def permute(self, nums, start, end, result, table):
        if start == end -1:
            result.append(nums)
        else:
            for current in range(start, end):
                if self.noswap(nums, start, current):
                    continue
                
                temp = nums[current]
                nums[current] = nums[start]
                nums[start] = temp
                self.permute(nums[:], start+1, end, result, table)
                temp = nums[current]
                nums[current] = nums[start]
                nums[start] = temp
    
    def noswap(self, nums, s, c):
        for i in range(s, c):
            if nums[i] == nums[c]:
                return True
{% endhighlight %}