[TOC]

# Python基础

## 标识符

标识符命名规则是Python中定义各种名字的时候的统一规范，具体如下：

- 由数字、字母、下划线组成
- 不能数字开头
- 不能使用内置关键字
- 严格区分大小写

```python
False     None    True   and      as       assert   break     class  
continue  def     del    elif     else     except   finally   for
from      global  if     import   in       is       lambda    nonlocal
not       or      pass   raise    return   try      while     with  
yield
```

## 输入和输出

### 输入

```s = input('请输入你的姓名')```

在Python中，`input`会把接收到的任意用户输入的数据都当做字符串处理。

### 格式化输出

- ```%06d```，表示输出的整数显示位数，不足以0补全，超出当前位数则原样输出
- ```%.2f```，表示小数点后显示的小数位数。
- ```end=''```结尾, ```sep=''```分隔

| 格式符号 |          转换          |
| :------: | :--------------------: |
|  **%s**  |         字符串         |
|  **%d**  |   有符号的十进制整数   |
|  **%f**  |         浮点数         |
|    %c    |          字符          |
|    %u    |    无符号十进制整数    |
|    %o    |       八进制整数       |
|    %x    | 十六进制整数（小写ox） |
|    %X    | 十六进制整数（大写OX） |
|    %e    | 科学计数法（小写'e'）  |
|    %E    | 科学计数法（大写'E'）  |
|    %g    |      %f和%e的简写      |
|    %G    |      %f和%E的简写      |

#### f-字符串/```format```

```python
# 百分比
f = 0.42542352
print(f"百分比示例 {f:2.2%}") # 百分比示例 42.54%
print("百分比示例 {:2.2%}".format(f)) # 百分比示例 42.54%

print(f"小数示例{32.5645:.^20.4}") # 小数示例.......32.56........
print(f"整数示例{32:.^20d}") # 整数示例.........32.........
print("小数示例{0:.^20.4f}".format(32.5645)) # 小数示例.......32.56........
x = 10
print(f"{x} is {'even' if x%2 == 0 else 'odd'}")

# 索引
d = [10, 15, 20]
print(f"小明今年{d[0]}岁，小红今年{d[1]}岁，小强今年{d[2]}岁")
print("小明今年{0[0]}岁，小红今年{0[1]}岁，小强今年{0[2]}岁".format(d))

print(1, 2, 3, 4, sep = '--', end = '/')
print(5, 6, 7, 8, sep = 'x', end = '**') #1--2--3--4/5x6x7x8**

msg=['wang',10]
'my name is {0}, {0} age is {1}'.format(*msg) # my name is wang, wang age is 10
msg={'name':'wang','age':10}
'my name is {name}, {name} age is {age}'.format(**msg) # my name is wang, wang age is 10
# 左对齐
'{:*<10}'.format('分割线')
# 居中
'{:*^10}'.format('分割线')
# 右对齐
'{:*>10}'.format('分割线')
# 输出二进制
'{0:b}'.format(10) # 1010
# 输出千分位分隔符
'{:,}'.format(12369132698) # 12,369,132,698
```

## 数据转换类型

|         函数          |                             说明                             |
| :-------------------: | :----------------------------------------------------------: |
|  **int(x [,base])**   |                      将x转换为一个整数                       |
|     **float(x)**      |                     将x转换为一个浮点数                      |
| complex(real [,imag]) |             创建一个复数，real为实部，imag为虚部             |
|      **str(x)**       |                    将对象 x 转换为字符串                     |
|        repr(x)        | 用于生成解释器可读的表示（如果没有等效的语法，则会强制执行 SyntaxError） |
|     **eval(str)**     |     用来计算在字符串中的有效Python表达式,并返回一个对象      |
|     **tuple(s)**      |                   将序列 s 转换为一个元组                    |
|      **list(s)**      |                   将序列 s 转换为一个列表                    |
|        chr(x)         |               将一个整数转换为一个Unicode字符                |
|        ord(x)         |               将一个字符转换为它的ASCII整数值                |
|        hex(x)         |              将一个整数转换为一个十六进制字符串              |
|        oct(x)         |               将一个整数转换为一个八进制字符串               |
|        bin(x)         |               将一个整数转换为一个二进制字符串               |

```python
#eval() -- 将字符串中的数据转换成Python表达式原本类型
str1 = '10'
str2 = '[1, 2, 3]'
str3 = '(1000, 2000, 3000)'
print(type(eval(str1)))
print(type(eval(str2)))
print(type(eval(str3)))
```

## 运算符

### 算术运算符

混合运算优先级顺序：`()` > `**` > `*` `/` `//` `%` > `+` `-`

| 运算符 | 描述 |                  实例                  |
| :----: | :--: | :------------------------------------: |
|   /    |  除  |  1 / 9 输出结果为 0.1111111111111111   |
|   //   | 取整 |           9 // 4 输出结果为2           |
|   %    | 取余 |           9 % 4 输出结果为 1           |
|   **   | 指数 | 2 ** 4 输出结果为 16，即 2 * 2 * 2 * 2 |

### 赋值运算符

To do any parallel assignment, python

1. first computes all the values of the expressions/objects on the right
2. second binds each name on the left to these computed values/objects 

```python
l, (*m, n), *o = (1, ['a', 'b', 'c'], 2, 3, 4)
print(l, m, n, o) # 1 ['a', 'b'] c [2, 3, 4]
a, *b, c = [1, 2, 3, 4, 5]
print(a, b, c) # 1 [2, 3, 4] 5
a = b = 10 #多个变量赋相同值
```

### 复合赋值运算符

优先级

1. 先算复合赋值运算符右侧的表达式
2. 再算复合赋值运算的算数运算
3. 最后算赋值运算

| 运算符 |      描述      |            实例            |
| :----: | :------------: | :------------------------: |
|   /=   | 除法赋值运算符 |  c /= a 等价于 c = c / a   |
|  //=   | 整除赋值运算符 | c //= a 等价于 c = c // a  |
|   %=   | 取余赋值运算符 |  c %= a 等价于 c = c % a   |
|  **=   |  幂赋值运算符  | c ** = a 等价于 c = c ** a |

### 逻辑运算符

| 运算符 | 逻辑表达式 |                             描述                             |                   实例                   |
| :----: | :--------: | :----------------------------------------------------------: | :--------------------------------------: |
|  and   |  x and y   | 布尔"与"：如果 x 为 False，x and y 返回 False，否则它返回 y 的值。 |      True and False， 返回 False。       |
|   or   |   x or y   |  布尔"或"：如果 x 是 True，它返回 True，否则它返回 y 的值。  |       False or True， 返回 True。        |
|  not   |   not x    | 布尔"非"：如果 x 为 True，返回 False 。如果 x 为 False，它返回 True。 | not True 返回 False, not False 返回 True |

### 数字之间的逻辑运算

```python
a = 0
b = 1
c = 2
# and运算符，只要有一个值为0，则结果为0，否则结果为最后一个非0数字
print(a and b)  # 0
print(b and a)  # 0
print(a and c)  # 0
print(c and a)  # 0
print(b and c)  # 2
print(c and b)  # 1
# or运算符，只有所有值为0结果才为0，否则结果为第一个非0数字
print(a or b)  # 1
print(a or c)  # 2
print(b or c)  # 1
# 这样记：and要看到最后一个是否为0，所以返回最后一个非0数字，or只要看第一个是否为0，所以第一个非0时，返回第一个非0数字
```

## 循环

- ```break```退出整个循环
- ```continue```退出本次循环，继续执行下一次循环的代码

### ```else: block-else```

指的是循环正常结束之后要执行的代码。如果是break终止循环的情况，else下方缩进的代码将不执行。而continue是退出当前一次循环，继续下一次循环，所以该循环在continue控制下是可以正常结束的，当循环结束后，则执行了else缩进的代码。

```python
# else:block-else in while loop
while 条件:
    条件成立重复执行的代码
else:
    循环正常结束之后要执行的代码
# else:block-else in for loop
for 临时变量 in 序列:
    重复执行的代码
else:
    循环正常结束之后要执行的代码
# 举例
for i in range(100):
    if special_property(i):
        print(f'{i} is the first value with the special property')
        break
else:
    print('No value in the range had the special property')
# 等价于
found_one = False
for i in range(100):
    if special_property(i):
        print(f'{i} is the first value with the special property')
        found_one = True
        break
if not found_one:
    print('No value in the range had the special property')
```

## 数据类型

```type()```查看数据类型

### 引用

在python中，值是靠引用来传递来的。

我们可以用`id()`来判断两个变量是否为同一个值的引用。 我们可以将id值理解为那块内存的地址标识。

```id(a) == id(b)```相当于```a is b```

```python
# 1. int类型
a = 10 ** 100
b = 10 ** 100
print(a is b) # False
print(id(a) == id(b)) # False

# 2. 列表
aa = [10, 20]
bb = aa
print(id(aa))  # 2325297783432
print(id(bb))  # 2325297783432
aa.append(30)
print(bb)  # [10, 20, 30], 列表为可变类型
print(id(aa))  # 2325297783432
print(id(bb))  # 2325297783432
```

### copy和deepcopy

- 浅拷贝使用`copy.copy`函数
- 深拷贝使用`copy.deepcopy`函数
- 不管是给对象进行深拷贝还是浅拷贝，只要拷贝成功就会开辟新的内存空间存储拷贝的对象。
- 浅拷贝和深拷贝的区别是:
  - 浅拷贝最多拷贝对象的一层，深拷贝可能拷贝对象的多层。

#### 浅拷贝

- `copy`函数是浅拷贝，只对可变类型的第一层对象进行拷贝，对拷贝的对象开辟新的内存空间进行存储，不会拷贝对象内部的子对象。
- 不可变类型进行浅拷贝不会给拷贝的对象开辟新的内存空间，而只是拷贝了这个对象的引用。

- Note that ```copy``` is shallow. That means the "copy" is a new object, but that object stores all the references from the "object being copied". 

- In a deep copy, all the mutable objects referred to are copied, but the immutable ones referred to are not copied.

```python
import copy  # 使用浅拷贝需要导入copy模块
# 对于不可变类型进行浅拷贝实际上是对引用的一个拷贝，两个变量指定的是一个内存地址
a1 = (1, 2)
c1 = (1, 2)
b1 = copy.copy(a1)  # 使用copy模块里的copy()函数就是浅拷贝了
print(a1 is b1) # True
print(a1 is c1) # True

l1 = [1, 2, 3, [14, 16, 19]]
l2 = [1, 2, 3, [14, 16, 19]]
l3 = copy.copy(l1)
print(id(l1) == id(l2)) # False
print(l1 is l2) # False
# 支队最外层拷贝，里面的一层不拷贝
print(l1[3] is l3[3]) # True
l1[3].append(20)
print(l1, l3) # [1, 2, 3, [14, 16, 19, 20]] [1, 2, 3, [14, 16, 19, 20]]
```

#### 深拷贝

- `deepcopy`函数是深拷贝, 只要发现对象有可变类型就会对该对象到最后一个可变类型的每一层对象就行拷贝, 对每一层拷贝的对象都会开辟新的内存空间进行存储。
- 不可变类型进行深拷贝如果子对象没有可变类型则不会进行拷贝，而只是拷贝了这个对象的引用，否则会对该对象到最后一个可变类型的每一层对象就行拷贝, 对每一层拷贝的对象都会开辟新的内存空间进行存储

```python
from copy import deepcopy
a1 = 12
b1 = 12
c1 = deepcopy(a1)
print(a1 is b1) # True
print(a1 is c1) # True

t1 = (1, [1, 2])
t2 = deepcopy(t1)
print(t1 is t2) # False
print(t1[0] is t2[0]) # True

l1 = [1, 2, 3, [4, 5]]
l2 = deepcopy(l1)
print(l1 is l2) # False
print(l1[3] is l2[3]) # False
```


### 可变(mutable)和不可变(hashable)类型

- small integer objects are unique in Python
  - if we write ```x=10**100``` and ```y=10**100``` then ```x is y``` is ```False```. 
  - To save space, Python allocates only one object for each small int. When a small int is computed, Python first looks to see if an object with that value already exists, and if it does, returns a reference to it; if it doesn't, it makes a new object storing that values and returns a  reference to it.
- lists always allocate new objects
  - if we write ```x=['a']``` and ```y=['a']```, then ```x is y``` evaluates to ```False```
- tuples have no mutator methods, but if a tuple contains mutable data, you can mutate the mutable data part.
- 因为列表是可变类型，可以在原有内存的基础上修改数据，并且修改后内存地址不变，所以不需要加上`global`关键字，加上`global`表示要修改全局变量的内存地址

### 切片

切片是指对操作的对象截取其中一部分的操作。**字符串、列表、元组**都支持切片操作。

语法：```序列[开始位置下标:结束位置下标:步长]```

注意

1. 不包含结束位置下标对应的数据， 正负整数均可；
2. 步长是选取间隔，正负整数均可，默认步长为1。

```python
name = "abcdefg"
print(name[2:5:1])  # cde
print(name[2:5])  # cde
print(name[:5])  # abcde
print(name[1:])  # bcdefg
print(name[:])  # abcdefg
print(name[::2])  # aceg
print(name[:-1])  # abcdef, 负1表示倒数第一个数据
print(name[-4:-1])  # def
print(name[::-1])  # gfedcba
lst = ['a', 'b', 'c', 'd', 'e'] 
print(lst[::2]) # ['a', 'c', 'e']
print(lst[1::2]) # ['b', 'd']
print(lst[3:1:-1]) # ['d', 'c']
print(lst[-1:1:-1]) # ['e', 'd', 'c']
```

### 公共操作

#### 运算符

| 运算符 |      描述      |      支持的容器类型      |
| :----: | :------------: | :----------------------: |
|   +    |      合并      |    字符串、列表、元组    |
|   *    |      复制      |    字符串、列表、元组    |
|   in   |  元素是否存在  | 字符串、列表、元组、字典 |
| not in | 元素是否不存在 | 字符串、列表、元组、字典 |

```python
# +
# 1. 字符串 
str1 = 'aa'
str2 = 'bb'
print(str1 + str2)  # aabb
# 2. 列表 
int_str_list = [1, 2, 'a', 'b']
int_list = [3, 4]
print(int_str_list + int_list) # [1, 2, 'a', 'b', 3, 4]
# 3. 元组 
t1 = (1, 2)
t2 = (10, 20)
print(t1 + t2)  # (1, 2, 10, 20)

# *
# 1. 字符串
print('-' * 10)  # ----------
# 2. 列表
list1 = ['hello']
print(list1 * 4)  # ['hello', 'hello', 'hello', 'hello']
# 3. 元组
t1 = ('world',)
print(t1 * 4)  # ('world', 'world', 'world', 'world')

# in/not in
# 1. 字符串
print('a' in 'abcd')  # True
print('a' not in 'abcd')  # False
# 2. 列表
list1 = ['a', 'b', 'c', 'd']
print('a' in list1)  # True
print('a' not in list1)  # False
# 3. 元组
t1 = ('a', 'b', 'c', 'd')
print('aa' in t1)  # False
print('aa' not in t1)  # True
```

#### 公共方法

|          函数           |                             描述                             |
| :---------------------: | :----------------------------------------------------------: |
|          len()          |                      计算容器中元素个数                      |
|      del 或 del()       |                             删除                             |
|          max()          |                     返回容器中元素最大值                     |
|          min()          |                     返回容器中元素最小值                     |
| range(start, end, step) |      生成从start到end的数字，步长为 step，供for循环使用      |
|       enumerate()       | 函数用于将一个可遍历的数据对象(如列表、元组或字符串)组合为一个索引序列，同时列出数据和数据下标，一般用在 for 循环当中。 |

