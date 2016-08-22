---
layout: post
title: Subset
---

## KMP Algorithm

1. Build the index table
2. Traverse the text

**Code:**
{% highlight python %}
def KMPSearch(pat, txt):
    M = len(pat)
    N = len(txt)

    # create lps[] that will hold the longest prefix suffix 
    # values for pattern
    lps = [0]*M
    j = 0 # index for pat[]
 
    # Preprocess the pattern (calculate lps[] array)
    computeLPSArray(pat, M, lps)
 
    i = 0 # index for txt[]
    while i < N:
        if pat[j] == txt[i]:
            i+=1
            j+=1
 
        if j==M:
            print "Found pattern at index " + str(i-j)
            j = lps[j-1]
 
        # mismatch after j matches
        elif i < N and pat[j] != txt[i]:
            if j != 0:
                j = lps[j-1]
            else:
                i+=1

def computeLPSArray(pat, M, lps):
    len = 0 # length of the previous longest prefix suffix
 
    lps[0] = 0 # lps[0] is always 0
    i = 1
 
    # the loop calculates lps[i] for i = 1 to M-1
    while i < M:
        if pat[i] == pat[len]:
            len+=1
            lps[i] = len
            i+=1
        else:
            if len != 0:
                # This is tricky. Consier the example AAACAAAA
                # and i = 7
                len = lps[len-1]
 
                # Also, note that we do not increment i here
            else:
                lps[i] = 0
                i+=1
{% endhighlight %}


### Shortest Palindrome
Given a string S, you are allowed to convert it to a palindrome by adding characters in front of it. Find and return the shortest palindrome you can find by performing this transformation.

For example:

Given "aacecaaa", return "aaacecaaa".

Given "abcd", return "dcbabcd".

**Analysis:**

1. Make a big string: s + '#' + s_reverse
2. Compute the KMP index table for the big string.
3. Concat the first k char of s_reverse with s. K = len(s_reverse) - table[-1]

**Code:**
{% highlight python %}
class Solution(object):
    def shortestPalindrome(self, s):
        """
        :type s: str
        :rtype: str
        """
        s_reverse = s[::-1]
        total = s + '#' + s_reverse
        
        table = [0]*len(total)
        c, i = 0, 1
        while i < len(total):
            if total[i] == total[c]:
                c += 1
                table[i] = c
                i += 1
            else:
                if c != 0:
                    c = table[c-1]
                else:
                    table[i] = 0
                    i += 1
        
        return s_reverse[:len(s_reverse) - table[-1]] + s
{% endhighlight %}


### Implement strStr()
Implement strStr(). Returns the index of the first occurrence of needle in haystack, or -1 if needle is not part of haystack.

**Analysis:**

1. Use KMP

**Code:**
{% highlight python %}
class Solution(object):
    def strStr(self, haystack, needle):
        """
        :type haystack: str
        :type needle: str
        :rtype: int
        """
        if not needle:
            return 0
        if not haystack:
            return -1
        
        return self.kmp(haystack, needle)
    
    def kmp(self, txt, pat):
        table = self.compute_table(pat)
        i, j = 0, 0
        while i < len(txt):
            if txt[i] == pat[j]:
                i += 1
                j += 1
            
            if j == len(pat):
                return i - len(pat)
            
            elif i < len(txt) and txt[i] != pat[j]:
                if j != 0:
                    j = table[j-1]
                else:
                    i += 1
        return -1
    
    def compute_table(self, pat):
        table = [0]*len(pat)
        track, i = 0, 1
        while i < len(pat):
            if pat[i] == pat[track]:
                track += 1
                table[i] = track
                i += 1
            else:
                if track != 0:
                    track = table[track-1]
                else:
                    table[i] = 0
                    i += 1
        return table
{% endhighlight %}