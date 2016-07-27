---
layout: post
title: Graph Sort
---

### Basics of Graph Sorting

1. There are largely two types o graph sorting problems: a) Directed Acyclic Graph (DAG) Sorting, b) Directed Cyclic Graph (DCG) Sorting.
2. To solve problems on DAG, use topological sorting.
3. To solve problems on DCG, use DFS.


### Leetcode Question 332

Given a list of airline tickets represented by pairs of departure and arrival airports [from, to], reconstruct the itinerary in order. All of the tickets belong to a man who departs from JFK. Thus, the itinerary must begin with JFK.

Note:

1. If there are multiple valid itineraries, you should return the itinerary that has the smallest lexical order when read as a single string. For example, the itinerary ["JFK", "LGA"] has a smaller lexical order than ["JFK", "LGB"].
2. All airports are represented by three capital letters (IATA code).
3. You may assume all tickets form at least one valid itinerary.

Example 1:

*tickets = [["MUC", "LHR"], ["JFK", "MUC"], ["SFO", "SJC"], ["LHR", "SFO"]]
* Return ["JFK", "MUC", "LHR", "SFO", "SJC"].

Example 2:

* tickets = [["JFK","SFO"],["JFK","ATL"],["SFO","ATL"],["ATL","JFK"],["ATL","SFO"]]
* Return ["JFK","ATL","JFK","SFO","ATL","SFO"].
* Another possible reconstruction is ["JFK","SFO","ATL","JFK","ATL","SFO"]. But it is larger in lexical order.

Analysis:

1. Use DFS.
2. When a node is visited, pop its neighbors and visit them one by one. 
3. The path needs to be constructed backwards. When a node does not go to any other nodes, add it to the path.

Code:
{% highlight python %}
class Solution(object):
    def findItinerary(self, tickets):
        """
        :type tickets: List[List[str]]
        :rtype: List[str]
        """
        print(tickets)
        print(sorted(tickets)[::-1])
        
        targets = collections.defaultdict(list)
        for a, b in sorted(tickets)[::-1]:
            targets[a] += b,
        #print(targets)
        
        route = []
        self.visit('JFK', targets, route)
        return route[::-1]
    
    def visit(self, airport, targets, route):
        while targets[airport]:
            airport_next = targets[airport].pop()
            self.visit(airport_next, targets, route)
        route.append(airport)
        #print(route)
        #print(targets)
{% endhighlight %}

### Leetcode Question 207
There are a total of n courses you have to take, labeled from 0 to n - 1. Some courses may have prerequisites, for example to take course 0 you have to first take course 1, which is expressed as a pair: [0,1]. Given the total number of courses and a list of prerequisite pairs, is it possible for you to finish all courses?

For example:
{% highlight python %}
2, [[1,0]]
{% endhighlight %}
There are a total of 2 courses to take. To take course 1 you should have finished course 0. So it is possible.

{% highlight python %}
2, [[1,0],[0,1]]
{% endhighlight %}
There are a total of 2 courses to take. To take course 1 you should have finished course 0, and to take course 0 you should also have finished course 1. So it is impossible.

Note:
The input prerequisites is a graph represented by a list of edges, not adjacency matrices. Read more about how a graph is represented.

Analysis:

1. Topological sort or topological ordering of a directed graph is a linear ordering of its vertices such that for every directed edge uv from vertex u to vertex v, u comes before v in the ordering.
2. Typical solutions for topological sort include BFS and DFS. Both BFS and DFS for directed graph are different from their applications on non-directed graph.
3. BFS for topological sort: BFS tracks the number of incoming edges of each node. We will first try to find a node with 0 incoming edges. If we fail to do so, there must be a cycle in the graph and we return false. Otherwise BFS will be applied to the node. We set its incoming edge number to be -1 to prevent from visiting it again and reduce the incoming edge number of all its neighbors by 1. This process will be repeated for n (number of nodes) times. If we have not returned false, we will return true.
4. DFS for topological sort: DFS will first visit a node, then one neighbor of it, then one neighbor of this neighbor... and so on. If it meets a node which was visited in the current process of DFS visit, a cycle is detected and we will return false. Otherwise it will start from another unvisited node and repeat this process. Two trackings are necessary: one is for all the visited nodes and the other for the visited nodes in the current DFS visit. Note: Once the current DFS visit is finished, we need to reset the onpath value of the starting node to false.

