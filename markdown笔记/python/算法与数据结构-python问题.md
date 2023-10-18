### `None`在python中的意义

教授说对于`None`来说，如果我们使用`if A`，会判断A是不是`None`，然后判断A是不是0，然后判断A是不是空字符串。

如果我们使用`if A is None`，我们只会判断A是不是`None`

### Comprehension

#### comprehension的执行机制

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

### 使用

```python
[[None] for i in range(5)] # 快速创建[[]]
```



### 并列赋值语句的执行顺序

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



### 继承的用法

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



### private和public

python中没有特定的public和private，约定俗成如果写成普通的格式`def get(self,v)`就是public方法

In Python, there aren't explicit keywords for declaring methods or attributes as public or private, like in languages such as Java or C++. However, there are conventions that are followed to indicate the intended level of visibility for methods and attributes:

1. **Public Methods and Attributes**: These are methods and attributes that are intended to be accessible from outside the class. They are defined without any leading underscores. For example, `def get(self):`.
2. **Protected Methods and Attributes**: These are methods and attributes that are intended to be accessed only from within the class itself or from its subclasses. They are defined with a single leading underscore. For example, `def _get(self):`.
3. **Private Methods and Attributes**: These are methods and attributes that are intended to be accessed only from within the class itself, not from its subclasses. They are defined with double leading underscores. For example, `def __get(self):`.

It's important to note that these are merely conventions and Python doesn't enforce access restrictions like some other languages. The double underscore prefix causes the Python interpreter to rewrite the attribute name to avoid naming conflicts in subclasses, a mechanism known as name mangling. This isn't true privacy, but it does make the attribute harder to access unintentionally.

As a rule of thumb, unless you have a good reason to do otherwise, you should define your methods and attributes as public. If you need to signal that a method or attribute is intended for internal use within a class or a module, use a single leading underscore. The double underscore prefix should be used sparingly, if at all.

### list中的+=和append的区别

有没有修改原数组

+= 类似extend



### list中的*和append的区别

在写dp的时候，遇到这样一个问题

```python
# dp = [[0 for _ in range(W+1)]] * 2
dp = [[0 for _ in range(W+1)],[0 for _ in range(W+1)]]
```

这是`[[0, 0],[0, 0]]`的结构。我发现在第一个例子中，修改内部第一个数组，第二个也会修改，而在第二个例子中，修改第一个第二个则不会变化。说明`*`操作极有可能复制的地址



### sorted set

```python
s = set((2,4,5,1,0))
sorted(s)
```



### 逗号的用处

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



### 内部函数和外部函数

内部函数可以访问外部函数的变量



### ！！！注意deque

```python
# 当我们想加入tuple时
queue = deque([(0, 1, 2, 3)]) # 结果是deque([(0, 1, 2, 3)])
# 如果
queue = deque((0, 1, 2, 3)) # 结果是deque([0, 1, 2, 3])
# 但是append不影响
queue.append((4,5,6,7)) # 结果是deque([(0, 1, 2, 3), (4, 5, 6, 7)])


```



##  KMP

KMP（Knuth-Morris-Pratt）算法是一种在字符串中查找子串的高效算法。

在朴素的子串查找算法中，通常从左到右检查主字符串中的每个字符是否匹配子串。如果发现不匹配，算法会回到主字符串的下一个字符并重新开始匹配。这种方法的时间复杂度可能高达 $O(nm)$，其中 是$n$主字符串的长度，$m$是子串的长度。

KMP 算法通过预处理子串来避免不必要的比较，从而提高了效率。它创建了一个所谓的 "部分匹配表"（也称为 "失败函数"），该表保存了子串中前缀和后缀的最长公共元素的长度。这样，当发生不匹配时，KMP 算法可以通过查表跳过已知不会匹配的字符，而不需要像朴素方法那样回到主字符串的下一个字符。

因此，KMP 算法的时间复杂度可以达到$O(n+m)$，这在匹配大字符串时能带来明显的性能提升。然而，KMP 算法的实现相对复杂，并且对于小字符串，其性能提升可能不明显

