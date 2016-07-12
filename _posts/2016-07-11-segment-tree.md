---
layout: post
title: Segment Tree
---

### Leetcode Question 284
Given an integer array nums, find the sum of the elements between indices i and j (i ≤ j), inclusive. The update(i, val) function modifies nums by updating the element at index i to val.

Example:
Given nums = [1, 3, 5]

{% highlight python %}
sumRange(0, 2) -> 9
update(1, 2)
sumRange(0, 2) -> 8
{% endhighlight %}

Note:

1. The array is only modifiable by the update function.
2. You may assume the number of calls to update and sumRange function is distributed evenly.

Analysis:

1. Segment tree is good for heavy tasks of sum, min, max, in combination with update.
2. The implementation can be hard to remember, and DFS sometimes can satisfy the job as well based on the structure of segment tree.

Code:

{% highlight python %}
class Node(object):
    def __init__(self, start, end):
        self.start = start
        self.end = end
        self.total = 0
        self.left = None
        self.right = None


class NumArray(object):
    def __init__(self, nums):
        """
        initialize your data structure here.
        :type nums: List[int]
        """
        self.root = self.create_tree(nums, 0, len(nums)-1)
    
    def create_tree(self, nums, l, r):
        if l > r:
            return None
        if l == r:
            node = Node(l, r)
            node.total = nums[l]
            return node
            
        root = Node(l, r)
        mid = (l+r)//2
        
        root.left = self.create_tree(nums, l, mid)
        root.right = self.create_tree(nums, mid+1, r)
        root.total = root.left.total + root.right.total
        
        return root
    
    def update(self, i, val):
        """
        :type i: int
        :type val: int
        :rtype: int
        """
        return self.update_val(self.root, i, val)
    
    def update_val(self, node, i, val):
        if node.start == node.end:
            node.total = val
            return val
        
        mid = (node.start + node.end)//2
        if i <= mid:
            self.update_val(node.left, i, val)
        else:
            self.update_val(node.right, i, val)
        
        node.total = node.left.total + node.right.total
        
        return node.total

    def sumRange(self, i, j):
        """
        sum of elements nums[i..j], inclusive.
        :type i: int
        :type j: int
        :rtype: int
        """
        return self.sum_range(self.root, i, j)
    
    def sum_range(self, node, i, j):
        if node.start == i and node.end == j:
            return node.total
        
        mid = (node.start + node.end) // 2
        if mid >= j:
            return self.sum_range(node.left, i, j)
        elif i >= mid + 1:
            return self.sum_range(node.right, i, j)
        else:
            return self.sum_range(node.left, i, mid) + self.sum_range(node.right, mid+1, j)

# Your NumArray object will be instantiated and called as such:
# numArray = NumArray(nums)
# numArray.sumRange(0, 1)
# numArray.update(1, 10)
# numArray.sumRange(1, 2)
{% endhighlight %}
