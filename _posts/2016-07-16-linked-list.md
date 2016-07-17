---
layout: post
title: Linked List
---

### Common strategies for handling linked lists:

1. Use a fake head
2. When you need to reverse a linked list, it's easier to construct it backwards.
3. Be very cautious to call next method on a node if there's no condition checking.

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


### Leetcode Question 2

You are given two linked lists representing two non-negative numbers. The digits are stored in reverse order and each of their nodes contain a single digit. Add the two numbers and return it as a linked list.

Input: (2 -> 4 -> 3) + (5 -> 6 -> 4)
Output: 7 -> 0 -> 8

Analysis:

1. The trick to make the code for this question succinct is to make the loop condition as A or B or C.

Code:
{% highlight python %}
# Definition for singly-linked list.
# class ListNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution(object):
    def addTwoNumbers(self, l1, l2):
        """
        :type l1: ListNode
        :type l2: ListNode
        :rtype: ListNode
        """

        carry = 0
        head_fake = track = ListNode(0)
        
        while l1 or l2 or carry:
            v1 = v2 = 0
            if l1:
                v1 = l1.val
                l1 = l1.next
            if l2:
                v2 = l2.val
                l2 = l2.next
            carry, val = (v1+v2+carry)//10, (v1+v2+carry)%10
            track.next = ListNode(val)
            track = track.next
        
        return head_fake.next
{% endhighlight %}