# HTTP协议和静态web服务器

## HTTP协议

- HTTP协议的全称是(HyperText Transfer Protocol)，翻译过来就是超文本传输协议。
- 超文本是超级文本的缩写，是指超越文本限制或者超链接，比如:图片、音乐、视频、超链接等等都属于超文本。
- 传输HTTP协议格式的数据是基于TCP传输协议的，发送数据之前需要先建立连接。
- 它规定了浏览器和Web服务器通信数据的格式，也就是说浏览器和web服务器通信需要使用http协议。

### HTTP请求报文

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

### HTTP响应报文

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

### HTTP状态码介绍

HTTP 状态码是用于表示web服务器响应状态的3位数字代码。

| 状态码 | 说明                             |
| :----- | :------------------------------- |
| 200    | 请求成功                         |
| 307    | 重定向                           |
| 400    | 错误的请求，请求地址或者参数有误 |
| 404    | 请求资源在服务器不存在           |
| 500    | 服务器内部源代码出现错误         |

### URL

URL的英文全拼是(Uniform Resoure Locator),表达的意思是统一资源定位符，通俗理解就是网络资源地址，也就是我们常说的网址。

#### URL的组成部分

https://news.163.com/hello.html?page=1&count=10

- 协议部分: `https://`（加密，端口号443）、`http://`（端口号80）、`ftp://`
- 域名部分: `news.163.com`
  - 域名: 域名就是IP地址的别名，它是用点进行分割使用英文字母和数字组成的名字，使用域名目的就是方便的记住某台主机IP地址

- 资源路径部分: `hello.html`
- 查询参数部分: `?page=1&count=10`
  - 参数说明: `?`后面的`page`表示第一个参数，后面的参数都使用`&`进行连接
  - 第1页，显示10条记录

### 使用谷歌浏览器查看HTTP协议的通信过程

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

## 静态web服务器

### python案例

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

# HTML+CSS

html是用来开发网页的，它是开发网页的语言。

前端开发三大块：1、HTML：负责网页结构 2、CSS：负责网页样式 3、JavaScript：负责网页行为， 比如:网页与用户的交互效果

## HTML标签

学习 html 语言就是学习标签的用法，常用的标签有20多个。

标签不区分大小写，但是推荐使用小写。标签可以带属性，嵌套。

根据标签的书写形式，标签分为双标签(闭合标签)和单标签(空标签)

- 双标签是指由开始标签和结束标签组成的一对标签，这种标签允许嵌套和承载内容，比如: div标签
- 单标签是一个标签组成，没有标签内容， 比如: img标签

### `<img>`资源路径

`src`属性是设置图片的资源路径的，资源路径可以分为相对路径和绝对路径。

- 从当前操作 html 的文档所在目录算起的路径叫做相对路径
  - `<img src="./images/logo.png">`
  - `<img src="images/logo.png">`

- 从根目录算起的路径叫做绝对路径，Windows 的根目录是指定的盘符，mac OS 和Linux 是`/`
  - `<img src="/Users/apple/Desktop/demo/hello/images/logo.png">`
  - `<img src="C:\demo\images\001.jpg">`。注意这里是backslash反斜杠

一般都会使用相对路径，绝对路径的操作在其它电脑上打开会有可能出现资源文件找不到的问题

同一级路径只需输入图像文件的名称即可，如`<img src="baidu.gif">;`

下一级路径用`/`，如` 如<img src="images/baidu.gif">;`

上一级路径用`../`，   如`<img src="../../../baidu.gif">;`

```html
<!DOCTYPE html> <!--文档声明, 此标签可告知浏览器文档使用哪种HTML或XHTML规范, 这里声明的是一个html5的文档-->
<html> <!--告诉浏览器，这是html文档的开始和结束标签-->
    <head> <!--用于定义文档的头部,是负责对网页进行设置标题、编码格式以及引入css和js文件的-->            
        <meta charset="UTF-8">
        <title>网页标题</title>
    </head>
    <body> <!--编写网页上显示的内容-->
          网页显示内容
    </body>
</html>
```

### 表单标签

1. `<form>`标签：表示表单标签，定义整体的表单区域
   - `action`设置表单数据提交地址
   - `method`属性设置表单提交的方式，一般有`GET`方式和`POST`方式，不区分大小写
     - `GET`方式提交数据到web服务器以`?`，`&`查询参数写在地址栏的方式提交给服务器，不安全，能看到提交的数据
     - `POST`方式提交数据表单数据会放到请求体里面
     - get和post方式提交表单数据都是以http协议的方式提交数据给web服务器
2. `<label>`标签：表示表单元素的文字标注标签，定义文字标注
3. `<input>`标签：表示表单元素的用户输入标签，定义不同类型的用户输入数据方式
   - `type`属性
     - `type="text"` 定义单行文本输入框
     - `type="password"` 定义密码输入框
     - `type="radio"` 定义单选框。同一组的单选按钮，`name`取值一定要一致，这样同一组的单选按钮才能起到单选的效果
     - `type="checkbox"` 定义复选框
     - `type="file"` 定义上传文件
     - `type="submit"` 定义提交按钮
     - `type="reset"` 定义重置按钮
     - `type="button"` 定义一个普通按钮
   - `name`属性设置表单元素的名称，该名称是提交数据时的参数名
   - `value`属性设置表单元素的值，该值是提交数据时参数名所对应的值
4. `<textarea>`标签 表示表单元素的多行文本输入框标签 定义多行文本输入框
5. `<select>`标签 表示表单元素的下拉列表标签 定义下拉列表
   - `<option>`标签 与`<select>`标签配合，定义下拉列表中的选项

### 代码

