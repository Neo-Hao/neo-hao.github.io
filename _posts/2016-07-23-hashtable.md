---
layout: post
title: Hashtable
---

### When to use a hashtable

1. As long as there are searching tasks, think about whether hashtable is a good choice.


### Leetcode Question 306
Write a function to find all the 10-letter-long sequences (substrings) that occur more than once in a DNA molecule. 

For example, Given s = "AAAAACCCCCAAAAACCCCCCAAAAAGGGTTT", Return: ["AAAAACCCCC", "CCCCCAAAAA"].

**Code:**

{% highlight python %}
class Solution(object):
    def findRepeatedDnaSequences(self, s):
        if len(s) == 10:
            return []
        
        result = set()
        table = collections.defaultdict(int)
        for i in range(0, len(s)-9):
            table[s[i:i+10]] += 1
            if table[s[i:i+10]] > 1:
                result.add(s[i:i+10])
        
        # print(table)
        return list(result)
{% endhighlight %}