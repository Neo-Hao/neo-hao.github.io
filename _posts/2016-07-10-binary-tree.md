---
layout: post
title: Binary Tree Traversal
---

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

Analytics:

1. Inorder, preorder, postorder traversals are must-to-knows.

Code:
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

Code:

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

Code:
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

Analysis:

1. Inorder traversal of binary tree is very helpful for searching problems related to trees.

Code:
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

Analysis:

1. Same as the previous question, inorder tree traversal is very helpful to tree-related searching problems.

Code:
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