```html
<!-- 输入!后按住回车，自动生成骨架 -->
<!DOCTYPE html> <!-- 文档声明, 用来指定页面所使用的html的版本, 这里声明的是一个html5的文档 -->
<!-- 当前网页的语言是英文，默认不指定时中文，lang="en" -->
<html lang="zh"> <!-- 告诉浏览器，这是html文档的开始和结束标签 -->
<head> <!-- 用于定义文档的头部,是负责对网页进行设置标题、编码格式以及引入css和js文件的 -->
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"> <!-- 在IE浏览器浏览网页时，使用IE的最高版本 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- 在移动设备浏览网页时，网页不缩放 -->
    <title>HTML学习</title>
    <style type = "text/css">
        span{
            color: green;
        }
    
    </style>
</head>

<body> <!-- 编写网页上显示的内容 -->
    <!-- 1、成对出现的标签：-->
    <h1><span>常用</span>标签</h1>
    <p>这个一个<em>段落标签</em></p>
    <p>段落标签<strong>独占一行</strong></p>
    <q>这是一段引用，引用标签不能独占一行，<del>自带引号</del></q><br>
    <blockquote>
        blockquote元素是可以<ins>独占一行的</ins>，
        于是我在这里写了一首十四行诗，
        每一首诗都是你的名字，
        写在了我的心上。
    </blockquote>
    让我写一段简短的代码 <code>print("code标签不能独占一行")</code>代码结束<br>
    但是长代码是可以独占一行的
    <pre>
        import threading
        sub_thread = threading.Thread(target = task)
        sub_thread.start()
    </pre>
    代码结束<br>
    <address>地址标签也可以独占一行</address>
    <a href="mailto: nbsktyzdjdg@163.com?cc=carefreebamboo@163.com&
    subject=这是一封测试邮件&body=你用代码发的">给我发个邮件吧，注意a标签不能独占一行</a><br>
    <a href="http://www.baidu.com", title="点击打开度娘", target="_blank">垃圾百度网</a>
    <a href="#">没有确定链接目标，表示该链接暂时为一个空链接</a>
    <hr>
    <h1><span>列表</span>标签</h1> 
    <!-- 无序列表 -->
    <ul>你最喜欢的动漫人物 
        <li>宇智波佐助</li>
        <li>吉良吉影</li>
        <li>御坂美琴</li>
    </ul>
    <!-- 有序列表 -->
    <ol>你最喜欢的作家
        <li>张爱玲</li>
        <li>沈从文</li>
        <li>朱自清</li>
    </ol>
    <hr>
    <h1><span>表格</span>标签</h1>
    <!-- border-collapse 设置表格的边线合并 -->
    <table style="border: 1px solid green; border-collapse: collapse;"> 
        <caption>3行2列的表格</caption> <!-- 标题文本 -->
        <th style="border: 1px solid green;">姓名</th> <!-- 表格中的表头 -->
        <th style="border: 1px solid green;">年龄</th>
        <tr>  <!-- 表格中的一行 -->
            <td>张三</td>  <!-- 表格中的列 -->
            <td>10</td>
        </tr>
        <tr>
            <td>李四</td> 
            <td>20</td>
        </tr>
        <tr>
            <td>Anglababy</td>
            <td>30</td>
        </tr>
    </table>
    <hr>
    <h1><span>表单</span>标签</h1>
    <form action="https://www.baidu.com" method="post"> <!-- label，input标签是不换行的 -->
        <p>
            <!-- label标签不会向用户呈现任何特殊效果，它的作用是为鼠标用户改进了可用性。如果你在label标签内点击文本，就会触发此控件。就是说，当用户单击选中该label标签时，浏览器就会自动将焦点转到和标签相关的表单控件上（就自动选中和该label标签相关联的表单控件上 -->
            <label for="username">姓名：</label><input type="text" id="username" name="username" value="张三">
        </p>
        <p>
            <label>密码：</label><input type="password" name="password">
        </p>
        <p>
            <!-- value: 提交数据到服务器的值 name: 为控件命名 以备后台程序ASP，PHP使用 -->
            <!-- 同一组的单选按钮，name取值一定要一致，这样同一组的单选按钮才能起到单选的效果 -->
            <label>性别：</label>
            <input type="radio" name="gender" value="0"> 男
            <input type="radio" name="gender" value="1"> 女
        </p>
        <p>
            <label>请输入您的邮箱地址</label>
            <input type="email" placeholder="输入邮箱地址">
        </p>
        <p>
            <label>爱好：</label>
            <input type="checkbox" checked="checked" name="hobby" value="sing"> 唱歌
            <input type="checkbox" name="hobby" value="run"> 跑步
            <input type="checkbox" name="hobby" value="swim"> 游泳
        </p>
        <p>
            <label>照片：</label>
            <input type="file" name="person_pic">
        </p>
        <p>
            <label>个人描述：</label>
            <textarea cols="100" rows="20" name="description">在这里输入您的个人描述</textarea>
        </p>
        <p>
            <label>籍贯：</label>
            <select multiple="multiple" name="hometown">
                <option selected="selected" value="北京">北京</option>
                <option value="上海">上海</option>
                <option value="广州">广州</option>
                <option value="深圳">深圳</option>
            </select>
        </p>
        <p>
            <input type="submit" value="提交">
            <input type="reset" value="重置">
            <br>
            <input type="button" value="点点点">
        </p>
    </form>
    <hr>
    <h1><span>img</span>标签</h1>
    <div>这是一个div容器标签，可以包裹其他内容
        <img src="沐樱.png" alt="图片无法显示", title="沐樱真漂亮">
        <img src="沐樱.png" alt="图片无法显示", title="乖乖很可爱">
    </div>
</body>
</html>
```

## CSS

css(Cascading Style Sheet)层叠样式表，它是用来美化页面的一种语言。

css的作用：

- 美化界面, 比如: 设置标签文字大小、颜色、字体加粗等样式。
- 控制页面布局, 比如: 设置浮动、定位等样式。

### CSS的三种引入方式

- 内联式css样式，直接写在现有的HTML标签中
  - 优点：方便、直观。 
  - 缺点：缺乏可重用性。
  - 行内式几乎不用