Code of BFS:

{% highlight python %}
class Solution(object):
    def canFinish(self, numCourses, prerequisites):
        """
        :type numCourses: int
        :type prerequisites: List[List[int]]
        :rtype: bool
        """
        # make graph
        graph = self.make_graph(numCourses, prerequisites)
        # calculate income edge numbers
        income = self.income_calc(graph)
        # topological traversal
        for i in range(len(graph)):
            j = 0
            while j < len(graph):
                if income[j] == 0:
                    break
                j += 1
            if j == len(graph):
                return False
            income[j] = -1
            for neighbor in graph[j]:
                income[neighbor] -= 1
        return True
            
    def make_graph(self, numCourses, prerequisites):
        result = [[] for i in range(numCourses)]
        for i in prerequisites:
            result[i[1]].append(i[0])
        return result
    
    def income_calc(self, graph):
        degree = [0]*len(graph)
        for neighbors in graph:
            for i in neighbors:
                degree[i] += 1
        
        return degree
{% endhighlight %}

Code of DFS:

{% highlight python %}
class Solution(object):
    def canFinish(self, numCourses, prerequisites):
        """
        :type numCourses: int
        :type prerequisites: List[List[int]]
        :rtype: bool
        """
        # make graph
        graph = self.make_graph(numCourses, prerequisites)
        visited = [False]*numCourses
        onpath = [False]*numCourses
        
        for i in range(numCourses):
            if (not visited[i]) and self.has_cycle(graph, i, visited, onpath):
                return False
        return True
            
    def make_graph(self, numCourses, prerequisites):
        result = [[] for i in range(numCourses)]
        for i in prerequisites:
            result[i[1]].append(i[0])
        return result
    
    def has_cycle(self, graph, i, visited, onpath):
        if visited[i] == True:
            return False
        onpath[i] = visited[i] = True
        for neighbor in graph[i]:
            if onpath[neighbor] or self.has_cycle(graph, neighbor, visited, onpath):
                return True
        onpath[i] = False
        return False
{% endhighlight %}


### Leetcode 210
There are a total of n courses you have to take, labeled from 0 to n - 1. Some courses may have prerequisites, for example to take course 0 you have to first take course 1, which is expressed as a pair: [0,1]. Given the total number of courses and a list of prerequisite pairs, return the ordering of courses you should take to finish all courses. There may be multiple correct orders, you just need to return one of them. If it is impossible to finish all courses, return an empty array.

For example:
{% highlight python %}
2, [[1,0]]
{% endhighlight %}

There are a total of 2 courses to take. To take course 1 you should have finished course 0. So the correct course order is [0,1]

{% highlight python %}
4, [[1,0],[2,0],[3,1],[3,2]]
{% endhighlight %}

There are a total of 4 courses to take. To take course 3 you should have finished both courses 1 and 2. Both courses 1 and 2 should be taken after you finished course 0. So one correct course order is [0,1,2,3]. Another correct ordering is[0,2,1,3].

Analysis:
1. This question is basically the same as the previous one. Just remember to reverse the result for DFS.

Code of BFS:
{% highlight python %}
class Solution(object):
    def findOrder(self, numCourses, prerequisites):
        """
        :type numCourses: int
        :type prerequisites: List[List[int]]
        :rtype: List[int]
        """
        graph = self.make_graph(numCourses, prerequisites)
        income_list = self.income_calc(graph)
        
        result = []
        for i in range(numCourses):
            j = 0
            while j < numCourses:
                if income_list[j] == 0:
                    break
                j += 1
            if j == numCourses:
                return []
            income_list[j] = -1
            result.append(j)
            for neighbor in graph[j]:
                income_list[neighbor] -= 1
        return result
            
    def make_graph(self, numCourses, prerequisites):
        result = [[] for i in range(numCourses)]
        for i in prerequisites:
            result[i[1]].append(i[0])
        return result
    
    def income_calc(self, graph):
        degree = [0]*len(graph)
        for neighbors in graph:
            for i in neighbors:
                degree[i] += 1
        
        return degree
{% endhighlight %}

