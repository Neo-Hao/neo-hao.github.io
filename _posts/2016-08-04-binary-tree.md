---
layout: post
title: Binary Tree
---

### The basics of trees

1. Node counting
2. Max / min height calculation
3. Preorder / inorder / postorder traversal


## Lowest common ancestor
### Leetcode Question 236
Given a binary tree, find the lowest common ancestor (LCA) of two given nodes in the tree. According to the definition of LCA on Wikipedia: “The lowest common ancestor is defined between two nodes v and w as the lowest node in T that has both v and w as descendants (where we allow a node to be a descendant of itself).”

{% highlight python %}
        _______3______
       /              \
    ___5__          ___1__
   /      \        /      \
   6      _2       0       8
         /  \
         7   4
{% endhighlight %}

For example, the lowest common ancestor (LCA) of nodes 5 and 1 is 3. Another example is LCA of nodes 5 and 4 is 5, since a node can be a descendant of itself according to the LCA definition.

**Analysis:**

1. If found a node in left subtree and another in right subtree (neither left nor right is null), root would be the lca. Otherwise, at most one value (left or right) is not null, return the not-null value, which would be the lca found in subtree
2. Use p, q and none as the boolean val: if p or q, ...; if None ...
    * Scenario 1: p and q are on the left and right branches separately, left == p and right == q
    * Scenario 2: p and q are on the left of the root, and the lowest common ancestor is saved as left

**Code:**

{% highlight python %}
# Definition for a binary tree node.
# class TreeNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution(object):
    def lowestCommonAncestor(self, root, p, q):
        if root == None or root == p or root == q:
            return root

        left = self.lowestCommonAncestor(root.left, p, q)
        right = self.lowestCommonAncestor(root.right, p, q)
        
        if left and right:
            return root
        if left == None:
            return right
        if right == None:
            return left
{% endhighlight %}


## Max and min depth of a tree
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


## Count the number of nodes
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


## Inorder, Postorder, and Preorder Traversal
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


### Construct Binary Tree from Preorder and Inorder Traversal
Given preorder and inorder traversal of a tree, construct the binary tree.

**Analysis:**

1. The only thing that stops you from building a tree only using preorder traversal is that you can't know where the right of the root starts.
2. Inorder traversal provides a way to locate where the left and right of the root is. Use two pointers to locate the left and right.

**Code:**
{% highlight python %}
# Definition for a binary tree node.
# class TreeNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution(object):
    def buildTree(self, preorder, inorder):
        """
        :type preorder: List[int]
        :type inorder: List[int]
        :rtype: TreeNode
        """
        self.table = {v:i for i,v in enumerate(inorder)}
        self.index = 0
        return self.dfs(preorder, inorder, 0, len(preorder)-1)
    
    def dfs(self, preorder, inorder, start, end):
        if start <= end:
            mid = self.table[preorder[self.index]]
            self.index += 1
            root = TreeNode(inorder[mid])
            root.left = self.dfs(preorder, inorder, start, mid-1)
            root.right = self.dfs(preorder, inorder, mid+1, end)
            return root
{% endhighlight %}


### Construct Binary Tree from Inorder and Postorder Traversal
Given inorder and postorder traversal of a tree, construct the binary tree.

**Analysis:**

1. This question is essentially the same as the previous one, except for that everything is reversed.

**Code:**
{% highlight python %}
# Definition for a binary tree node.
# class TreeNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution(object):
    def buildTree(self, inorder, postorder):
        """
        :type inorder: List[int]
        :type postorder: List[int]
        :rtype: TreeNode
        """
        self.table = {v:i for i, v in enumerate(inorder)}
        self.index = len(inorder)-1
        return self.dfs(inorder, postorder, len(inorder)-1, 0)
    
    def dfs(self, inorder, postorder, start, end):
        if start >= end:
            mid = self.table[postorder[self.index]]
            self.index -= 1
            root = TreeNode(inorder[mid])
            root.right = self.dfs(inorder, postorder, start, mid+1)
            root.left = self.dfs(inorder, postorder, mid-1, end)
            return root
{% endhighlight %}


## Level Order Traversal
### Binary Tree Level Order Traversal
Given a binary tree, return the level order traversal of its nodes' values. (ie, from left to right, level by level).

For example: Given binary tree [3,9,20,null,null,15,7],
{% highlight python %}
    3
   / \
  9  20
    /  \
   15   7
{% endhighlight %}
return its level order traversal as:
{% highlight python %}
[
  [3],
  [9,20],
  [15,7]
]
{% endhighlight %}

**Analysis:**

1. Use DFS.

