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


### Search in Rotated Sorted Array
Suppose a sorted array is rotated at some pivot unknown to you beforehand.

(i.e., 0 1 2 4 5 6 7 might become 4 5 6 7 0 1 2).

You are given a target value to search. If found in the array return its index, otherwise return -1.

**Analysis:**

1. Use more generalized version of binary searching: the key is to determine if target is in the first or the second sorted section.

**Code:**
{% highlight python %}
class Solution(object):
    def search(self, nums, target):
        """
        :type nums: List[int]
        :type target: int
        :rtype: int
        """
        start, end = 0, len(nums)-1
        while start <= end:
            mid = (start+end)//2
            if nums[mid] == target:
                return mid
            
            if nums[mid] >= nums[start]:
                if target < nums[mid] and target >= nums[start]:
                    end = mid-1
                else:
                    start = mid + 1
            else:
                if target > nums[mid] and target <= nums[end]:
                    start = mid + 1
                else:
                    end = mid - 1
        return -1
{% endhighlight %}


### Search in Rotated Sorted Array II
Follow up for "Search in Rotated Sorted Array": What if duplicates are allowed?

Analysis:

1. This question is similar to the previous one.
2. When duplication is allowed, there would be scenarios that it is difficult to determine which section (first or second) to go with, like [1,3,1,1,1].
3. The best way to solve the problem is that when nums[mid] == nums[start], increment the pointer of start to its next.

{% highlight python %}
class Solution(object):
    def search(self, nums, target):
        """
        :type nums: List[int]
        :type target: int
        :rtype: bool
        """
        start, end = 0, len(nums)-1
        while start <= end:
            mid = (start+end)//2
            if nums[mid] == target:
                return True
            
            if nums[mid] > nums[start]:
                if target < nums[mid] and target >= nums[start]:
                    end = mid-1
                else:
                    start = mid + 1
            elif nums[mid] < nums[start]:
                if target > nums[mid] and target <= nums[end]:
                    start = mid + 1
                else:
                    end = mid - 1
            else:
                start += 1
        return False
{% endhighlight %}