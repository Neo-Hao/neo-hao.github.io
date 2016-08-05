 ---
layout: post
title: Calculator Related Questions
---

### Different Ways to Add Parentheses
Given a string of numbers and operators, return all possible results from computing all the different possible ways to group numbers and operators. The valid operators are +, - and *.

Example 1. Input: "2-1-1".
{% highlight python %}
((2-1)-1) = 0
(2-(1-1)) = 2
Output: [0, 2]
{% endhighlight %}

Example 2. Input: "2*3-4*5"
{% highlight python %}
(2*(3-(4*5))) = -34
((2*3)-(4*5)) = -14
((2*(3-4))*5) = -10
(2*((3-4)*5)) = -10
(((2*3)-4)*5) = 10
{% endhighlight %}

**Analysis:**

1. Use DFS. The general idea is: When an operator is encountered, apply DFS to the string on its left and right. 
2. The usage of enumerate() in Python is very handy: index, item in enumerate(iterator)

**Code:**
{% highlight python %}
class Solution(object):
    def diffWaysToCompute(self, string):
        """
        :type input: str
        :rtype: List[int]
        """
        if string.isdigit():
            return [int(string)]
        
        result = []
        for i, s in enumerate(string):
            if s in '+-*':
                l = self.diffWaysToCompute(string[:i])
                r = self.diffWaysToCompute(string[i+1:])
                result.extend(self.compute(l, r, s))
        return result
    
    def compute(self, l, r, op):
        return [eval(str(m)+op+str(n)) for m in l for n in r]
{% endhighlight %}


### Expression Add Operators
Given a string that contains only digits 0-9 and a target value, return all possibilities to add binary operators (not unary) +, -, or * between the digits so they evaluate to the target value.

Examples: 
{% highlight python %}
"123", 6 -> ["1+2+3", "1*2*3"] 
"232", 8 -> ["2*3+2", "2+3*2"]
"105", 5 -> ["1*0+5","10-5"]
"00", 0 -> ["0+0", "0-0", "0*0"]
"3456237490", 9191 -> []
{% endhighlight %}

**Analysis:**

1. Use DFS. 
2. The key is how to calculation for multiplication and subtraction. Use two variables to hold current number and previous number.

**Code:**
{% highlight python %}
class Solution(object):
    def addOperators(self, num, target):
        """
        :type num: str
        :type target: int
        :rtype: List[str]
        """
        result = []
        if len(num) == 0:
            return result
        
        for i in range(1,len(num)+1):
            if i == 1 or (i > 1 and num[0] != "0"):
                self.dfs(num[i:], target, num[:i], result, int(num[:i]), int(num[:i]))
        
        return result
        
    def dfs(self, num, target, path, result, cur, prev):
        if not num:
            if target == cur:
                result.append(path)
            return
        
        for i in range(1, len(num)+1):
            if i == 1 or (i > 1 and num[0] != "0"):
                n = int(num[:i])
                self.dfs(num[i:], target, path + '+' + num[:i], result, cur + n, n)
                self.dfs(num[i:], target, path + '-' + num[:i], result, cur - n, -n)
                self.dfs(num[i:], target, path + '*' + num[:i], result, cur - prev + prev*n, prev*n)
{% endhighlight %}


### Basic Calculator II
Implement a basic calculator to evaluate a simple expression string. The expression string contains only non-negative integers, +, -, *, / operators and empty spaces . The integer division should truncate toward zero. You may assume that the given expression is always valid.

Some examples:
{% highlight python %}
"3+2*2" = 7
" 3/2 " = 1
" 3+5 / 2 " = 5
{% endhighlight %}

Note: Do not use the eval built-in library function.

**Analysis:**

1. Use stack.
2. There are many details that need attentions.
	* Don't append a digit to the stack but a full number
	* For addition and subtraction, simply append the number or the number subtractd by 0.
	* For multiplication or division, do the calculation and then append the number.

**Code:**
{% highlight python %}
class Solution(object):
    def calculate(self, s):
        """
        :type s: str
        :rtype: int
        """
        stack, num, op = [], 0, '+'
        for i in range(len(s)):
            n = s[i]
            if n.isdigit():
                num = 10*num + int(n)
            if (not n.isdigit() and not n.isspace()) or i == len(s)-1:
                if op == '+':
                    stack.append(num)
                elif op == '-':
                    stack.append(-num)
                elif op == '*':
                    stack.append(stack.pop()*num)
                else:
                    tmp = stack.pop()
                    if tmp//num < 0 and tmp%num != 0:
                        stack.append(tmp//num+1)
                    else:
                        stack.append(tmp//num)
                op = s[i]
                num = 0
        
        return sum(stack)
{% endhighlight %}


### Basic Calculator
Implement a basic calculator to evaluate a simple expression string. The expression string may contain open ( and closing parentheses ), the plus + or minus sign -, non-negative integers and empty spaces . You may assume that the given expression is always valid.

Some examples:
{% highlight python %}
"1 + 1" = 2
" 2-1 + 2 " = 3
"(1+(4+5+2)-3)+(6+8)" = 23
{% endhighlight %}

Note: Do not use the eval built-in library function.

**Analysis:**

1. Use two stacks. One to hold numbers, while the other to hold operators.
2. Use two temporary stacks for calculation purpose whenever in need.

**Code:**
{% highlight python %}
class Solution(object):
    def calculate(self, s):
        """
        :type s: str
        :rtype: int
        """
        nums, signs = [], []
        num = ''
        
        for i in range(len(s)):
            if s[i].isdigit():
                num = num + s[i]
            else:
                if num != '':
                    nums.append(int(num))
                    num = ''
                if s[i] == ')':
                    # pop
                    sign = signs.pop()
                    tmp_nums, tmp_signs = [], []
                    while sign != '(':
                        tmp_nums.append(nums.pop())
                        tmp_signs.append(sign)
                        sign = signs.pop()
                    tmp_nums.append(nums.pop())
                    # calculate
                    val = self.calc(tmp_nums, tmp_signs)
                    nums.append(val)
                elif not s[i].isdigit() and not s[i].isspace():
                    signs.append(s[i])
        if num != '':
            nums.append(int(num))
        
        tmp_nums, tmp_signs = [], []
        while signs:
            tmp_nums.append(nums.pop())
            tmp_signs.append(signs.pop())
        tmp_nums.append(nums.pop())
        
        return self.calc(tmp_nums, tmp_signs)
    
    def calc(self, nums, signs):
        while signs:
            l, r = nums.pop(), nums.pop()
            sign = signs.pop()
            if sign == '+':
                nums.append(l+r)
            else:
                nums.append(l-r)
        result = nums.pop()
        return result
{% endhighlight %}