```python
def build_prefix_table(pattern):
    prefix_table = [0] * len(pattern)
    j = 0
    for i in range(1, len(pattern)):
        while j > 0 and pattern[i] != pattern[j]:
            j = prefix_table[j - 1]
        if pattern[i] == pattern[j]:
            j += 1
        prefix_table[i] = j
    return prefix_table


def kmp_search(text, pattern):
    if not pattern:
        return 0  # If the pattern is empty, we return 0

    prefix_table = build_prefix_table(pattern)
    j = 0
    for i in range(len(text)):
        while j > 0 and text[i] != pattern[j]:
            j = prefix_table[j - 1]
        if text[i] == pattern[j]:
            j += 1
        if j == len(pattern):
            return i - (j - 1)  # Return the start index of the match in the text

    return -1  # If no match is found, we return -1


# Test the kmp_search function
text = "ABABDABACDABABCABAB"
pattern = "ABABCABAB"
index = kmp_search(text, pattern)
index # 10

```



## AVL树

AVL树（由发明者 G. M. Adelson-Velsky 和 E. M. Landis 命名）是一种自平衡二叉搜索树，即任何时候对其进行插入或删除操作，它都能保持其高度差不大于 1 的特性。这种特性使得树保持相对平衡，从而在最坏情况下，保证了查找、插入和删除的时间复杂度为 $O(logn)$。

AVL树在以下几种操作中进行自平衡：

- 插入：在一次或多次树旋转后，可以保持AVL树的平衡。
- 删除：也是在一次或多次树旋转后，可以保持AVL树的平衡。

下面是一个简单的 AVL 树的 Python 实现：

```python
class Node:
    def __init__(self, val):
        self.val = val
        self.left = None
        self.right = None
        self.height = 1  # height of node in tree (starts at 1)

class AVLTree:
    def insert(self, root, key):
        if not root:
            return Node(key)
        elif key < root.val:
            root.left = self.insert(root.left, key)
        else:
            root.right = self.insert(root.right, key)

        root.height = 1 + max(self.getHeight(root.left), self.getHeight(root.right))

        balance = self.getBalance(root)

        if balance > 1 and key < root.left.val:
            return self.rightRotate(root)

        if balance < -1 and key > root.right.val:
            return self.leftRotate(root)

        if balance > 1 and key > root.left.val:
            root.left = self.leftRotate(root.left)
            return self.rightRotate(root)

        if balance < -1 and key < root.right.val:
            root.right = self.rightRotate(root.right)
            return self.leftRotate(root)

        return root

    def leftRotate(self, z):
        y = z.right
        T2 = y.left
        y.left = z
        z.right = T2
        z.height = 1 + max(self.getHeight(z.left), self.getHeight(z.right))
        y.height = 1 + max(self.getHeight(y.left), self.getHeight(y.right))
        return y

    def rightRotate(self, y):
        x = y.left
        T2 = x.right
        x.right = y
        y.left = T2
        y.height = 1 + max(self.getHeight(y.left), self.getHeight(y.right))
        x.height = 1 + max(self.getHeight(x.left), self.getHeight(x.right))
        return x

    def getHeight(self, root):
        if not root:
            return 0
        return root.height

    def getBalance(self, root):
        if not root:
            return 0
        return self.getHeight(root.left) - self.getHeight(root.right)

```



## 红黑树

红黑树是一种自平衡的二叉搜索树，其中每个节点都带有一个颜色属性，颜色可以是红色或黑色。在二叉搜索树的基础上，红黑树在树的结构上增加了一些额外的约束，以确保没有一条路径会比其他路径长出两倍以上。这样可以保证从根到叶子的最长可能路径不超过最短可能路径的两倍长，结果是树大致上是平衡的。由于树的操作往往需要在树的高度上花费时间，这个特性使红黑树在最坏情况下的时间复杂度仍然保持在$O(logn)$

以下是红黑树的一些关键特性：

- 每个节点或者是黑色，或者是红色。
- 树的根节点是黑色。
- 所有叶节点（NIL节点，空节点）是黑色的。
- 如果一个节点是红色的，则它的子节点必须是黑色的。
- 从一个节点到该节点的子孙节点的所有路径上包含相同数量的黑节点。

Python 中实现红黑树的代码会比较复杂，因为需要处理多种不同的插入和删除情况，以保持红黑树的特性。