- 嵌入式css样式，写在当前的文件中
  - 把css样式代码写在`<style type="text/css"></style> `标签之间。嵌入式css样式必须写在`<style></style> `之间，并且一般情况下嵌入式css样式写在`<head></head> `之间。
  - 优点：在同一个页面内部便于复用和维护。 
  - 缺点：在多个页面之间的可重用性不够高。
  - 内嵌式在学习css样式的阶段使用

- 外部式css样式，写在单独的一个文件中
  - 把css代码写一个单独的外部文件中，这个css样式文件以`.css `为扩展名，在`<head>` 内。使用`<link> `标签将css样式文件链接到HTML文件内。
  - 可以在VSC中输入`link:css`快速输入框架
  - 优点：使得css样式与html页面分离，便于整个页面系统的规划和维护，可重用性高。 
  - 缺点：css代码由于分离到单独的css文件，容易出现css代码过于集中，若维护不当则极容易造成混乱。
  - 外链式在公司开发的阶段使用，可以对 css 样式和 html 页面分别进行开发。

```html
<head>
    ...
    <title>CSS学习</title>
    <!-- 输入link:css自动生成 -->
    <link href="css/main.css" rel="stylesheet" type="text/css"> <!-- 外部式 -->
    <style type="text/css"> <!-- 嵌入式 -->
        a {
            color: green;
        }
    </style>
</head>

<body>
    <h1>CSS样式表的三种使用方法</h1>
    <p style="color:red;background:green;font-size:1 12px;">这里文字是红色。</p> <!-- 内联式 -->
    <p><a href="https://www.baidu.com" title="我是绿色的">百度</a></p>
</body>
```

#### 优先级

在相同权值的情况下，**内联式 > 嵌入式 > 外部式**。但是嵌入式 > 外部式有一个前提：嵌入式css样式的位置一定在外部式的后面。其实总结来说，就是就近原则（离被设置元素越近优先级别越高）。

### CSS选择器

1. 标签选择器

   - 根据标签来选择标签，仅以标签开头
   - `p{color:red;}`
   - 此种选择器影响范围大，一般用来做一些通用设置
2. 类选择器

   - 以英文圆点` .`开头，类选择器可以任意起名。在标签内用`class="类选择器名称"`为标签应用一个类的样式
   - `.blue{color:blue}.box{width:100px;height:100px;background:gold}(...)<p class="blue box">...</p>`
   - 一个类选择器可应用于多个标签上，一个标签上也可以使用多个类选择器，多个类选择器需要使用空格分割，应用灵活，可复用，是css中应用最多的一种选择器
3. id选择器

   - 以`#`开头。在标签内使用`id="id名称"`为标签应用一个id的样式。
   - `#box{color:red}(...)<p id="box">...</p>`
   - 在一个HTML文档中，ID选择器仅能使用一次，而类选择器可以使用多次
   - 类选择器可以为一个标签设置多个类的样式，而id选择器不可以
   - 不推荐使用id作为选择器，在HTML文档中标签的id是唯一的，不能重复，后续js会通过id获取对应的标签对象
4. 后代选择器

   - 加入空格，以`选择器1 选择器2`开头，根据层级关系选择后代标签
   - `.con{width:300px;height:80px;background:green}(...).con .pink{color:pink}.con span{color:red}`
   - 主要应用在标签嵌套的结构中，减少命名。
   - 这个层级关系不一定是父子关系，也有可能是祖孙关系，只要有后代关系都适用于这个层级选择器
5. 子选择器
   - 使用大于符号`>`，用于选择指定标签元素的第一代子元素
   - `.first span{color:red;}`
   - 子选择器仅是指它的直接后代，或者说是第一代后代。而后代选择器是作用于所有子后代元素。
6. 分组选择器

   - 将多个选择器以`,`分割开
   - `.box1,.box2,.box3{width:100px;height:100px}`
   - 如果有公共的样式设置，可以使用组选择器。
7. 伪类选择器

   -  以 `: `分割开
   -  `.box1{width:100px;height:100px;background:gold;}(...).box1:hover{width:300px;}`
   - 用于向选择器添加特殊的效果， 当用户和网站交互的时候改变显示效果可以使用伪类选择器
8. 通用选择器
   - 使用一个`*`号指定，作用是匹配html中所有标签元素。使用下面代码设置html中任意标签元素字体颜色为红色
   - `* {color:red;}`

### CSS的继承，层叠和特殊性

#### 继承

继承是一种规则，它允许样式不仅应用于某个特定html标签元素，而且应用于其后代。但注意有一些css样式是不具有继承性
的。如`border:1px solid red;`

#### 特殊性

浏览器是根据权值来判断使用哪种css样式的，权值高的就使用哪种css样式。

下面是权值的规则：标签的权值为1，类选择符的权值为10，ID选择符的权值最高为100。

例如下面的代码：

```css
p{color:red;} /*权值为1*/
p span{color:green;} /*权值为1+1=2*/
.warning{color:white;} /*权值为10*/
p span .warning{color:purple;} /*权值为1+1+10=12*/
/*tested: span.warning与.warning span不同*/
#footer .note p{color:yellow;} /*权值为100+10+1=111*/
```

注意：还有一个权值比较特殊--继承也有权值但很低，有的文献提出它只有0.1，所以可以理解为继承的权值最低。

#### 层叠

层叠就是在html文件中对于同一个元素可以有多个css样式存在，当有相同权重的样式存在时，会根据这些css样式的前后顺序来决定，处于最后面的css样式会被应用。

#### 重要性

使用`!important`设置最高权值

```css
p{color:red!important;}
p{color:green;}
<p class="first">三年级时，我还是一个<span>胆小如鼠</span>的小女孩。</p> /* 文本显示为红色 */
```

注意：`!important`要写在分号的前面

