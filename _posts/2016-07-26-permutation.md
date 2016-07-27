---
layout: post
title: Permutation
---

### Permutation

1. The basic idea of backtracking is to revert what you did after calling the same function recursively.


### Leetcode Question 31

Implement next permutation, which rearranges numbers into the lexicographically next greater permutation of numbers. If such arrangement is not possible, it must rearrange it as the lowest possible order (ie, sorted in ascending order). The replacement must be in-place, do not allocate extra memory.

Here are some examples. Inputs are in the left-hand column and its corresponding outputs are in the right-hand column.

* 1,2,3 → 1,3,2
* 3,2,1 → 1,2,3
* 1,1,5 → 1,5,1

**Analysis of Method 1:**

1. Find the first item (index i) from the end that is smaller than another item whose index (j) is bigger. 
2. Exchange the two.
3. Sort the list from i+1 till the end.
4. Another case is when the list is already in descending order, you need to reverse the list.

**Code of Method 1**:
{% highlight python %}
class Solution(object):
    def nextPermutation(self, nums):
        """
        :type nums: List[int]
        :rtype: void Do not return anything, modify nums in-place instead.
        """
        for i in range(len(nums)-2, -1, -1):
            for j in range(len(nums)-1, i, -1):
                if nums[i] < nums[j]:
                    tmp = nums[i]
                    nums[i] = nums[j]
                    nums[j] = tmp
                    nums[i+1:] = sorted(nums[i+1:])
                    return
        nums[:] = nums[::-1]
{% endhighlight %}

**Code of Method 2**:
{% highlight python %}
class Solution(object):
    def nextPermutation(self, nums):
        """
        :type nums: List[int]
        :rtype: void Do not return anything, modify nums in-place instead.
        """
        for i in range(len(nums)-2, -1, -1):
            for j in range(len(nums)-1, i, -1):
                if nums[i] < nums[j]:
                    tmp = nums[i]
                    nums[i] = nums[j]
                    nums[j] = tmp
                    nums[i+1:] = sorted(nums[i+1:])
                    return
        nums[:] = nums[::-1]
{% endhighlight %}

**Analysis of Method 2:**

The algorithm is as the following:

1. Find the largest index k such that a[k] < a[k + 1]. If no such index exists, reverse the string/list, then it's done.
2. Find the largest index l greater than k such that a[k] < a[l].
3. Swap the value of a[k] with that of a[l].
4. Reverse the sequence from a[k + 1] up to and including the final element a[n].

Note:

1. How to reverse part of the list: a[k:] = a[k:][::-1]
2. To reverse a list in place: nums[:] = nums[::-1]

**Code of Method 2**:
{% highlight python %}
class Solution(object):
    def nextPermutation(self, nums):
        """
        :type nums: List[int]
        :rtype: void Do not return anything, modify nums in-place instead.
        """
        k = -1
        for i in range(len(nums)-2, -1, -1):
            if nums[i] < nums[i+1]:
                k = i
                break
        
        if k == -1:
            nums[:] = nums[::-1]
        else:
            l = -1
            for i in range(len(nums)-1, k, -1):
                if nums[i] > nums[k]:
                    l = i
                    break
            temp = nums[k]
            nums[k] = nums[l]
            nums[l] = temp
            nums[k+1:] = nums[k+1:][::-1]
{% endhighlight %}


### Leetcode Question 60
The set [1,2,3,…,n] contains a total of n! unique permutations. By listing and labeling all of the permutations in order, We get the following sequence (ie, for n = 3):

1. "123"
2. "132"
3. "213"
4. "231"
5. "312"
6. "321"

Given n and k, return the kth permutation sequence. Note: Given n will be between 1 and 9 inclusive.

Analysis:

1. For permutations of n, the first (n-1)! permutations start with 1, next (n-1)! ones start with 2, ... and so on. And in each group of (n-1)! permutations, the first (n-2)! permutations start with the smallest remaining number, ... Take n = 3 as an example, the first 2 (that is, (3-1)! ) permutations start with 1, next 2 start with 2 and last 2 start with 3. For the first 2 permutations (123 and 132), the 1st one (1!) starts with 2, which is the smallest remaining number (2 and 3). So we can use a loop to check the region that the sequence number falls in and get the starting digit. Then we adjust the sequence number and continue.

Code:
{% highlight python %}
class Solution(object):
    def getPermutation(self, n, k):
        """
        :type n: int
        :type k: int
        :rtype: str
        """
        numbers = range(1, n+1)
        permutation = ''
        k -= 1
        while n > 0:
            n -= 1
            # get the index of current digit
            index, k = divmod(k, math.factorial(n))
            permutation += str(numbers[index])
            # remove handled number
            numbers.remove(numbers[index])

        return permutation
{% endhighlight %}


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

**Analysis:**

1. Very typical backtracking problem.
2. Be careful when dealing with the recursive function that has list as a parameter.
3. A more general solution is to sort the list first, then use DFS without backtracking.

**Code of DFS**:
{% highlight python %}
class Solution(object):
    def permute(self, nums):
        result = []
        nums.sort()
        self.permute_unique(nums, 0, result)
        return result
    
    def permute_unique(self, nums, start, result):
        if start == len(nums):
            result.append(nums)
        
        for i in range(start, len(nums)):
            if i != start and nums[i] == nums[start]:
                continue
            tmp = nums[start]
            nums[start] = nums[i]
            nums[i] = tmp
            self.permute_unique(nums[:], start+1, result)
{% endhighlight %}

**Code of backtracking**:
{% highlight python %}
class Solution(object):
    def permute(self, nums):
        """
        :type nums: List[int]
        :rtype: List[List[int]]
        """
        result = []
        self.permute_helper(nums, 0, result)
        return result
    
    def permute_helper(self, nums, start, result):
        if start == len(nums):
            result.append(nums)
        else:
            for current in range(start, end):
                if current != start and nums[current] == nums[start]:
                    continue
                temp = nums[current]
                nums[current] = nums[start]
                nums[start] = temp
                self.permute_helper(nums[:], start+1, result)
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
        if nums == []:
            return []
        
        result = []
        nums.sort()
        self.permute(nums, 0, result)
        return result
    
    def permute(self, nums, start, result):
        if start == len(nums):
            result.append(nums)
        
        for i in range(start, len(nums)):
            if i != start and nums[i] == nums[start]:
                continue
            tmp = nums[start]
            nums[start] = nums[i]
            nums[i] = tmp
            self.permute(nums[:], start+1, result)
{% endhighlight %}