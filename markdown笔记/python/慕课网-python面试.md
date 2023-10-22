# python语言基础 

python是强类型动态语言（JS是弱类型）。强类型指的是不会发生隐式转换，动态指的是编译器还是运行期确定类型

**动态语言**

- duck typing：关注对象的行为，而不是类型。比如`file`,`StringIO`,`socket`对象都支持`read`/`write`方法(file like object)
- monkey patch：运行时替换，比如gevent库需要修改内置的socket
  - `from gevent import monkey; monkey.patch_socket()`

- introspection：运行时判断一个对象的类型的能力
  - `type`/`id`/`isinstance`
  - `inspect`模块提供了更多获取对象 信息的函数

**作为后端语言的优缺点**

- 胶水语言，轮子多
- 语言灵活
- 性能问题，代码维护问题

**the Zen of Python**

`import this`

## python2/python3差异

 `pyenv shell 2.7.13 `手动测试查看差异

### python3改进

1. `print`成为函数
2. 编码问题。python3不再有unicode对象，默认str就是unicode
3. 除法变化。python3除号返回浮点数
4. 类型注解(type hint)。帮助ide实现类型检查
   - `def hello(name: str) -> str:`
5. 优化的`super()`方便直接调用父类函数
   - `super.hello()`
6. 高级解包操作。`a, b, *rest = range(10)`
   - `a, b, *_ = range(5)`
7. keyword only arguments。限定关键字参数
   - `def add(a, b, *, c)`
   - `add(1, 2, c=3)`
8. chained exceptions。python3重新抛出异常不会丢失栈信息
   - error -> error 
9. 一切返回迭代器(iterators)：`range`/`zip`/`map`/`dict.values`
   - 懒加载迭代器**节省内存**
10. `yield from`链接子生成器
11. `asyncio`内置库，`async/await`原生协程支持异步编程
12. 新的内置库`enum`/`mock`/`asyncio`/`ipaddress`/`concurrent.futures`
13. 生成的pyc文件统一放到`__pycache__`
14. 一些内置库的修改。`urllib`/`selector`

```python
s = u'中文'
type(s) # unicode

s = '中文'
type(s) # str
```

### 兼容2、3的工具

`six`模块，2to3等工具转换代码，`__future__`模块

## python函数常考题

### python如何传递参数？

python不是通过引用传递也不是通过值传递，唯一支持的参数传递是共享传参(call by object/call by sharing/call by object reference)。函数形参获得实参中各个引用的副本

默认参数只计算一次

```python
def flist(l=[1]):
    l.append(1)
    print(l)

flist() # [1,1]
flist() # [1,1,1]

def clear_list(l):
    l = []

l = [1, 2, 3]
clear_list(l)
print(l) # [1,2,3]
```

### python中`*args`,`**kwargs`含义是什么

用来处理可变参数，`*args`被打包成tuple。`**kwargs`被打包成dict

```python
def printf(*args, **kwargs):
    if args: print(args)
    if kwargs: print(kwargs)

printf(a=1,b=2)
printf(**dict(a=1,b=2))
printf(1,2)
printf(*[1,2])

```

## python类、元类和继承

- 优先使用组合而非继承
- 私有属性`self._age`，魔法函数`__len__`
- 静态变量由所有示例共享，实例对象由实例单独占有  
- 类方法`@classmethod`和静态方法`@staticmethod`
- 元类
  - 了解使用`type`方法等价定义
  - 自己写一个元类`class LowercaseMeta(type)`并重写`__new__`方法
  - 使用`class LowercaseClass(metaclass=LowercaseMeta)`
  - `print(dir(LowercaseClass))`

## python异常处理

- BaseException
- SystemExit/KeyboardInterrupt/GeneratorExit
- Exception, other exceptions are inherted from this, and our custom exception

**如何自定义异常**

- 继承 Exception 实现自定义异常（想想为什么不是BaseException)
- 给异常加上一些附加信息
- 处理一些业务相关的特定异常（raise MyException)

**常见异常**

- 网络请求（超时，连接错误）
- 资源访问（权限问题，资源不存在）
- 代码逻辑（越界访问，KeyError等）

# 性能分析与优化和GIL

GIL: Global Interpreter Lock