这里注意当网页制作者不设置css样式时，浏览器会按照自己的一套样式来显示网页。并且用户也可以在浏览器中设置自己习惯的样式，比如有的用户习惯把字号设置为大一些，使其查看网页的文本更加清楚。这时注意样式优先级为：**浏览器默认的样式 < 网页制作者样式 < 用户自己设置的样式**，但记住`!important`优先级样式是个例外，权值高于用户自己设置的样式。



### CSS文本常用样式属性

#### 文本常用样式属性

- `color`：设置文字的颜色，如：`color:red;`
- `font-size`：设置文字的大小，如：`font-size:12px;`
- `font-family`：设置文字的字体，如：`font-family:'微软雅黑';`。为了避免中文字不兼容，一般写成：`font-family:'Microsoft Yahei';`
- `font-weight`：设置文字是否加粗，如：`font-weight:bold;` 设置加粗， `font-weight:normal` 设置不加粗
- `line-height`：设置文字的行高，如：`line-height:24px;` 表示文字高度加上文字上下的间距是24px，也就是每一行占有的高度是24px
- `text-decoration`： 设置文字的下划线，如：`text-decoration:none;` 将文字下划线去掉
- `text-align`：设置文字水平对齐方式，如`text-align:center` 设置文字水平居中
- `text-indent`： 设置文字首行缩进，如：`text-indent:24px;` 设置文字首行缩进24px

```css
.h_demo {
    /* 文字排版 */
    /* font: "Microsoft Yahei","Consolas",sans-serif italic bold small-caps bold 12px/2em; */
    font-family:"Microsoft Yahei","Consolas",sans-serif; /* 微软雅黑 */
    font-size: 12px;
    color:#666;
    background-color: beige;
    font-weight: bold; /* font-weight: normal; */
    font-style: italic;
    text-decoration: underline line-through overline;
    line-height: 4em; /* 表示文字高度加上文字上下的间距是48px，也就是每一行占有的高度是48px */
    text-indent: 2em; /* 设置文字首行缩进24px */
    word-spacing: 0.5em; /* 设置英文单词之间的间距为6px */
    letter-spacing: 0.5em; /* 设置中文字之间/英文字母之间的间距为6px */
    text-align: center; /* 设置文字水平居中 */
}
```

#### 布局常用样式属性

- `width`：设置元素(标签)的宽度，如：`width:100px;`
- `height`：设置元素(标签)的高度，如：`height:200px;`
- `background`：设置元素背景色或者背景图片，如：`background:gold;` 设置元素的背景色, `background: url(images/logo.png);` 设置元素的背景图片。
- `border`：设置元素四周的边框，如：`border:1px solid black;` 设置元素四周边框是1像素宽的黑色实线。也可以拆分成四个边的写法，分别设置四个边的：
  - `border-top`：设置顶边边框，如：`border-top:10px solid red;`
  - `border-left`：设置左边边框，如：`border-left:10px solid blue;`
  - `border-right`：设置右边边框，如：`border-right:10px solid green;`
  - `border-bottom`：设置底边边框，如：`border-bottom:10px solid pink;`
- `padding`：设置元素包含的内容和元素边框的距离，也叫内边距，如`padding:20px;padding`是同时设置4个边的，也可以像border一样拆分成分别设置四个边
- `margin`：设置元素和外界的距离，也叫外边距，如`margin:20px;`是同时设置4个边的，也可以像border一样拆分成分别设置四个边
- `float`：设置元素浮动，浮动可以让块元素排列在一行，浮动分为左浮动：`float:left;` 右浮动：`float:right;`

```css
.div_demo {
    width: 500px;
    height: 500px;
    background-color: chocolate;
    /* 设置背景图片，不重复显示图片，拉伸当前显示的这个图片 */
    /* background-image: url("乖乖.png") no-repeat; */
    border-top: 5px dotted green;
    border-left: 5px dotted green;
    border-right: 5px dotted green;
    border-bottom: 5px dotted green;
    float: left;
}
```

##### CSS元素溢出`overflow`

当子元素(标签)的尺寸超过父元素(标签)的尺寸时，此时需要在父标签里设置显示溢出的子元素的方式，设置的方法是通过`overflow`属性来完成。

overflow的设置项：

1. `visible`默认值, 显示子标签溢出部分。
2. `hidden`隐藏子标签溢出部分。
3. `auto`如果子标签溢出，则可以拉动滚顶条查看其余的内容。

##### CSS显示特性`display`

`display`属性是用来设置元素的类型及隐藏的，常用的属性有：

1. `none`元素隐藏且不占位置
2. `inline`元素以行内元素显示，以后就不能设置宽高。但是可以通过浮动`float`来完成
3. `block`元素以块元素显示，单独占用一行

### 元素分类

#### 块级元素

html中`< <div>`、`<p>`、`<h1>`、`<form>`、`<ul>` 和` <li>` 就是块级元素。设置`display:block`就是将元素显示为块级元素

块级元素特点：
1. 每个块级元素都从新的一行开始，并且其后的元素也另起一行。（一个块级元素独占一行）
2. 元素的高度、宽度、行高以及顶和底边距都可设置。
3. 元素宽度在不设置的情况下，是它本身父容器的100%（和父元素的宽度一致），除非设定一个
宽度。

#### 内联元素

html中， `<span>`、`<a>`、`<label>`、 `<strong>` 和`<em>`就是典型的内联元素（inline）元素。当然块状元素也可以通过代码`display:inline`将元素设置为内联元素

内联元素特点：
1. 和其他元素都在一行上；
2. 元素的高度、宽度及顶部和底部边距不可设置；
3. 元素的宽度就是它包含的文字或图片的宽度，不可改变。

#### 内联块级元素

内联块状元素（inline-block）就是同时具备内联元素、块状元素的特点，代码`display:inlineblock`就是将元素设置为内联块状元素。(css2.1新增)，`<img>`、`<input>`标签就是这种内联块状标签。

inline-block元素特点：

1. 和其他元素都在一行上；
2. 元素的高度、宽度、行高以及顶和底边距都可设置。

### 盒子模型

