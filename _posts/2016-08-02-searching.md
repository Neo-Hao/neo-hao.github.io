---
layout: post
title: Searching
---

## Binary Searching

The common solution to binary searching:
{% highlight python %}
def binary_search(self, nums, target):
    start, end = 0, len(nums)-1
    
    while start <= end:
        mid = (start+end)//2
        if nums[mid] == target:
            return True
        elif nums[mid] > target:
            end = mid-1
        else:
            start = mid+1
    return False
{% endhighlight %}


### Search a 2D Matrix
Write an efficient algorithm that searches for a value in an m x n matrix. This matrix has the following properties:

Integers in each row are sorted from left to right.
The first integer of each row is greater than the last integer of the previous row. For example, Consider the following matrix:
{% highlight python %}
[
  [1,   3,  5,  7],
  [10, 11, 16, 20],
  [23, 30, 34, 50]
]
{% endhighlight %}

Given target = 3, return true.

**Code:**
{% highlight python %}
class Solution(object):
    def searchMatrix(self, matrix, target):
        """
        :type matrix: List[List[int]]
        :type target: int
        :rtype: bool
        """
        if not matrix:
            return False
        
        start, end = 0, len(matrix[0])-1
        loc = 0
        for i in range(len(matrix)):
            if target >= matrix[i][start] and target <= matrix[i][end]:
                loc = i
                break
        
        return self.binary_search(matrix[loc], target)
    
    def binary_search(self, nums, target):
        start, end = 0, len(nums)-1
        
        while start <= end:
            mid = (start+end)//2
            if nums[mid] == target:
                return True
            elif nums[mid] > target:
                end = mid-1
            else:
                start = mid+1
        return False
{% endhighlight %}