```python
# len()
# 4. 集合
s1 = {10, 20, 30}
print(len(s1))  # 3
# 5. 字典
dict1 = {'name': 'Rose', 'age': 18}
print(len(dict1))  # 2

# del
str1 = 'abcdefg'
del str1
print(str1) 

# min()/max()
str1 = 'abcdefg'
print(min(str1))  # a
print(min("abc", "abcd", key=lambda x: -len(x))) # 'abcd'

# range()
for i in range(20, 1, -2):
    print(i, end = " ") # 20 18 16 14 12 10 8 6 4 2 

# enumerate
for line_number, line in enumerate(open("file_name"), 1):
    process_file()
```

### string

- 控制台显示结果为`<class 'str'>`， 即数据类型为```str```(字符串)。
- 注意：数据按照是否能直接修改分为可变类型和不可变类型两种。字符串类型的数据修改的时候不能改变原有字符串，属于不能直接修改数据的类型即是不可变类型。
- In fact, we can not sort strings(they are immutable); we can not sort tuples(their order is immutable); we can not sort sets(they have no order, which actually allow them to operate more efficiently); we can not sort dicts(like sets, they have no order, which actually allow them to operate more efficiently)
- string的比较：先比较ASCII，若相同，则比较len。如```len(ant)```<```len(anteater)```，则```ant```<```anteater```

```python
# 三引号形式的字符串支持换行。
a = ''' i am Tom, 
        nice to meet you! '''

b = """ i am Rose, 
        nice to meet you! """

mystr = "hello world and itcast and itheima and Python"
# 判断
# startswith()：检查字符串是否是以指定子串开头，是则返回 True，否则返回 False。如果设置开始和结束位置下标，则在指定范围内检查。
# 字符串序列.startswith(子串, 开始位置下标, 结束位置下标)
print(mystr.startswith('hello', 5, 20)) # False
# endswith()：：检查字符串是否是以指定子串结尾，是则返回 True，否则返回 False。如果设置开始和结束位置下标，则在指定范围内检查。
# 字符串序列.endswith(子串, 开始位置下标, 结束位置下标)
print(mystr.endswith('Python', 2, 20)) # False
# isalpha()：如果字符串至少有一个字符并且所有字符都是字母则返回 True, 否则返回 False。
mystr2 = 'hello12345'
print(mystr2.isalpha()) # False
# isdigit()：如果字符串只包含数字则返回 True 否则返回 False。
print(mystr2.isdigit()) # False
# isalnum()：如果字符串至少有一个字符并且所有字符都是字母或数字则返回 True,否则返回 False。
print(''.isalnum()) # False
# isspace()：如果字符串中只包含空白，则返回 True，否则返回 False。
print(''.isspace()) # False

print('-------------------------------------------------------------------------------------------------------------------------')
# 查找
# find()：检测某个子串是否包含在这个字符串中，如果在返回这个子串开始的位置下标，否则则返回-1。
# 字符串序列.find(子串, 开始位置下标, 结束位置下标)
# 注意：开始和结束位置下标可以省略，表示在整个字符串序列中查找。
# 注意：list没有find函数，可以多用index
# rfind()： 和find()功能相同，但查找方向为右侧开始。
print(mystr.find('and', 15, 30))  # 23
# index()：检测某个子串是否包含在这个字符串中，如果在返回这个子串开始的位置下标，否则则报异常。
# 字符串序列.index(子串, 开始位置下标, 结束位置下标)
# 注意：开始和结束位置下标可以省略，表示在整个字符串序列中查找。
# rindex()：和index()功能相同，但查找方向为右侧开始。
print(mystr.index('and', 15, 30))  # 23
# count()：返回某个子串在字符串中出现的次数
# 字符串序列.count(子串, 开始位置下标, 结束位置下标)
# 开始和结束位置下标可以省略，表示在整个字符串序列中查找。
print(mystr.count('and', 0, 20))  # 1

print('-------------------------------------------------------------------------------------------------------------------------')
# 修改
# replace()：替换
# 字符串序列.replace(旧子串, 新子串, 替换次数)
# 注意：替换次数如果超出子串出现次数，则替换次数为该子串出现次数。
print(mystr.replace('and', 'he')) # hello world he itcast he itheima he Python
print(mystr.replace('and', 'he', 1)) # hello world he itcast and itheima and Python
print(mystr) # hello world and itcast and itheima and Python
# split()：按照指定字符分割字符串。
# 字符串序列.split(分割字符, num)
# num表示的是分割字符出现的次数，即将来返回数据个数为num+1个。
# 注意：如果分割字符是原有字符串中的子串，分割后则丢失该子串。比如这里的and
print(mystr.split('and', 2)) # ['hello world ', ' itcast ', ' itheima and Python']
# join()：用一个字符或子串合并字符串，即是将多个字符串合并为一个新的字符串。
# 字符或子串.join(多字符串组成的序列)
list1 = ['chuan', 'zhi', 'bo', 'ke']
t1 = ('aa', 'b', 'cc', 'ddd') 
print('_'.join(list1)) # chuan_zhi_bo_ke
print('...'.join(t1)) # aa...b...cc...ddd
# 字符串序列.ljust(长度, 填充字符)
# ljust()：返回一个原字符串左对齐,并使用指定字符(默认空格)填充至对应长度的新字符串。
# rjust()：返回一个原字符串右对齐,并使用指定字符(默认空格)填充至对应长度的新字符串，语法和ljust()相同。
# center()：返回一个原字符串居中对齐,并使用指定字符(默认空格)填充至对应长度的新字符串，语法和ljust()相同。
'hello'.ljust(10) # 'hello     '
'hello'.center(10, '.') # '..hello...'
# 删除字符串/字符串左侧/字符串右侧字符
'AaA'.strip('A') # a
'AaA'.lstrip('A') # aA
'AaA'.rstrip('A') # Aa
mystr.lower() # 将字符串中大写转小写。
mystr.upper() # 将字符串中小写转大写。
mystr.capitalize() # 将字符串第一个字符转换成大写。注意：capitalize()函数转换后，只字符串第一个字符大写，其他的字符全都小写。
mystr.title() # 将字符串每个单词首字母转换成大写。
```

### list

- 列表追加数据的时候，直接在原列表里面追加了指定数据，即修改了原列表，故列表为可变类型数据。数据可以是不同的数据类型。

```python
# comprehension列表推导式
lst = [i**2 for i in range(10) if i%2==0]
lst = [(i, j) for i in range(1, 3) for j in range(3)]
print(list1) # [(1, 0), (1, 1), (1, 2), (2, 0), (2, 1), (2, 2)]

name_list = ['Tom', 'Lily', 'Rose']
print('-------------------------------------------------------------------------------------------------------------------------')
# 查找
# index()：返回指定数据所在位置的下标 。
# 列表序列.index(数据, 开始位置下标, 结束位置下标)
# 注意：如果查找的数据不存在则报错。
print(name_list.index('Lily', 0, 2))  # 1
# count()：统计指定数据在当前列表中出现的次数。
print(name_list.count('Lily'))  # 1

print('-------------------------------------------------------------------------------------------------------------------------')
# 增加
# append()：列表结尾追加数据。如果append()追加的数据是一个序列，则追加整个序列到列表
# extend()：列表结尾追加数据，如果数据是一个序列，则将这个序列的数据逐一添加到列表。
name_list.append(['xiaoming', 'xiaohong'])
print(name_list) # ['Tom', 'Lily', 'Rose', ['xiaoming', 'xiaohong']]
name_list.extend('xiaoming')
print(name_list) # ['Tom', 'Lily', 'Rose', 'x', 'i', 'a', 'o', 'm', 'i', 'n', 'g']
# insert()：指定位置新增数据。
# 列表序列.insert(位置下标, 数据)
name_list.insert(1, 'xiaoming')
print(name_list) # ['Tom', 'xiaoming', 'Lily', 'Rose']

print('-------------------------------------------------------------------------------------------------------------------------')
# 删除
del name_list[0]
print(name_list) # ['Lily', 'Rose']
# pop()：删除指定下标的数据(默认为最后一个)，并返回该数据。
# 列表序列.pop(下标)
print(name_list.pop(1)) 结果：Lily
# remove()：移除列表中某个数据的第一个匹配项。
# 列表序列.remove(数据)
name_list.remove('Rose')
print(name_list) ['Tom', 'Lily']
# clear()：清空列表
name_list.clear()
print(name_list) # []

print('-------------------------------------------------------------------------------------------------------------------------')
# 修改
# 逆置：reverse()
num_list.reverse()
'''
sort 与 sorted 区别：
sort 是应用在 list 上的方法，sorted 可以对所有可迭代的对象进行排序操作。
列表序列.sort( key=None, reverse=False)
list 的 sort 方法返回的是对已经存在的列表进行操作，无返回值，而内建函数 sorted 方法返回的是一个新的 list，而不是在原来的基础上进行的操作。
sorted 语法：
sorted(iterable, cmp=None, key=None, reverse=False)
参数说明：
iterable -- 可迭代对象。
cmp -- 比较的函数，这个具有两个参数，参数的值都是从可迭代对象中取出，此函数必须遵守的规则为，大于则返回1，小于则返回-1，等于则返回0。
key -- 主要是用来进行比较的元素，只有一个参数，具体的函数的参数就是取自于可迭代对象中，指定可迭代对象中的一个元素来进行排序。
reverse -- 排序规则，reverse = True 降序 ， reverse = False 升序（默认）。
when we sort with key = lambda x: x[1], we are telling sorted function to determine the order of values by calling the key function on each value
'''
L = [('b', 2), ('a', 1), ('c', 3), ('d', 4)]
L.sort(key=lambda x: x[1], reverse=True)
print(L)  # [('d', 4), ('c', 3), ('b', 2), ('a', 1)]
L=[('b',2),('a',1),('c',3),('d',4)]
b = sorted(L, key=lambda x:x[1]) 
print(b) # [('a', 1), ('b', 2), ('c', 3), ('d', 4)]

print('-------------------------------------------------------------------------------------------------------------------------')
# 复制
name_li2 = name_list.copy() # works like copy.copy()
```

### tuple

- 一个元组可以存储多个数据，元组内的数据是不能修改的，只支持查找。数据可以是不同的数据类型。

- 注意：
  1. 元组内的直接数据如果修改则立即报错。但是如果元组里面有列表，修改列表里面的数据则是支持的
  2. 如果定义的元组只有一个数据，那么这个数据后面也要添加逗号，否则数据类型为唯一的这个数据的数据类型。如：```t2 = (10,)```

```python
# comprehension
print(type((tuple)(i for i in range(10)))) # <class 'tuple'>
print(type((i for i in range(10)))) # <class 'generator'>
print(type(tuple(i for i in range(10)))) # <class 'tuple'>

tuple1 = ('aa', 'bb', 'cc', 'bb')
print(tuple1[0])  # aa
print(tuple1.index('aa'))  # 0
print(tuple1.count('bb'))  # 2
```

### dict和defaultdict

- There is a type called ```defaultdict``` whose constructor generally takes an argument that is a reference to any object that CAN BE CALLED WITH NO ARGUMENTS. Very frequently we use a NAME OF A CLASS that when called will CONSTRUCT A NEW VALUE: if the argument is ```int```, it will call ```int()``` producing the value ```0```; if the argument is ```list```, it will call ```list()``` producing an empty list; if the argument is ```set```, it will call ```set()``` producing an empty set; etc.

```python
# comprehension字典推导式
dict1 = {k : len(k) for k in ['one', 'two', 'three', 'four', 'five']}
list1 = ['name', 'age', 'gender']
list2 = ['Tom', 20, 'man']
dict1 = {list1[i]: list2[i] for i in range(len(list1))}
print(dict1)
print(dict(zip(list1, list2))) # {'name': 'Tom', 'age': 20, 'gender': 'man'}

dict1 = {'name': 'Tom', 'age': 20, 'gender': '男'}
# 遍历键值对
for key, value in dict1.items():
    print(f'{key} = {value}')

print('-------------------------------------------------------------------------------------------------------------------------')
# 空字典
dict2 = {}
dict2 = dict()

print('-------------------------------------------------------------------------------------------------------------------------')
# 复制
dict3 = dict(dict1)
dict3 = dict(dict1.items())

print('-------------------------------------------------------------------------------------------------------------------------')
# 增加
# 注意：如果key存在则修改这个key对应的值 ；如果key不存在则新增此键值对。
dict1['id'] = 110
print(dict1) # {'name': 'Tom', 'age': 20, 'gender': '男', 'id': 110}
dict1 = {'name': 'Tom', 'age': 20, 'gender': '男'}
value = dict1.setdefault('id', 20) # 若键对应的值存在，则返回该值，若不存在则新增该键值对并返回新增的值
print(value) # 20
print(dict1) # {'name': 'Tom', 'age': 20, 'gender': '男', 'id': 20}

print('-------------------------------------------------------------------------------------------------------------------------')
# 删除
del dict1['gender']
print(dict1) # {'name': 'Tom', 'age': 20}
dict1.clear()
print(dict1)  # {}

print('-------------------------------------------------------------------------------------------------------------------------')
# 查找
# 如果当前查找的key存在，则返回对应的值；否则则报错。
print(dict1['name'])  # Tom
print(dict1['id'])  # 报错
# 字典序列.get(key, 默认值)
# 注意：如果当前查找的key不存在则返回第二个参数(默认值)，如果省略第二个参数，则返回None。不会新增
print(dict1.get('id'))  # None
print(dict1.get('id', 110))  # 110
print(dict1.keys())  # dict_keys(['name', 'age', 'gender'])
print(dict1.values())  # dict_values(['Tom', 20, '男'])
print(dict1.items())  # dict_items([('name', 'Tom'), ('age', 20), ('gender', '男')])

# defaultdict
from collections import defaultdict
dd = defaultdict(list)
for i in range(10):
    s = 'even' if i%2==0 else 'odd'
    dd[s].append(i)
print(dict(dd)) # {'even': [0, 2, 4, 6, 8], 'odd': [1, 3, 5, 7, 9]}
```

### set和frozenset

- 集合可以去掉重复数据；
- 集合数据是无序的，故不支持下标
- 创建集合使用`{}`或`set()`， 但是如果要创建空集合只能使用`set()`，因为`{}`用来创建空字典。
- a frozenset can do everything that a set can do, but doesn't allow any mutator methods to be called(so we can not add a value to or delete a value from a frozenset). Thus, we can use a frozenset as a value in a set or a key in a dictionary

```python
# comprehension集合推导式
list1 = [1, 1, 2]
set1 = {i ** 2 for i in list1}
print(set1)  # {1, 4}

s1 = {10, 20}
s2 = set('abcdefg')
print('-------------------------------------------------------------------------------------------------------------------------')
# 增加
# 因为集合有去重功能，所以，当向集合内追加的数据是当前集合已有数据的话，则不进行任何操作
s1.add(100)
print(s1)  # {100, 10, 20}
# update(), 追加的数据是序列
# s1.update(100)  # 报错
s1.update([100, 200])
s1.update('abc')
print(s1) # {'a', 100, 200, 10, 'b', 'c', 20}

print('-------------------------------------------------------------------------------------------------------------------------')
# 删除
# remove()，删除集合中的指定数据，如果数据不存在则报错。
s1.remove(100)  # 报错
# discard()，删除集合中的指定数据，如果数据不存在也不会报错。
s1.discard(100)
print(s1) # {10, 20}
# pop()，随机删除集合中的某个数据，并返回这个数据
print(s1.pop())

# frozenset
set1 = frozenset()
```

![set](..\图片笔记\Python\set.png)

## 生成器

数据不是一次性全部生成处理，而是使用一个，再生成一个，可以节约大量的内存

