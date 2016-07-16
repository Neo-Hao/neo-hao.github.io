---
layout: post
title: Useful Factory Methods
---

### Leetcode Question 355
Design a simplified version of Twitter where users can post tweets, follow/unfollow another user and is able to see the 10 most recent tweets in the user's news feed. Your design should support the following methods:

1. postTweet(userId, tweetId): Compose a new tweet.
2. getNewsFeed(userId): Retrieve the 10 most recent tweet ids in the user's news feed. Each item in the news feed must be posted by users who the user followed or by the user herself. Tweets must be ordered from most recent to least recent.
3. follow(followerId, followeeId): Follower follows a followee.
4. unfollow(followerId, followeeId): Follower unfollows a followee.

Code from <a href="https://discuss.leetcode.com/topic/47838/python-solution" target="_blank">https://discuss.leetcode.com/topic/47838/python-solution</a>:

{% highlight python %}
class Twitter(object):
    def __init__(self):
        self.timer = itertools.count(step=-1)
        self.tweets = collections.defaultdict(collections.deque)
        self.followees = collections.defaultdict(set)

    def postTweet(self, userId, tweetId):
        self.tweets[userId].appendleft((next(self.timer), tweetId))

    def getNewsFeed(self, userId):
        tweets = heapq.merge(*(self.tweets[u] for u in self.followees[userId] | {userId}))
        return [t for s, t in itertools.islice(tweets, 10)]

    def follow(self, followerId, followeeId):
        self.followees[followerId].add(followeeId)

    def unfollow(self, followerId, followeeId):
        self.followees[followerId].discard(followeeId)
{% endhighlight %}

Methods:

1. <strong>collections.defaultdict</strong>: Usually, a Python dictionary throws a KeyError if you try to get an item with a key that is not currently in the dictionary. The defaultdict in contrast will simply create any items that you try to access (provided of course they do not exist yet). The argument for collections.defaultdict defines the type of values of the dictionary.
2. <strong>collections.deque</strong>: appendleft for deque is more time efficient than insert(0, item) for list.
3. <strong>itertools.count(optional start, optional end, optional step)</strong>: Create an iterator. Every time you call next() on it, it returns a value differs by step.
4. <strong>itertools.islice(iterable, optional start, end, optional step)</strong>: Make an iterator that returns selected elements from the iterable.
5. <strong>heapq.merge(*iterables)</strong>: Merge multiple sorted inputs into a single sorted output (for example, merge timestamped entries from multiple log files). Returns an iterator over the sorted values. Don't forget the *.
6. lambda expression in Python. Some good examples are listed below.

{% highlight python %}
heapq.merge(*(self.tweets[u] for u in self.followees[userId] | {userId}))
[t for s, t in itertools.islice(tweets, 10)]
{% endhighlight %}

### Leetcode Question 324
Given an unsorted array nums, reorder it such that nums[0] < nums[1] > nums[2] < nums[3]....

Example:
(1) Given nums = [1, 5, 1, 1, 6, 4], one possible answer is [1, 4, 1, 5, 1, 6]. 
(2) Given nums = [1, 3, 2, 2, 3, 1], one possible answer is [2, 3, 1, 3, 1, 2].

Code:

{% highlight python %}
class Solution(object):
    def wiggleSort(self, nums):
        """
        :type nums: List[int]
        :rtype: void Do not return anything, modify nums in-place instead.
        """
        nums.sort()
        half = len(nums[::2])
        
        nums[::2], nums[1::2] = nums[:half][::-1], nums[half:][::-1]
{% endhighlight %}

Methods:

1. a[:5] means the sub-list of a from 0 to 5 (index 5 not included)
2. a[5:] means sub-list of a from 5 to the end
3. a[-2:] means the sub-list of a from the second last till the end
4. a[:-2] means the sub-list of a from 0 to the second last (the second last not included)

a[start:end:step] can be a little bit tricky when step is negative:

1. a[::2] returns a sublist of a with only numbers on even index positions.
1. a[::-1] returns the reverse of a
2. a[half::-2] means: starting from index half till the beginning, select every even number. The order is opposite to a.

