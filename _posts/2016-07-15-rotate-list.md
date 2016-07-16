---
layout: post
title: Rotate List
---

### Leetcode Question 61
Given a list, rotate the list to the right by k places, where k is non-negative.

For example:
{% highlight python %}
Given 1->2->3->4->5->NULL and k = 2,
return 4->5->1->2->3->NULL.
{% endhighlight %}

Analysis:

1. The number of k can be arbitrarily large. Therefore, to deal with k is the key to solving this problem.
2. fast.next = head should come first before other arrangements.

Code:

{% highlight python %}
# Definition for singly-linked list.
# class ListNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution(object):
    def rotateRight(self, head, k):
        """
        :type head: ListNode
        :type k: int
        :rtype: ListNode
        """
        if head == None or k == 0 or head.next == None:
            return head
        
        slow=fast=head
        length = 1
        while fast and fast.next:
            fast = fast.next
            length += 1
        k = k % length
        fast = head
        
        for i in range(k):
            fast = fast.next
        while fast and fast.next:
            fast = fast.next
            slow = slow.next
        
        fast.next = head
        head_new = slow.next
        slow.next = None
            
        return head_new
{% endhighlight %}


### Leetcode 189
Rotate an array of n elements to the right by k steps.

For example, with n = 7 and k = 3, the array [1,2,3,4,5,6,7] is rotated to [5,6,7,1,2,3,4].

Analysis:

1. Same as the previous question, to deal with large k is the key to solving this problem.

Code:

{% highlight python %}
class Solution(object):
    def rotate(self, nums, k):
        """
        :type nums: List[int]
        :type k: int
        :rtype: void Do not return anything, modify nums in-place instead.
        """
        
        length = len(nums)
        k = k % length
        start = length - k
        
        nums[:] = nums[start:] + nums[:start]
{% endhighlight %}