- 代码执行到`yield`会暂停，然后把结果返回出去，下次启动生成器会在暂停的位置继续往下执行
- 生成器如果把数据生成完成，再次获取生成器中的下一个数据会抛出一个`StopIteration`异常，表示停止迭代异常
- `while`循环内部没有处理异常操作，需要手动添加处理异常操作
- `for`循环内部自动处理了停止迭代异常，使用起来更加方便，推荐大家使用

```python
# 生成器推导式创建生成器
my_generator = (i * 2 for i in range(5))
print(my_generator) # <generator object <genexpr> at 0x000001A07BE94248>

# 遍历生成器
# for value in my_generator:
#     print(value, end = " ") # 0 2 4 6 8

while True:
    try:
        value = next(my_generator)
        print(value, end = " ")
    except StopIteration:
        break
        
# 使用yield关键字创建生成器
def my_generater(n):
    for i in range(n):
        print("开始执行生成器")
        yield i
        print("暂停开始生成下一个数据")


if __name__ == '__main__':
    # 可以看到代码执行到yield会暂停，然后把结果返回出去，下次启动生成器会在暂停的位置继续往下执行
    g = my_generater(5)
    print(next(g))
    print()
    print(next(g))
    print()
    for i in g:
        print(i)
```



## 函数

**函数的参数：**函数调用的时候可以传入真实数据，增大函数的使用的灵活性

- 形参：函数定义时书写的参数(非真实数据)
- 实参：函数调用时书写的参数(真实数据)

**函数的返回值**

1. `return a, b`写法，返回多个数据的时候，默认是元组类型。
2. ```return```后面可以连接列表、元组或字典，以返回多个值。

### 拆包和交换变量值

```python
# 拆包：元组
def return_num():
    return 100, 200
num1, num2 = return_num()

# 拆包：字典
dict1 = {'name': 'TOM', 'age': 18}
a, b = dict1
# 对字典进行拆包，取出来的是字典的key
print(a)  # name
print(b)  # age

# 交换变量值
a, b = 1, 2
a, b = b, a
print(a)  # 2
print(b)  # 1
```

### 局部变量和全局变量

变量作用域指的是变量生效的范围，主要分为两类：局部变量和全局变量。

- 局部变量
  - 所谓局部变量是定义在函数体内部的变量，即只在函数体内部生效。
  - 局部变量的作用：在函数体内部，临时保存数据，即当函数调用完成后，则销毁局部变量。
- 全局变量
  - 所谓全局变量，指的是在函数体内、外都能生效的变量。

```python
# 1. 定义全局变量
glo_num = 0

def test1():
    global glo_num
    glo_num = 100

def test2():
    print(glo_num)
    
test1()
test2()  # 100
```

### 参数传递

#### 位置参数

- 调用函数时根据函数定义的参数位置来传递参数。
- 注意：传递和定义参数的顺序及个数必须一致。

#### 关键字参数

- 函数调用，通过```键=值```形式加以指定。可以让函数更加清晰、容易使用，同时也清除了参数的顺序需求。
- 注意：函数调用时，如果有位置参数时，==**位置参数必须在关键字参数的前面**==，但关键字参数之间不存在先后顺序。

#### 缺省参数

- 缺省参数也叫默认参数，用于定义函数，为参数提供默认值，调用函数时可不传该默认参数的值（注意：**所有位置参数必须出现在默认参数前，包括函数定义和调用**）。
- 注意：函数调用时，如果为缺省参数传值则修改默认参数值；否则使用这个默认值。

#### 不定长参数

- 不定长参数也叫可变参数。用于不确定调用的时候会传递多少个参数(不传参也可以)的场景。此时，可用包裹(packing)位置参数，或者包裹关键字参数，来进行参数传递，会显得非常方便。
- 注意点：参数```(arg, *args, **kwargs)```三个参数的位置必须是一定的。必须是```(arg,*args,**kwargs)```这个顺序，否则程序会报错。
- writing ```*``` and ```**``` when specifying parameters makes those parameters names bind to a tuple/dict respectively
- using the parameter names by themselves in the function is equivalent to using the tuple/dict respectively
- using ```*``` and ```**``` followed by the parameter name as arguments in function calls expands all the values in the tuple/dict respectively to represent all the arguments
  - 可以将加`*`和`**`理解为，将元组/字典解压为单独的元素

```python
# 这里对元组和字典进行拆包，仅限于结合不定长参数的函数使用

# 包裹位置传递
# *args：把元组里面的每一个元素，按照位置参数的方式进行传参
# 注意：传进的所有参数都会被args变量收集，它会根据传进参数的位置合并为一个元组(tuple)，args是元组类型，这就是包裹位置传递。
def f(x, y, *args):
    print(x, y, args)
f(1, 2, 3, 4, 5) # 1 2 (3, 4, 5)

# 包裹关键字传递 keyword arguments
# **kargs/**kwargs：把字典里面的每一个键值对，按照关键字的方式进行传参
# if we use it to specify this kind of parameter, it must occur as the last parameter
def f(a, b,**kwargs):
    print(a, b, kwargs)

def g(*args, **kwargs):
    print(args, kwargs)

f(1, 2, d = 3, c = 4) # 1 2 {'d': 3, 'c': 4}
f(c = 3, a = 1, b = 2, d = 4) # 1 2 {'d': 4, 'c': 3}
g(1, 2, c = 3, d = 4) # (1, 2) {'d': 4, 'c': 3}
g(a = 1, b = 2, c = 3, d = 4) # () {'d': 4, 'c': 3, 'a' : 1, 'b' : 2}
```

### 函数的说明文档

```python
# 实例
def sum_num(a, b):
    """ 求和函数 
    :param a:
    :param b:
    :return sum:
    """
    return a + b
help(sum_num)
```

### 递归函数

- 函数内部自己调用自己
- 必须有出口

### lambda表达式

如果一个函数有一个返回值，并且只有一句代码，可以使用 lambda简化。

语法：```lambda arg1, arg2, arg3, ... : expression```

注意：

- lambda表达式的参数可有可无，函数的参数在lambda表达式中完全适用。
- lambda表达式能接收任何数量的参数但只能返回一个表达式的值。

```python
# 默认参数
fn1 = lambda a, b, c=100: a + b + c
print(fn1(10, 20)) # 130
# 可变参数 *args
# remember parenthesis
print((lambda *args: args)(10, 20, 30)) # (10, 20, 30)
# 可变参数：**kwargs
print((lambda **kwargs: kwargs)(name='python', age=20)) # {'name': 'python', 'age': 20}
print((lambda a, b: a if a > b else b)(1000, 500)) # 1000
```

## 高阶函数

把函数作为参数传入，这样的函数称为高阶函数，高阶函数是函数式编程的体现。函数式编程就是指这种高度抽象的编程范式。

函数式编程大量使用函数，减少了代码的重复，因此程序比较短，开发速度较快。

```python
def sum_num(a, b, f):
    return f(a) + f(b)
result = sum_num(-1, 2, abs)
print(result)  # 3
```

### 内置高阶函数

#### map()

- ```map()```会根据提供的函数对指定序列做映射。
- 语法：```map(function, iterable, ...)```
- 第一个参数```function```以参数序列中的每一个元素调用```function```函数，返回包含每次```function```函数返回值的新列表(Python2)/迭代器(Python3)。


``` python
f = lambda x: x**2
m = map(f, [i for i in range(10)])
print(m) # <map object at 0x000002446123F688>
print(list(m)) # [0, 1, 4, 9, 16, 25, 36, 49, 64, 81]

# 提供了两个列表，对相同位置的列表数据进行相加
f = lambda x,y: x+y
l = list(map(f, [1,2,3], [4,5,6]))
print(l) # [5, 7, 9]
```

#### reduce()

- ```reduce()```函数会对参数序列中元素进行累积。
- 函数将一个数据集合（链表，元组等）中的所有数据进行下列操作：用传给```reduce```中的函数```function（有两个参数）```先对集合中的第 1、2 个元素进行操作，得到的结果再与第三个数据用```function```函数运算，最后得到一个结果。
- 语法：```reduce(function, iterable[, initializer])```
- 参数
  - ```function``` -- 函数，有两个参数
  - ```iterable``` -- 可迭代对象
  - ```initializer``` -- 可选，初始参数
- 返回值
  - 返回函数计算结果。

``` python
from functools import reduce
print(reduce((lambda x,y:x+y), [1,2,3,4,5]))  # 15
```

#### filter()

- ```filter()```函数用于过滤序列，过滤掉不符合条件的元素，返回由符合条件元素组成的新列表。
- 该接收两个参数，第一个为函数，第二个为序列，序列的每个元素作为参数传递给函数进行判断，然后返回```True```或```False```，最后将返回```True```的元素放到新列表中。
- 语法：```filter(function, iterable)```
- 返回一个```filter```对象。

``` python
import math
f2 = lambda x:math.sqrt(x)%1 == 0
l = filter(f2, range(1,101))
print(l) # <filter object at 0x0000024E83575188>
print(list(l)) # [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]
```

#### zip()

- ```zip()```函数用于将可迭代的对象作为参数，将对象中对应的元素打包成一个个元组，然后返回由这些元组组成的列表。
- 如果各个迭代器的元素个数不一致，则返回列表长度与最短的对象相同，利用```*```号操作符，可以将元组解压为列表。
- 返回一个```zip```对象。

```python
# 虽然在参数传递也通过*args，这里的*更像是zip()独有的用法

raw_data = ('abcde', (1, 2, 3), ['1st', '2nd', '3rd', '4th'])
z = zip(*raw_data) 
# this is same as z = zip('abcde',(1, 2, 3),['1st', '2nd', '3rd', '4th'])
print(z) # <zip object at 0x000001EC2B1328C8>
# 元素个数与最短的列表一致
l = list(z)
print(l) # [('a', 1, '1st'), ('b', 2, '2nd'), ('c', 3, '3rd')]
# 我们可以将其转换成原来的数组
print(list(zip(*l))) # [('a', 'b', 'c'), (1, 2, 3), ('1st', '2nd', '3rd')]

# 可以换成dict
z2 = zip([1, 2, 3], ('a', 'b', 'c'))
# 只能使用两个zip()参数，前者产生key，后者产生value。
print(dict(z2)) # {1: 'a', 2: 'b', 3: 'c'}
```

## 闭包

在函数嵌套的前提下，内部函数使用了外部函数的变量，并且外部函数返回了内部函数，我们把这个使用外部函数变量的内部函数称为闭包。

通过闭包的定义，我们可以得知闭包的形成条件:

1. 在函数嵌套(函数里面再定义函数)的前提下
2. 内部函数使用了外部函数的变量(还包括外部函数的参数)
3. 外部函数返回了内部函数

闭包可以保存外部函数内的变量，不会随着外部函数调用完而销毁。由于闭包引用了外部函数的变量，则外部函数的变量没有及时释放，消耗内寸

修改闭包内使用的外部函数变量使用`nonlocal`关键字来完成。

备注：这段不太适合通用装饰器，适用于想要在return内部函数之前在外部函数做一些操作的场景。

```python
def func_out(num1):
    def func_inner(num2):
        # 这里本意想要修改外部num1的值，实际上是在内部函数定义了一个局部变量num1
        # num1 = 10
        nonlocal num1  # 告诉解释器，此处使用的是外部变量num1
        # 修改外部变量num1
        num1 = 10
        # 内部函数使用了外部函数的变量(num1)
        result = num1 + num2
        print("内部函数求和:", result)
    print("外部函数1：", num1)
    func_inner(1)
    print("外部函数2：", num1)
    print()
    # 外部函数返回了内部函数，这里返回的内部函数就是闭包
    return func_inner
f = func_out(1)
f(2) # 仍然保留了外部函数的变量值
"""
外部函数1： 1
内部函数求和: 11
外部函数2： 10

内部函数求和: 12
"""
```

## 装饰器

装饰器就是给已有函数增加额外功能的函数，它本质上就是一个闭包函数。

**装饰器的功能特点:**

1. 不修改已有函数的源代码
2. 不修改已有函数的调用方式
3. 给已有函数增加额外的功能

### 通用装饰器

```python
# 通用装饰器：添加输出日志的功能
# 装饰器的执行时机：当前模块加载完成后，装饰器会立即执行，对已有函数进行装饰
# 如果闭包函数有且只有一个并且是函数类型，那么这个闭包函数称为装饰器
def logging(fn): 
    def inner(*args, **kwargs): # 应该是固定写法
        # 在内部函数里面对已有函数进行装饰
        # 使用装饰器装饰已有函数的时候，内部函数的类型和要装饰的已有函数的类型保持一致
        print("--正在努力计算--")
        result = fn(*args, **kwargs) # 执行被装饰的函数
        return result
    return inner

# 装饰器的语法糖写法：@装饰器名称，装饰器的语法糖就是在装饰函数的时候写法更加简单
@logging # sum_num = logging(sum_num) 装饰器语法糖对改代码进行了封装
def sum_num(*args, **kwargs):
    result = 0
    for value in args:
        result += value
        
    for value in kwargs.values():
        result += value
    return result

@logging
def subtraction(a, b):
    result = a - b
    print(result)

result = sum_num(1, 2, a=10)
print(result)
subtraction(4, 2)
```

### 多个装饰器的使用

![](..\图片笔记\Python\多个装饰器原理.png)

```python
# 多个装饰器的装饰过程是: 离函数最近的装饰器先装饰，然后外面的装饰器再进行装饰，由内到外的装饰过程
def make_div(func):
    """对被装饰的函数的返回值 div标签"""
    def inner(*args, **kwargs):
        return "<div>" + func() + "</div>"
    return inner

def make_p(func):
    """对被装饰的函数的返回值 p标签"""
    def inner(*args, **kwargs):
        return "<p>" + func() + "</p>"
    return inner

# 装饰过程: 1 content = make_p(content) 2 content = make_div(content)
# content = make_div(make_p(content))
@make_div
@make_p
def content():
    return "人生苦短"

result = content()
print(result)
```

### 带有参数的装饰器

> 简单的说就是最外层函数指传参，中间一层传递函数（相当于原来的最外层），最内层函数装饰并返回装饰的函数

```python
# 装饰器只能接收一个参数，并且还是函数类型。如果想要通过装饰器传参，在装饰器外面再包裹上一个函数，让最外面的函数接收参数，返回的是装饰器，用函数内部的装饰器对函数进行装饰，因为@符号后面必须是装饰器实例
# 添加输出日志的功能
def logging(flag):
    def decorator(fn):
        def inner(num1, num2):
            if flag == "+":
                print("--正在努力加法计算--")
            elif flag == "-":
                print("--正在努力减法计算--")
            result = fn(num1, num2)
            return result
        return inner
    # 返回装饰器
    return decorator

# 使用装饰器装饰函数
@logging("+") # decorator = logging("+") @logging => add = decorator(add)
def add(a, b):
    result = a + b
    return result

@logging("-")
def sub(a, b):
    result = a - b
    return result

result = add(1, 2)
print(result)

result = sub(1, 2)
print(result)
```

### 类装饰器

```python
class Check(object):
    # @Check 等价于 comment = Check(comment), 所以需要提供一个init方法，并多增加一个fn参数。
    def __init__(self, fn):
        self.__fn = fn # 私有的
    # 要想类的实例对象能够像函数一样调用，需要在类里面使用call方法，把类的实例变成可调用对象(callable)，也就是说可以像调用函数一样进行调用。
    # 例如，tom = Cat(), 如果有__call__方法，tom()可以调用
    def __call__(self, *args, **kwargs):
        # 添加装饰功能，在call方法里进行对fn函数的装饰，可以添加额外的功能。
        print("请先登陆...")
        self.__fn()

@Check # @Check => comment = Check(comment)
def comment():
    print("发表评论")
comment()

# 扩展：函数之所以能够调用是因为函数内部使用__call__
def test():
    print("Hello World!")
print(dir(test)) # ['__annotations__', '__call__', '__class__', '__closure__',...]
```

