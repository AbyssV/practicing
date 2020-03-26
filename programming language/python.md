[TOC]

# package example

## xlwt

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

## list
```python
lst.append(item)
lst.count(item)
lst.index(item)
lst.insert(index, item)
lst.pop()
lst.remove(item)
lst.reverse()
lst.sort()
```

```python
x in lst
x not in lst
lstA + lstB
lst*n, n*lst
lst[i]
len(lst)
min(lst)
max(lst)
sum(lst)
```

### ```append``` 和```extend ```的区别

```append```: append object at end
```extend```: extends list by appending elements from the iterable

## string

```python
s.capitalize()
s.count(target)
s.find(target)
s.lower()
s.replace(old, new)
s.translate(table)
s.split(sep)
s.strip()
s.upper()
```



## math library

```python
sqrt(x)
ceil(x)
floor(x)
cos(x)
sin(x)
log(x, base)
pi
e
```



# Some techniques

## 爬虫相关

很多网站都有反爬虫的措施，对于没有headers头信息的请求一律认为是爬虫，禁止该请求的访问。因此在每次爬取网页时都需要加上headers头信息。

对于访问过于频繁的请求，客户端的IP会被禁止访问，因此设置代理可以将请求伪装成来自不同的IP，前提是要保证代理的IP地址是有效的。

