---
layout: post
title: Linked List
---

### Common strategies for handling linked lists:

1. Use a fake head
2. When you need to reverse a linked list, it's easier to construct it backwards.
3. Be very cautious to call next method on a node if there's no condition checking.


### Leetcode Question 92
Reverse a linked list from position m to n. Do it in-place and in one-pass.

For example: Given 1->2->3->4->5->NULL, m = 2 and n = 4, return 1->4->3->2->5->NULL.

Given m, n satisfy the following condition: 1 ≤ m ≤ n ≤ length of list.

**Code:**

{% highlight python %}
# Definition for singly-linked list.
# class ListNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution(object):
    def reverseBetween(self, head, m, n):
        """
        :type head: ListNode
        :type m: int
        :type n: int
        :rtype: ListNode
        """
        if m == n or not head or not head.next:
            return head
        
        head_fake = ListNode(-1)
        head_fake.next = head
        
        c = 1
        prev = head_fake
        while c < m:
            prev = head
            head = head.next
            c += 1
        
        self.reverse(prev, head, m, n)
        return head_fake.next
    
    def reverse(self, prev_con, head, n, m):
        prev = None
        end = head
        
        next_con = None
        while n <= m:
            if n == m:
                next_con = head.next
            
            tmp = head.next
            head.next = prev
            prev = head
            head = tmp
            n += 1
        
        prev_con.next = prev
        end.next = next_con
{% endhighlight %}        


### Leetcode Question 82
Given a sorted linked list, delete all nodes that have duplicate numbers, leaving only distinct numbers from the original list.

For example,

Given 1->2->3->3->4->4->5, return 1->2->5.
Given 1->1->1->2->3, return 2->3.

**Code:**

{% highlight python %}
# Definition for singly-linked list.
# class ListNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution(object):
    def deleteDuplicates(self, head):
        """
        :type head: ListNode
        :rtype: ListNode
        """
        if not head or not head.next:
            return head
        
        head_fake = prev = ListNode(-1)
        head_fake.next = head
        
        while head.next:
            if head.val == head.next.val:
                while head.next and head.val == head.next.val:
                    head = head.next
                head = head.next
                prev.next = head
            else:
                prev = head
                head = head.next
        return head_fake.next
{% endhighlight %}


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


### Leetcode Question 328
Given a singly linked list, group all odd nodes together followed by the even nodes. Please note here we are talking about the node number and not the value in the nodes.

You should try to do it in place. The program should run in O(1) space complexity and O(nodes) time complexity.

Example:
Given 1->2->3->4->5->NULL,
return 1->3->5->2->4->NULL.

**Analysis:**:

1. Build two separate lists, and combine them afterwards.

**Code:**

{% highlight python %}
# Definition for singly-linked list.
# class ListNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution(object):
    def oddEvenList(self, head):
        """
        :type head: ListNode
        :rtype: ListNode
        """
        dummy1 = odd = ListNode(0)
        dummy2 = even = ListNode(0)
        while head:
            odd.next = head
            even.next = head.next
            odd = odd.next
            even = even.next
            head = head.next.next if even else None
        odd.next = dummy2.next
        return dummy1.next
{% endhighlight %}