## property属性

property属性就是负责把一个方法当做属性进行使用，这样做可以简化代码使用。定义property属性有两种方式：装饰器方式和类属性方式。

### 装饰器方式

- `@property`表示把方法当做属性使用，表示当获取属性时会执行下面修饰的方法
- `@方法名.setter`表示把方法当做属性使用，表示当设置属性时会执行下面修饰的方法
- 装饰器方式的property属性修饰的方法名一定要一样。

```python
class Person(object):
    def __init__(self):
        self.__age = 0 # 私有属性
    # 装饰器方式的property, 把age方法当做属性使用, 表示当获取属性时会执行下面修饰的方法
    @property
    def age(self):
        print("正在获取属性")
        return self.__age
    # 把age方法当做属性使用, 表示当设置属性时会执行下面修饰的方法
    @age.setter
    def age(self, new_age):
        if new_age >= 150:
            print("成精了")
        else:
            self.__age = new_age

# 创建person
p = Person()
print(p.age)
p.age = 100
print(p.age)
p.age = 1000
```

### 类属性方式

```python
class Person(object):
    def __init__(self):
        self.__age = 0
    def get_age(self):
        """当获取age属性的时候会执行该方法"""
		print("正在获取属性")
        return self.__age
    def set_age(self, new_age):
        """当设置age属性的时候会执行该方法"""
        if new_age >= 150:
            print("成精了")
        else:
            self.__age = new_age
    # 类属性方式的property属性。property是一个类
    age = property(get_age, set_age)

# 创建person
p = Person()
print(p.age)
p.age = 100
print(p.age)
p.age = 1000
```

## 类和对象

类是对一系列具有相同特征和行为的事物的统称，是一个抽象的概念，不是真实存在的事物。类是用来创建对象

对象是类创建出来的真实存在的事物

<u>面向对象三大特性</u>

- **封装**
  - 将属性和方法书写到类的里面的操作即为封装
  - 封装可以为属性和方法添加私有权限
- **继承**
  - 子类默认继承父类的所有属性和方法
  - 子类可以重写父类属性和方法
- **多态**
  - 传入不同的对象，产生不同的结果

### 魔法方法

在Python中，`__xx__()`的函数叫做魔法方法，指的是具有特殊功能的函数。

#### ```__init__()```

作用：初始化对象。

**注意：**

- `__init__()`方法，**在创建一个对象时默认被调用，不需要手动调用**
- `__init__(self)`中的```self```参数，不需要开发者传递，python解释器会自动把当前的对象引用传递过去。

#### ```__str__()```

当使用```print```输出对象的时候，默认打印对象的内存地址。如果类定义了`__str__`方法，那么就会打印从在这个方法中return的数据。

#### ```__del__()```

当删除对象时，python解释器也会默认调用`__del__()`方法。

### 继承

Python面向对象的继承指的是多个类之间的所属关系，即子类默认继承父类的所有属性和方法

在Python中，所有类默认继承object类，object类是顶级类或基类；其他子类叫做派生类。

子类和父类具有同名属性和方法时，默认使用子类的同名属性和方法

**注意：当一个类有多个父类的时候，默认使用第一个父类的同名属性和方法。**

```__mro__```

- python 类有多继承特性，如果继承关系太复杂，很难看出会先调用那个属性或方法。

- 为了方便且快速地看清继承关系和顺序，可以用```__mro__```方法来获取这个类的调用顺序。
- 使用`super()`可以自动查找父类。调用顺序遵循 `__mro__` 类属性的顺序。比较适合单继承使用。

#### 私有属性

在Python中，可以为实例属性和方法设置私有权限，即设置某个实例属性或实例方法不继承给子类。

设置私有权限的方法：在属性名和方法名前面加上两个下划线，如```self.__age```

私有属性和私有方法只能在类里面访问和修改。在Python中，一般定义函数名`get_xx`用来获取私有属性，定义`set_xx`用来修改私有属性值。

```python
class Master(object):
    def __init__(self):
        self.kongfu = '[古法煎饼果子配方]'

    def make_cake(self):
        print(f'运用{self.kongfu}制作煎饼果子')


class School(object):
    def __init__(self):
        self.kongfu = '[黑马煎饼果子配方]'

    def make_cake(self):
        print(f'运用{self.kongfu}制作煎饼果子')


class Prentice(School, Master):
    def __init__(self):
        self.kongfu = '[独创煎饼果子配方]'
        self.__money = 2000000

    def __str__(self):
        return f'配方是{self.kongfu}，钱是{self.__money}'

    # 获取私有属性
    def get_money(self):
        return self.__money

    # 修改私有属性
    def set_money(self):
        self.__money = 500


    def make_cake(self):
        self.__init__()
        print(f'运用{self.kongfu}制作煎饼果子')

    # 一次性调用父类的同名属性和方法
    def make_old_cake(self):
        # 方法一：代码冗余；父类类名如果变化，这里代码需要频繁修改
        # Master.__init__(self)
        # Master.make_cake(self)
        # School.__init__(self)
        # School.make_cake(self)

        # 方法二: super()
        # 方法2.1 super(当前类名, self).函数()
        # super(Prentice, self).__init__()
        # super(Prentice, self).make_cake()

        # 方法2.2 super().函数()
        super().__init__()
        super().make_cake()

# 徒孙类
class Tusun(Prentice):
    pass

daqiu = Prentice()
xiaoqiu = Tusun()
print(daqiu) # 配方是[独创煎饼果子配方]，钱是2000000
daqiu.make_old_cake() # 运用[黑马煎饼果子配方]制作煎饼果子
print(Tusun.__mro__) # (<class '__main__.Tusun'>, <class '__main__.Prentice'>, <class '__main__.School'>, <class '__main__.Master'>, <class 'object'>)
```

