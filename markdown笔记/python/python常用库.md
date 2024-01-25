# 常用library

```python
from functools import reduce, accumulator
from collections import deque, Counter, OrderedDict

import itertools
import sys
import os
import calendar
import datetime

# import pyecharts
import cProfile
import Cython
# import PyPy

from pprint import pprint
import hashlib
from tqdm import tqdm
import inspect
import streamlit
```

deque和PQ的区别

> Python 中 `collections` 库的 `deque` 类和 `queue` 库的 `PriorityQueue` 类具有不同的特性和用途：
>
> 1. **deque (双端队列)**:
>    - 属于 `collections` 模块。
>    - 支持从两端快速添加 (`append`) 和移除 (`pop`) 元素。
>    - 可以用作普通队列或栈。
>    - 不是线程安全的，但提供了 `collections.deque` 的线程安全版本，即 `queue.Queue` 和 `queue.LifoQueue`。
>    - 适用于需要快速访问两端元素的场景。
> 2. **PriorityQueue (优先队列)**:
>    - 属于 `queue` 模块，而非 `collections`。
>    - 元素按优先级顺序排列，优先级最低的元素首先被移除。
>    - 线程安全，适用于多线程编程。
>    - 适用于需要元素按一定顺序处理的场景，如调度任务。
>
> 简而言之，`deque` 是一个快速的双端队列，而 `PriorityQueue` 是一个线程安全的队列，用于处理有优先级的元素。

是否因为多线程中有单独的Queue，因此PQ是线程安全的，但是deque不是？

# 命令行使用

```bash
pip install tldr
pip install coverage
```

# argparse

`argparse` 是 Python 标准库中的一个模块，用于编写命令行接口。它使得创建用户友好的命令行界面变得简单。通过 `argparse`，你可以轻松地为你的程序添加位置参数、可选参数、默认值，并自动生成帮助和使用消息，提高用户交互的便捷性。

主要特点和用法包括：

1. **解析命令行参数**：`argparse` 能够处理各种类型的命令行参数，并将其转换为 Python 数据类型。
2. **自动生成帮助和使用说明**：通过使用 `argparse`，你的程序可以自动生成 `-h` 或 `--help` 选项，显示程序的使用说明和参数描述。
3. **支持位置和可选参数**：你可以定义位置参数（必须提供的参数）和可选参数（可省略的参数，通常以 `-` 或 `--` 开头）。
4. **自定义行为**：`argparse` 允许自定义各种行为，例如定义参数类型、设置默认值、指定参数是可选还是必需的等。
5. **错误处理**：如果提供了无效的参数，`argparse` 将自动显示错误信息并打印程序使用说明。

下面是一个简单的 `argparse` 使用示例，该示例创建了一个解析命令行参数的脚本：

```python
import argparse
# 创建 ArgumentParser 对象
parser = argparse.ArgumentParser(description='示例程序')
# 添加位置参数
parser.add_argument('echo', help='显示输入的字符串')
# 添加可选参数
parser.add_argument('--verbosity', help='增加输出详细性', action='store_true')
# 解析参数
args = parser.parse_args()
# 输出结果
if args.verbosity:
    print(f"你输入了: {args.echo}")
else:
    print(args.echo)
```

在这个例子中，程序定义了一个位置参数 `echo` 和一个可选参数 `--verbosity`。如果你在命令行中运行这个脚本并传入相应的参数，`argparse` 将处理这些参数并将其存储在 `args` 中，供后续使用。

> argparse和sys.argv
>
> 在许多情况下，`argparse` 提供的功能比直接使用 `sys.argv` 更为强大和灵活，尤其是在创建复杂的命令行接口时。下面是一些比较 `argparse` 和 `sys.argv` 的关键点：
>
> - 使用 `sys.argv`
>
>   - `sys.argv` 是一个简单的列表，包含命令行参数的字符串。它是 Python 中处理命令行参数的最基本方式。
>
>   - 使用 `sys.argv` 需要手动解析和处理命令行参数，这在参数较少且简单时可能是可行的。
>
>   - 对于复杂的命令行参数解析，使用 `sys.argv` 可能会导致代码变得冗长、难以维护，并且容易出错。
>
> - 使用 `argparse`
>
>   - `argparse` 是一个功能强大的库，可以自动处理命令行参数的解析、类型检查、生成帮助信息等。
>
>   - 它可以轻松处理位置参数、可选参数、默认值，并支持多种参数类型（如字符串、整数、浮点数等）。
>
>   - `argparse` 还能自动生成帮助和使用说明，增加用户友好性。
>
>   - 它支持更复杂的用例，如子命令处理（类似于 Git 那样的命令行工具）。
>
> argparse和click
>
> 1. **第三方库**：`argparse`是标准库，`click` 是一个第三方库，需要通过 pip 安装。
> 2. **使用方式**：
>    - `click`使用装饰器来声明命令行接口，使得构建 CLI 的过程更为直观和声明式。参数通过装饰器参数定义，更加简洁。
>    - `argparse`通过创建 `ArgumentParser` 对象并添加参数来构建 CLI。参数定义较为详细，需要明确指定每个参数的类型、动作等。
> 3. **功能**：
>    - `click`专注于易用性和可组合性。提供了丰富的辅助功能，如颜色输出、进度条等。
>    - `argpare`提供了丰富的参数解析功能，包括位置参数、可选参数、默认值、类型转换等。支持子命令，类似于 `git` 风格的命令行工具。
> 4. **自动帮助生成**：
>    - 同样自动生成帮助和使用说明，但`click`在易用性和可读性方面通常被认为更优。
> 5. **适用场景**：
>    - `argparse` 和 `click` 都是功能强大的 CLI 构建工具。选择哪个取决于个人偏好和项目需求。
>    - 如果你倾向于使用 Python 标准库并需要详尽的参数配置，`argparse` 是一个不错的选择。
>    - 如果你偏好更简洁、直观的接口设计，且不介意添加一个外部依赖，`click` 可能更符合你的需求。