所谓的盒子模型就是把HTML页面的元素看作一个矩形盒子，矩形盒子是由内容(content)、内边距(padding)、边框(border)、外边距(margin)四部分组成。

- 盒子的内容宽度(width)，注意：不是盒子的宽度
- 盒子的内容高度(height)，注意：不是盒子的高度
- 盒子的边框(border)
- 盒子内的内容和边框之间的间距(padding)
- 盒子与盒子之间的间距(margin)。外边距会影响与其他盒子的距离。

**盒子的真实尺寸**

盒子的width和height值固定时，如果盒子增加border和padding，盒子整体的尺寸会变大，所以盒子的真实尺寸为：

- 盒子宽度 = width + padding左右 + border左右
- 盒子高度 = height + padding上下 + border上下

<img src="C:\Users\admin\Desktop\practicing\图片笔记\Python\hzmx.png" style="zoom:33%;" />

**简写方法**

```css
padding：20px 40px 50px 30px; /* 四个值按照顺时针方向，分别设置的是 上 右 下 左  四个方向的内边距值。 */
padding：20px 40px 50px; /* 设置顶部内边距为20px，左右内边距为40px，底部内边距为50px */ 
padding：20px 40px; /* 设置上下内边距为20px，左右内边距为40px*/ 
padding：20px; /* 设置四边内边距为20px */
p{color: #336699;} /* 可以缩写为：p{color: #369;} */
body{
    font-style:italic;
    font-variant:small-caps;
    font-weight:bold;
    font-size:12px;
    line-height:1.5em;
    font-family:"宋体",sans-serif;
}
/* 这么多行的代码其实可以缩写为一句 */
body{
	font:italic small-caps bold 12px/1.5em "宋体",sans-serif;
}
/*
注意：
1、使用这一简写方式你至少要指定font-size和font-family属性，其他的属性(如 font-weight、fontstyle、font-variant、line-height)如未指定将自动使用默认值。
2、在缩写时font-size与line-height中间要加入“/”斜扛。*/
```



# Emmet Abbreviation

```html
<!-- >> (div>div#big.box{this is son})+div.box.box2{this is brother}+div>ol.box2>li*5 -->
<div>
    <div id="big" class="box">this is son</div>
</div>
<div class="box box2">this is brother</div>
<div>
    <ol class="box2">
        <li></li>
        <li></li>
        <li></li>
        <li></li>
        <li></li>
    </ol>
</div>

<!-- >> form>input[type=button value="submit" onclick=replaceMessage()] -->
<form action=""><input type="button" value="submit" onclick="replaceMessage()"></form>

<!-- >> ul>li*3>img[src=./imgs/$.jpg][alt={img $}] -->
<ul>
    <li><img src="./imgs/1.jpg" alt={img 1}></li>
    <li><img src="./imgs/2.jpg" alt={img 2}></li>
    <li><img src="./imgs/3.jpg" alt={img 3}></li>
</ul>
<!-- >> link:css -->
<link rel="stylesheet" href="style.css">
```

# JavaScript

## JavaScript的三种使用方式

- 内联式（主要用于事件）

  - `<input type="button" name="" onclick="alert('ok！');">`

- 嵌入式

  - ```html
    <script type="text/javascript">        
        alert('ok！');
    </script>
    ```

- 外部式css样式，写在单独的一个文件中

  - `<script type="text/javascript" src="js/index.js"></script>`

我们可以将JavaScript代码放在html文件中任何位置，但是我们一般放在网页的head或者body部分。 放在`<head>`部分 最常用的方式是在页面中head部分放置`<script>`元素，浏览器解析head部分就会执行这个代码，然后才解析页面的其余部分。 放在`<body>`部分 JavaScript代码在网页读取到该语句的时候就会执行。

注意: javascript作为一种脚本语言可以放在html页面中任何位置，但是浏览器解释html时是按先后顺序的，所以前面的script就先被执行。比如进行页面显示初始化的js必须放在head里面，因为初始化都要求提前进行（如给页面body设置css等）；而如果是通过事件调用执行的function那么对位置没什么要求的。

比如使用`document.getElementById`时，该标签还没有定义，所以这个语句要写在这个标签后面

## 变量定义

JavaScript 是一种弱类型语言，也就是说不需要指定变量的类型，JavaScript的变量类型由它的值来决定， 定义变量需要用关键字`var`, 一条JavaScript语句应该以`;`结尾

定义变量的语法格式: `var 变量名 = 值;`

### 数据类型

js中有六种数据类型，包括五种基本数据类型和一种复杂数据类型(object)。

5种基本数据类型：

1. `number`：数字类型
2. `string`：字符串类型
3. `boolean`：布尔类型 true 或 false
4. `undefined`：undefined类型，变量声明未初始化，它的值就是undefined
5. `null`：null类型，表示空对象，如果定义的变量将来准备保存对象，可以将变量初始化为null,在页面上获取不到对象，返回的值就是null

1种复合类型：

1. object 后面学习的**数组、函数和JavaScript对象**都属于复合类型

```javascript
 //同时定义多个变量可以用","隔开，公用一个‘var’关键字
var iNum = 45,sTr='qwe',sCount='68';
//1.1 数字 number
var iOne = 10.1;
//1.2 字符串 string
var sStr = '1234';
//1.3 布尔 boolean; 
var bIsTrue = false;
//1.4 未定义 undefined
var unData;
//1.5 null 表示空对象
var nullData = null;
//1.6 object 表示对象类型
var oObj = {
   name:"隔壁老王",
   age:88
}
//创建数组
//数组存储的数据可以是任何类型（数字、字符、布尔值等）。js里不支持负数下标 
var aList = new Array(1,2,3);
var aList2 = [[1,2,3],['a','b','c']];
var aList3 = new Array(8) //即使指定了长度为8，仍然可以将元素存储在规定长度以外。
aList[6]=10;
document.write("数组的长度是："+aList.length); //数组的长度是：7
// 获取变量的类型
/* 由于js历史原因，设计之前没有null类型，null值归属于object类型，后续js语言迭代后也没进行修改 */
var type = typeof(oObj);
alert(type);
// 获取对象的name属性
console.log(oObj.name);
```