<u>a more detailed example</u>

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
__title__ = ''
__author__ = 'admin'
__mtime__ = '2021/11/14'
"""

import math
import time
import copy
#*

class Grandfather(object):
    def __init__(self, age):
        self.__identity = "grandfather"
        self.gender = "male"
        self.age = age

    def showIdentity(self):
        identity = f"I am {self.__identity} {self.age} yrs. old"
        return identity

class Father(Grandfather):
    def __init__(self, age):
        self.__identity = "father"
        self.gender = "male"
        self.age = age

    def showIdentity(self):
        identity = f"I am {self.__identity} {self.age} yrs. old"
        return identity

class Mother(object):
    def __init__(self, age):
        self.__identity = "mother"
        self.gender = "female"
        self.age = age

    def showIdentity(self):
        identity = f"I am {self.__identity} {self.age} yrs. old"
        return identity

class Child(Father, Mother):
    def __init__(self, age):
        self.__identity = "child"
        self.gender = "male"
        self.age = age

    def __str__(self):
        return f"ClassObject: Child; Condition: good!"

    def __call__(self):
        print("HAHA you find me!!")

    def get_identity(self):
        return self.__identity

    def set_identity(self, new_idenitity):
        self.__identity = new_idenitity


    def showIdentity(self):
        identity = f"I am {self.__identity} {self.age} yrs. old"
        return identity

    def showFatherIdentity(self):
        # 当一个类有多个父类的时候，默认使用第一个父类的同名属性和方法
        super().__init__(40) # super(Father, self).__init__(40)
        identity = super().showIdentity() # super(Father, self).showIdentity()
        return identity

    def showMotherIdentity(self):
        Mother.__init__(self, 40)
        identity = Mother.showIdentity(self)
        return identity

grandfather = Grandfather(60)
father = Father(30)
mother = Mother(30)
child = Child(10)

print(father.showIdentity())
print(mother.showIdentity())
print(child.showIdentity())
print(child.showFatherIdentity())
print(child.showMotherIdentity())
# child()
child()
print(Child.__mro__)
"""
I am father 30 yrs. old
I am mother 30 yrs. old
I am child 10 yrs. old
I am father 40 yrs. old
I am mother 40 yrs. old
HAHA you find me!!
(<class '__main__.Child'>, <class '__main__.Father'>, <class '__main__.Grandfather'>, <class '__main__.Mother'>, <class 'object'>)
"""
```

### 多态

多态指的是一类事物有多种形态（一个抽象类有多个子类，因而多态的概念依赖于继承）

- 定义：多态是一种使用对象的方式，子类重写父类方法，调用不同子类对象的相同父类方法，可以产生不同的执行结果
- 好处：调用灵活，有了多态，更容易编写出通用的代码，做出通用的编程，以适应需求的不断变化！
- 实现步骤：
  - 定义父类，并提供公共方法
  - 定义子类，并重写父类方法
  - 传递子类对象给调用者，可以看到不同子类执行效果不同

#### 类属性

- 类属性就是类对象所拥有的属性，它被该类的所有实例对象所共有
- 类属性可以使用类对象或实例对象访问

- 类属性的优点
  - 记录的某项数据始终保持一致时，则定义类属性。
  - 实例属性要求每个对象为其单独开辟一份内存空间来记录数据，而类属性为全类所共有，仅占用一份内存，**更加节省内存空间**
- 类属性只能通过类对象修改，不能通过实例对象修改，如果通过实例对象修改类属性，表示的是创建了一个实例属性

#### 类方法(`@classmethod`)和静态方法(`@staticmethod`)

类方法需要用装饰器`@classmethod`来标识其为类方法，对于类方法，第一个参数必须是类对象，一般以`cls`作为第一个参数。

##### 类方法使用场景

- **当方法中需要使用类对象 (如访问私有类属性等)时**，定义类方法
- 类方法一般和类属性配合使用

***

静态方法需要通过装饰器`@staticmethod`来进行修饰，静态方法既不需要传递类对象也不需要传递实例对象（形参没有`self`/`cls`）。

静态方法也能够通过实例对象和类对象去访问

##### 静态方法使用场景

- 当方法中既不需要使用实例对象(如实例对象，实例属性)，也不需要使用类对象(如类属性、类方法、创建实例等)时，定义静态方法
- 取消不需要的参数传递，**有利于减少不必要的内存占用和性能消耗**

```python
class Dog(object):
    __genre = "柯基"
    age = 9

    def __init__(self):
        pass

    @staticmethod
    def introduction():
        print("Here we are introducing dogs")

    @classmethod
    def get_genre(cls):
        return cls.__genre

d1 = Dog()
d2 = Dog()
d1.age = 10
print(d1.age) # 10
print(d2.age) # 9
print(Dog.age) # 9
# print(d2.__genre) 不知道是不是私有反正无法访问

# 静态方法和类方法能够通过实例对象和类对象去访问
print(d2.get_genre())
print(Dog.get_genre())

print(d2.introduction())
print(Dog.introduction())
```

## 异常

**注意：**

1. 如果尝试执行的代码的异常类型和要捕获的异常类型不一致，则无法捕获异常。
2. 一般```try```下方只放一行尝试执行的代码。

### 自定义异常

在Python中，抛出自定义异常的语法为` raise 异常类对象`。

```python
try:
    f = open('test.txt', 'r')
# 捕获所有异常，Exception是所有程序异常类的父类。
except Exception as result: # 捕获异常描述信息
     print(result)
else:
    print('没有异常，真开心') # else表示的是如果没有异常要执行的代码。
finally:
    f.close() # finally表示的是无论是否异常都要执行的代码，例如关闭文件。
    
# 捕获多个异常
try:
    print(1/0)
except (NameError, ZeroDivisionError):
    print('有错误')

# 实例
class SpecificNumError(Exception):
    def __init__(self, num):
        self.num = num

    def __str__(self):
        return f"Error: the input num {self.num} is not allowed"

if __name__=='__main__':
    forbidden_num = [1, 3, 5, 7, 9]
    try:
        num = int(input())
        if num in forbidden_num:
            raise SpecificNumError(num)
    except Exception as e:
        print(e)
    else:
        print(f"the number {num} is accepted")
```



Namespace

- In Python, every data instance, module, function, and class is an object that has a dictionary that stores its namespace

- writing ```del x``` inside module m would remove ```x``` and its box from m's namespace/dictionary

- Name Spaces (for objects): ```__dict__```
  - Every object has a special variable named ```__dict__``` that stores all its namespace bindings in a dictionary. Writing ```x.a = 1``` is similar to writing ```x.__dict__['a'] = 1```; both associate a name with a value in the object.
- ```None``` is a value(object/instance) of ```NoneType```; it is the only value of that type. Sometimes we use it as a return value of a function: in fact, a Python function that terminates without executing a return statement automatically returns the value ```None```

## 模块和包

### 模块

Python模块(Module)，是一个Python文件，以```.py```结尾，包含了Python对象定义和Python语句。

模块能定义函数，类和变量，模块里也能包含可执行的代码。

#### 导入模块

导入模块的方式

```python
# 5 forms of import
import module-name {,module-name}
import module-name [as alt-name], {, module-name [as alt-name]}
from module-name import attr-name {,attr-name}
from module-name import attr-name [as alt-name], {attr-name [as alt-name]}
from module-name import * # 不推荐，如果导入的不同模块的方法名冲突，此时调用到的是后面导入的模块的功能。
```

在Python中，每个Python文件都可以作为一个模块，模块的名字就是文件的名字。**也就是说自定义模块名必须要符合标识符命名规则。**

当想导入某个模块，但不想执行该模块中的函数时

- ```if __name__ == '__main__':```
  - 只在当前文件中调用该函数，其他导入的文件内不符合该条件，则不执行函数调用

#### 模块定位顺序

当导入一个模块，Python解析器对模块位置的搜索顺序是：

1. 当前目录
2. 如果不在当前目录，Python则搜索在shell变量```PYTHONPATH```下的每个目录。
3. 如果都找不到，Python会察看默认路径。UNIX下，默认路径一般为```/usr/local/lib/python/```

模块搜索路径存储在system模块的sys.path变量中。变量里包含当前目录，```PYTHONPATH```和由安装过程决定的默认目录。

- 注意
  - 自己的文件名不要和已有模块名重复，否则导致模块功能无法使用
  - 使用`from 模块名 import 功能`的时候，如果功能名字重复，调用到的是最后定义或导入的功能。

#### ```__all__```

如果一个模块文件中有`__all__`变量，当使用`from xxx import *`导入时，只能导入这个列表中的元素。

```python
# my_module1
__all__ = ['testA']
def testA():
    print('testA')
def testB():
    print('testB')
# 导入 
from my_module1 import *
testA()
testB() # NameError: name 'testB' is not defined
```

### 包

包将有联系的模块组织在一起，即放到同一个文件夹下，并且在这个文件夹创建一个名字为`__init__.py` 文件，那么这个文件夹就称之为包。

**制作包**

- [New] — [Python Package] — 输入包名 — [OK] — 新建功能模块(有联系的模块)
- 注意：新建包后，包内部会自动创建`__init__.py`文件，这个文件控制着包的导入行为


### 导入包

**注意同一文件夹导入时也需要加包名**

<u>方法一</u>

```python
'''
import 包名.模块名
包名.模块名.目标
'''
import myPackage.test1
myPackage.test1.info_print1()
```

方法二

注意：必须在`__init__.py`文件中添加`__all__ = []`，控制允许导入的模块列表。

```python
'''
from 包名 import *
模块名.目标
'''
# __init__.py
__all__ = ['test1']
# test.py
from myPackage import *
test1.info_print1()
```

## 文件操作

### 打开文件模式

**注意：**

1. `w	`和`a`模式：如果文件不存在则创建该文件；如果文件存在，`w`模式先清空再写入，`a`模式直接末尾追加。
2. `r`模式：如果文件不存在则报错。

| 模式 | 描述                                                         |
| :--: | ------------------------------------------------------------ |
|  r   | 以只读方式打开文件，该文件必须存在。文件的指针将会放在文件的开头。这是默认模式。 |
|  rb  | 以二进制格式打开一个文件用于只读。文件指针将会放在文件的开头。这是默认模式。 |
|  r+  | 打开一个文件用于读写，该文件必须存在。文件指针将会放在文件的开头。 |
| rb+  | 以二进制格式打开一个文件用于读写。文件指针将会放在文件的开头。 |
|  w   | 打开一个文件只用于写入。如果该文件已存在则打开文件，并从开头开始编辑，即原有内容会被删除。如果该文件不存在，创建新文件。 |
|  wb  | 以二进制格式打开一个文件只用于写入。如果该文件已存在则打开文件，并从开头开始编辑，即原有内容会被删除。如果该文件不存在，创建新文件。 |
|  w+  | 打开一个文件用于读写。如果该文件已存在则打开文件，并从开头开始编辑，即原有内容会被删除。如果该文件不存在，创建新文件。 |
| wb+  | 以二进制格式打开一个文件用于读写。如果该文件已存在则打开文件，并从开头开始编辑，即原有内容会被删除。如果该文件不存在，创建新文件。 |
|  a   | 打开一个文件用于追加。如果该文件已存在，文件指针将会放在文件的结尾。也就是说，新的内容将会被写入到已有内容之后。如果该文件不存在，创建新文件进行写入。 |
|  ab  | 以二进制格式打开一个文件用于追加。如果该文件已存在，文件指针将会放在文件的结尾。也就是说，新的内容将会被写入到已有内容之后。如果该文件不存在，创建新文件进行写入。 |
|  a+  | 打开一个文件用于读写。如果该文件已存在，文件指针将会放在文件的结尾。文件打开时会是追加模式。如果该文件不存在，创建新文件用于读写。 |
| ab+  | 以二进制格式打开一个文件用于追加。如果该文件已存在，文件指针将会放在文件的结尾。如果该文件不存在，创建新文件用于读写。 |

### 文件操作

- ```read(num)```：```num```表示要从文件中读取的数据的长度（单位是字节），如果没有传入```num```，那么就表示读取文件中所有的数据。
- ```readline()``` 读取文件中的一行，然后返回整行，包括行结束符到字符串变量中 
- ```readlines()``` 读取整个文件，返回一个字符串```list```，列表中的每个元素都是一个字符串，代表一行
- ```文件对象.seek(偏移量, 起始位置)```：用来移动文件指针。
  - 起始位置：
    - 0：文件开头
    - 1：当前位置
    - 2：文件结尾
- 写文件：```文件对象.write(内容)```
- 关闭文件：```文件对象.close()```

### 使用`with`语句读写文件

执行完成以后自动调用关闭文件操作，即使出现异常也会自动调用关闭文件操作。使用`with`语句操作建立在上下文管理器(实现`__enter__`和`__exit__`)的基础上，**也就是说使用`open`函数创建的文件对象就是就是一个上下文管理器对象**

```python
with open("1.txt", "w") as f:
    f.write("hello world")
```

#### 自定义上下文管理器类并模拟文件操作

一个类只要实现了`__enter__()`和`__exit__()`这个两个方法，通过该类创建的对象我们就称之为上下文管理器。

上下文管理器可以使用`with`语句，`with`语句之所以这么强大，背后是由上下文管理器做支撑的

定义一个File类，实现`__enter__()`和 `__exit__()`方法，然后使用`with`语句来完成操作文件， 示例代码:

```python
class File(object):
    # 初始化方法
    def __init__(self, file_name, file_model):
        # 定义变量保存文件名和打开模式
        self.file_name = file_name
        self.file_model = file_model
    def __enter__(self):
        print("表示上文方法，需要返回一个操作文件对象")
        self.file = open(self.file_name,self.file_model)
        return self.file
    def __exit__(self, exc_type, exc_val, exc_tb):
        print("表示下文方法，with语句执行完成会自动执行，即使出现异常也会执行该方法")
        self.file.close()

if __name__ == '__main__':
    with File("1.txt", "r") as file:
        file_data = file.read()
        print(file_data)
```

#### 使用`@contextmanager`装饰器简化上下文管理器的实现方式

假如想要让一个函数成为上下文管理器，Python还提供了一个`@contextmanager`的装饰器，更进一步简化了上下文管理器的实现方式。通过`yield`将函数分割成两部分，`yield`上面的语句在 `__enter__ `方法中执行，`yield`下面的语句在 `__exit__ `方法中执行，紧跟在 `yield`后面的参数是函数的返回值。

```python
from contextlib import contextmanager

# 装饰器装饰函数，让其称为一个上下文管理器对象
@contextmanager
def my_open(path, mode):
    try:
        file = open(file_name, file_mode)
        # yield之前的代码好比是上文方法
        yield file
    except Exception as e:
        print(e)
    finally:
        print("over")
        # yield下面的代码好比是下文方法
        file.close()
        
with my_open('out.txt', 'w') as f:
    f.write("hello , the simplest context manager")
```

## 常用library

### math

```python
import math
math.sqrt(x)
math.ceil(x)/math.floor(x)
math.cos(x)/math.sin(x)
math.log(x, base)
math.pi/math.e
```

### `logging`日志

记录程序日志信息的目的是

1. 可以很方便的了解程序的运行情况
2. 可以分析用户的操作行为、喜好等信息
3. 方便开发人员检查bug

#### 日志等级

日志等级可以分为5个，从低到高分别是:

1. DEBUG：程序调试bug时使用
2. INFO：程序正常运行时使用
3. WARNING：程序未按预期运行时使用，但并不是错误，如:用户登录密码错误
4. ERROR：程序出错误时使用，如:IO操作失败
5. CRITICAL：特别严重的问题，导致程序不能再继续运行时使用，如:磁盘空间为空，一般很少使用

默认的日志级别设置为WARNING，当在WARNING或WARNING之上等级的才记录日志信息。

日志等级从低到高的顺序是: DEBUG < INFO < WARNING < ERROR < CRITICAL

#### 示例

在`logging`包中记录日志的方式有两种:

1. 输出到控制台
2. 保存到日志文件

**设置日志等级和输出日志格式**

- `level`表示设置的日志等级
- `format`表示日志的输出格式, 参数说明:
  - `%(levelname)s`: 打印日志级别名称
  - `%(filename)s`: 打印当前执行程序名
  - `%(lineno)d`: 打印日志的当前行号
  - `%(asctime)s`: 打印日志的时间
  - `%(message)s`: 打印日志信息

```python
import logging
logging.basicConfig(level=logging.DEBUG,
                    format='%(asctime)s - %(filename)s[line:%(lineno)d] - %(levelname)s: %(message)s',
                    filename="log.txt",
                    filemode="a")
logging.debug('这是一个debug级别的日志信息')
logging.info('这是一个info级别的日志信息')
logging.warning('这是一个warning级别的日志信息')
logging.error('这是一个error级别的日志信息')
logging.critical('这是一个critical级别的日志信息')
"""
运行结果在log.txt：
2021-03-28 23:40:34,837 - logging.py[line:6] - DEBUG: 这是一个debug级别的日志信息
2021-03-28 23:40:34,862 - logging.py[line:7] - INFO: 这是一个info级别的日志信息
2021-03-28 23:40:34,862 - logging.py[line:8] - WARNING: 这是一个warning级别的日志信息
2021-03-28 23:40:34,862 - logging.py[line:9] - ERROR: 这是一个error级别的日志信息
2021-03-28 23:40:34,862 - logging.py[line:10] - CRITICAL: 这是一个critical级别的日志信息
"""
# 注意，以上代码不能修改写入文件的编码格式，所以我找了下，这是修改后的代码
logger = logging.getLogger()
logger.setLevel(logging.DEBUG)
fh = logging.FileHandler(filename="log.txt", mode="a", encoding="utf-8")
logger.addHandler(fh)
formatter = logging.Formatter("%(asctime)s-%(filename)s[lineno:%(lineno)d]-%(levelname)s-%(message)s")
fh.setFormatter(formatter)
```

### os

```python
import os
# os模块中文件和文件夹的操作
os.rename(目标文件名, 新文件名) # 文件重命名
os.remove(目标文件名) # 删除文件
os.mkdir(文件夹名字) # 创建文件夹
os.rmdir(文件夹名字) # 删除文件夹
os.getcwd() # 获取当前目录
os.chdir(目录) # 改变默认目录
os.listdir(目录) # 获取目录列表
```

### time

```python
import time
time.time()
time.ctime()
```

### socket

socket(简称套接字)是进程之间通信一个工具，负责进程之间的网络数据传输，好比数据的搬运工。

#### ip地址

- IPv4 是由点分十进制组成
- IPv6 是由冒号十六进制组成
- 查看 IP 地址
  - Linux和mac OS使用`ifconfig`这个命令
  - Windows使用`ipconfig`这个命令
  - `127.0.0.1`表示本机地址，提示：如果和自己的电脑通信就可以使用该地址。该地址对应的域名是`localhost`
- 检查网络是否正常使用 ping 命令
  - `ping www.baidu.com` 检查是否能上公网
  - `ping 设备的ip地址` 检查是否在同一个局域网内
  - `ping 127.0.0.1` 检查本地网卡是否正常

#### 端口号

知名端口号是指众所周知的端口号，范围从0到1023。

- 这些端口号一般固定分配给一些服务，比如21端口分配给FTP(文件传输协议)服务，25端口分配给SMTP（简单邮件传输协议）服务，80端口分配给HTTP服务。

一般程序员开发应用程序使用端口号称为动态端口号, 范围是从1024到65535。

- 如果程序员开发的程序没有设置端口号，操作系统会在动态端口号这个范围内随机生成一个给开发的应用程序使用。
- 当运行一个程序默认会有一个端口号，当这个程序退出时，所占用的这个端口号就会被释放。

#### TCP程序开发流程

TCP 网络应用程序开发分为客户端程序开发和服务端程序开发。

主动发起建立连接请求的是客户端程序

等待接受连接请求的是服务端程序

##### TCP客户端程序开发步骤

1. 创建客户端套接字对象
2. 和服务端套接字建立连接
3. 发送数据
4. 接收数据
5. 关闭客户端套接字

##### TCP服务端程序开发步骤

1. 创建服务端端套接字对象
2. 绑定端口号
3. 设置监听
4. 等待接受客户端的连接请求
5. 接收数据
6. 发送数据
7. 关闭套接字

![](..\图片笔记\Python\tcp网络应用程序的开发流程.png)****

#### 注意点

1. 当TCP客户端程序想要和TCP服务端程序进行通信的时候必须要先建立连接
2. TCP客户端程序一般不需要绑定端口号（可以绑定，绑定之后端口号是固定的），因为客户端是主动发起建立连接的。
3. TCP服务端程序必须绑定端口号，否则客户端找不到这个TCP服务端程序。
4. `listen`后的套接字是**被动套接字**，只负责接收新的客户端的连接请求，不能收发消息。
5. 当TCP客户端程序和TCP服务端程序连接成功后，TCP服务器端程序会产生一个新的套接字，收发客户端消息使用该套接字。
6. 关闭`accept`返回的套接字意味着和**这个客户端**已经通信完毕。
7. 关闭`listen`后的套接字意味着服务端的套接字关闭了，会导致**新的客户端不能连接服务端，但是之前已经接成功的客户端还能正常通信**。
8. 当客户端的套接字调用`close`后，服务器端的`recv`会解阻塞，返回的数据长度为0，服务端可以通过返回数据的长度来判断客户端是否已经下线，反之服务端关闭套接字，客户端的`recv`也会解阻塞，返回的数据长度也为0。

#### socket 类的介绍

导入socket模块`import socket`

创建客户端socket对象`socket.socket(AddressFamily, Type)`

参数说明:

- `AddressFamily`表示IP地址类型, 分为TPv4和IPv6
- `Type`表示传输协议类型

方法说明:

- `connect((host, port))`表示和服务端套接字建立连接, `host`是服务器ip地址，`port`是应用程序的端口号
- `send(data)`表示发送数据，`data`是二进制数据
- `recv(buffersize)`表示接收数据, `buffersize`是每次接收数据的长度
- `bind((host, port))`表示绑定端口号,`host`是ip地址，`port`是端口号，ip地址一般不指定，表示本机的任何一个ip地址都可以。
  - 多个有网卡
- `listen (backlog)`表示设置监听，`backlog`参数表示最大等待建立连接的个数。单任务下，128是=最大等待连接数
- `accept()`表示等待接受客户端的连接请求

当客户端和服务端建立连接后，**服务端程序**退出后端口号不会立即释放，需要等待大概1-2分钟。解决办法有两种:

1. 更换服务端端口号
2. 设置端口号复用(推荐大家使用)，也就是说让服务端程序退出后端口号立即释放。

`tcp_server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, True)`

1. 参数1: 表示当前套接字
2. 参数2: 设置端口号复用选项
3. 参数3: 设置端口号复用选项对应的值

##### `send`和`recv`原理剖析

当创建一个TCP socket对象的时候会有一个发送缓冲区和一个接收缓冲区，这个发送和接收缓冲区指的就是内存中的一片空间。

`send`: 要想发数据，必须得通过网卡发送数据，应用程序是无法直接通过网卡发送数据的，它需要调用操作系统接口，也就是说，应用程序把发送的数据先写入到发送缓冲区(内存中的一片空间)，再由操作系统控制网卡把发送缓冲区的数据发送给服务端网卡。

`recv`: 应用软件是无法直接通过网卡接收数据的，它需要调用操作系统接口，由操作系统通过网卡接收数据，把接收的数据写入到接收缓冲区(内存中的一片空间），应用程序再从接收缓存区获取客户端发送的数据。

不管是`recv`还是`send`都不是直接接收到对方的数据和发送数据到对方，发送数据会写入到发送缓冲区，接收数据是从接收缓冲区来读取，发送数据和接收数据最终是由操作系统控制网卡来完成。

![](..\图片笔记\Python\send和recv原理.png)

```python
# 客户端代码
import socket

if __name__ == '__main__':
    # 1. 创建tcp客户端套接字
    tcp_client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    # 提示: 客户端程序不强制要求绑定端口号
    # tcp_client_socket.bind(("", 9001))
    # 2. 和服务端套接字建立连接
    tcp_client_socket.connect(("192.168.1.8", 5001))
    send_content = input()
    # 对字符串进程编码成为二进制数据
    send_data = send_content.encode("utf-8")
    # 3. 发送数据到服务端
    # windows里面的网络调试助手使用的gbk编码
    # linux 里面的络调试助手使用的utf-8编码
    tcp_client_socket.send(send_data)
    # 4. 接收服务端的数据
    # 1024：表示每次接收的最大字节数
    recv_data = tcp_client_socket.recv(1024)
    # 对二进制数据进行解码
    recv_content = recv_data.decode("utf-8")
    print("接收服务端的数据为:", recv_content)
    # 5. 关闭套接字
    tcp_client_socket.close()

# 服务端代码
import socket
import threading
def handle_client_request(new_client, ip_port):
    # 代码执行到此，说明客户端和服务端建立连接成功
    while True:
        # 5. 接收客户端的数据
        # 收发消息都使用返回的这个新的套接字, 接收数据的最大字节数是1024
        recv_data = new_client.recv(1024)
        if recv_data:
            # 对二进制数据进行解码变成字符串
            recv_content = recv_data.decode("utf-8")
            print(f"正在接收来自{threading.current_thread()}，端口号{ip_port}的数据...\n接收的数据：{recv_data}\n长度：{len(recv_data)}")
            send_content = f"服务端正在处理来自{threading.current_thread()}，端口号{ip_port}的问题...\n"
            # 对字符串进行编码
            send_data = send_content.encode("utf-8")
            # 6. 发送数据到客户端
            new_client.send(send_data)
        else:
            print(f"来自{threading.current_thread()}，端口号{ip_port}的数据接收已关闭\n")
            break
    # 关闭服务与客户端套接字，表示和客户端终止通信
    new_client.close()

if __name__ == '__main__':
    # 1. 创建tcp服务端套接字
    # AF_INET: ipv4 , AF_INET6: ipv6
    tcp_server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    # 设置端口号复用，让程序退出端口号立即释放
    tcp_server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, True)
    # 2. 绑定端口号
    # 第一个参数表示ip地址，一般不用指定，表示本机的任何一个ip即可
    # 第二个参数表示端口号
    tcp_server_socket.bind(("", 5001))
    # 3. 设置监听
    # 128:最大等待建立连接的个数， 提示： 目前是单任务的服务端，同一时刻只能服务与一个客户端，后续使用多任务能够让服务端同时服务与多个客户端，
    # 不需要让客户端进行等待建立连接
    # listen后的这个套接字只负责接收客户端连接请求，不能收发消息，收发消息使用返回的这个新套接字来完成
    tcp_server_socket.listen(128)
    # 4. 等待接受客户端的连接请求
    # 注意点： 每次当客户端和服务端建立连接成功都会返回一个新的套接字
    # tcp_server_socket只负责等待接收客户端的连接请求，收发消息不使用该套接字。用接受的新的套接字和服务端通信，当有新的连接创建时，
    # 再创建新的套接字和新的连接通信
    while True:
        new_client, ip_port = tcp_server_socket.accept()
        sub_thread = threading.Thread(target = handle_client_request, args = (new_client, ip_port), daemon = True)
        sub_thread.start()
    # 7. 关闭服务端套接字， 表示服务端以后不再等待接受客户端的连接请求
    # tcp_server_socket.close()
```

#### HTTP协议和静态web服务器

##### HTTP协议

- HTTP协议的全称是(HyperText Transfer Protocol)，翻译过来就是超文本传输协议。
- 超文本是超级文本的缩写，是指超越文本限制或者超链接，比如:图片、音乐、视频、超链接等等都属于超文本。
- 传输HTTP协议格式的数据是基于TCP传输协议的，发送数据之前需要先建立连接。
- 它规定了浏览器和Web服务器通信数据的格式，也就是说浏览器和web服务器通信需要使用http协议。

##### HTTP请求报文

浏览器发送给web服务器程序的数据

一个HTTP请求报文可以由请求行、请求头、空行和请求体4个部分组成。

请求行是由三部分组成:

1. 请求方式

2. 请求资源路径

3. HTTP协议版本


HTTP最常见的请求报文有两种:

- `GET`方式的请求报文获取web服务器数据
  - `GET`方式的请求报文没有请求体，只有请求行、请求头、空行组成。
- `POST`方式的请求报文向web服务器提交数据（也可以获取数据，更安全）
  - `POST`方式的请求报文可以有请求行、请求头、空行、请求体四部分组成，注意:`POST`方式可以允许没有请求体，但是这种格式很少见。

`GET`请求原始报文说明:

注意：http协议规定每项信息后都要有`/r/n`，分割每项信息

```
---- 请求行 ----
GET / HTTP/1.1  # GET请求方式 请求资源路径（根路径index.html） HTTP协议版本
---- 请求头 -----
Host: www.itcast.cn  # 服务器的主机地址和端口号,默认是80
Connection: keep-alive # 和服务端保持长连接，发送完数据后，服务端不断开连接。当客户端和服务端有一段时间(3-5min)没有进行通信，那么服务器程序会主动向客户端断开连接
Upgrade-Insecure-Requests: 1 # 让浏览器升级不安全请求，使用https请求
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36  # 用户代理，也就是客户端的名称。可以根据是否有user-agent进行反爬机制
Accept:text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8 # 告诉服务端程序可接受的数据类型
Accept-Encoding: gzip, deflate # 告诉服务端程序可接受的压缩格式
Accept-Language: zh-CN,zh;q=0.9 # 告诉服务端程序可接受的语言
Cookie: pgv_pvi=1246921728; # 登录用户的身份标识 
---- 空行 ----/r/n
```

POST请求报文说明:

```
---- 请求行 ----
POST /xmweb?host=mail.itcast.cn&_t=1542884567319 HTTP/1.1 # POST请求方式 请求资源路径 HTTP协议版本
---- 请求头 ----
Host: mail.itcast.cn # 服务器的主机地址和端口号,默认是80
Connection: keep-alive # 和服务端保持长连接
Content-Type: application/x-www-form-urlencoded  # 告诉服务端请求的数据类型
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36 # 客户端的名称
---- 空行 ----
---- Form Data 请求体 ----
username=hello&pass=hello # 请求参数
```

##### HTTP响应报文

web服务器程序发送给浏览器的http协议的数据

一个HTTP响应报文是由响应行、响应头、空行和响应体4个部分组成。

响应行是由三部分组成：

1. HTTP协议版本 
2. 状态码 
3. 状态描述，最常见的状态码是**200**

响应报文说明:

注意：http协议规定每项信息后都要有`/r/n`，分割每项信息

```
--- 响应行/状态行 ---
HTTP/1.1 200 OK # HTTP协议版本 状态码 状态描述
--- 响应头 ---
Server: Tengine # 服务器名称
Content-Type: text/html; charset=UTF-8 # 服务器发送给浏览器的内容类型及编码格式
Transfer-Encoding: chunked # 服务器发送给客户端（浏览器）的数据不确定内容长度，数据发送完成的接收标识：0\r\n, Content-Length表示服务端确定发送给客户端的内容大小，但是二者只能用其一。
Connection: keep-alive # 和客户端保持长连接
Date: Fri, 23 Nov 2018 02:01:05 GMT # 服务端的响应时间
--- 以下都是自定义响应头信息，字节定义响应头的名字和响应头的值，比如：is_login: True
提示：对于请求头和响应头信息程序员都可以进行自定义，按照客户端和服务器约定好的方式来制定即可。
--- 空行 ---
--- 响应体 就是真正意义上给浏览器解析使用的数据 ---
<!DOCTYPE html>
<html lang=“en”>
…
</html> # 响应给客户端的数据
```

##### HTTP状态码介绍

HTTP 状态码是用于表示web服务器响应状态的3位数字代码。

| 状态码 | 说明                             |
| :----- | :------------------------------- |
| 200    | 请求成功                         |
| 307    | 重定向                           |
| 400    | 错误的请求，请求地址或者参数有误 |
| 404    | 请求资源在服务器不存在           |
| 500    | 服务器内部源代码出现错误         |

##### URL

URL的英文全拼是(Uniform Resoure Locator),表达的意思是统一资源定位符，通俗理解就是网络资源地址，也就是我们常说的网址。

###### URL的组成部分

https://news.163.com/hello.html?page=1&count=10

- 协议部分: `https://`（加密，端口号443）、`http://`（端口号80）、`ftp://`
- 域名部分: `news.163.com`
  - 域名: 域名就是IP地址的别名，它是用点进行分割使用英文字母和数字组成的名字，使用域名目的就是方便的记住某台主机IP地址

- 资源路径部分: `hello.html`
- 查询参数部分: `?page=1&count=10`
  - 参数说明: `?`后面的`page`表示第一个参数，后面的参数都使用`&`进行连接
  - 第1页，显示10条记录

##### 使用谷歌浏览器查看HTTP协议的通信过程

开发者工具：网页右击选择检查。

开发者工具的标签选项说明:

- 元素（Elements）：用于查看或修改HTML标签
- 控制台（Console）：执行js代码
- 源代码（Sources）：查看静态资源文件，断点调试JS代码
- 网络（Network）：查看http协议的通信过程
  - 这里的每项记录都是请求+响应的一次过程
  - General: 主要信息
  - Request Headers: http的请求头信息
  - Response Headers: http的响应头信息

##### 静态web服务器

使用命令行接受服务端端口号，多线程处理来自客户端的请求，封装http响应报文并返回给客户端，并将这个过程封装成类。

```python
import socket
import threading
import sys

# http协议的web服务器类
class HttpWebServer():
    def __init__(self, server_bind_port):
        self.tcp_server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.tcp_server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, True)
        self.tcp_server_socket.bind(("", server_bind_port))
        self.tcp_server_socket.listen(128)

    def start(self):
        while True:
            new_socket, ip_port = self.tcp_server_socket.accept()
            sub_thread = threading.Thread(target=self.handle_client_request, args=(new_socket,), daemon=True)
            sub_thread.start()

    @staticmethod
    def handle_client_request(new_socket):
        recv_data = new_socket.recv(4096).decode("utf-8")
        request_path = recv_data.split(" ", maxsplit=2)[1].lstrip("/")  # 长度为3
        # with open 关闭文件这步操作有系统帮我们完成。这里使用rb，兼容打开图片。favicon.ico是浏览器左上角的图标。可能因为我是
        # PyCharm写的html代码，那个图标是PyCharm的图标
        # ValueError: binary mode doesn't take an encoding argument
        # with open(request_path, "rb", encoding = "utf-8") as file: 是错误的
        try:
            with open(request_path, "rb") as file:
                file_data = file.read()
                print(f"打开 {request_path} ...")
        except Exception as e:  # 文件无法打开
            print(f"{request_path}: 404 Not Found")
        else:
            # 响应行
            response_line = "HTTP/1.1 200 OK \r\n"
            # 响应头
            response_header = "Server: PWS/1.0\r\n"
            # 响应体
            response_body = file_data
            # 把数据封装成http响应报文格式的数据
            response = (response_line +
                        response_header +
                        "\r\n").encode("utf-8") + response_body
            new_socket.send(response)
        finally:
            new_socket.close()

if __name__ == '__main__':
    # 列表里的每项数据都是字符串类型
    # yating@ZZMF-20190903EB:~$ python3 check_args.py canshu1 canshu2
    # ['check_args.py', 'canshu1', 'canshu2'] <class 'list'>
    server_bind_port = int(sys.args[1])

    if not server_bind_port.isdigit():
        print("请输入端口号")
        sys.exit(0)

    web_server = HttpWebServer(server_bind_port)
    web_server.start()
```

### pymysql

#### 防止SQL注入

用户提交带有恶意的数据与SQL语句进行字符串方式的拼接，从而影响了SQL语句的语义，最终产生**数据泄露**的现象。例如：```sql = "select * from students where name = '%s';" % "黄蓉' or 1 = 1 or '"`会显示所有的数据

**如何防止SQL注入?**

SQL语句参数化

- SQL语言中的参数使用`%s`来占位，此处不是python中的字符串格式化操作
- 将SQL语句中`%s`占位所需要的参数存在一个列表中，把参数列表传递给`execute`方法中第二个参数

![](..\图片笔记\Python\pymysql.png)

```python
import pymysql
"""
*参数host：连接的mysql主机，如果本机是
'localhost'
*参数port：连接的mysql主机的端口，默认是3306
*参数user：连接的用户名
*参数password：连接的密码
*参数database：数据库的名称
*参数charset：通信采用的编码方式，推荐使用utf8
"""
# 创建连接对象
"""
连接对象操作说明:
    - 关闭连接 conn.close()
    - 提交数据 conn.commit() 表示将修改操作提交到数据库
    - 撤销数据 conn.rollback() 表示回滚数据
