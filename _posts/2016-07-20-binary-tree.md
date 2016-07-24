---
layout: post
title: Binary Tree Traversal
---

### The basics of trees

1. Node counting
2. Max / min height calculation
3. Preorder / inorder / postorder traversal


### Leetcode Question 104

Given a binary tree, find its maximum depth. The maximum depth is the number of nodes along the longest path from the root node down to the farthest leaf node.

**Code:**

{% highlight python %}
class Solution(object):
    def maxDepth(self, root):
        if (root == None):
            return 0
        else:
            return max(self.maxDepth(root.left)+1, self.maxDepth(root.right)+1)
{% endhighlight %}


### Leetcode Question 111

Given a binary tree, find its minimum depth. The minimum depth is the number of nodes along the shortest path from the root node down to the nearest leaf node.

**Code:**

{% highlight python %}
class Solution(object):
    def minDepth(self, root):
        if not root:
            return 0
        if not root.left:
            return self.minDepth(root.right)+1
        if not root.right:
            return self.minDepth(root.left)+1
        
        return min(self.minDepth(root.left)+1, self.minDepth(root.right)+1)
{% endhighlight %}

### Leetcode Question 200

Given a binary tree, count the number of nodes.

**Code:**

{% highlight python %}
class Solution(object):
    def countNodes(self, root):
        return self.get_count(root)
    
    def get_count(self, node):
        if node == None:
            return 0
        else:
            return self.get_count(node.left) + self.get_count(node.right) + 1
{% endhighlight %}

### Leetcode Question 222

Given a complete binary tree, count the number of nodes.

Definition of a complete binary tree from Wikipedia: In a complete binary tree every level, except possibly the last, is completely filled, and all nodes in the last level are as far left as possible. It can have between 1 and pow(2,h) nodes inclusive at the last level h.

**Analysis:**

1. The node number of a perfect tree can be calculated: pow(2, h) - 1, where h is the height of the tree. pow(2, h) can be written as 1 >> h.
2. The basic idea is as the followings:
    - Calculate the tree height
    - Calculate the height from root.right
    - If the difference between the two heights is 1, the last node is on the right side of the tree; else the last node is on the left side of the tree.

**Code:**

{% highlight python %}
class Solution(object):
    def countNodes(self, root):
        """
        :type root: TreeNode
        :rtype: int
        """
        h = self.height(root)
        if h < 0:
            return 0
        else:
            h_right = self.height(root.right)
            if h_right == h-1:
                return (1<<\h) - 1 + 1 +self.countNodes(root.right)
            else:
                return (1<<(h-1)) - 1 + 1 +self.countNodes(root.left)
            
    def height(self, root):
        if not root:
            return -1
        return self.height(root.left)+1
{% endhighlight %}


### Leetcode Question 94
Given a binary tree, return the inorder traversal of its nodes' values. For example: Given binary tree [1,null,2,3],

{% highlight python %}
   1
    \
     2
    /
   3
{% endhighlight %}

return [1,3,2].

**Analysis:**

1. Inorder, preorder, postorder traversals are must-to-knows.

**Code:**
{% highlight python %}
# Definition for a binary tree node.
# class TreeNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution(object):
    def inorderTraversal(self, root):
        """
        :type root: TreeNode
        :rtype: List[int]
        """
        result = []
        self.traverse(root, result)
        return result
    
    def traverse(self, node, result):
        if node == None:
            return
        
        self.traverse(node.left, result)
        result.append(node.val)
        self.traverse(node.right, result)
{% endhighlight %}


### Leetcode Question 144
Given a binary tree, return the preorder traversal of its nodes' values. For example:
Given binary tree {1,#,2,3},

{% highlight python %}
   1
    \
     2
    /
   3
{% endhighlight %}
return [1,2,3].

**Code:**
{% highlight python %}
# Definition for a binary tree node.
# class TreeNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution(object):
    def preorderTraversal(self, root):
        """
        :type root: TreeNode
        :rtype: List[int]
        """
        result = []
        self.traverse(root, result)
        
        return result
    
    def traverse(self, node, result):
        if node == None:
            return
        
        result.append(node.val)
        self.traverse(node.left, result)
        self.traverse(node.right, result)
{% endhighlight %}

### Leetcode Question 145
Given a binary tree, return the postorder traversal of its nodes' values. For example:
Given binary tree {1,#,2,3},
{% highlight python %}
   1
    \
     2
    /
   3
{% endhighlight %}
return [3,2,1].

**Code:**
{% highlight python %}
# Definition for a binary tree node.
# class TreeNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution(object):
    def postorderTraversal(self, root):
        """
        :type root: TreeNode
        :rtype: List[int]
        """
        result = []
        self.traverse(root, result)
        
        return result
    
    def traverse(self, node, result):
        if node == None:
            return
        
        self.traverse(node.left, result)
        self.traverse(node.right, result)
        result.append(node.val)
{% endhighlight %}


### Leetcode Question 173
Implement an iterator over a binary search tree (BST). Your iterator will be initialized with the root node of a BST. Calling next() will return the next smallest number in the BST. Note: next() and hasNext() should run in average O(1) time and uses O(h) memory, where h is the height of the tree.

**Analysis:**

1. Inorder traversal of binary tree is very helpful for searching problems related to trees.

**Code:**
{% highlight python %}
# Definition for a  binary tree node
# class TreeNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class BSTIterator(object):
    def __init__(self, root):
        """
        :type root: TreeNode
        """
        self.container = []
        self.traverse(root)
        self.index = 0
        #self.index = self.container.index(root.val)

    def hasNext(self):
        """
        :rtype: bool
        """
        if self.index < len(self.container):
            return True
        else:
            return False
        
    def next(self):
        """
        :rtype: int
        """
        #print(self.container)
        self.index += 1
        return self.container[self.index-1]
        
    def traverse(self, node):
        if node == None:
            return
        
        self.traverse(node.left)
        self.container.append(node.val)
        self.traverse(node.right)

# Your BSTIterator will be called like this:
# i, v = BSTIterator(root), []
# while i.hasNext(): v.append(i.next())
{% endhighlight %}


### Leetcode Question 173
Given a binary search tree, write a function kthSmallest to find the kth smallest element in it. Note: You may assume k is always valid, 1 ≤ k ≤ BST's total elements. Follow up: What if the BST is modified (insert/delete operations) often and you need to find the kth smallest frequently? How would you optimize the kthSmallest routine?

**Analysis:**

1. Same as the previous question, inorder tree traversal is very helpful to tree-related searching problems.

**Code:**
{% highlight python %}
# Definition for a binary tree node.
# class TreeNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution(object):
    def kthSmallest(self, root, k):
        """
        :type root: TreeNode
        :type k: int
        :rtype: int
        """
        result = []
        self.traverse(root, result)
        
        return result[k-1]
    
    def traverse(self, node, result):
        if node == None:
            return
        self.traverse(node.left, result)
        result.append(node.val)
        self.traverse(node.right, result)
{% endhighlight %}