**Code:**
{% highlight python %}
# Definition for a binary tree node.
# class TreeNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution(object):
    def levelOrder(self, root):
        """
        :type root: TreeNode
        :rtype: List[List[int]]
        """
        result = []
        self.traverse(root, 0, result)
        return result
    
    def traverse(self, node, level, result):
        if not node:
            return
        
        if level == len(result):
            result.append([])
            result[level].append(node.val)
        else:
            result[level].append(node.val)
        
        self.traverse(node.left, level+1, result)
        self.traverse(node.right, level+1, result)
{% endhighlight %}


### Binary Tree Right Side View
Given a binary tree, imagine yourself standing on the right side of it, return the values of the nodes you can see ordered from top to bottom.

For example: Given the following binary tree,
{% highlight python %}
   1            <---
 /   \
2     3         <---
 \     \
  5     4       <---
{% endhighlight %}
You should return [1, 3, 4].

**Analysis:**

1. Use DFS.
2. Level order traversal. Use a number level to control the appending process.

**Code:**
{% highlight python %}
# Definition for a binary tree node.
# class TreeNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution(object):
    def rightSideView(self, root):
        """
        :type root: TreeNode
        :rtype: List[int]
        """
        result = []
        self.add(root, 0, result)
        return result
    
    def add(self, node, level, result):
        if not node:
            return
        
        if level == len(result):
            result.append(node.val)
        
        self.add(node.right, level+1, result)
        self.add(node.left, level+1, result)
{% endhighlight %}


### Populating Next Right Pointers in Each Node
Given a binary tree
{% highlight python %}
    struct TreeLinkNode {
      TreeLinkNode *left;
      TreeLinkNode *right;
      TreeLinkNode *next;
    }
{% endhighlight %}
Populate each next pointer to point to its next right node. If there is no next right node, the next pointer should be set to NULL. Initially, all next pointers are set to NULL.

Note:

1. You may only use constant extra space.
2. You may assume that it is a perfect binary tree (ie, all leaves are at the same level, and every parent has two children). For example, Given the following perfect binary tree,
{% highlight python %}
         1
       /  \
      2    3
     / \  / \
    4  5  6  7
{% endhighlight %}
After calling your function, the tree should look like:
{% highlight python %}
         1 -> NULL
       /  \
      2 -> 3 -> NULL
     / \  / \
    4->5->6->7 -> NULL
{% endhighlight %}

**Analysis:**

1. Use DFS.

**Code:**
{% highlight python %}
# Definition for binary tree with next pointer.
# class TreeLinkNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None
#         self.next = None

class Solution(object):
    def connect(self, root):
        """
        :type root: TreeLinkNode
        :rtype: nothing
        """
        if not root or not root.left:
            return
        
        if root.left:
            root.left.next = root.right
            if root.next:
                root.right.next = root.next.left
        
        self.connect(root.left)
        self.connect(root.right)
{% endhighlight %}


### Populating Next Right Pointers in Each Node II
Follow up for problem "Populating Next Right Pointers in Each Node". What if the given tree could be any binary tree? Would your previous solution still work?

Note: You may only use constant extra space. For example, Given the following binary tree,
{% highlight python %}
         1
       /  \
      2    3
     / \    \
    4   5    7
{% endhighlight %}

After calling your function, the tree should look like:
{% highlight python %}
         1 -> NULL
       /  \
      2 -> 3 -> NULL
     / \    \
    4-> 5 -> 7 -> NULL
{% endhighlight %}

**Analysis:**

1. Most tree problems can be solved by DFS. However, this question requires using BFS on trees, with the next method as the bridge from the left to the right.

**Code:**
{% highlight python %}
# Definition for binary tree with next pointer.
# class TreeLinkNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None
#         self.next = None

class Solution(object):
    def connect(self, node):
        """
        :type root: TreeLinkNode
        :rtype: nothing
        """
        tail = dummy = TreeLinkNode(0)
        while node:
            tail.next = node.left
            if tail.next:
                tail = tail.next
            tail.next = node.right
            if tail.next:
                tail = tail.next
            node = node.next
            if not node:
                tail = dummy
                node = dummy.next
{% endhighlight %}


### Flatten Binary Tree to Linked List
Given a binary tree, flatten it to a linked list in-place.

For example, Given
{% highlight python %}
         1
        / \
       2   5
      / \   \
     3   4   6
{% endhighlight %}
The flattened tree should look like:
{% highlight python %}
   1
    \
     2
      \
       3
        \
         4
          \
           5
            \
             6
{% endhighlight %}

**Code:**
{% highlight python %}
# Definition for a binary tree node.
# class TreeNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution(object):
    def flatten(self, root):
        """
        :type root: TreeNode
        :rtype: void Do not return anything, modify root in-place instead.
        """
        if not root:
            return
        
        l = root.left
        r = root.right
        
        root.left = None
        self.flatten(l)
        self.flatten(r)
        
        root.right = l
        cur = root
        while cur.right:
            cur = cur.right
        cur.right = r
{% endhighlight %}