"""
conn = pymysql.connect(host="localhost",
                       port=3306,
                       user="root",
                       password="1djdgQL@",
                       database="self_practice",
                       charset="utf8")
# 获取游标对象
"""
游标操作说明:
    - 使用游标执行SQL语句: execute(operation [parameters ]) 执行SQL语句，
      返回受影响的行数，主要用于执行insert、update、delete、select等语句
    - 获取查询结果集中的一条数据:cur.fetchone()返回一个元组, 如 (1,'张三')
    - 获取查询结果集中的所有数据: cur.fetchall()返回一个元组,如((1,'张三'),(2,'李四'))
    - 关闭游标: cur.close(),表示和数据库操作完成
"""
cursor = conn.cursor();
sql = "insert into goods values(%s, %s, %s, %s, %s, %s, %s);"
try:
    cursor.execute(sql, (0, 'test_laptop1', 'alienware', '戴尔', 16888.000, 1, 0))
    # 如果是查询的sql语句，可以不用提交
    conn.commit()
except Exception as e:
    print(e)
    conn.rollback()
"""
# 查询语句
sql = "select * from goods where cate_name = %s and price > %s;"
# 返回的数据类型是一个元组，其中元组里面的每条数据还是元组
cursor.execute(sql, ("超级本", 1000))
result = cursor.fetchall()
for row in result:
    print(row)