Code of DFS:

{% highlight python %}
class Solution(object):
    def findOrder(self, numCourses, prerequisites):
        """
        :type numCourses: int
        :type prerequisites: List[List[int]]
        :rtype: List[int]
        """
        graph = self.make_graph(numCourses, prerequisites)
        visited = [False]*numCourses
        onpath = [False]*numCourses
        result = []
        
        for i in range(numCourses):
            if (not visited[i]) and self.has_cycle(graph, i, visited, onpath, result):
                return []
        
        result.reverse()
        return result
            
    def make_graph(self, numCourses, prerequisites):
        result = [[] for i in range(numCourses)]
        for i in prerequisites:
            result[i[1]].append(i[0])
        return result
    
    def has_cycle(self, graph, i, visited, onpath, result):
        if visited[i] == True:
            return False
        onpath[i] = visited[i] = True
        for neighbor in graph[i]:
            if onpath[neighbor] or self.has_cycle(graph, neighbor, visited, onpath, result):
                return True
        
        result.append(i)
        onpath[i] = False
        return False
{% endhighlight %}


### Leetcode 310
For a undirected graph with tree characteristics, we can choose any node as the root. The result graph is then a rooted tree. Among all possible rooted trees, those with minimum height are called minimum height trees (MHTs). Given such a graph, write a function to find all the MHTs and return a list of their root labels.

Format

The graph contains n nodes which are labeled from 0 to n - 1. You will be given the number n and a list of undirected edges (each edge is a pair of labels).

You can assume that no duplicate edges will appear in edges. Since all edges are undirected, [0, 1] is the same as [1, 0] and thus will not appear together in edges.

Example 1: Given n = 4, edges = [[1, 0], [1, 2], [1, 3]]
{% highlight python %}
        0
        |
        1
       / \
      2   3
{% endhighlight %}

return [1]

Example 2: Given n = 6, edges = [[0, 3], [1, 3], [2, 3], [4, 3], [5, 4]]
{% highlight python %}
     0  1  2
      \ | /
        3
        |
        4
        |
        5
{% endhighlight %}

return [3, 4]

Analysis:

1. There is a difference between directed and undirected graphs in terms of making a graph in the format of dictionary. Directed graph only needs one traversal in the given order. Undirected graph needs traversals in both the given and reverse orders.
1. Similar to topological sort, it is important to start with the nodes that have only one edges (degrees).
2. Start with having the nodes that have degree 1 in a leave set. Have their adjacency info deleted. Remove them from their neighbors's adjacency information, and subtract their neighbors' degrees accordingly. If their neighbors also happen to have a degree as 1, then save them in a new set and swap with the original leave set by the end of the loop.
3. Start from the both ends of nodes with degree as 1. Stop when there are less or equal to two nodes left.

Code:

{% highlight python %}
class Solution(object):
    def findMinHeightTrees(self, n, edges):
        """
        :type n: int
        :type edges: List[List[int]]
        :rtype: List[int]
        """
        if n == 1: return [0] 
        # make graph
        graph = self.make_graph(n, edges)
        # collect leaves
        leaves = []
        for i in range(len(graph)):
            if len(graph[i]) == 1:
                leaves.append(i)
        
        while n > 2:
            n -= len(leaves)
            newleaves = []
            for i in leaves:
                j = graph[i].pop()
                graph[j].remove(i)
                if len(graph[j]) == 1:
                    newleaves.append(j)
                leaves = newleaves
        return leaves
            
    def make_graph(self, n, edges):
        graph = [[] for i in range(n)]
        for i in edges:
            graph[i[0]].append(i[1])
            graph[i[1]].append(i[0])
        return graph
{% endhighlight %}