- Cpython解释器的内存管理并不是线程安全的，为了保护多线程情况下对Python对象的访问，Cpython使用简单的锁机制避免多个线程同时执行字节码
- 限制了程序的多核执行，同一个时间只能有一个线程执行字节码。CPU（计算）密集程序难以利用多核优势。IO（网络传输，耗时，不密集）期间会释放GIL，对IO密集程序影响不大
  - 这是因为通常，CPU的密集计算更需要依赖多核支持，而IO密集型即便在有锁的情况下，不需要多核支持也可以正常运行
  - 如何规避GIL影响：CPU密集可以使用多进程+进程池。IO密集使用多线程/协程，使用cython扩展
  
- 一个操作如果是一个字节码指令可以完成就是原子的，原子的是可以保证线程安全的
  - 使用dis模块来分析字节码: `dis.dis(函数名)`
  - 非原子操作不是线程安全的，可以加`lock`

<img src="../../图片笔记/Python/python面试/原子操作.jpg" style="zoom:50%;" />

```python
import dis
def incr_list(l):
    l[0] += 1
print(dis.dis(incr_list))
```

## 如何剖析程序性能

可以使用内置的`profile`/`cprofile`，或者uber开源的pyflame分析程序性能

## 服务端性能优化措施

1. 数据结构与算法优化
2. 数据库层：索引优化，慢查询消除，批量操作减少IO，NoSQL
3. 网络IO：批量操作，pipeline操作 减少IO
4. 缓存：使用内存数据库 redis/memcached
5. 异步：asyncio，celery
6. 并发：gevent/多线程

> 异步（Asynchronous）和并发（Concurrency）是计算机科学和软件工程中常用的两个术语，它们描述的是程序或系统处理多个任务的方式。虽然它们经常一起使用，但它们的意思是不同的。
>
> 1. **并发 (Concurrency)**
>    - 并发是同时处理多个任务的能力。这并不意味着多个任务在同一时刻真正同时执行（例如，在单核CPU上），而是在短时间内交替处理多个任务，使它们看起来好像是同时执行的。
>    - 并发可以在单核或多核处理器上实现。在多核处理器上，真正的同时执行是可能的，因为每个核心可以独立地运行不同的任务。
>    - 并发的目标是最大限度地利用系统资源，提高效率和响应性。
> 2. **异步 (Asynchronous)**
>    - 异步是一种处理方式，其中任务启动后会继续进行，不必等待前一个任务完成。异步编程中，你可能会启动一个操作（例如网络请求），而不立即等待它完成，而是继续其他工作。当操作完成时，通常会通过回调、Promise、async/await等机制来通知你。
>    - 异步的核心思想是非阻塞，意味着代码执行时不会因为某些长时间运行的任务而被卡住。
>    - 异步通常用于I/O密集型操作，如网络请求、文件操作等，因为这些操作可能需要很长时间才能完成，而不必使整个系统或应用等待。
>
> **区别**:
>
> - 并发关注于同时处理多个任务（无论是真正的“同时”还是看起来像是“同时”），而异步关注于不必等待任务完成就继续执行其他任务。
> - 异步并不总是意味着并发。例如，你可以异步启动一个任务，但在它完成之前不启动其他任务。这是异步，但不是并发。
> - 并发也不总是异步的。例如，在多线程环境中，你可能会有多个线程真正地同时执行任务。这是并发的，但这些线程可能并不是异步运行的。
>
> 尽管有这些区别，异步和并发在实践中经常一起使用，因为它们都是处理多任务和提高程序响应性和效率的有效方法。

# 生成器与协程

跳过，请参考流畅的python协程之后的所有内筒，包括元类和元编程

## 操作系统进程和线程

- 进程是对运行时程序的封装，是系统资源调度和分配的基本单位 
- 线程是进程的子任务, cpu 调度和分配的基本单位，实现进程内并发
- 一个进程可以包含多个线程，线程依赖进程存在，并共享进程内存 

## 什么是线程安全

- 一个操作可以在多线程环境中安全使用，获取正确的结果 
- 线程安全的操作好比线程是顺序执行而不是并发执行的(i += 1)
- 一般如果涉及到写操作需要考虑如何让多个线程安全访问数据 

## 线程同步的方式