"""
cursor.close()
conn.close()
```

### xlrd

python操作excel主要用到```xlrd```和```xlwt```这两个库，即```xlrd```是读excel，```xlwt```是写excel的库。

#### 常用单元格中的数据类型

- 0: empty（空的

- 1: string（text）
- 2: number

- 3: date: 日期需要做特殊处理
- 4: boolean
- 5: error

- 6: blank（空白表格）

```python
# -*- coding: utf-8 -*-
import xlrd
data = xlrd.open_workbook(filename)#文件名以及路径，如果路径或者文件名有中文给前面加一个r表示原生字符。需要输入Excel的名称，程序会在Python程序所在目录下找到该文件，如果文件不存在，会返回FileNotFoundError错误
names = data.sheet_names()    #返回book中所有工作表的名字
table = data.sheets()[0]          #通过索引顺序获取
table = data.sheet_by_index(sheet_indx) #通过索引顺序获取
table = data.sheet_by_name(sheet_name)#通过名称获取
'''以上三个函数都会返回一个xlrd.sheet.Sheet()对象'''
data.sheet_loaded(sheet_name or indx)   # 检查某个sheet是否导入完毕

print(sheet1.name, sheet1.nrows, sheet1.ncols)
# sheet1的名称、行数、列数
print(sheet1.row_values(0), sheet1.col_values(0), sheet1.cell_value(0, 0))
# sheet1的某一行/某一列所有值的列表，某行某列的值
nrows = table.nrows  #获取该sheet中的有效行数
table.row(rowx)  #返回由该行中所有的单元格对象组成的列表
table.row_slice(rowx)  #返回由该列中所有的单元格对象组成的列表
table.row_types(rowx, start_colx=0, end_colx=None)    #返回由该行中所有单元格的数据类型组成的列表
table.row_values(rowx, start_colx=0, end_colx=None)   #返回由该行中所有单元格的数据组成的列表
table.row_len(rowx) #返回该列的有效单元格长度
ncols = table.ncols   #获取列表的有效列数
table.col(colx, start_rowx=0, end_rowx=None)  #返回由该列中所有的单元格对象组成的列表
table.col_slice(colx, start_rowx=0, end_rowx=None)  #返回由该列中所有的单元格对象组成的列表
table.col_types(colx, start_rowx=0, end_rowx=None)    #返回由该列中所有单元格的数据类型组成的列表
table.col_values(colx, start_rowx=0, end_rowx=None)   #返回由该列中所有单元格的数据组成的列表
table.cell(rowx,colx)   #返回单元格对象

table.cell_type(rowx,colx)    #返回单元格中的数据类型
table.cell_value(rowx,colx)   #返回单元格中的数据
table.cell_xf_index(rowx, colx)   # 暂时还没有搞懂

#日期的处理
'''
excel中的日期时间通过xlrd读取到数据后，会转换成一串数字
2018/07/10会转换为43291.0
2018/7/10  18:15:02 会转换成43291.76043981482
'''
cell_0_0_tuple = xlrd.xldata_as_tuple(cell_0_0.value, datemode=0)
# 首先要判断ctype属于日期，然后才能转换为tuple（年，月，日，时，分，秒）
# datemode在此处的含义是从1900年开始，如果等于1，则是从1904年开始（使用0即可）

from datetime import datetime, date
date(*cell_0_0_tuple[:3]）.strftime('%Y/%m/%d')
# 使用date模块，将tuple的年月日转换为date对象（只支持三位参数），使用strftime方法格式化。
```

### xlwt

```python
# -*- coding: utf-8 -*-
#导入xlwt模块
import xlwt
# 创建一个Workbook对象，这就相当于创建了一个Excel文件
book = xlwt.Workbook(encoding='utf-8', style_compression=0)
'''
Workbook类初始化时有encoding和style_compression参数
encoding:设置字符编码，一般要这样设置：w = Workbook(encoding='utf-8')，就可以在excel中输出中文了。
默认是ascii。当然要记得在文件头部添加：
#!/usr/bin/env python
# -*- coding: utf-8 -*-
style_compression:表示是否压缩，不常用。
'''
#创建一个sheet对象，一个sheet对象对应Excel文件中的一张表格。
# 在电脑桌面右键新建一个Excel文件，其中就包含sheet1，sheet2，sheet3三张表
sheet = book.add_sheet('test', cell_overwrite_ok=True)
# 其中的test是这张表的名字,cell_overwrite_ok，表示是否可以覆盖单元格，其实是Worksheet实例化的一个参数，默认值是False
# 向表test中添加数据
sheet.write(0, 0, 'EnglishName')  # 其中的'0-行, 0-列'指定表中的单元，'EnglishName'是向该单元写入的内容
sheet.write(1, 0, 'Marcovaldo')
txt1 = '中文名字'
sheet.write(0, 1, txt1.decode('utf-8'))  # 此处需要将中文字符串解码成unicode码，否则会报错
txt2 = '马可瓦多'
sheet.write(1, 1, txt2.decode('utf-8'))
 
# 最后，将以上操作保存到指定的Excel文件中
book.save(r'e:\test1.xls')  # 在字符串前加r，声明为raw字符串，这样就不会处理其中的转义了。否则，可能会报错
# 这个真的很有用
```

# 进程和线程

## 并发和并行

- 并发: 在一段时间内交替去执行任务。
  - 例如: 对于单核cpu处理多任务,操作系统轮流让各个软件交替执行，假如:软件1执行0.01秒，切换到软件2，软件2执行0.01秒，再切换到软件3，执行0.01秒……这样反复执行下去。表面上看，每个软件都是交替执行的，但是，由于CPU的执行速度实在是太快了，我们感觉就像这些软件都在同时执行一样，这里需要注意单核cpu是并发的执行多任务的。

- 并行: 对于多核cpu处理多任务，操作系统会给cpu的每个内核安排一个执行的软件，多个内核是真正的一起执行软件。这里需要注意多核cpu是并行的执行多任务，始终有多个软件一起执行。

任务数大于CPU的核数表示并发的去执行多任务，任务数小于等于CPU的核数表示并行的去执行多任务。

## 进程和线程对比

### 关系对比

- 线程是依附在进程里面的，没有进程就没有线程。
- 一个进程默认提供一条线程，进程可以创建多个线程。

### 区别对比

- 进程之间不共享全局变量

- 线程之间共享全局变量，但是要注意资源竞争的问题
  - 解决办法: 互斥锁
  - 线程同步
- 创建进程的资源开销要比创建线程的资源开销要大

- 进程是操作系统资源分配的基本单位，线程是CPU调度的基本单位

- 线程不能够独立执行，必须依存在进程中

- 多进程开发比单进程多线程开发稳定性要强，某个进程挂掉不会影响其它进程，但是占用资源多

### 优缺点对比

进程:

- 优点：可以用多核
- 缺点：资源开销大

线程:

- 优点：资源开销小
- 缺点：不能使用多核

和计算密集型相关操作使用多进程

文件写入，文件的下载，i/o使用多线程

## 进程

在Python程序中，想要实现多任务可以使用进程来完成，进程是实现多任务的一种方式。

一个正在运行的程序或者软件就是一个进程，它是操作系统进行资源分配的基本单位，也就是说每启动一个进程，操作系统都会给其分配一定的运行资源(内存资源)保证进程的运行。

注意: 一个程序运行后至少有一个进程，一个进程默认有一个线程，进程里面可以创建多个线程，线程是依附在进程里面的，没有进程就没有线程。

### 获取进程编号

获取进程编号的目的是验证主进程和子进程的关系，可以得知子进程是由那个主进程创建出来的。

`os.getpid()`: 表示获取当前进程编号

`os.getppid()`: 表示获取当前父进程编号

`os.kill(pid, 9)`: 根据进程编号强制杀死指定进程

### ```multiprocessing```

`multiprocessing.current_process()`: 获取当前进程对象

#### ```Process```进程类

需要导包`import multiprocessing`

```Process([group [, target [, name [, args [, kwargs]]]]])```

- ```group```：指定进程组，目前只能使用```None```
- ```target```：执行的目标任务名，函数
- ```name```：进程名字，如果不设置，默认是```Process-N```
- ```args```：以元组方式给执行任务传参，元组里面的元素要和函数的参数顺序保持一致
- ```kwargs```：以字典方式给执行任务传参，字典里面的key要和函数里面的参数名保持一致，没有顺序要求

```Process```创建的实例对象的常用方法:

- ```start()```：启动子进程实例（创建子进程）
- ```join()```：等待当前子进程执行结束
- ```terminate()```：不管任务是否完成，立即终止子进程

```Process```创建的实例对象的常用属性:

- ```name```：当前进程的别名，默认为```Process-N```，```N```为从1开始递增的整数

### 注意点

- 进程之间执行是无序的
  - 它是由操作系统调度决定的，操作系统调度哪个进程，哪个进程就先执行，没有调度的进程不能执行。
- 进程之间不共享全局变量
  - 创建子进程其实是对主进程资源进行拷贝，子进程其实就是主进程的一个副本。在子进程中修改全局变量时，是在修改子进程副本的全局变量
  - 对于Linux和Mac主进程执行的代码不会进行拷贝，但是对于windows系统来说创建子进程时会拷贝执行主进程的代码，相当于递归无限制创建子进程，会报错
- 主进程会等待所有的子进程执行结束再结束
  - 解决办法1：将子进程设置成守护主进程，主进程退出子进程销毁，子进程会依赖主进程
    - ```sub_process.daemon = True    sub_process.start()```
  - 解决办法2：让主进程退出之前先让子进程销毁
    - ```time.sleep(0.5)    sub_process.terminate()```

进程之间不共享全局变量的解释效果图:

![](..\图片笔记\Python\进程关系.png)

### 示例

```python
import multiprocessing
import time
import os
def dance(name, age):
    dance_process_id = os.getpid()
    print(f"进程{multiprocessing.current_process()}执行中，id: {dance_process_id}，父进程id: {os.getppid()}")
    for i in range(3):
        print(f"{name}（年龄{age}）第{i + 1}次跳舞中...")
        time.sleep(0.2)
        os.kill(dance_process_id, 9)
def sing():
    print(f"进程{multiprocessing.current_process()}执行中，id: {os.getpid()}，父进程id: {os.getppid()}")
    for i in range(3):
        print(f"第{i + 1}次唱歌中...")
        time.sleep(0.2)
# The "freeze_support()" line can be omitted if the program
# 对于Linux和Mac主进程执行的代码不会进行拷贝，但是对于windows系统来说主进程执行的代码也会进行拷贝执行，相当于递归无限制创建子进程，会报错
if __name__ == '__main__':
    print(f"{multiprocessing.current_process()}执行中，id: {os.getpid()}")
    dance_process = multiprocessing.Process(target=dance, name="dance_process", args=("张三",), kwargs={"age": 20})
    sing_process = multiprocessing.Process(target=sing, name="sing_process")
    # 主进程MainProcess先执行，子进程执行是无序的，具体哪个进程先执行是由操作系统调度决定
    sing_process.start()
    sing_process.join()
    dance_process.start()
```

## 线程

线程是进程中执行代码的一个分支，每个执行分支（线程）要想工作执行代码需要cpu进行调度，也就是说线程是cpu调度的基本单位，每个进程至少都有一个线程，而这个线程就是我们通常说的主线程。

### ```threading```

`threading.current_thread()`: 获取当前线程对象

#### ```Thread```线程类

需要导包`import threading`

```Thread([group [, target [, name [, args [, kwargs]]]]])```

- `group`: 线程组，目前只能使用`None`
- `target`: 执行的目标任务名，函数
- `name`: 线程名，如果不设置，默认是`Thread-N`
- `args`: 以元组的方式给执行任务传参，元组里面的元素要和函数的参数顺序保持一致
- `kwargs`: 以字典方式给执行任务传参，字典里面的key要和函数里面的参数名保持一致，没有顺序要求
- `daemon=True`: 表示创建的子线程守护主线程

```Thread```创建的实例对象的常用方法:

- `start()`: 启动线程执行任务
- ```join()```：等待当前子线程执行结束

### 注意点

- 线程之间执行是无序的
  - 它是由cpu调度决定的，cpu调度哪个线程，哪个线程就先执行，没有调度的线程不能执行。
- 主线程会等待所有的子线程执行结束再结束
  - 解决办法：将子线程设置成守护主线程，主线程退出子线程销毁，子线程会依赖主线程

    - `threading.Thread(target=task, daemon=True)`
    - `sub_thread.setDaemon(True)`
- 线程之间共享全局变量
  - 因为多线程在同一个线程里面，所以多线程可以共享全局变量
- 线程之间共享全局变量数据会出现错误问题，如，调用两个线程同时给全局变量`g_num`加上1,000,000，实际结果会小于2,000,000
  - 线程同步: 保证同一时刻只能有一个线程去操作全局变量 
    - 同步: 就是协同步调，按预定的先后次序进行运行。如:你说完，我再说, 好比现实生活中的对讲机
  - 线程同步的方式
    - 线程等待(`join()`)
    - 互斥锁
  - 线程等待和互斥锁都是把多任务改成单任务去执行，保证了数据的准确性，但是执行性能会下降

### 互斥锁

- 互斥锁: 对共享数据进行锁定，保证同一时刻只能有一个线程去操作。

- 互斥锁是多个线程一起去抢，抢到锁的线程先执行，没有抢到锁的线程需要等待，等互斥锁使用完释放后，其它等待的线程再去抢这个锁。
- 使用互斥锁的好处确保某段关键代码只能由一个线程从头到尾完整地去执行，能够保证全局变量的数据没有问题
- 使用互斥锁会影响代码的执行效率，多任务改成了单任务执行
- 互斥锁如果没有使用好容易出现死锁的情况

#### `Lock`

- `threading`模块中定义了`Lock`变量，这个变量本质上是一个函数，通过调用这个函数可以获取一把互斥锁。
- `acquire()`和`release()`方法之间的代码同一时刻只能有一个线程去操作
- 如果在调用`acquire()`方法的时候 其他线程已经使用了这个互斥锁，那么此时`acquire()`方法会堵塞，直到这个互斥锁释放后才能再次上锁。

#### 死锁

死锁: 一直等待对方释放锁的情景就是死锁

使用互斥锁的时候需要注意死锁的问题，**要在合适的地方注意释放锁。**

锁一旦产生就会造成应用程序的停止响应，应用程序无法再继续往下执行了。

### 示例

```python
import threading
import time
import os

# 创建互斥锁, Lock本质上是一个函数，通过调用函数可以创建一个互斥锁
lock = threading.Lock()

def dance(name, age):
    # 上锁
    lock.acquire()
    print(f"进程{threading.current_thread()}执行中")
    for i in range(3):
        print(f"{name}（年龄{age}）第{i + 1}次跳舞中...")
        time.sleep(0.2)
    # 释放锁
    lock.release()


def sing():
    lock.acquire()
    print(f"进程{threading.current_thread()}执行中")
    for i in range(3):
        print(f"第{i + 1}次唱歌中...")
        time.sleep(0.2)
    lock.release()

if __name__ == '__main__':
    print(f"{threading.current_thread()}执行中")
    dance_thread = threading.Thread(target=dance, name = "dance_thread", kwargs={"name": "张三", "age": 20})
    sing_thread = threading.Thread(target=sing, name = "sing_thread")
    dance_thread.start()
    sing_thread.start()
```





 # PyCharm

## Tips

- 如果你在条件句前忘记键入```if```，在该句子最后增添```.if```并点击```Tab```键，PyCharm将修复该`if`条件句。该用法同样适用于```True.while```。这即是PyCharm的Postfix Completion功能，它可以帮助用户减少退格键使用次数。或者选中语句，按住`Ctrl+Alt+T`环绕
- 输入`main Enter`PyCharm会自动输入`if __name__ == __main__:`
- 要快速查看插入符号处的文档，请按`Ctrl+Q`（查看|快速文档）。
- 如果光标位于方法调用的括号之间，按下`Ctrl+P`将弹出一个有效参数列表。
- (`Ctrl+Shift+J`快捷键将两行合并为一行，并删除不必要的空格以符合您的代码样式。)
- `Ctrl+Shift+Backspace`（导航|上一个编辑位置）将您带回到您在代码中进行更改的最后一个地方。
- 使用`Ctrl+Shift+F7`（Edit|Find|突出显示文件中的用法）快速突出显示当前文件中某些变量的用法。`F3`/`Shift+F3`向后或向前浏览。按`Esc`退出
- 要查看您的本地文件更改历史记录，请调用本地历史记录|显示上下文菜单中的历史记录（Local History|Show History）。 您可以浏览不同的文件版本，查看差异并回滚到任何以前的版本。
- 使用`Alt+Up`和`Alt+Down`在编辑器中快速移动方法。
- 使用`Ctrl+Shift+V`快捷键选择并将最近的剪贴板内容插入到文本中。如果不选择文本，`Ctrl+C`会复制当前行到剪切板。`Ctrl+Alt+Shift+V`纯文本粘贴
- 您可以通过按`Ctrl+O`(代码|覆盖方法）轻松地覆盖基类的方法。
- `Alt+Insert`智能生成常用代码
- `Alt+Enter`智能提示
- `Ctrl+Alt+V`会自动生成局部变量接受
- 为了帮助您了解主菜单中每个项目的用途，将鼠标指针放在该项目上时，其简短说明会显示在应用程序框架底部的状态栏中。

## 一些常用设置

- 插件介绍：https://www.2bboy.com/archives/153.html

- PyCharm中的设置是可以导入和导出的，**Manage IDE Settings -> Export Settings**可以保存当前PyCharm中的设置

- 在**Editer -> File and Code Templates -> python scripts**输入如下

  ```python
    #!/usr/bin/env python
    # `-*- coding: utf-8 -*-`
    """
    __title__ = '$Package_name'
    __author__ = '$USER'
    __mtime__ = '$DATE'
    """
  ```

- PyCharm默认是自动保存的，习惯自己按```Ctrl+S```全部保存的可以进行如下设置：
  
- **Appearance & Behavior -> System Settings -> Save files if IDE is idle for xx seconds**的勾去掉
  
- 对于常用的快捷键，可以设置为visual studio, eclipse一样的：
  
  - **Keymap -> Visual Studio**
  
- PyCharm中默认是不能用`Ctrl+'+'`滚轮改变字体大小的，可以在**Genral -> Mouse Control -> Change font size with Control+Mouse Wheel**打上勾

- 设置缩进符为制表符```Tab```
  
  - **Editor -> Code Style -> Python -> 勾选Use tab character -> Python -> 勾选Use tab character**，其他的语言代码同理设置
  
- ==显示行号与空白字符==
  
  - **Editor -> General -> Appearance -> 勾选“Show line numbers”; “Show whitespaces”; “Show method separators”**
  
- 去掉默认折叠
  
  - **Editor -> General -> Code Folding** 
  
  
  

## 在 PyCharm 中搜索和导航

在大项目中，我们很难记住每个事物的位置，因此快速导航和搜索非常重要。PyCharm可以提供这些功能。

- 在当前文件中搜索代码段：在Mac系统中使用`Cmd+F`键，在Windows或 Linux系统中使用`Ctrl+F`键。

  在整个项目中搜索代码段：在Mac系统中使用`Cmd+Shift+F`键，在Windows或Linux系统中使用`Ctrl+Shift+F`键。
- 搜索类：在Mac系统中使用`Cmd+O`键，在Windows或Linux系统中使用`Ctrl+N`键。
- 搜索文件：在Mac系统中使用`Cmd+Shift+O`键，在Windows或Linux系统中使用`Ctrl+Shift+N`键。
- **如果你不知道要搜索的是文件、类还是代码段，则搜索全部：按两次 Shift 键。**

导航可使用以下快捷键：

- 前往变量的声明：在Mac系统中使用`Cmd`键，在Windows或Linux系统中使用`Ctrl`键，然后单击变量。
- 寻找类、方法或文件的用法：使用`Alt+F7`键。
- 查看近期更改：使用`Shift+Alt+C`键，或者在主菜单中点击View → Recent Changes。
- 查看近期文件：在Mac系统中使用`Cmd+E`键，在Windows或Linux系统中使用`Ctrl+E`键，或者在主菜单中点击View → Recent Files。
- 多次跳转后在导航历史中前进和后退：在Mac系统中使用`Cmd+[`/`Cmd+]`键，在Windows或Linux系统中使用`Ctrl+Alt+Left`/`Ctrl+Alt+Right`键。

# python虚拟环境和安装包

安装Redis的有3种方式https://github.com/andymccurdy/redis-py

第一种：进入虚拟环境，联网安装包redis：`pip install redis`

第二种：进入虚拟环境，联网安装包redis：`easy_install redis`

第三种：到中文官网-客户端下载redis包的源码，使用源码安装

```bash
wget https://github.com/andymccurdy/redis-py/archive/master.zip
unzip master.zip
cd redis-py-master
sudo python setup.py install
```

## pip

While **pip** alone is sufficient to install from pre-built binary archives, up to date copies of the **setuptools** and **wheel** projects are useful to ensure you can also install from source archives: ```python -m pip install --upgrade pip setuptools wheel```

```bash
# upgrade pip
python3 -m pip install --upgrade pip
# check packages
pip list
pip show xlwt
# check outdated packages
pip list --outdated
# install the latest version of "someproject"
pip install "someproject" / python -m pip install --user "someproject"
# install a specfic version 
pip install "someproject==1.4"
# install greater than or equal to one version and less than another
pip install "SomeProject>=1,<2"
# To install a version that’s “compatible” with a certain version
# this means to install any version "==1.4.*" version that’s also ">=1.4.2.*"
pip install "SomeProject~=1.4.2"
# Upgrade an already installed SomeProject to the latest
pip install --upgrade SomeProject
# uninstall
pip uninstall [options] <package>
# 查看是否安装成功
pip show pymsql
```

Install a list of requirements specified in a Requirements File: ```pip install -r requirements.txt```

To uninstall: ```pip uninstall [options] -r <requirements file> ...```

For more information, check [python documentation](https://packaging.python.org/tutorials/installing-packages/#installing-packages)

## 虚拟环境

 virtual environments have their own installation directories and they don’t share libraries with other virtual environments.

Currently, there are two common tools for creating Python virtual environments:

- **venv** is available by default in Python 3.3 and later, and installs pip and setuptools into created virtual environments in Python 3.4 and later.
- **virtualenv** needs to be installed separately, but supports Python 2.7+ and Python 3.3+, and pip, setuptools and wheel are always installed into created virtual environments by default (regardless of Python version).

### `pipenv`

```bash
# 查看命令使用帮助
pipenv -h 
pipenv --python 3[.6]
# 这条命令会指出pidfile的存储地址和新的虚拟环境的存储地址。pidfile中会有安装包，依赖包和配置环境等相关信息
pipenv --where # 查看项目位置
pipenv --py # 查看解释器信息
# 激活虚拟环境
pipenv shell
# 查看虚拟环境信息 
pipenv --venv
# 安装包
pipenv install requests
# 卸载包
pipenv uninstall requests
# 查看包的依赖结构
pipenv graph
# 退出虚拟环境
exit
# 删除虚拟环境
# 注意 pipenv --rm 只是把创建的虚拟环境删除了，但Pipfile和Pipfile.lock还存。下次如果想要创建与项目myproject相同的虚拟环境时：只要打 cmd，切换到myproject目录下执行命令 pip install 即可
pipenv --rm
使用pipenv install -r requirements.txt安装第三方的模块
pipenv install -r requirements.txt
# 查看第三方安装的模块依赖，可导出到requirements.txt
pipenv lock -r -i https://pypi.org/simple
```

### `venv`

```bash
# install pipenv
pip install --user pipenv
# install packages for your project
cd my_project
pipenv install requests 
# create a virtual environment
python3 -m venv my_project/test_env
source myproject/test_env/bin/activate
```

### `virtualenv`

目前只有这个比较稳定（因为被很多人试过了），保险起见还是用这个吧~

```bash
# 安装虚拟环境
sudo pip install virtualenv
# Virtaulenvwrapper是virtualenv的扩展包，用于更方便管理虚拟环境，它可以做
# 将所有虚拟环境整合在一个目录下 
# 管理（新增，删除，复制）虚拟环境 
# 快速切换虚拟环境
# 安装
sudo pip install virtualenvwrapper
pip install virtualenvwrapper-win # 对于windows

# 安装完虚拟环境后，如果提示找不到mkvirtualenv命令，须配置环境变量：
# 1、创建目录用来存放虚拟环境
mkdir $HOME/.virtualenvs
# 2、打开~/.bashrc文件，并添加如下：
export VIRTUALENVWRAPPER_PYTHON='/Library/Frameworks/Python.framework/Versions/3.9/bin/python3' # 在同时安装了python2和python3的情况下，需要加上这句
export WORKON_HOME=$HOME/.virtualenvs
# 注意对于mac，如果这个文件在/Library/Frameworks/Python.framework/Versions/3.9/bin/下，需要复制到/usr/local/bin/下
source /usr/local/bin/virtualenvwrapper.sh 
# 3、运行
source ~/.bashrc
# 对于windows，在系统变量中添加 WORKON_HOME=你想存放虚拟环境的目录，默认C:\Users\admin。如果想修改的话，virtualenvwrapper安装完成后，打开Python根目录\Scripts目录下的mkvirtualenv.bat文件，然后修改第24行[set "venvwrapper.default_workon_home=%USERPROFILE%\Envs"] 这里的，%USERPROFILE%相当于Linux系统中的/user/home，修改这个路径地址就可以修改virtualenv的环境地址
# 我在用windows做完上述步骤之后，workon没有结果。于是在系统变量里加了WORKON_HOME=C:\Users\admin\.virtualenvs并且重新运行了C:\Users\admin\AppData\Local\Programs\Python\Python36\Scripts下的virtualenvwrapper.bat文件，之后可以正常显示。之所以用.是因为这是pycharm默认安装虚拟环境的目录。但是创建虚拟环境的话，用pycharm的话比较方便

# 罗列当前的虚拟环境
workon

# 创建虚拟环境并进入
mkvirtualenv -p python2.7 虚拟环境名称 / mkvirtualenv --python=python2.7 虚拟环境名称
# 或是
virtualenv envname02
workon envname02  # 进入该虚拟环境
# 或是
virtualenv envname03
cd envname03
source bin/activate  # 激活并进入虚拟环境

# 使用虚拟环境
workon 虚拟环境名称
# 工具包安装的位置是C:\Users\admin\Documents\PycharmProjects\DjangoProject\Lib\site-packages
pip list
pip install django==1.11.11
pip uninstall 模块名
# 复制虚拟环境
cpvirtualenv env1 env2  # 前面的是原文件 后面的拷贝后的新文件
# 退出虚拟环境
deactivate
# 删除虚拟环境
先退出：deactivate
再删除：rmvirtualenv py3_django
------------------------------------没有用过，复制的-------------------------------------
pip freeze # 查看当前安装库版本
# 创建 requirements.txt 文件，其中包含了当前环境中所有包及各自的版本的简单列表
# 保持部署相同，一键安装所有包
pip install -r requirements.txt
pip freeze > requirements.txt 
lsvirtualenv    #列举所有的环境
cdvirtualenv    #导航到当前激活的虚拟环境的目录中，相当于pushd 目录
cdsitepackages   # 和上面的类似，直接进入到 site-packages 目录
lssitepackages     #显示 site-packages 目录中的内容
---------------------------------------没有装virtualenvwrapper----------------------------------------
# 在windows系统下，推荐使用cmd，提示pip有新版本，按提示用'python -m pip install --upgrade pip'命令更新就好了。在虚拟环境里，千万别用'pip install --upgrade pip'更新pip，这会破坏pip。
# 使用虚拟环境
.\Scripts\activate.bat或直接activate
# 退出虚拟环境
.\Scripts\deactivate.bat或直接deactivate
# 删除虚拟环境
# 没有使用virtualenvwrapper前，可以直接删除venv文件夹来删除环境
```

# Anaconda

```bash
# 检查conda版本
conda --version
# 查看包括版本的更多信息
conda info
# 查看conda帮助信息
conda -h
# 更新Anaconda
conda update conda
# 更新所有包
conda update --all
# 列举当前活跃环境下的所有包
conda list
conda list beautifulsoup4
# 查找指定的包信息，模糊查找，即模糊匹配，只要含py字符串的包名就能匹配到
conda search numpy  
# 查找包，--full-name表示精确查找，即完全匹配名为numpy的包
conda search --full-name numpy
# 在当前活跃环境安装包
conda install beautifulsoup4
# 删除当前环境的包
conda remove beautifulsoup4
# 列举一个非当前活跃环境下的所有包
conda list -n your_env_name
-----------------------------虚拟环境的操作，加上--name和虚拟环境名称-----------------------------
# 查看conda环境管理命令帮助信息
conda create --help
# 创建不同的python版本，直接写出版本号就好了
conda create -n env_name python=3.5
# 指定python版本,以及多个包
conda create -n env_name python=3.4 scipy=0.15.0 astroib numpy
# 查看某个指定环境的已安装包
conda list -n env_name
# 为指定环境安装某个包，也可以通过-c指定通过某个channel安装
conda install -n env_name package_name
# 更新指定环境下安装的某个包
conda update -n env_name scrapy
# 删除指定环境安装的包
conda remove -n env_name package_name
# 激活虚拟环境
activate env_name / source activate env_name
# 退出虚拟环境
deactivate / source deactivate
# 删除一个已有环境
conda remove --name env_name --all
# 列出系统存在虚拟环境
conda info -e
conda env list
# 克隆一个环境
conda create --name clone_env --clone envname   # clone_env 代指克隆得到的新环境的名称，envname 代指被克隆的环境的名称
---------------------------------------更换源-----------------------------------------------
# 查看当前下载源
conda config --show channels
# 配置国内安装的镜像
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/r
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/pro
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/msys2
conda config --set show_channel_urls yes
# 清除添加的所有下载源
conda config --remove-key channels
```

# 一些注意点

以数字开头命名的包不能导入

## raw字符串

如果一个字符串包含很多需要转义的字符，对每一个字符都进行转义会很麻烦。为了避免这种情况，

我们可以在字符串前面加个前缀```r```，表示这是一个raw字符串，里面的字符就不需要转义了。例如：```print(r"\r\n\t")```

## 字符串类型

在python中字符串默认采用的ASCII编码，如果要显示声明为unicode类型的话，需要在字符串前面加上```u```或者```U```。

```python
# -*- coding: utf-8 -*-
s1 = "这是中文"
s2 = u"这是中文"
print(type(s1)) # <class 'str'>
print(type(s2)) # <class 'str'>
```

注意：如果中文字符串在Python环境下遇到```UnicodeDecodeError```，这是因为```.py```文件保存的格式有问题。可以在第一行添加注释：```# -*- coding: utf-8 -*-```，对于GBK，使用```# -*- coding: gbk -*-```

我的备注：实际上加不加效果是一样的，因为Python2默认使用的是ASCII编码 (不支持中文)，Python3默认使用UTF-8编码(万国码, 支持中文)。

## ```#!/usr/bin/env python3```

[#!/usr/bin/python3 和 #!/usr/bin/env python3 的作用](https://www.jianshu.com/p/400c612381dd) 

在脚本中, 第一行以```#!```开头的代码, 在计算机行业中叫做 "shebang", 也叫做 sha-bang / hashbang / pound-bang / hash-pling, 其作用是"指定由哪个解释器来执行脚本".

在windows的powershell里不支持shebang

## 爬虫相关

很多网站都有反爬虫的措施，对于没有headers头信息的请求一律认为是爬虫，禁止该请求的访问。因此在每次爬取网页时都需要加上headers头信息。

对于访问过于频繁的请求，客户端的IP会被禁止访问，因此设置代理可以将请求伪装成来自不同的IP，前提是要保证代理的IP地址是有效的。

[bs4库的入门介绍-博客](https://www.cnblogs.com/yuanchenqi/articles/7617280.html)

[简单教学](https://www.cnblogs.com/airnew/p/9981599.html)

## 正则表达式

[知乎的详细解释](https://www.zhihu.com/question/48219401/answer/742444326)

[菜鸟教程](https://www.runoob.com/python3/python3-reg-expressions.html)

- `.`匹配任意1个字符（除了`\n`）
- `*`匹配前一个字符出现0次或者无限次
- `+`匹配前一个字符出现1次或者无限次，即至少有1次
- `?`匹配前一个字符出现1次或者0次
- `{m,}`匹配前一个字符至少出现m次
- `{m,n}`匹配前一个字符出现从m到n次
- `\w`匹配非特殊字符，即`a-z`、`A-Z`、`0-9`、`_`、汉字
- 一个小括号就表示一个分组，分组是从1开始的。默认是0，获取整个分组的数据

```python
import re
"""
|: 匹配左右任意一个表达式
(ab): 将括号中字符作为一个分组.分组数是从左到右的方式进行分配的，最左边的是第一个分组，依次类推
\num: 引用分组num匹配到的字符串
(?P<name>): 分组起别名
(?P=name): 引用别名为name分组匹配到的字符串
"""

# \1也是一个特殊字符，所以用\\1转义，表示引用第一个分组
html_tag = re.match("<([a-zA-Z1-6]+)>.*</\\1>", "<html>hh</html>")
if html_tag:
    print(html_tag.group())
else:
    print("匹配失败")
# 分组起别名
match_obj = re.match("<(?P<name1>[a-zA-Z1-6]+)><(?P<name2>[a-zA-Z1-6]+)>.*</(?P=name2)></(?P=name1)>", "<html><h1>www.itcast.cn</h1></html>")
if match_obj:
    print(match_obj.group())
else:
    print("匹配失败")
```

# 编码经验

1. Generally, choose to write the simplest loop possible(the one with the fewest details) for all your code.

2. Note that exception handling is very powerful, but should be avoided if a boolean test can easily determine whether a computation will fail. For example.

   ```python
   l = [...]
   if (0 <= i < len(l))
   	print(l[i])
   # is preferred to
   try:
   	print(l[i])
   except IndexError:
   	pass
   ```

   

   

