---
layout: post
title: Dealing with Numbers
---

### Some bascis of dealing with numbers

1. When A is added to B digit by digit, the number left on that position and the carry follow the following rule: carry, val = (v1+v2+carry)//10, (v1+v2+carry)%10.
2. When A is multiplied by B digit by digit, it follows the same rule as the addition. The length of the result will be no bigger than the size of A plus the size of B.
3. How to find sqrt of a number: binary search


### Leetcode Question 69

Implement int sqrt(int x). Compute and return the square root of x.

Analysis:

1. Use binary search.

Code:
{% highlight python %}
class Solution(object):
    def mySqrt(self, x):
        """
        :type x: int
        :rtype: int
        """
        if x == 0:
            return 0
        
        right = x//2+1
        left = 1
        while True:
            mid = (left + right)//2
            if mid*mid <= x:
                if mid*mid <= x and (mid+1)*(mid+1) > x:
                    return mid
                left = mid
            else:
                right = mid
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


### Leetcode Question 43
Given two numbers represented as strings, return multiplication of the numbers as a string.

Note:

1. The numbers can be arbitrarily large and are non-negative.
2. Converting the input string to integer is NOT allowed.
3. You should NOT use internal library such as BigInteger.

Code:
{% highlight python %}
class Solution(object):
    def multiply(self, num1, num2):
        """
        :type num1: str
        :type num2: str
        :rtype: str
        """
        result = [0]*(len(num1) + len(num2))
        
        for i in range(len(num1)-1, -1, -1):
            carry = 0
            for j in range(len(num2)-1, -1, -1):
                temp = result[i+j+1] + int(num1[i])*int(num2[j]) + carry
                result[i+j+1] = temp % 10
                carry = temp // 10
            result[i] += carry
        
        result_str = ""
        for i in range(len(result)):
            result_str += str(result[i])
        
        count = 0
        while count < len(result_str):
            if result_str[count] != '0':
                break
            count += 1
        
        if count < len(result_str):
            return result_str[count:]
        else:
            return '0'
{% endhighlight %}