### 变量命名规范

- 区分大小写
- 第一个字符必须是字母、下划线（`_`）或者美元符号（`$`）
- 其他字符可以是字母、下划线、美元符或数字
- 不能使用JavaScript关键词与JavaScript保留字
- 变量虽然也可以不声明，直接使用，但不规范，需要先声明，后使用

### 匈牙利命名风格

- 对象o Object 比如：oDiv
- 数组a Array 比如：aItems
- 字符串s String 比如：sUserName
- 整数i Integer 比如：iItemCount
- 布尔值b Boolean 比如：bIsComplete
- 浮点数f Float 比如：fPrice
- 函数fn Function 比如：fnHandler

### JavaScript对象

JavaScript 中的所有事物都是对象：字符串、数值、数组、函数等都可以认为是对象，此外，JavaScript 允许自定义对象，对象可以拥有属性和方法。

创建自定义javascript对象有两种方式:

1. 通过顶级Object类型来实例化一个对象
2. 通过对象字面量创建一个对象

```javascript
// Object类创建对象的示例代码:
<script>
    var oPerson = new Object();
    // 添加属性：
    oPerson.name = 'tom';
    oPerson.age = '25';
    // 添加方法：
    oPerson.sayName = function(){
        alert(this.name);
    }
    // 调用属性和方法：
    alert(oPerson.age);
    oPerson.sayName();
</script>
// 对象字面量创建对象的示例代码:
<script>
    var oPerson2 = {
        name:'Rose',
        age: 18,
        sayName:function(){
            alert('My name is' + this.name);
        }
    }
    // 调用属性和方法：
    alert(oPerson2.age);
    oPerson2.sayName();
</script>
```

## 变量作用域

变量作用域就是变量的使用范围，变量分为:

- 局部变量：在函数内使用的变量，只能在函数内部使用。
- 全局变量：在函数外定义的变量，可以在不同函数内使用。并且不同函数内可以共享全局变量。

```html
<script type="text/javascript">
    /* 函数调用：
    函数中'return'关键字的作用:
    1、返回函数中的值
    2、执行完return函数执行结束
    */
    var iNum = 1;
    function fnAdd(iNum01,iNum02){
        var iRs = iNum01 + iNum02; //var就相当于找盒子的动作，在JavaScript中是关键字（即保留字），这个关键字的作用是声明变量，并为"变量"准备位置(即内存）
        return iRs;
        alert('here!');
    }
    function fnModify(){
        iNum++;
    }
    var iCount = fnAdd(3,4);
    alert(iCount);  //弹出7
    // js可以将数字类型和字符串类型直接进行拼接，底层自动把数字类型转成字符串（隐式类型转换）
    alert("函数外访问的全局变量":+iNum) //弹出2
</script>
<script type="text/javascript">
    //计时器
    var num=0;
    var stop=0;
    function numCount(){
        document.getElementById('clocker').value=num;
        num++;
        stop = setTimeout("numCount()", 1000);
}
    function stopClocker(){
        // 销毁定时器，返回值表示创建定时器返回的id，通俗理解就是创建的第几个定时器
        clearTimeout(stop); //不同函数内可以共享全局变量
    }
</script>
<form action="">
    <input type="text" id="clocker">
    <input type="button" value="Start" onClick="numCount()">
    <input type="button" value="Stop" onclick="stopClocker()">
</form>
```

## 条件语句

### 比较运算符

假如 x = 5, 查看比较后的结果:

| 比较运算符 |                       描述                       |                 例子                 |
| :--------: | :----------------------------------------------: | :----------------------------------: |
|     ==     | 等于（比较的是值，比较时会自动进行数据类型转换） |           x == 8 为 false            |
|    ===     |                 全等（值和类型）                 | x =\== 5 为 true; x === "5" 为 false |
|     !=     |                      不等于                      |            x != 8 为 true            |
|     >      |                       大于                       |            x > 8 为 false            |
|     <      |                       小于                       |            x < 8 为 true             |
|     >=     |                    大于或等于                    |           x >= 8 为 false            |
|     <=     |                    小于或等于                    |            x <= 8 为 true            |

### 逻辑运算符

假如 x=6, y=3, 查看比较后的结果:

| 比较运算符 | 描述 |             例子              |
| :--------: | :--: | :---------------------------: |
|     &&     | and  |   (x < 10 && y > 1) 为 true   |
|    \|\|    |  or  | (x == 5 \|\| y == 5) 为 false |
|     !      | not  |       !(x == y) 为 true       |

## 代码

```html
<script type="text/javascript">
    // if条件语句
	if(条件1)
		{条件1成立时执行的代码}
	else if(条件2)
		{条件2成立时执行的代码}
	...
	else if(条件n)
		{条件n成立时执行的代码}
	else
		{条件1、2至n不成立时执行的代码}
    // switch条件语句
    switch(表达式)
    {
    case值1:
    	执行代码块 1
    	break;
    case值2:
    	执行代码块 2
    	break;
    ...
    case值n:
    	执行代码块 n
    	break;
    default:
    	与 case值1 、 case值2...case值n 不同时执行的代码
    }
    // for循环 
    for(初始化变量;循环条件;循环迭代)
    {
		循环语句
        continue; //break;
    }
	// while循环
    while(判断条件)
    {
	    循环语句
    }
    // do...while循环: 它保证循环体至少被执行一次。因为它是先执行代码，后判断条件，如果条件为真，继续循环。
    do
    {
        循环语句
    }
    while(判断条件)
</script>
<script type="text/javascript">
    // 匿名函数的写法。页面标签和数据都加载完成以后会触发onload事件
	window.onload = function(){
		var oDiv = document.getElementById('div1');
    }
</script>
```

# jQuery

