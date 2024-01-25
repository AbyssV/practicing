#  `None`在python中的意义

教授说对于`None`来说，如果我们使用`if A`，会判断A是不是`None`，然后判断A是不是0，然后判断A是不是空字符串。

如果我们使用`if A is None`，我们只会判断A是不是`None`



# Comprehension

教授说comprehension内部进行了优化

```python
def subsets(nums):
    result = [[]]
    for num in nums:
        for element in result[:]:  # 每一轮循环都对result做了copy，如果不copy，会永远循环
            x = element[:]  # 切片器的拷贝是浅拷贝，如果不对里面的element做拷贝，result里原有的元素都会通过x的指向被改动
            x.append(num)
            result.append(x)

    return result
def subsets_2(nums):
    res = [[]]
    for num in nums:
        res += [ i + [num] for i in res] # 这里不懂
    return res
nums = [1, 2, 3]
print(subsets_2(nums))
print(subsets(nums))
```

使用

```python
[[None] for i in range(5)] # 快速创建[[]]
```



# 并列赋值语句的执行顺序

```python
# 找到中间节点，反转前半部分，然后逐个比对。O(n)
def isPalindrome(head):
    rev = None
    slow = fast = head
    while fast and fast.next:
        fast = fast.next.next
        rev, rev.next, slow = slow, rev, slow.next # 这里不懂
    if fast:
        slow = slow.next
    while rev and rev.value == slow.value:
        slow = slow.next
        rev = rev.next
    return not rev # None的用法
```

我自己写了个例子

```python
print(not 1)
a = 3
b = 4
c = 5
# 右边都是旧的
a, b, c = b, c, a
print(a, b, c) # 4, 5, 3
```



# 继承的用法

```python
import sys
from ArrayStack import ArrayStack
class MinStack(ArrayStack):
    def __init__(self):
        # 这里不懂。不应该是super(ArrayStack, self).__init__()吗？难道是我的笔记错了
        # 修正：是我记错了，就是这么写的。推荐super().__init__()
        super(MinStack, self).__init__()

    def push(self, v):
        newMin = min(v, self.min())
        super(MinStack, self).push(NodeWithMin(v, newMin))

    def min(self):
        if (super(MinStack, self).is_empty()):
            # An integer giving the maximum value a variable of type Py_ssize_t can take. It’s usually 2**31 - 1 on a 32-bit platform and 2**63 - 1 on a 64-bit platform
            return sys.maxsize
        else:
            return super(MinStack, self).top()._min; # 推荐：super().top()

class NodeWithMin:
    def __init__(self, v, min):
        self._value = v
        self._min = min
```



# private和public

python中没有特定的public和private，约定俗成如果写成普通的格式`def get(self,v)`就是public方法

In Python, there aren't explicit keywords for declaring methods or attributes as public or private, like in languages such as Java or C++. However, there are conventions that are followed to indicate the intended level of visibility for methods and attributes:

1. **Public Methods and Attributes**: These are methods and attributes that are intended to be accessible from outside the class. They are defined without any leading underscores. For example, `def get(self):`.
2. **Protected Methods and Attributes**: These are methods and attributes that are intended to be accessed only from within the class itself or from its subclasses. They are defined with a single leading underscore. For example, `def _get(self):`.
3. **Private Methods and Attributes**: These are methods and attributes that are intended to be accessed only from within the class itself, not from its subclasses. They are defined with double leading underscores. For example, `def __get(self):`.

It's important to note that these are merely conventions and Python doesn't enforce access restrictions like some other languages. The double underscore prefix causes the Python interpreter to rewrite the attribute name to avoid naming conflicts in subclasses, a mechanism known as name mangling. This isn't true privacy, but it does make the attribute harder to access unintentionally.

As a rule of thumb, unless you have a good reason to do otherwise, you should define your methods and attributes as public. If you need to signal that a method or attribute is intended for internal use within a class or a module, use a single leading underscore. The double underscore prefix should be used sparingly, if at all.



# list中的+=和append的区别

有没有修改原数组

+= 类似extend



# list中的*和append的区别

在写dp的时候，遇到这样一个问题

```python
# dp = [[0 for _ in range(W+1)]] * 2
dp = [[0 for _ in range(W+1)],[0 for _ in range(W+1)]]
```

这是`[[0, 0],[0, 0]]`的结构。我发现在第一个例子中，修改内部第一个数组，第二个也会修改，而在第二个例子中，修改第一个第二个则不会变化。说明`*`操作极有可能复制的地址



# sorted set

```python
s = set((2,4,5,1,0))
sorted(s)
```



# 逗号的用处

```python
# 本题与introduction中求100内所有质数的解法类似
# 这个函数非常奇怪，不用return，必须有逗号，没有逗号报错
def nthUglyNumber(n):
    q2, q3, q5 = [2], [3], [5]
    ugly = 1
    for u in heapq.merge(q2, q3, q5):
        if n == 1:
            return ugly
        if u > ugly:
            ugly = u
            n -= 1
            q2 += 2 * u,
            q3 += 3 * u,
            q5 += 5 * u,
    # return ugly
print(nthUglyNumber(10))
```

已验证：我猜测是换tuple。通常这个教授会用`lst1 += [int]`代替`lst.append(int)`，但是他不写`[]`时，就会变成`lst += int,`



# 内部函数和外部函数

内部函数可以访问外部函数的变量



# ！！！注意deque

```python
# 当我们想加入tuple时
queue = deque([(0, 1, 2, 3)]) # 结果是deque([(0, 1, 2, 3)])
# 如果
queue = deque((0, 1, 2, 3)) # 结果是deque([0, 1, 2, 3])
# 但是append不影响
queue.append((4,5,6,7)) # 结果是deque([(0, 1, 2, 3), (4, 5, 6, 7)])


```