对于完整的红黑树，还需要实现更多的旋转操作、修复操作以及删除操作。在实际使用中，可以考虑使用已经实现的数据结构库，如 Python 的 `sortedcontainers` 库。

### 红黑树和AVL树的应用场景

1. **红黑树**：红黑树的主要优点是在插入、删除和查找操作上的最坏情况时间复杂度都是 $O(logn)$。因此，红黑树在需要大量插入和删除操作的场景中特别有用，如在许多类型的集合或映射中。红黑树也在很多编程语言的标准库中被广泛使用，例如在 Java 的 TreeMap 和 TreeSet、C++ STL 的 map 和 set 等。
2. **AVL树**：AVL树是严格平衡的，因此对于查找密集型的应用，AVL树通常比红黑树有更好的性能。然而，由于需要更严格的平衡，AVL树在插入和删除时可能需要更多的旋转操作。因此，如果你的应用主要是进行查找操作，而插入和删除较少，那么 AVL 树可能是一个更好的选择。



## Union-Find

Union-Find 是一种解决动态连通性问题的算法，也称为 disjoint-set 数据结构或 merge-find set。它可以高效地解决一类问题：对于一些元素，将它们划分为若干个不相交的集合，并支持两种操作：

1. Union（合并）操作：合并两个集合。
2. Find（查找）操作：查找某个元素所在的集合。

Union-Find 算法主要由两个函数组成：

1. `Union(x, y)`: 将元素 `x` 和元素 `y` 所在的集合合并为一个集合。
2. `Find(x)`: 返回元素 `x` 所在的集合的代表元素。通常，这是该集合中的某个特定元素，如集合中的最小元素或集合的根元素。

Union-Find 算法在很多应用中都非常有用，例如在 Kruskal 算法中查找最小生成树，在编译器的符号表中，以及在计算机视觉中的连通组件标记等。

以下是 Union-Find 算法的一个简单 Python 实现：

```python
class UnionFind:
    def __init__(self, n):
        self.parent = list(range(n))
        self.rank = [0] * n

    def find(self, x):
        if self.parent[x] != x:
            self.parent[x] = self.find(self.parent[x])
        return self.parent[x]

    def union(self, x, y):
        xr = self.find(x)
        yr = self.find(y)
        if xr != yr:
            if self.rank[xr] < self.rank[yr]:
                self.parent[xr] = yr
            elif self.rank[xr] > self.rank[yr]:
                self.parent[yr] = xr
            else:
                self.parent[yr] = xr
                self.rank[xr] += 1
```

在这个实现中，我们使用路径压缩（在 `find` 方法中）和按秩合并（在 `union` 方法中）来提高效率。这两种优化都能使 Union-Find 算法在实践中运行得非常快。



## LRU(Least Recent Unit)

LRU（Least Recently Used）是一种常用的缓存淘汰策略。当缓存已满，需要在缓存中存入新的元素时，LRU 策略会选择最近最少使用的元素进行替换。

Python 中的 `collections` 库提供了一个 `OrderedDict` 数据结构，它可以非常容易地用于实现 LRU 缓存。`OrderedDict` 是一个字典子类，它记住了元素添加的顺序。当需要淘汰一个元素时，我们只需要弹出字典中的第一个元素即可。

以下是一个简单的 LRU 缓存的实现：

```python
from collections import OrderedDict

class LRUCache:
    def __init__(self, capacity):
        self.cache = OrderedDict()
        self.capacity = capacity

    def get(self, key):
        if key not in self.cache:
            return -1
        self.cache.move_to_end(key)  # 将元素移动到最后，表示最近使用
        return self.cache[key]

    def put(self, key, value):
        if key in self.cache:
            del self.cache[key]
        elif len(self.cache) == self.capacity:
            self.cache.popitem(last=False)  # 弹出最早加入的元素
        self.cache[key] = value

```

在这个实现中，我们使用 `OrderedDict` 作为缓存。`get` 方法尝试获取并返回元素，如果元素在缓存中，我们将其移动到有序字典的末尾，表示最近使用过。`put` 方法插入一个元素到缓存中，如果元素已经在缓存中，我们先删除旧的元素，然后插入新的元素。如果缓存已满（即元素数量等于设定的容量），我们先淘汰最少使用的元素（即有序字典的第一个元素），然后插入新元素。
