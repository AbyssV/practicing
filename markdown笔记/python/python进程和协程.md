# 进程和线程

## 并发和并行

- 并发: 在一段时间内交替去执行任务。
  - 例如: 对于单核cpu处理多任务,操作系统轮流让各个软件交替执行，假如:软件1执行0.01秒，切换到软件2，软件2执行0.01秒，再切换到软件3，执行0.01秒……这样反复执行下去。表面上看，每个软件都是交替执行的，但是，由于CPU的执行速度实在是太快了，我们感觉就像这些软件都在同时执行一样，这里需要注意单核cpu是并发的执行多任务的。

- 并行: 对于多核cpu处理多任务，操作系统会给cpu的每个内核安排一个执行的软件，多个内核是真正的一起执行软件。这里需要注意多核cpu是并行的执行多任务，始终有多个软件一起执行。

**任务数大于CPU的核数表示并发的去执行多任务，任务数小于等于CPU的核数表示并行的去执行多任务**

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

文件写入，文件的下载，i/o使用多线程，因为这几个任务比较耗时，不会出现锁的问题

> 1. **GIL（全局解释器锁）**: GIL 是 Python 的全局解释器锁，是 Python 设计中的一个历史遗留问题。由于 GIL 的存在，Python 的线程在同一时间只能有一个线程在执行，即使在多核 CPU 的环境下，Python 也不能利用多核实现真正的并行计算。这对于 CPU 密集型的多线程程序来说，可能会导致性能问题。
> 2. **Python 的多线程和协程**：Python 的多线程并不是协程。它们是两种不同的并发处理技术：
>    - **多线程**：Python 的 threading 模块提供了基于线程的并行化。这是操作系统级别的真实线程，并且受到 GIL 的影响，所以在 CPU 密集型任务中可能不会带来明显的性能提升，但在 I/O 密集型任务中，多线程可以提高程序的并发性，提升性能。
>    - **协程**：Python 的 asyncio 模块提供了基于协程的并发。协程是一种用户空间的轻量级线程，不需要操作系统的介入就可以实现并发。协程适合于 I/O 密集型任务，可以提高程序的并发性，提升性能。协程的执行需要在事件循环中进行，可以实现复杂的并发编程模型。
>
> GIL（全局解释器锁）实际上对 Python 的多进程并没有直接的影响。这是因为每一个 Python 进程都有自己的 Python 解释器和内存空间，因此也有自己的 GIL。这意味着每个进程都可以独立地在各自的 CPU 核心上执行，而不会受到其他进程的 GIL 的影响。
>
> 因此，Python 的多进程可以真正地并行执行，即使在 CPU 密集型任务中，也可以利用多核 CPU 来提高性能。这是与多线程（受到 GIL 影响，在多核 CPU 上无法真正并行执行）的一个主要区别。
>
> 然而，多进程的开销（如进程创建和进程间通信的开销）通常比多线程大，而且进程间的数据共享也比线程间的数据共享更为复杂。因此，在选择使用多进程还是多线程时，需要根据应用的特性和需求进行权衡。

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

![](../../图片笔记/Python/进程关系.png)

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

