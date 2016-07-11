---
layout: post
title: Graph Search
---
### Leetcode Question 130
Given a 2D board containing 'X' and 'O', capture all regions surrounded by 'X'. A region is captured by flipping all 'O's into 'X's in that surrounded region. For example,
{% highlight python %}
	X X X X
	X O O X
	X X O X
	X O X X
{% endhighlight %}
After running your function, the board should be:
{% highlight python %}
	X X X X
	X X X X
	X X X X
	X O X X
{% endhighlight %}

Analysis:

1.  Bredth first search should be the key. Get the O on the edges, and use bredth first search to find all connected Os, then turn them to B.
2.  If there's still any O left, then they should be converted to X.
3.  Convert Bs back to Os.

Code:
{% highlight python %}
class Solution(object):
    def solve(self, board):
        """
        :type board: List[List[str]]
        :rtype: void Do not return anything, modify board in-place instead.
        """
        # fill up the queue
        if board == []:
            return
        
        width = len(board)
        length = len(board[0])
        
        for i in range(width):
            if board[i][0] == 'O':
                self.bfs_convert(board, i, 0, width, length)
            if board[i][length-1] == 'O':
                self.bfs_convert(board, i, length-1, width, length)
                
        for i in range(length):
            if board[0][i] == 'O':
                self.bfs_convert(board, 0, i, width, length)
            if board[width-1][i] == 'O':
                self.bfs_convert(board, width-1, i, width, length)

        for i in range(width):
            for j in range(length):
                if board[i][j] == 'O':
                    board[i][j] = 'X'
                if board[i][j] == 'B':
                    board[i][j] = 'O'
        
        
    def bfs_convert(self, board, x, y, width, length):
        queue = []
        queue.append((x,y))
        
        while queue != []:
            x = queue[0][0]
            y = queue[0][1]
            board[x][y] = 'B'
            xs = [x, x, x-1, x+1]
            ys = [y+1, y-1, y, y]
            for i in range(4):
                if xs[i] >= 0 and xs[i] < width and \
                    ys[i] >= 0 and ys[i] < length and \
                    board[xs[i]][ys[i]] == 'O':
                        queue.append((xs[i], ys[i]))
                        #print(queue)
            queue.pop(0)
{% endhighlight %}

### Leetcode Question 200
Given a 2d grid map of '1's (land) and '0's (water), count the number of islands. An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.
Example 1:
{% highlight python %}
	11110
	11010
	11000
	00000
{% endhighlight %}
Answer: 1

Example 2:
{% highlight python %}
	11000
	11000
	00100
	00011
{% endhighlight %}
Answer: 3

Analysis:

1.  Very similar to the previous question. Traverse the graph, if there is a 1, then use bredth first search to convert all connected 1s to 0s, and increment the count.

### Leetcode Question 127
Given two words (beginWord and endWord), and a dictionary's word list, find the length of shortest transformation sequence from beginWord to endWord, such that:

*  Only one letter can be changed at a time
*  Each intermediate word must exist in the word list

For example, Given:
{% highlight python %}
beginWord = "hit"
endWord = "cog"
wordList = ["hot","dot","dog","lot","log"]
As one shortest transformation is "hit" -> "hot" -> "dot" -> "dog" -> "cog",
return its length 5.
{% endhighlight %}

Analysis:

1. The question has the nice structure of bredth-first search. Words differ by 1 character can ben treated as neighbors.
2. To make things easier, it's better to include the endword in the set, and keep popping words that are added to the queue from the word list.

Code:
{% highlight python %}
class Solution(object):
    def ladderLength(self, beginWord, endWord, wordList):
        """
        :type beginWord: str
        :type endWord: str
        :type wordList: Set[str]
        :rtype: int
        """
        
        if beginWord in wordList:
            wordList.remove(beginWord)
        
        theword = beginWord
        word_list = list(wordList) + [endWord]
        step = 2
        
        queue = self.find_neighbors(theword, word_list)
        while queue != []:
            limit = len(queue)
            for i in range(limit):
                target = queue.pop(0)
                if target == endWord:
                    return step
                else:
                    queue = queue + self.find_neighbors(target, word_list)
            step += 1
        
        return 0
    
    
    def find_neighbors(self, theword, word_list):
        result = []
        i = 0
        while i < len(word_list):
            if self.diff_count(theword, word_list[i]) == 1:
                word = word_list.pop(i)
                result.append(word)
            else:
                i += 1
        
        return result
    
    def diff_count(self, word1, word2):
        count = 0
        for i in range(len(word1)):
            if word1[i] != word2[i]:
                count += 1
        
        return count
{% endhighlight %}