# Enum

```python
from enum import Enum, unique
class _const(object):
    class ConstError(TypeError):
         pass
    def __setattr__(self, key, value):
        if key in self.__dict__:
           raise self.ConstError("cannot rebind const: %s"%key)
        else:
            self.__dict__[key] = value
    def __getattr__(self, key):
        if key in self.__dict__:
            return self.__dict__[key]
        else:
            return None
    def __delattr__(self, key):
        if key in self.__dict__:
            raise self.ConstError("Can't unbind const const instance attribute (%s)" % key)
        raise AttributeError("const instance has no attribute '%s'" % key)

```



# ConfigParser

`ConfigParser` 是 Python 的标准库之一，用于处理配置文件。它是一个类，主要用于读取和写入常见的 `.ini` 格式的配置文件。

`.ini` 文件的基本结构是将配置分成不同的段落（sections），每个段落内包含键值对。

例如，一个简单的 `.ini` 文件可能是这样的：

```ini
[DEFAULT]
base_dir = /var/shared
debug = false

[webserver]
port = 8080
ssl = true

[database]
host = localhost
port = 5432
```

以下是如何使用 `ConfigParser`：

1. **读取配置文件**：

   ```python
   import configparser
   
   config = configparser.ConfigParser()
   config.read('path_to_config_file.ini')
   
   # 读取默认值
   base_dir = config['DEFAULT']['base_dir']
   debug = config.getboolean('DEFAULT', 'debug')
   
   # 读取webserver段落的值
   port = config.getint('webserver', 'port')
   ssl = config.getboolean('webserver', 'ssl')
   
   # 读取database段落的值
   db_host = config['database']['host']
   db_port = config.getint('database', 'port')
   ```

2. **写入配置文件**：

   ```python
   config = configparser.ConfigParser()
   
   config['DEFAULT'] = {
       'base_dir': '/var/shared',
       'debug': 'false'
   }
   
   config['webserver'] = {
       'port': '8080',
       'ssl': 'true'
   }
   
   config['database'] = {
       'host': 'localhost',
       'port': '5432'
   }
   
   with open('path_to_output_config_file.ini', 'w') as configfile:
       config.write(configfile)
   ```

3. **其他常用功能**：

   - 检查段落是否存在：`if 'section_name' in config: ...`
   - 检查某段落中的键是否存在：`if 'key' in config['section_name']: ...`
   - 获取所有段落：`sections = config.sections()`





# math

```python
import math
math.sqrt(x)
math.ceil(x)/math.floor(x)
math.cos(x)/math.sin(x)
math.log(x, base)
math.pi/math.e
```



# `logging`日志

记录程序日志信息的目的是

1. 可以很方便的了解程序的运行情况
2. 可以分析用户的操作行为、喜好等信息
3. 方便开发人员检查bug

## 日志等级

日志等级可以分为5个，从低到高分别是:

1. DEBUG：程序调试bug时使用
2. INFO：程序正常运行时使用
3. WARNING：程序未按预期运行时使用，但并不是错误，如:用户登录密码错误
4. ERROR：程序出错误时使用，如:IO操作失败
5. CRITICAL：特别严重的问题，导致程序不能再继续运行时使用，如:磁盘空间为空，一般很少使用

默认的日志级别设置为WARNING，当在WARNING或WARNING之上等级的才记录日志信息。

日志等级从低到高的顺序是: DEBUG < INFO < WARNING < ERROR < CRITICAL

## 示例

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

# os

在Python中，`os.path`模块包含了许多处理路径的实用工具函数

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
os.path.dirname(__file__) # 获取当前脚本或模块所在的目录路径。__file__是一个内置的Python变量，用于存储当前脚本或模块的文件路径。它的值是相对于当前执行的文件而言的，提供了关于当前脚本的信息
```



# sys

```python
sys.stdout.flush() # 强制将缓冲区的内容立即输出，而不是等到程序结束或缓冲区满了才输出。这在某些情况下是很有用的，特别是当你希望在程序执行过程中立即看到输出而不是等到程序结束时。
sys.stdout.flush()
```





# time / datetime / calendar

```python
import time
time.time()
time.ctime()

a = str(datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S') + ' 星期' + str(datetime.datetime.now().isoweekday()) )
print('timestamp: ', a)
```



# pymysql

注：先在用sqlalchemy

## 防止SQL注入

用户提交带有恶意的数据与SQL语句进行字符串方式的拼接，从而影响了SQL语句的语义，最终产生**数据泄露**的现象。例如：```sql = "select * from students where name = '%s';" % "黄蓉' or 1 = 1 or '"`会显示所有的数据

**如何防止SQL注入?**

SQL语句参数化

- SQL语言中的参数使用`%s`来占位，此处不是python中的字符串格式化操作
- 将SQL语句中`%s`占位所需要的参数存在一个列表中，把参数列表传递给`execute`方法中第二个参数

<img src="../../图片笔记/Python/pymysql.png" style="zoom:33%;" />

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

# xlrd 

python操作excel主要用到```xlrd```和```xlwt```这两个库，即```xlrd```是读excel，```xlwt```是写excel的库。

## 常用单元格中的数据类型

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

# xlwt

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



# socket IO多路复用模块selectors

- 事件类型：`EVENT_READ` / `EVENT_WRITE`
- `DefaultSelector`：自动根据平台选取合适的IO模型
  - `register`
  - `unregister`
  - `modify `
  - `select`
  - `close`