jQuery和JavaScript它们的作用一样，都是负责网页行为操作，增加网页和用户的交互效果的，只不过jQuery简化了JavaScript编程，实现交互效果更简单，兼容主流浏览器。

## 入口函数

下载`jquery-1.12.4.min.js`并在html页面中引入：`<script src="js/jquery-1.12.4.min.js"></script>`

```html
<script src="js/jquery-1.12.4.min.js"></script>
<script>
    window.onload = function(){
        var oDiv = document.getElementById('div01');
        alert('原生就是获取的div：' + oDiv);
    };

    /*
    $(document).ready(function(){
        var $div = $('#div01');
        alert('jquery获取的div：' + $div);
    });
    */

    // 上面ready的写法可以简写成下面的形式：
    $(function(){
        var $div = $('#div01');
        alert('jquery获取的div：' + $div);
    }); 
</script>

<div id="div01">这是一个div</div>
```

## 补充：DOM



##  jQuery选择器

1. 标签选择器
   - `$('li')` //选择所有的li标签
2. 类选择器
   - `$('.myClass')` // 选择class为myClass的标签
3. id选择器
   - `$('#myId')` //选择id为myId的标签
4. 层级选择器
   - `$('#ul1 li span')` //选择id为ul1标签下的所有li标签下的span标签
5. 属性选择器
   - `$('input[name=first]') `// 选择name属性等于first的input标签

### 选择集方法

使用`length`属性来判断标签是否选择成功, 如果`length`大于0表示选择成功，否则选择失败：`$("div").length;`

测试时一直有问题：因为没有等页面加载完成再执行函数

#### 选择集过滤

- `has(选择器名称)`：表示选取包含指定选择器的标签$div.css({"background":"yellow"});
  - `var $div = $("div").has("#mytext");`
- `eq(索引)`：表示选取指定索引的标签
  - `var $div = $("div").eq(1);`索引从0开始

#### 选择集转移

- `$('#box').prev();` 表示选择id是box元素的上一个的同级元素
- `$('#box').prevAll();` 表示选择id是box元素的上面所有的同级元素
- `$('#box').next();` 表示选择id是box元素的下一个的同级元素
- `$('#box').nextAll();` 表示选择id是box元素的下面所有的同级元素
- `$('#box').parent();` 表示选择id是box元素的父元素
- `$('#box').children();` 表示选择id是box元素的所有子元素
- `$('#box').siblings();` 表示选择id是box元素的其它同级元素
- `$('#box').find('.myClass');` 表示选择id是box元素的class等于myClass的元素
- `$(this).index();` 获取发生事件标签的索引

#### 获取和设置元素内容

- `html()`：获取和设置标签的html内容
  - `var result = $div.html();`
  - `$div.html("<span style='color:red'>你好</span>");`
- `append()`：给指定标签追加html内容
  - `$div.append("<span style='color:red'>你好</span>");`

#### 获取和设置样式属性

- `css()`
  - `var $px=$p.css('font-size');`
  - `$div.siblings().css({'text-decoration':'underline','text-indent':'50px','font-size':'25px'})`

#### 获取和设置元素属性

- `prop()`除了样式属性的相关操作使用`css`方法，其他属性的操作都是`prop`方法
  - `var $name=$text.prop('name');`
    - 获取`value`属性可以使用`val`方法`var $name=$text.val();`
  - `$text.prop({'value':'张三','class':'tname'});`
    - 设置`value`属性可以使用`val`方法`$text.val('张三');`

## jQuery事件

- `click()` 鼠标单击
- `blur()` 元素失去焦点
- `focus()` 元素获得焦点
- `mouseover()` 鼠标进入（进入子元素也触发）
- `mouseout()` 鼠标离开（离开子元素也触发）
- `ready()` DOM加载完成

### 事件代理

事件代理就是利用事件冒泡的原理(事件冒泡就是事件会向它的父级一级一级传递),把事件加到父级上，通过判断事件来源，执行相应的子元素的操作，**事件代理首先可以极大减少事件绑定次数，提高性能；其次可以让新加入的子元素也可以拥有相同的操作**。

```html
<head>
    ...
    <style type="text/css">
        .bigbox{
            border:2px solid green;
            width:800px;
            height: 800px;
        }
    </style>
    <script src="js/jquery-1.12.4.js"></script>
    <script>
        // 表示使用JQuery本质就是函数，函数名是$
        // 页面标签加载完成以后就实行ready事件，onload会等待资源数据加载完成。
/*         $(document).ready(function(){
            // 获取标签和css样式匹配标签的规则一样
            var $div = $("#div1") // 使用JQuery，变量名都要以$符号开头
            document.write($div)
        }) */
        // 这是简写方式
        $(function(){
            var $btn = $("#btn1");
            var $div = $('div');
            // 点击button时div也会弹出，这就是事件冒泡
            $div.click(function(){
                var $text = $("#txt1");
                alert($text.val());
                
            });
            $btn.click(function(){
                // 原生js写法
                // this.style.color = "red";
                var $text = $("#txt1");
                alert($text.val());
            });
            // 通过事件代理，让父控件代理子控件的事件，然后执行子控件的相关操作
            // 可以代理不同子控件的事件
            // $div1.delegate("#p2,#btn2","click",function(){});
            var $ul = $("div ul");
            $ul.delegate("li","click",function(){
                $(this).css({"color":"red","font-size":"50px"});
            });
        });           
    </script>
</head>
<body>
    <div class="bigbox">
        <input type="text" id="txt1" value="请输入值">
        <input type="button" id="btn1" value="点点" style="width:80px;height:40px;background-color:grey;">
        <ul>
            <li>第一项</li>
            <li>第二项</li>
            <li>第三项</li>
        </ul>
    </div>
</body>
```

# JSON

json是 JavaScript Object Notation 的首字母缩写，翻译过来就是javascript对象表示法，这里说的json就是**类似于javascript对象的字符串**，它同时是一种**数据格式**，目前这种数据格式比较流行，逐渐替换掉了传统的xml数据格式，web开发的时候经常使用json数据格式

