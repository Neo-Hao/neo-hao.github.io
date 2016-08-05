---
layout: post
title: Spiral Matrix
---

### Keys to Spiral Matrix Problem

1. lambda expression
2. itertools.count


### Rotate Image
You are given an n x n 2D matrix representing an image. Rotate the image by 90 degrees (clockwise).

**Analysis:**

1. The most common way to roate a n*n matrix is to:
    1. Reverse the matrix
    2. Swap the items along the diagonal.

**Code:**
{% highlight python %}
class Solution(object):
    def rotate(self, matrix):
        """
        :type matrix: List[List[int]]
        :rtype: void Do not return anything, modify matrix in-place instead.
        """
        matrix.reverse()
        for i in range(len(matrix)):
            for j in range(i):
                matrix[i][j], matrix[j][i] = matrix[j][i], matrix[i][j]
{% endhighlight %}


### Spiral Matrix
Given a matrix of m x n elements (m rows, n columns), return all elements of the matrix in spiral order. For example, Given the following matrix:
{% highlight python %}
[
 [ 1, 2, 3 ],
 [ 4, 5, 6 ],
 [ 7, 8, 9 ]
]
{% endhighlight %}

You should return [1,2,3,6,9,8,7,4,5].

Analysis:

1. Use iteration instead of recursion would make you write fewer lines of code for this question.
2. Pay attention to the corner cases: when l = r or u = d.

Code:

{% highlight python %}
class Solution(object):
    def spiralOrder(self, matrix):
        """
        :type matrix: List[List[int]]
        :rtype: List[int]
        """
        if matrix == []:
            return []
        if len(matrix) == 1:
            return matrix[0]
        
        result = []
        m, n = len(matrix), len(matrix[0])
        l, r, u, d = 0, n-1, 0, m-1
        
        while l < r and u < d:
            result.extend([matrix[u][i] for i in range(l, r)])
            result.extend([matrix[i][r] for i in range(u, d)])
            result.extend(matrix[d][i] for i in range(r, l, -1))
            result.extend(matrix[i][l] for i in range(d, u, -1))
            l, r, u, d = l+1, r-1, u+1, d-1
        
        if l == r:
            result.extend([matrix[i][r] for i in range(u, d+1)])
        elif u == d:
            result.extend([matrix[u][i] for i in range(l, r+1)])
        
        return result
{% endhighlight %}


### Leetcode Question 59

Given an integer n, generate a square matrix filled with elements from 1 to n2 in spiral order. For example, Given n = 3, You should return the following matrix:
{% highlight python %}
[
 [ 1, 2, 3 ],
 [ 8, 9, 4 ],
 [ 7, 6, 5 ]
]
{% endhighlight %}

Analysis:

1. This question is simply the reverse of the previous one. It is not hard to reverse the solution of the previous question.

Code:
{% highlight python %}
class Solution(object):
    def generateMatrix(self, n):
        """
        :type n: int
        :rtype: List[List[int]]
        """
        if n == 0:
            return []
        
        num = itertools.count(start = 1, step = 1)
        result = [[0 for i in range(n)] for j in range(n)]
        l, r, u, d = 0, n-1, 0, n-1
        
        while l < r and u < d:
            for i in range(l, r):
                result[u][i] = next(num)
            for i in range(u, d):
                result[i][r] = next(num)
            for i in range(r, l, -1):
                result[d][i] = next(num)
            for i in range(d, u, -1):
                result[i][l] = next(num)
            l, r, u, d = l+1, r-1, u+1, d-1
        if l == r:
            for i in range(u, d+1):
                result[i][l] = next(num)
        elif u == d:
            for i in range(l, r+1):
                result[u][i] = next(num)
                
        return result
{% endhighlight %}