[bs4库的入门介绍-博客](https://www.cnblogs.com/yuanchenqi/articles/7617280.html)

[简单教学](https://www.cnblogs.com/airnew/p/9981599.html)

## 正则表达式

[知乎的详细解释](https://www.zhihu.com/question/48219401/answer/742444326)

[菜鸟教程](https://www.runoob.com/python3/python3-reg-expressions.html)

## 一些注意点

### Python文件操作中的```a```，```a+```,```w```，```w+```几种方式的区别

```r``` 打开只读文件，该文件必须存在。

```r+``` 打开可读写的文件，该文件必须存在。

```w``` 打开只写文件，若文件存在则文件长度清为0，即该文件内容会消失。若文件不存在则建立该文件。

```w+``` 打开可读写文件，若文件存在则文件长度清为零，即该文件内容会消失。若文件不存在则建立该文件。

```a``` 以附加的方式打开只写文件。若文件不存在，则会建立该文件，如果文件存在，写入的数据会被加到文件尾，即文件原先的内容会被保留。

```a+``` 以附加方式打开可读写的文件。若文件不存在，则会建立该文件，如果文件存在，写入的数据会被加到文件尾后，即文件原先的内容会被保留。

```b```二进制读，```wb```二进制写，```rb+``` ```wb+``` ```ab+```二进制读写 



### 函数：```read()```，```readline()```，```readlines()```，```write()```，```writelines() ```

1. ```read()``` 读取整个文件到字符串变量中 
2. ```readline()``` 读取文件中的一行，然后返回整行，包括行结束符到字符串变量中 
3. ```readlines()``` 读取整个文件，返回一个字符串list，列表中的每个元素都是一个字符串，代表一行



### raw字符串（原始字符串）

如果一个字符串包含很多需要转义的字符，对每一个字符都进行转义会很麻烦。为了避免这种情况，

我们可以在字符串前面加个前缀````r```，表示这是一个 raw 字符串，里面的字符就不需要转义了。例如：

````r'\(^_^)/ \(~_~)/'```

raw字符串表示原始字符串，我对于原始的理解就是：你看到这个字符串是什么就显示什么，去掉所有字符都不进行转义，该显示啥就是啥。



### 多行显示

Python中除了可以使用单引号```' '```、双引号```" "```表示一个字符串，还可以使用三引号来表示一个字符串

''' '''。单引号和双引号不能用来表示多行显示，而三引号可以，例如：

```python
a = '''line1
line2
line3'''

print a
```

还可以将raw字符串和多行字符串结合起来使用：

```python
a = r'''\(^_^)/
\(~_
~)/'''
 
print a
```



### 字符串类型

Python中的字符串有两种类型：str类型和unicode类型

str类型采用的ASCII编码，也就是说它无法表示中文。unicode类型采用unicode编码，能够表示任意的字符，包括中文、日文、韩文等。

在python中字符串默认采用的ASCII编码，如果要显示声明为unicode类型的话，需要在字符串前面加上'u'或者'U'。

```print u'字符串'```

注意：如果中文字符串在Python环境下遇到 ```UnicodeDecodeError```，这是因为.py文件保存的格式有问题。可以在

第一行添加注释：```\` # -*- coding: utf-8 -*-```

目的是告诉Python解释器，用UTF-8编码读取源代码。然后用Notepad++ 另存为... 并选择UTF-8格式保存。

#### #!/usr/bin/python

[#!/usr/bin/python的作用](https://www.jianshu.com/p/400c612381dd) 在windows的powershell里不支持shebang



 # PyCharm

此外，如果你在条件句前忘记键入```if```，在该句子最后增添```.if```并点击```Tab```键，PyCharm 将修复该 if 条件句。该用法同样适用于```True.while```。这即是 PyCharm 的 Postfix Completion 功能，它可以帮助用户减少退格键使用次数。



# pipenv

## Installing Pipenv

Pipenv is a dependency manager for Python projects.
Use pip to install Pipenv: ```pip install --user pipenv```

> Note This does a user installation to prevent breaking any system-wide packages. 
> If **pipenv** isn’t available in your shell after installation, you’ll need to add the user base’s binary directory to your **PATH**. 

## Installing packages for your project

run ```cd myproject``` ```pipenv install requests``` Pipenv will install the Requests library and create a Pipfile for you in your project’s directory. The Pipfile is used to track which dependencies your project needs in case you need to re-install them, **such as when you share your project with others.** 

## Using installed packages

Now that Requests is installed you can create a simple main.py file to use it:
```python
import requests
response = requests.get('https://httpbin.org/ip')
print('Your IP is {0}'.format(response.json()['origin']))
```
Then you can run this script using pipenv run: ```pipenv run python main.py``` You should get output similar to this: ```Your IP is 8.8.8.8``` 

## create a virtual environment

```
python3 -m venv tutorial_env
source tutorial_env/bin/activate
```
This will create a new virtual environment in the **tutorial_env** subdirectory, and configure the current shell to use it as the **default python environment**.



# installing default packages

## Ensure pip, setuptools, and wheel are up to date

While **pip** alone is sufficient to install from pre-built binary archives, up to date copies of the **setuptools** and **wheel** projects are useful to ensure you can also install from source archives: ```python -m pip install --upgrade pip setuptools wheel```
> Python “Virtual Environments” allow Python packages to be installed **in an isolated location** for a particular application, rather than being installed globally. 
> Imagine you have an application that needs version 1 of LibFoo, but another application requires version 2. How can you use both these applications? If you install everything into /usr/lib/python3.6/site-packages (or whatever your platform’s standard location is), it’s easy to end up in a situation where you unintentionally upgrade an application that shouldn’t be upgraded.
> Or more generally, what if you want to install an application and leave it be? If an application works, any change in its libraries or the versions of those libraries can break the application.
> Also, what if you can’t install packages into the global site-packages directory? For instance, on a shared host.
> In all these cases, virtual environments can help you. They have their own installation directories and they don’t share libraries with other virtual environments.

Currently, there are two common tools for creating Python virtual environments:

- **venv** is available by default in Python 3.3 and later, and installs pip and setuptools into created virtual environments in Python 3.4 and later.
- **virtualenv** needs to be installed separately, but supports Python 2.7+ and Python 3.3+, and pip, setuptools and wheel are always installed into created virtual environments by default (regardless of Python version).

The basic usage is like so:

**Using virtualenv:**

```
virtualenv <DIR>
source <DIR>/bin/activate
```
**Using venv:**

```
python3 -m venv <DIR>
source <DIR>/bin/activate
```
>In both of the above cases, **Windows users should not use the ```source``` command, but should rather run the activate script directly from the command shell.** The use of source under Unix shells ensures that the virtual environment’s variables are set within the current shell, and not in a subprocess (which then disappears, having no useful effect).

## Use pip for Installing

To upgrade pip: ```python -m pip install --upgrade pip```

To check packages: ```pip list```

To check outdated packages: ```pip list --outdated```

Because of the conflicts between Anaconda3 and Python 3.6, I rename the ```python.exe``` under Python3.6 file to ```python3.exe```, every time I use pip, I have to type ```python3 -m pip list```

pip is the recommended installer. The most common usage of pip is to install from the Python Package Index using a requirement specifier. Generally speaking, a requirement specifier is composed of a project name followed by an optional version specifier. PEP 440 contains a full specification of the currently supported specifiers. Below are some examples.

To install the latest version of “SomeProject”: ```pip install "SomeProject"```

To install a specific version: ```pip install "SomeProject==1.4"```

To install greater than or equal to one version and less than another: ```pip install "SomeProject>=1,<2"```

To install a version that’s “compatible” with a certain version: ```pip install "SomeProject~=1.4.2"```

*In this case, this means to install any version “==1.4.*” version that’s also “>=1.4.2”.*

## Upgrading packages

Upgrade an already installed SomeProject to the latest from PyPI: ```pip install --upgrade SomeProject```

To uninstall: ```pip uninstall [options] <package> ...```


## Requirements files

Install a list of requirements specified in a Requirements File: ```pip install -r requirements.txt```

To uninstall: ```pip uninstall [options] -r <requirements file> ...```

For more information, check [python documentation](https://packaging.python.org/tutorials/installing-packages/#installing-packages)