json有两种格式：

1. 对象格式：对象格式的json数据，使用一对大括号`{}`，大括号里面放入`key:value`形式的键值对，多个键值对使用逗号分隔。
   - json中的(key)属性名称和字符串值需要用==**双引号**==引起来，用单引号或者不用引号会导致读取数据错误。
2. 数组格式
   - 数组格式的json数据，使用一对中括号`[]`，中括号里面的数据使用逗号分隔。

```javascript
// 对象格式的json数据:
{
    "name":"tom",
    "age":18
}
// 数组格式的json数据:
["tom",18,"programmer"]

// json数据转换成JavaScript对象
// json本质上是字符串，如果在js中操作json数据，可以将json字符串转化为JavaScript对象
var sJson = '{"name":"tom","age":18}';
var oPerson = JSON.parse(sJson);
// 操作属性
alert(oPerson.name);
alert(oPerson.age)
var sJson2 = '[{"name":"张三","age":20},{"name":"李四","age":21}]'
var aArray = JSON.parse(sJson2);
console.log(aArray);
//通过下标获取js对象，然后通过js对象获取name属性
var oPerson = aArray[1];
document.write(oPerson.name);
```

# AJAX

ajax 是 Asynchronous JavaScript and XML的简写，ajax是一个前后台配合的技术，它可以让 javascript 发送**异步的http请求（同时发送多个请求，不用等待）**，与后台通信进行数据的获取，ajax 最大的优点是**实现局部刷新**，ajax可以发送http请求，当获取到后台数据的时候更新页面显示数据实现局部刷新，在这里大家只需要记住，当前端页面想和后台服务器进行数据交互就可以使用ajax了。

这里提示一下大家，**==在html页面使用ajax需要在web服务器环境下运行==, 一般向自己的web服务器发送ajax请求。**

## AJAX的使用

```html
<script>
    // 向服务器发送ajax请求，本质上是一个http协议的请求
    $.ajax({
        // 请求的资源地址，不指定ip地址和端口号表示请求的是自己的服务器资源数据
        url:"data.json",
        // 请求方式，默认是'GET'，常用的还有'POST'
        type:"GET",
        // 指定对服务器数据的解析格式，常用的是'json'格式
        dataType:"JSON",
        // data：表示发送给web服务器的数据, 没有数据不需要设置
        // 设置请求成功后的执行的函数
        success:function (response) {
            console.log(response.name);    
            // 数据请求回来以后可以绑定给html中的某个标签控件，实现局部刷新
        },
        // 设置请求失败后的执行的函数
        error:function () {
            alert("请求失败,请稍后再试!");
        },
        // async 设置是否异步，默认值是'true'，表示异步，一般不用写
        async:true
    });
</script>
```

### ajax的简写方式

`$.ajax`按照请求方式可以简写成`$.get`或者`$.post`方式

`$.get`和`$.post`方法的参数说明:

`$.get(url,data,success(data, status, xhr),dataType).error(func)`

`$.post(url,data,success(data, status, xhr),dataType).error(func)`

1. `url`请求地址
2. `data`设置发送给服务器的数据，没有数据不需要设置
3. `success`设置请求成功后的回调函数
   - `data`请求的结果数据
   - `status`请求的状态信息, 比如: `success`
   - `xhr`底层发送http请求XMLHttpRequest对象
4. `dataType`设置返回的数据格式
   - `xml`
   - `html`
   - `text`
   - `json`
5. `error`表示错误异常处理
   - `func`错误异常回调函数

```html
 <script>
    $(function(){
        /*
         1. url 请求地址
         2. data 设置发送给服务器的数据, 没有参数不需要设置
         3. success 设置请求成功后的回调函数
         4. dataType 设置返回的数据格式，常用的是'json'格式, 默认智能判断数据格式
        */ 
       // 使用get方式发送请求，name=李四会以?name=李四&..&..的形式出现在地址栏后
        $.get("data.json", {"name":"李四"}, function(dat,status){
            console.log(dat.name);
            console.log(status);
        }).error(function(){
            alert("网络异常");
        });

        /*
         1. url 请求地址
         2. data 设置发送给服务器的数据, 没有参数不需要设置
         3. success 设置请求成功后的回调函数
         4. dataType 设置返回的数据格式，常用的是'json'格式, 默认智能判断数据格式
        */ 
       // 使用post方式发送请求，name=李四会出现在请求体内
       // 这里没有指定http协议头和ip地址和端口号，那么默认ajax请求会自动帮我们加上
       // 如果请求的是自己的web服务器可以不要加上http协议地址，请求别人服务器的数据需要加上http协议地址
        $.post("http://localhost:8000/data.json", {"name":"李四"}, function(data){
            alert(data.name); 
            console.log(data.time); 
        }, "json").error(function(){
            alert("网络异常");
        }); 
    });
</script>
```

# mini-Web框架

web框架是专门为web服务器处理动态资源请求的一个应用程序。web框架和web服务器的关系是web框架专门服务于web服务器，给web服务器提供处理动态资源请求的服务。

WSGI协议：它是web服务器和web框架之间进行协同工作的一个规则，WSGI协议规定web服务器把动态资源的请求信息传给web框架处理，web框架把处理好的结果返回给web服务器。

## 框架程序开发

根据请求资源路径的后缀名进行判断

- 如果请求资源路径的后缀名是.html则是动态资源请求, 让web框架程序进行处理。
  - 创建web框架程序
  - 接收web服务器的动态资源请求
  - 处理web服务器的动态资源请求并把处理结果返回给web服务器
  - web服务器把处理结果组装成响应报文发送给浏览器
- 否则是静态资源请求，让web服务器程序进行处理。

### 使用带有参数的装饰器添加路由

路由功能：路由就是请求的URL到处理函数的映射，也就是说提前把请求的URL和处理函数关联好。