> 查一下with lock怎么用
>
> ```python
> lock = threading.Lock()
> 
> def add():
> with lock:
>  n[0] += 1
>  n[0] += 1
> ```
>
> 

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
"""
<_MainThread(MainThread, started 41264)>执行中
进程<Thread(dance_thread, started 36412)>执行中
张三（年龄20）第1次跳舞中...
张三（年龄20）第2次跳舞中...
张三（年龄20）第3次跳舞中...
进程<Thread(sing_thread, started 26596)>执行中
第1次唱歌中...
第2次唱歌中...
第3次唱歌中...
"""
# 不用锁也不用join()
"""
<_MainThread(MainThread, started 42856)>执行中
进程<Thread(dance_thread, started 42960)>执行中
张三（年龄20）第1次跳舞中...
进程<Thread(sing_thread, started 42964)>执行中
第1次唱歌中...
张三（年龄20）第2次跳舞中...第2次唱歌中...

张三（年龄20）第3次跳舞中...第3次唱歌中...
"""
```

### 信号量Semphare

控制同一时刻多个线程访问同一个资源的线程数 

### 事件（信号）`threading.event`

通过通知的方式保持多个线程同步

## 进程间通信的方式

Inter-Process Communication

- 管道 / 匿名管道 / 有名管道（pipe）
- 信号signal：比如用户使用ctrl+c产生SIGINT程序终止信号
- 消息队列message：kafka，rabitMQ
- 共享内存shared memory
- 信号量Semphare
- socket：最常用的方式，我们的web应用都是这种方式

什么是Semaphore和event？

> 在 Python 的 threading 模块中，`Semaphore` 和 `Event` 是两种用于线程间同步的工具。
>
> 1. **Semaphore（信号量）**: 信号量是一个更为通用的线程同步工具。它维护了一个内部计数器，可以被任何数量的线程修改。通常，这个计数器表示一种资源的数量。线程在启动前会尝试获取信号量（`Semaphore.acquire()`），如果信号量的计数器大于0，那么计数器就会减1并且线程就可以执行；否则，线程将被阻塞，直到其他线程释放信号量（`Semaphore.release()`）为止。**因此，信号量可以用来控制同一时间可以访问某一资源（如文件或网络连接）的线程数量。**
> 2. **Event（事件）**: Event 是一个简单的线程同步工具。Event 对象内部有一个标志，可以被线程设置或清除。其他线程可以等待这个标志被设置。当线程调用 `Event.wait()` 时，如果标志已经被设置，那么 `wait()` 方法会立即返回；否则，线程将被阻塞，直到其他线程设置标志（`Event.set()`）为止。因此，Event 可以用来让一个或多个线程等待某个条件被满足，或者等待某个任务完成。
>
> 这两种工具都可以用来解决线程间的同步问题，但适用的场景不同。在具体的应用中，选择哪种工具需要根据任务的特性和需求进行决定。

使用python时，web应用间通信的方式有哪些？

> Python 中的 web 应用程序间通信方式主要有以下几种：
>
> 1. **HTTP/HTTPS 请求**：这是最常见的 web 应用程序间通信的方式。一个应用可以通过发送 HTTP 或 HTTPS 请求来访问另一个应用提供的 API 接口，以获取数据或者触发某些操作。Python 中有很多库可以用来发送 HTTP 请求，如 requests、http.client 和 urllib 等。
> 2. **WebSockets**：WebSockets 提供了一种在单个 TCP 连接上进行全双工通信的方式。这种方式对于需要实时交互的应用程序非常有用，因为它允许服务器主动向客户端发送数据。Python 中有很多库可以处理 WebSocket 连接，如 websocket-client 和 websockets 等。
> 3. **RESTful API**：RESTful API 是一种软件架构风格，它定义了一组约束和属性，用于设计可扩展的 web 服务。通过使用 RESTful API，一个 web 应用可以以一种结构化的方式提供服务，使其他应用更容易访问和使用。
> 4. **gRPC**：gRPC 是一个高性能、开源的通用 RPC 框架，它可以让客户端和服务器应用程序直接进行通信。gRPC 支持多种语言，包括 Python，并且可以在一种语言编写的客户端和另一种语言编写的服务器之间进行通信。
> 5. **消息队列**：消息队列是一种异步通信方式，允许应用程序通过将消息放入队列来进行通信，而不是直接发送请求。消息队列可以帮助应用程序处理并发或者大量的数据流。Python 中有很多消息队列的库，如 RabbitMQ、Kafka、Celery 等。
>
> 以上这些都是 Python 中常见的 web 应用程序间通信的方式，每种方式都有其适用的场景，需要根据具体的需求来选择适合的通信方式。