1. 互斥量（锁）: 通过互斥机制防止多个线程同时访问公共资源 
2. 信号量(Semphare):控制同一时刻多个线程访问同一个资源的线程数
3. 事件(信号): 通过通知的方式保持多个线程同步

## 进程间通信的方式

1. 管道/匿名管道/有名管道(pipe) 
2. 信号(Signal): 比如用户使用Ctrl+c 产生 SIGINT 程序终止信号
3. 消息队列 (Message)
4. 共享内存(share memory) 
5. 信号量(Semaphore)
6. 套接字 (socket)：最常用的方式，我们的 web 应用都是这种方式

# 单元测试

单元测试相关库

- `nose`/`pytest`较为常用
- `mock`模块用来模拟替换网络请求等
- `ucoverage`统计测试覆盖率

# 设计模式

## 创建型设计模式

- 工厂模式factory: 解决对象创建问题
- 构造模式builder: 控制复杂对象的创建
  - u创建和表示分离。比如你要买电脑，工厂模式直接给你需要的电脑，但是构造模式允许你自己定义电脑的配置，组装完成后给你
- 原型模式prototype: 通过原型的克隆创建新的实例
  - 可以使用相同的原型，通过修改部分属性来创建新的示例，对于一些创建实例开销比较高的地方可以用原型模式
- 单例模式singleton: 一个类创建出来的对象都是同一个
  - 使用共享同一个实例的方式来创建单例模式
- 对象池模式pool: 预先分配同一类型的一组实例
- 惰性计算模式lazy evaluation: 延迟计算(python 的property)

## 结构性设计模式

- 装饰器模式(Decorator): 无需子类化扩展对象功能
- 代理模式(Proxy): 把一个对象的操作代理到另一个对象
- 适配器模式(Adapter)：通过一个间接层适配统一接口
- 外观模式(Facade): 简化复杂对象的访问问题
- 享元模式(Flyweight): 通过对象复用(池)改善资源利用，比如连接池
- Model-View-Controller(MVC)：解耦展示逻辑和业务逻辑

## 行为性设计模式

- 迭代器模式(Iterator): 通过统一的接口迭代对象 
- 观察者模式(Observer):对象发生改变的时候，观察者执行相应动作
  - 发布订阅是一种最常用的实现方式
  - 发布订阅用于解耦逻辑
  - 可以通过回调等方式实现，当发生事件时，调用相应的回调函数
- 策略模式(Strategy): 针对不同规模输入使用不同的策略 
  - 根据不同的输入采用不同的策略
  - 比如买东西超过10个打八折，超过20个打七折
  - 对外暴露统一的接口，内部采用不同的策略计算

# Linux常见命令

```bash
# 文件/目录操作命令
chown chmod chgrp
rename
locate find grep

# 进程操作
top htop

# 内存操作
free

# 网络操作
lsof
tcpdump

# 用户/组操作命令
useradd usermod
groupadd groupmod
```

# 整理

跳过第8章和第4章，目前整理至第7章开头

 ```
 import tldr # linux命令
 
 很多模板引擎都有转义操作，python的http模块也可以=通过escape和unescape转义，防止XSS
 python的from pprint import pprint
 gunicorn提供gevent, asynoic
 from wsgiref.simple_server import make_server
 from functools import wraps
 
 import hashlib
 url = "www.baidu.com"
 hashlib.md5(url.encode()).hexdigest()
 
 divmod()
 from flask import Flask, jsonify, render_template, request
 from flask_mysqldb import MySQL
 from flask.ext.redis import FlaskRedis
 
 
 
 
 ```

# 面试相关

## 中级工程师

- 扎实的计算机基础和丰富的项目经验
- 能独立设计和完成项目需求
- 熟悉常用 web 组件(缓存、消息队列等)，具备一定的系统设计能力

## 软技能

- 具有产品意识，技术引导产品
- 沟通交流能力，团队协作能力
- 技术领导能力和影响力 

## STAR模型

- Situation: 什么情况下发生的
- Task: 你是如何明确你的任务的
- Action: 采取了什么样的行动
- Result: 结果怎么样？学到了什么

## 简历内容

- 基本信息（姓名，学校，学历，联系方式等）
- 职业技能（编程语言，框架，数据库，开发工具等）
- 关键项目经验（担任职责，用到了哪些技术）





