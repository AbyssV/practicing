

[TOC]

# HTML标签

html是用来开发网页的，它是开发网页的语言。

前端开发三大块：1、HTML：负责网页结构 2、CSS：负责网页样式 3、JavaScript：负责网页行为， 比如:网页与用户的交互效果

学习 html 语言就是学习标签的用法，常用的标签有20多个。

标签不区分大小写，但是推荐使用小写。标签可以带属性，嵌套。

根据标签的书写形式，标签分为双标签(闭合标签)和单标签(空标签)

- 双标签是指由开始标签和结束标签组成的一对标签，这种标签允许嵌套和承载内容，比如: div标签
- 单标签是一个标签组成，没有标签内容， 比如: img标签

## 排版标签总结

| 标签名          | 定义       | 说明                                  |
| --------------- | :--------- | :------------------------------------ |
| `<hx></hx>`     | 标题标签   | 作为标题使用，并且依据重要性递减      |
| `<p></p>`       | 段落标签   | 可以把 HTML 文档分割为若干段落        |
| `<hr />`        | 水平线标签 | 没啥可说的，就是一条线                |
| `<br />`        | 换行标签   |                                       |
| `<span></span>` | span标签   | 用来布局的，一行上可以放好多个span    |
| `<div></div>`   | div标签    | 用来布局的，但是现在一行只能放一个div |

## 文本格式化标签

![html-文本格式化标签](C:\Users\admin\Desktop\practicing\图片笔记\前端\html\html-文本格式化标签.png)

## 特殊字符替换

![html-特殊字符](C:\Users\admin\Desktop\practicing\图片笔记\前端\html\html-特殊字符.png)

## `<img>`标签和资源路径

`src`属性是设置图片的资源路径的，资源路径可以分为相对路径和绝对路径。

- 从当前操作 html 的文档所在目录算起的路径叫做相对路径
  - 同一级路径只需输入图像文件的名称即可，如`<img src="baidu.gif">;`
  - 下一级路径用`/`，如` 如<img src="images/baidu.gif">;`
  - 上一级路径用`../`，   如`<img src="../../../baidu.gif">;`
- 从根目录算起的路径叫做绝对路径，==Windows 的根目录是指定的盘符，mac OS 和Linux 是`/`==
  - `<img src="/Users/apple/Desktop/demo/hello/images/logo.png">`
  - `<img src="C:\demo\images\001.jpg">`。注意这里是backslash反斜杠

一般都会使用相对路径，绝对路径的操作在其它电脑上打开会有可能出现资源文件找不到的问题

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

## 表单标签

1. `<form>`标签：表示表单标签，定义整体的表单区域。将收集到的用户信息传递给服务器
   
   - `action`用于指定接收并处理表单数据的服务器程序的url地址
   - `method`属性设置表单提交的方式，一般有`GET`方式和`POST`方式，不区分大小写
     - `GET`方式提交数据到web服务器以`?`，`&`查询参数写在地址栏的方式提交给服务器，不安全，能看到提交的数据
     - `POST`方式提交数据表单数据会放到请求体里面
     - get和post方式提交表单数据都是以http协议的方式提交数据给web服务器
   - `name`用于指定表单的名称，以区分同一个页面中的多个表单
   
2. `<label>`标签：表示表单元素的文字标注标签。当我们鼠标点击 label标签里面的文字时， 光标会定位到指定的表单里面

   1. 第一种用法就是用label直接包括input表单`<label> 用户名： <input type="radio" name="usename" value="请输入用户名">   </label>`

   2. 第二种用法`for`属性规定`label`与哪个表单元素绑定。

      ```html
      <label for="sex">男</label>
      <input type="radio" name="sex"  id="sex">
      ```

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
   - `name`属性设置表单的名字。后台可以通过这个`name`属性找到这个表单。页面中的表单很多，`name`主要作用就是用于区别不同的表单
     - `name`属性后面的值，是我们自己定义的。
     - `radio`如果是一组，**我们必须给他们命名相同的名字name** 
   - `value`属性设置默认的文本值。 有些表单想刚打开页面就默认显示几个文字，就可以通过这个value来设置
   - `checked="checked"`表示默认选中状态

4. `<textarea>`标签：表示表单元素的多行文本输入框标签 定义多行文本输入框

5. `<select>`标签：表示表单元素的下拉列表标签 定义下拉列表

   - `<option>`标签与`<select>`标签配合，定义下拉列表中的选项
   - `<select>`中至少包含一对`option`
   - 在`option`中定义`selected ="selected"`时，当前项即为默认选中项
   - 但是我们实际开发会用的比较少

### 表单标签的`type`属性

![html-表单标签type属性](C:\Users\admin\Desktop\practicing\图片笔记\前端\html\html-表单标签type属性.png)

## 插入ico图标

网站的图标一般在`https://www.jd.com/favicon.ico`，引入ico图标时，在<head>之间插入代码`<link rel="shortcut icon" href="favicon.ico"  type="image/x-icon"/>`（`type=`可以省略）

## CSS书写规范

1. 使用小写，少用通用选择器`*`，不使用id选择器
2. ==颜色值`rgb()`，`rgba()`，`hsl()`，`hsla()`，`rect()`中不需有空格，且取值不要带有不必要的 0（用`.5`不要用`0.5`）==
3. ==不要为`0`指明单位，`margin: 0 10px;`而不是`margin: 0px 10px;`==
4. css属性值需要用到引号时，统一使用单引号`font-family: 'Hiragino Sans GB';`
5. 选择器与`{`之间必须包含空格，属性名与之后的`:`之间不允许包含空格，` : `与 属性值 之间必须包含空格，属性定义必须另起一行
6. 并集选择器，每个选择器声明必须独占一行


```css
.post,
.page,
.comment {
    line-height: 1.5;
    margin: 0;
    padding: 0;
}
```

## 学习代码

1. 建议HTML标签名、类名、标签属性和大部分属性值统一用小写
2. 不需要为CSS，JS指定类型属性，html5中默认已包含`type="text/css"`
3. 元素属性值使用双引号语法：`<input type="radio" name="name" checked="checked" >`
4. 网站优化三大标签：`title`，`description`，`keyword`

```html
<!-- 输入!后按住回车，或html:5，自动生成骨架 -->
<!DOCTYPE html> <!-- 文档声明, 用来指定页面所使用的html的版本, 这里声明的是一个html5的文档 -->
<html lang="zh">
<!-- 当前网页的语言是英文，默认不指定时中文，lang="en" -->
<!-- 告诉浏览器，这是html文档的开始和结束标签 -->

<head>
    <!-- 用于定义文档的头部,是负责对网页进行设置标题、编码格式以及引入css和js文件的 -->
    <meta charset="UTF-8"> <!-- 规范，不要使用小写 -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge"> <!-- 在IE浏览器浏览网页时，使用IE的最高版本 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- 在移动设备浏览网页时，网页不缩放 -->
    <!-- 1. base 可以设置整体链接的打开状态
    2. base 写到 <head> </head> 之间
    3. 把所有的连接都默认添加 target="_blank" -->
    <base target="_blank" />
    <style type="text/css">
        span {
            color: green;
        }

        .box1 {
            width: 200px;
            height: 200px;
            background-color: rgba(255, 0, 0, 0.5);
            /* 让第 1 个盒子漂浮起来，不占位置 */
            float: right;
        }

        .box2 {
            width: 150px;
            height: 300px;
            background-color: skyblue;
        }
    </style>
</head>

<body>

    <!-- 编写网页上显示的内容 -->
    <!-- 1、成对出现的标签：-->
    <h3 id="common tag"><span>常用</span>标签</h3>
    <p>这是个一个<em>斜体</em>段落标签</p>
    <p>这是个一个<strong>加粗</strong>段落标签</p>
    <p>这是个一个<del>删除线</del>段落标签</p>
    <p>这是个一个<ins>下划线</ins>段落标签</p>
    <p>&lt;p&gt;段落标签独占一行</p>
    <q>&lt;q&gt;引用标签不能独占一行，自带引号</q><br \>
    <blockquote>
        &lt;blockquote&gt;标签是可以独占一行的，
        这是第二行；
        这是第三行；
        这是第四行；
        但 是 不 区 分 空 行
    </blockquote>
    code标签 <code>print("'code'标签不能独占一行")</code>代码结束<br \>
    <p>但是长代码是可以独占一行的</p>
    <pre>
        所谓的预格式化文本就是 ，按照我们预先写好的文字格式来显示页面， 保留空格和换行等。
        被包围在"pre"标签元素中的文本通常会保留空格和换行符。而文本也会呈现为等宽字体。
        有了这个标签，里面的文字，会按照我们书写的模式显示，不需要段落和换行标签了。但是，比较少用，因 为 不 好 整 体 控 制。
    </pre>

    <address>"address"标签也可以独占一行</address>
    <a href="mailto: yatinl4@uci.edu?cc=liuyatingusa@gmail.com&
    subject=这是一封测试邮件&body=mail from VS Code">发邮件</a>&nbsp;&nbsp;&nbsp;&nbsp;注意"a"标签不能独占一行<br>
    <a href="http://www.baidu.com" , title="点击打开百度" , target="_blank">百度</a><br>
    <a href="http://www.google.com" , title="点击打开谷歌">谷歌</a><br>
    <a href="https://www.zhihu.com/" , title="点击打开知乎">知乎</a><br>
    <a href="#">空链接</a>&nbsp;&nbsp;&nbsp;&nbsp;href="#"没有确定链接目标，表示该链接暂时为一个空链接<br>
    <hr \>

    <h3 id="list tag"><span>列表</span>标签</h3>
    <a href="#common tag">回到常用标签</a><br \>
    <!-- 无序列表 -->
    <!-- <ul></ul>中只能嵌套<li></li>，直接在<ul></ul>标签中输入其他标签或者文字的做法是不被允许的。
    <li>与</li>之间相当于一个容器，可以容纳所有元素。 -->
    <ul>无序列表-你最喜欢的动漫人物
        <li>宇智波佐助</li>
        <li>吉良吉影</li>
        <li>御坂美琴</li>
    </ul>
    <!-- 有序列表 -->
    <ol>有序列表-鼠标样式测试
        <li style="cursor:default">我是小白</li>
        <li style="cursor:pointer">我是小手</li>
        <li style="cursor:move">我是移动</li>
        <li style="cursor:text">我是文本</li>
        <li style="cursor:not-allowed">我是禁止</li>
    </ol>
    <!-- 自定义列表 -->
    <dl>自定义列表
        <dt>小明的优点</dt>
        <dd>爱吃蔬菜</dd>
        <dd>爱运动</dd>

        <dt>小红的优点</dt>
        <dd>爱学习</dd>
        <dd>爱帮助他人</dd>

    </dl>
    <hr>

    <h3 id="table tag"><span>表格</span>标签</h3>
    <a href="#common tag">回到常用标签</a><br \>
    <a href="#list tag">回到列表标签</a><br \>
    <!-- border-collapse 设置表格的边线合并 -->
    <!-- "clospan"和"rowspan"可以用来合并单元格 -->
    <!-- 1. <thead></thead>：用于定义表格的头部。用来放标题之类的东西。<thead>内部必须拥有<tr>标签！
    2. <tbody></tbody>：用于定义表格的主体。放数据本体
    3. <tfoot></tfoot>放表格的脚注之类
    4. 以上标签都是放到table标签中 -->
    <table style="border: 10px solid red; border-collapse: collapse;" width="300" height="400">
        <caption>这是标题文本</caption> <!-- 标题文本 -->
        <th style="border: 5px solid green;">姓名</th> <!-- 表格中的表头 -->
        <th style="border: 5px solid blue;">年龄</th>
        <tr>
            <!-- 表格中的一行 -->
            <td>张三</td> <!-- 表格中的列 -->
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

    <h3 id="form tag"><span>表单</span>标签</h3>
    <a href="#common tag">回到常用标签</a><br \>
    <a href="#list tag">回到列表标签</a><br \>
    <a href="#table tag">回到表格标签</a><br \>
    <form action="https://www.baidu.com" method="post">
        <h4>基本信息</h4>
        <!-- label，input标签是不换行的 -->
        <p>
            <!-- label标签不会向用户呈现任何特殊效果，它的作用是为鼠标用户改进了可用性。如果你在label标签内点击文本，就会触发此控件。就是说，当用户单击选中该label标签时，浏览器就会自动将焦点转到和标签相关的表单控件上（就自动选中和该label标签相关联的表单控件上 -->
            <label for="username">姓名：</label><input type="text" id="username" name="username" value="张三" style="outline: solid rgb(255, 0, 242) 2px;">
        </p>
        <p>
            <label for="password">密码：</label><input type="password" id="password" name="password" style="outline: solid rgb(255, 0, 242) 2px;">
        </p>
        <p>
            <!-- value: 提交数据到服务器的值 name: 为控件命名 以备后台程序ASP，PHP使用 -->
            <!-- 同一组的单选按钮，name取值一定要一致，这样同一组的单选按钮才能起到单选的效果 -->
            <label>性别（单选）：
                <input type="radio" name="gender" value="0"> 男
                <input type="radio" name="gender" value="1"> 女
            </label>
        </p>
        <p>
            <label>请输入您的邮箱地址
                <input type="email" placeholder="输入邮箱地址" style="outline: solid rgb(255, 0, 242) 2px;">
            </label>
        </p>
        <p>
            <label>爱好（多选）：
                <input type="checkbox" checked="checked" name="hobby" value="sing"> 唱歌
                <input type="checkbox" name="hobby" value="run"> 跑步
                <input type="checkbox" name="hobby" value="swim"> 游泳
            </label>
        </p>
        <h4>上传文件</h4>
        <p>
            <label>照片：
                <input type="file" name="person_pic">
            </label>
        </p>
        <h4>文本域</h4>
        <p>
            <label>个人描述：
                <textarea cols="100" rows="20" name="description" style="resize: none;outline: solid rgb(255, 0, 242) 2px;">在这里输入您的个人描述...</textarea>
            </label>
        </p>
        <h4>多选</h4>
        <p>
            <label>籍贯：</label>
            <select multiple="multiple" name="hometown">
                <option selected="selected" value="北京">北京</option>
                <option value="上海">上海</option>
                <option value="广州">广州</option>
                <option value="深圳">深圳</option>
            </select>
        </p>
        <h4>提交，重置和按钮</h4>
        <p><input type="submit" value="提交"></p>
        <p><input type="reset" value="重置"></p>
        <p><input type="button" value="点点点" style="cursor:pointer"></p>
    </form>
    <hr>
    <h3><span>img</span>标签</h3>
    <a href="#common tag">回到常用标签</a><br \>
    <a href="#list tag">回到列表标签</a><br \>
    <a href="#table tag">回到表格标签</a><br \>
    <a href="#form tag">回到表单标签</a><br \>
 
    <div>
        <p>图片示例</p>
        <img src="沐樱.png" alt="图片无法显示" title="别点我老婆" width="500" height="300" style="vertical-align: middle;">老婆贴贴
    </div>
    <hr \>

    <h3>盒子模型边距测试</h3>
    <div style="width:300px;height:300px;background-color:blue">
        <div style="width:300px;height:300px;background-color: rgba(255, 0, 0, 0.1);border:10px solid green">
        </div>
    </div>

    <h3>盒子模型浮动测试</h3>
    <div style="width:300px;height:300px;">
        <!-- 可以看到box1附在了box2的下面 -->
        <div class="box1">红色盒子</div>
        <div class="box2">蓝色盒子</div>
    </div>
    
</body>
</html>
```

# HTML5

HTML5定义了HTML标准的最新版本，是对HTML的第五次重大修改，号称下一代的HTML，定义了新的标签、特性和属性

HTML5 拓展了哪些内容

- 语义化标签，主要针对搜索引擎，可以使用一次或者多次，在IE9浏览器中，需要把语义化标签都转换为块级元素：`display:block;`
  - `header`   ---  头部标签
  - `nav`        ---  导航标签
  - `article` ---   内容标签
  - `section` ---   块级标签
  - `aside`     ---   侧边栏标签
  - `footer`   ---   尾部标签
- 本地存储
- 兼容特性
- 2D、3D
- 动画、过渡
- CSS3特性
- 性能与集成

![html5-语义化标签](C:\Users\admin\Desktop\practicing\图片笔记\前端\html\html5-语义化标签.png)

## 多媒体标签

### `audio`音频标签

注意不同浏览器支持的格式不同，有的浏览器禁用了某些功能。通常我们为音频准备多个格式

![html5-audio标签](C:\Users\admin\Desktop\practicing\图片笔记\前端\html\html5-audio标签.png)

```html
<audio controls="controls">
    <source src="media/snow.mp3" type="audio/mpeg">
    <source src="media/snow.ogg" type="audio/ogg">
</audio>
```

### `video`视频标签

![html5-video标签](C:\Users\admin\Desktop\practicing\图片笔记\前端\html\html5-video标签.png)

```html
<!-- 谷歌浏览器禁用了自动播放功能，如果想自动播放，需要添加 muted 属性 -->
<video controls autoplay>
    <source src="../sort algo. video interpretation\quick sort.mp4" type="video/mp4">
    <source src="../sort algo. video interpretation\quick sort.ogg" type="video/ogg">
    您的浏览器不支持此格式
</video>
```

## `input`表单属性

### 新增`input`标签

![html5-input标签](C:\Users\admin\Desktop\practicing\图片笔记\前端\html\html5-input标签.png)

### 新增`input`属性

![html5-input属性](C:\Users\admin\Desktop\practicing\图片笔记\前端\html\html5-input属性.png)

# CSS

css(Cascading Style Sheet)层叠样式表，它是用来美化页面的一种语言。

css的作用：

- 美化界面, 比如: 设置标签文字大小、颜色、字体加粗等样式。
- 控制页面布局, 比如: 设置浮动、定位等样式。

## CSS的三种引入方式

- 内联式（行内式）css样式，直接写在现有的HTML标签中
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
  - ==可以在VSC中输入`link:css`快速输入框架==
  - 优点：使得css样式与html页面分离，便于整个页面系统的规划和维护，可重用性高。 
  - 缺点：css代码由于分离到单独的css文件，容易出现css代码过于集中，若维护不当则极容易造成混乱。
  - 外链式在公司开发的阶段使用，可以对 css 样式和 html 页面分别进行开发。

```html
<head>
    ...
    <title>CSS学习</title>
    <!-- 输入link:css自动生成 -->
    <!-- 外部式
    rel：定义当前文档与被链接文档之间的关系，在这里需要指定为“stylesheet”，表示被链接的文档是一个样式表文件。
    type：定义所链接文档的类型，在这里需要指定为“text/CSS”，表示链接的外部文件为CSS样式表。我们都可以省略
    href：定义所链接外部样式表文件的URL，可以是相对路径，也可以是绝对路径。-->      
    <link href="css/main.css" rel="stylesheet" type="text/css"> <!--  -->
    <!-- 嵌入式，type="text/css"在html5中可以省略 -->
    <style type="text/css"> 
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

### 优先级

在相同权值的情况下，**内联式 > 嵌入式 > 外部式**。但是嵌入式 > 外部式有一个前提：嵌入式css样式的位置一定在外部式的后面。其实总结来说，就是就近原则（离被设置元素越近优先级别越高）。

## CSS选择器

1. 标签选择器-权值为1

   - 根据标签来选择标签，仅以标签开头
   - `p{color:red;}`
   - 此种选择器影响范围大，一般用来做一些通用设置
   
2. 类选择器（常用）-权值为10

   - 以英文圆点` .`开头，类选择器可以任意起名。在标签内用`class="类选择器名称"`为标签应用一个类的样式
   - `.blue{color:blue}.box{width:100px;height:100px;background:gold}(...)<p class="blue box">...</p>`
     - 命名时不要使用空格，因为多个类是用空格隔开的
   - 一个类选择器可应用于多个标签上，一个标签上也可以使用多个类选择器，多个类选择器需要使用空格分割，应用灵活，可复用，是css中应用最多的一种选择器
   
3. id选择器-权值为100

   - 以`#`开头。在标签内使用`id="id名称"`为标签应用一个id的样式。
   - `#box{color:red}(...)<p id="box">...</p>`
   - 在一个HTML文档中，ID选择器仅能使用一次，而类选择器可以使用多次
   - 类选择器可以为一个标签设置多个类的样式，而id选择器不可以
   - 不推荐使用id作为选择器，在HTML文档中标签的id是唯一的，不能重复，后续js会通过id获取对应的标签对象
   
4. 后代选择器（常用）

   - 加入空格，以`选择器1 选择器2`开头，根据层级关系选择后代标签
   - `.con{width:300px;height:80px;background:green}(...).con .pink{color:pink}.con span{color:red}`
   - 主要应用在标签嵌套的结构中，减少命名。
   - 这个层级关系不一定是父子关系，也有可能是祖孙关系，或者说，它能够选在任何内层嵌套在外层的标签
   
5. 子选择器
   - 使用大于符号`>`，用于选择指定标签元素的第一代子元素（直系）
   - `.first span{color:red;}`
   - 子选择器仅是指它的直接后代，或者说是第一代后代。而后代选择器是作用于所有子后代元素。
   
6. 分组选择器

   - 将多个选择器以`,`分割开
   - `.box1,.box2,.box3{width:100px;height:100px}`
   - 如果有公共的样式设置，可以使用组选择器。
   - 还有比较少用的交集选择器，选择的标签需要满足两个标签，用`.`分隔，例如`p.one{color:red;}`表示选择的是`class=one`的`p`标签
   
7. 伪类选择器

   - 以 `: `分割开
   
   - `.box1{width:100px;height:100px;background:gold;}(...).box1:hover{width:300px;}`
   
   - 用于向选择器添加特殊的效果， 当用户和网站交互的时候改变显示效果可以使用伪类选择器
   
   - 常用的有：
   
     ```css
     写的时候，他们的顺序尽量不要颠倒，按照lvha的顺序。否则可能引起错误。实际工作开发中，我们很少写全四个状态
     a:link      /* 未访问的链接 */
     a:visited   /* 已访问的链接 */
     a:hover     /* 鼠标移动到链接上 */
     a:active    /* 选定的链接 */
     ```
   
8. 通用选择器
   - 使用一个`*`号指定，作用是匹配html中所有标签元素。使用下面代码设置html中任意标签元素字体颜色为红色
   - `* {color:red;}`

## CSS的继承，层叠和特殊性

### 继承

继承是一种规则，它允许样式不仅应用于某个特定html标签元素，而且应用于其后代（如文本颜色和字号）。但注意有一些css样式是不具有继承性的。如`border:1px solid red;`

### 特殊性

浏览器是根据权值来判断使用哪种css样式的，权值高的就使用哪种css样式。

下面是权值的规则：标签的权值为1，类选择符的权值为10，ID选择符的权值最高为100，行内样式`style=`为1000，`!important`为正无穷

权重叠加

```css
p{color:red;} /*权值为1*/
p span{color:green;} /*权值为1+1=2*/
.warning{color:white;} /*权值为10*/
p span .warning{color:purple;} /*权值为1+1+10=12*/
#footer .note p{color:yellow;} /*权值为100+10+1=111*/
a:hover /*权值为11*/
```

继承或者通配符选择器的权重约为0

### 层叠

层叠就是在html文件中对于同一个元素可以有多个css样式存在，当有相同权重的样式存在时，会根据这些css样式的前后顺序来决定，处于最后面的css样式会被应用。

### 重要性

使用`!important`设置最高权值

```css
p{color:red!important;}
p{color:green;}
<p class="first">三年级时，我还是一个<span>胆小如鼠</span>的小女孩。</p> /* 文本显示为红色 */
```

注意：`!important`要写在分号的前面

这里注意当网页制作者不设置css样式时，浏览器会按照自己的一套样式来显示网页。并且用户也可以在浏览器中设置自己习惯的样式，比如有的用户习惯把字号设置为大一些，使其查看网页的文本更加清楚。这时注意样式优先级为：**浏览器默认的样式 < 网页制作者样式 < 用户自己设置的样式**，但记住`!important`优先级样式是个例外，权值高于用户自己设置的样式。

## CSS文本常用样式属性

- `color`：设置文字的颜色，如：`color:red/green/blue/pink;`
  - 16进制表示。如`#FF0000`
  - rgb代码，如`rgb(255,0,0)`或`rgb(100%,0%,0%)`
  - 可以设置透明度alpha值，取值范围 0~1之间， 后面必须是4个值。如`rgba(0, 0, 0, 0.3);`


***

==以下都可以用font代替==

- `font`：综合设置字体样式。`{ font: font-style  font-weight  font-size/line-height  font-family;}`
  - 必须保留`font-size`和`font-family`属性
  - 使用`font`属性时，必须按上面语法格式中的顺序书写，不能更换顺序，各个属性以**空格**隔开

- `font-size`：设置文字的大小，如：`font-size:12px;`
  - em：相对于当前对象内文本的字体尺寸
  - px：像素，最常用
  - rem：1rem等于html根元素设定的font-size的px值
  
- `font-family`：设置文字的字体
  - 各种字体之间必须使用英文状态下的逗号隔开
  - 中文字体需要加英文状态下的引号，英文字体一般不需要加引号。当需要设置英文字体时，英文字体名必须位于中文字体名之前
  - <u>如果字体名中包含空格、#、$等符号，则该字体必须加英文状态下的单引号或双引号，例如`font-family: "Times New Roman";`</u>
  - `font-family:'微软雅黑';`。为了避免中文字不兼容，一般写成：`font-family:'Microsoft Yahei';`。字体不兼容时，解决方式有
    - 使用英文来替代。 比如` font-family:"Microsoft Yahei"`
    - 使用Unicode写中文字体名称，浏览器是可以正确的解析的。微软雅黑的Unicode编码是`font-family: "\5FAE\8F6F\96C5\9ED1"; `

- `font-weight`：设置文字是否加粗，如：`font-weight:bold/normal;` 设置加粗/不加粗（默认）。可以设置为100-900，<u>400 等同于normal，而700等同于bold</u>
- `font-style`：字体风格。`normal`是默认的标准样式，`italic`是斜体

***

- `line-height`：设置文字的行高（行间距），如：`line-height:24px;` 表示文字高度加上文字上下的间距是24px，也就是每一行占有的高度是24px。一般情况下，行距比字号大7.8像素左右就可以了
  - 我们可以利用行高=盒子高度使得文字在盒子中垂直居中显示。当文字的行高=盒子的高度时，因为上距离和下距离总是相等的，因此文字看上去是垂直居中的[^1]
    - 如果行高>盒子高度，文字会偏下（想象行顶和盒子的<u>顶部对齐</u>，因为行高更大，文字就会偏下）
    - 如果行高<盒子高度，文字会偏上
  - 可以使用`em`
  - 百分比`%`
- `text-decoration`： 设置文字的下划线，如：`text-decoration:none/underline/overline/line-through;` 将文字下划线去掉（默认）/下划线/文本上的线/穿过文本的线
- `text-align`：设置文字水平对齐方式，如`text-align:center/left/right` 设置文字水平居中/左对齐/右对齐
  - 是让盒子里面的内容水平居中， 而不是让盒子居中对齐
- `text-indent`： 设置文字首行缩进，如：`text-indent:24px;` 设置文字首行缩进24px
  - 可以使用字符宽度的倍数em，推荐使用
  - 相对于浏览器窗口宽度的百分比%

[^1]: 修改中

```css
.h_demo {
    /* 文字排版 */
    /* font: "Microsoft Yahei","Consolas",sans-serif italic bold small-caps bold 12px/2em; */
    font-family:"Microsoft Yahei","Consolas",sans-serif, Arial; /* 微软雅黑 */
    font-size: 12px;
    color:#666;
    background-color: beige;
    font-weight: bold; /* font-weight: normal; */
    font-style: italic;
    text-decoration: underline | line-through | overline | ;
    line-height: 4em; /* 表示文字高度加上文字上下的间距是48px，也就是每一行占有的高度是48px */
    text-indent: 2em; /* 设置文字首行缩进24px */
    word-spacing: 0.5em; /* 设置英文单词之间的间距为6px */
    letter-spacing: 0.5em; /* 设置中文字之间/英文字母之间的间距为6px */
    text-align: center; /* 设置文字水平居中 */
}
```

## CSS布局常用样式属性

- `background: transparent url(image.jpg) repeat-y  scroll center top`设置背景
  - 属性的值的书写顺序官方并没有强制标准的。为了可读性，建议大家如下写`background: 背景颜色 背景图片地址 背景平铺 背景滚动 背景位置;`
- `background-color: gold`设置元素的背景色为金色（默认`transparent`）
- `background-image: url(images/logo.png);`设置元素的背景图片（默认`none`）。我们提倡背景图片后面的地址，url不要加引号
- `background-repeat: repeat | no-repeat | repeat-x | repeat-y `设置背景图像在纵向和横向上平铺（默认的） | 背景图像不平铺 | 背景图像在横向上平铺 | 背景图像在纵向平铺
- `background-position`sets the initial position for each background image. check [MDN documents](https://developer.mozilla.org/en-US/docs/Web/CSS/background-position)
  - 必须先指定`background-image`属性
  - 可以是`x y`的精确长度（`px cm ch em`）或者是百分比
  - 可以是方位词（`top bottom left right center`）或是方位词+长度如`background-position: right 3em bottom 10px;`（即edge offect值）
- `background-attachment: scroll | fixed `设置背景的滚动是随对象内容滚动 | 背景图像固定

---

- `width`：设置元素(标签)的宽度，如：`width:100px;`。设置内边距或边框会撑大盒子，如果没有设置宽度和高度，则设置内边距或边框不会撑大盒子
- `height`：设置元素(标签)的高度，如：`height:200px;` 
- `border: border-width | border-style | border-color`（没有顺序）：设置元素四周的边框，如：`border:1px solid black;` 设置元素四周边框是1像素宽的黑色实线。也可以拆分成四个边的写法，分别设置四个边的，也可以对四个边分别指定：
  - `border-top`：设置顶边边框，如：`border-top:10px solid red;`
    - `border-top-width`
    - `border-top-style`
    - `border-top-color`
  - `border-left`：设置左边边框，如：`border-left:10px solid blue;`
  - `border-right`：设置右边边框，如：`border-right:10px solid green;`
  - `border-bottom`：设置底边边框，如：`border-bottom:10px solid pink;`
- `border-style: none | solid | dashed | dotted`：设置边框样式为没有边框即忽略所有边框的宽度（默认值）| 单实线 | 虚线 | 点线
- `padding`内边距：设置元素包含的**内容**和元素**边框**的距离，也叫内边距，如`padding:20px;`padding是同时设置4个边的，也可以像border一样拆分成分别设置`padding-left,padding-right, padding-top, padding-bottom`
- ==盒子的实际的大小 =   内容的大小(width+height) +  左右内边距   + 左右边框==
- `margin`外边距：设置元素和外界的距离，例如盒子和盒子之间的距离，也叫外边距，如`margin:20px;`是同时设置4个边的，也可以像padding一样拆分成分别设置四个边。
  - 以下三种方法可以设置块级盒子水平居中，盒子必须指定宽度。盒子内的文字水平居中是`text-align:center`
    - `margin-left: auto;margin-right: auto;`
    - `margin: auto;`
    - `margin: 0 auto;`

  - 插入一张图片时多用`margin`或`padding`调整位置，一个盒子的背景图片一般用`background-position: x y`调整位置


***

对于表格的边框

- `cellspacing="0"`将单元格与单元格之间的距离设置为0
- `border-collapse:collapse;`表示相邻边框合并在一起

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

### 浮动`float`

**注意**

1. 我们使用浮动的核心目的——让多个块级盒子在同一行显示。 因为这是我们最常见的一种布局方式
2.  浮动的元素互相贴靠一起的，但是如果父级宽度装不下这些浮动的盒子， 多出的盒子会另起一行对齐
3. 浮动只会影响当前的或者是后面的标准流盒子，不会影响前面的标准流
   1. 如果前一个兄弟盒子是浮动的，那么当前盒子会与前一个盒子的顶部对齐
   2. ==如果前一个兄弟盒子是普通流的，那么当前盒子会显示在前一个兄弟盒子的下方==
   3. 建议：如果一个盒子里面有多个子盒子，如果其中一个盒子浮动了，其他兄弟也应该浮动。防止引起问题
4. ==子盒子的浮动参照父盒子对齐，不会与父盒子的边框（border）重叠，也不会超过父盒子的内边距（padding）==
5. 加了浮动的盒子是浮起来的，漂浮在其他标准流盒子的上面
6. 加了浮动的盒子是不占位置的，它原来的位置漏给了标准流的盒子
7. 浮动元素会改变`display`属性， 类似转换为了行内块，但是元素之间没有空白缝隙

设置元素浮动，浮动可以让块元素排列在一行`float: 属性值;`，没有居中浮动

1. `none`：元素不浮动（默认值）
2. `left`：元素向左浮动
3. `right`：元素向右浮动

CSS 提供了3 种机制来设置盒子的摆放位置，分别是普通流（标准流）、浮动和定位 

1. 普通流（标准流）
   - 块级元素会独占一行，**从上向下**顺序排列；
     - 常用元素：div、hr、p、h1~h6、ul、ol、dl、form、table
   - 行内元素会按照顺序，**从左到右**顺序排列，碰到父元素边缘则自动换行；
     - 常用元素：span、a、i、em等
2. 浮动
   - 让盒子从普通流中浮起来,主要作用让多个块级盒子一行显示。
3. 定位
   - 将盒子定在浏览器的某一个位置——CSS 离不开定位，特别是后面的 js 特效。

#### 清除浮动

因为父级盒子很多情况下，没有高度值，但是子盒子浮动就不占有位置，最后父级盒子高度为0，就影响了下面的标准流盒子，对后面的元素排版产生影响

![清除浮动-正常标准盒子](C:\Users\admin\Desktop\practicing\图片笔记\前端\css\清除浮动-正常标准盒子.jpg)

![清除浮动-子盒子浮动](C:\Users\admin\Desktop\practicing\图片笔记\前端\css\清除浮动-子盒子浮动.jpg)

清除浮动的方法有

1. 在最后一个浮动元素的末尾添加一个额外的空的标签例如 `<div style="clear:both"></div>`，或则其他标签`br`等亦可
   1. `clear:left`：不允许左侧有浮动元素（清除左侧浮动的影响）
   2. `clear:right`：不允许右侧有浮动元素（清除右侧浮动的影响）
   3. `clear:both`：同时清除左右两侧浮动的影响
2. 可以给父级添加`overflow: hidden| auto| scroll`
3. 使用`.clearfix:after`伪元素标签

```css
 .clearfix:after {  
     content: ""; 
     display: block; 
     height: 0; 
     clear: both; 
     visibility: hidden;  
}   
/* IE6、7 专有 */
 .clearfix {
     *zoom: 1;
}   
```



1. 使用`.clearfix:before, .clearfix:after`双伪元素标签

```css
.clearfix:before,.clearfix:after { 
  content:"";
  display:table; 
}
.clearfix:after {
 clear:both;
}
.clearfix {
  *zoom:1;
}
```



### CSS元素溢出`overflow`

当子元素(标签)的尺寸超过父元素(标签)的尺寸时，此时需要在父标签里设置显示溢出的子元素的方式，设置的方法是通过`overflow`属性来完成。`overflow`可以用来清除浮动

overflow的设置项：

1. `visible`默认值, 显示子标签溢出部分。
2. `hidden`隐藏子标签溢出部分。
3. `auto`如果子标签溢出，则可以拉动滚顶条查看其余的内容，不超出不显示滚动条
3. `scroll`不管超出内容否，总是显示滚动条

### CSS显示特性`display`

`display`属性是用来设置元素的类型及隐藏的，常用的属性有：

1. `none`元素隐藏且**不占位置**
   - `visibility: visible/hidden`：可视/隐藏对象。隐藏之后，继续保留原有位置
2. `inline`元素以行内元素显示，以后就不能设置宽高。但是可以通过浮动`float`来完成
3. `block`元素以块元素显示，单独占用一行
4. `inline-block`元素以行内块显示

## 元素分类

### 块级元素(block-level)

html中`<div>`、`<p>`、`<h1>~<h6>`、`<form>`、`<ul>` 和` <li>` 就是块级元素。设置`display:block`就是将元素显示为块级元素。常用的是`<div>`

块级元素特点：
1. 每个块级元素都从新的一行开始，并且其后的元素也另起一行。（一个块级元素独占一行）
2. 元素的高度、宽度、行高以及顶和底边距都可设置。
3. 元素宽度在不设置的情况下，是它本身父容器的100%（和父元素的宽度一致），除非设定一个
宽度。
4. 是一个容器及盒子，里面可以放行内或者块级元素。==注意`<p>`、`<h1>~<h6>`文字块级标签里面不能放其他块级元素==

### 内联元素(inline-level)

html中， `<span>`、`<a>`、`<label>`、 `<strong><b>` 、`<em><i>`、`<del><s>`、`<ins><u>`就是典型的内联元素（inline）元素。当然块状元素也可以通过代码`display:inline`将元素设置为内联元素。常用的是`<span>`

内联元素特点：
1. 和其他元素都在一行上
2. 元素的高度、宽度及顶部和底部边距不可设置（左右外边距可以设置）
3. 元素的宽度就是它包含的文字或图片的宽度，不可改变
3. 行内元素只能容纳文本或则其他行内元素。注意链接里面不能再放链接

### 内联块级元素（inline-block）

`<img />`、`<input />`、`<td>`标签就是这种内联块状标签。内联块状元素（inline-block）就是同时具备内联元素、块状元素的特点，代码`display:inlineblock`就是将元素设置为内联块状元素。

inline-block元素特点：

1. 和其他元素都在一行上，==但是之间会有空白缝隙（这是为什么我们会用`float`而不是`display`）==

2. 元素的高度、宽度、行高以及顶和底边距都可设置。

3. 默认宽度就是它本身内容的宽度

补充：我们知道浮动`float`会默认转化为行内块，而绝对定位和固定定位也和浮动类似，所以，一个行内的盒子如果加了浮动、固定定位和绝对定位，不用转换，就可以给这个盒子直接设置宽度和高度等，并且不会触发外边距合并的问题

### 三种模式总结区别

| 元素模式         | 元素排列               | 设置样式               | 默认宽度         | 包含                     |
| ---------------- | ---------------------- | ---------------------- | ---------------- | ------------------------ |
| 块级元素         | 一行只能放一个块级元素 | 可以设置宽度高度       | 容器的100%       | 容器级可以包含任何标签   |
| 内联元素         | 一行可以放多个内联元素 | 不可以直接设置宽度高度 | 它本身内容的宽度 | 容纳文本或则其他行内元素 |
| 内联块级元素元素 | 一行放多个内联块级元素 | 可以设置宽度和高度     | 它本身内容的宽度 |                          |

## 盒子模型

所谓的盒子模型就是把HTML页面的元素看作一个矩形盒子，矩形盒子是由内容(content)、内边距(padding)、边框(border)、外边距(margin)四部分组成。

用chrome调试时，注意可以通过颜色判断盒子，蓝色是盒子的宽度高度；青色是内边距；橙色是外边距

- 盒子的内容宽度(width)，注意：不是盒子的宽度
- 盒子的内容高度(height)，注意：不是盒子的高度
- 盒子的边框(border)
- 盒子内的内容和边框之间的间距(padding)
- 盒子与盒子之间的间距(margin)。外边距会影响与其他盒子的距离。

什么情况下用内边距，什么情况下用外边距？按照 优先使用 宽度 （width） 其次使用内边距（padding）再次  外边距（margin）

原因：

- margin会有外边距合并还有ie6下面margin加倍的bug所以最后使用
- padding会影响盒子大小，需要进行加减计算其次使用
- width  没有问题我们经常使用宽度剩余法高度剩余法来做

**盒子的真实尺寸**

盒子的width和height值固定时，如果盒子增加border和padding，盒子整体的尺寸会变大，所以盒子的真实尺寸为：

- 盒子宽度 = width + padding左右 + border左右
- 盒子高度 = height + padding上下 + border上下

<img src="C:\Users\admin\Desktop\practicing\图片笔记\Python\hzmx.png" style="zoom:33%;" />

### 外边距合并

==注意浮动，固定定位和绝对定位的元素不会有外边距塌陷的问题==

#### 相邻块元素垂直外边距的合并

当上下相邻的两个块元素相遇时，如果上面的元素有下外边距margin-bottom，下面的元素有上外边距margin-top，则他们之间的垂直间距不是margin-bottom与margin-top之和，而是**取两个值中的较大者**。这种现象被称为相邻块元素垂直外边距的合并（也称外边距塌陷）。<u>解决方案：尽量给只给一个盒子添加margin值</u>

#### 嵌套块元素垂直外边距的合并（塌陷）

对于两个嵌套关系的块元素，如果父元素没有上内边距及边框，父元素的上外边距会与子元素的上外边距发生合并

，合并后的外边距为两者中的较大者

![嵌套块元素垂直外边距的合并（塌陷）](C:\Users\admin\Desktop\practicing\图片笔记\前端\css\嵌套块元素垂直外边距的合并（塌陷）.png)

解决方案：1.可以为父元素定义上边框 2.可以为父元素定义上内边距 3.可以为父元素添加`overflow:hidden`

## 定位

我们在动态滚动窗口是，可以看到盒子是固定在屏幕某个位置的；在静态浏览时，也能看到浮动的盒子。定位是将盒子定在某一个位置，自由的漂浮在其他盒子(包括标准流和浮动)的上面。三种布局机制的上下顺序：标准流在最底层——浮动的盒子在中间层——定位的盒子在最上层

定位由两部分组成：定位 = 定位模式+边偏移

### 定位模式`position` 

在CSS中，通过`position`属性定义元素的定位模式：`选择器 {position: 属性值;}`

| 定位模式         | 是否脱标占有位置     | 移动位置基准           | 模式转换（行内块） | 使用情况                 |
| ---------------- | -------------------- | :--------------------- | ------------------ | ------------------------ |
| 静态static       | 不脱标，正常模式     | 正常模式               | 不能               | 几乎不用                 |
| 相对定位relative | 不脱标，占有位置     | 相对自身位置移动       | 不能               | 基本单独使用             |
| 绝对定位absolute | 完全脱标，不占有位置 | 相对于定位父级移动位置 | 能                 | 要和定位父级元素搭配使用 |
| 固定定位fixed    | 完全脱标，不占有位置 | 相对于浏览器移动位置   | 能                 | 单独使用，不需要父级     |

- `static`：静态定位
  - 静态定位是元素的默认定位方式，无定位的意思。它相当于border里面的none，不要定位的时候用
  - 静态定位按照标准流特性摆放位置，它没有边偏移
  - 静态定位在布局时我们几乎不用的 
- `relative`：相对定位
  - 相对定位是元素相对于它原来在标准流中的位置来说的
  - 原来在标准流的区域继续占有，后面的盒子仍然以标准流的方式对待它

![相对定位案例](C:\Users\admin\Desktop\practicing\图片笔记\前端\css\相对定位案例.png)

- `absolute`：绝对定位

  - 完全不占位置，如果盒子中没有内容，需要指定宽度，不能通过设置 `margin: auto` 设置水平居中
  - 绝对定位是元素以带有定位的父级元素来移动位置。父级元素需要是相对定位

  ![绝对定位_父级有定位](C:\Users\admin\Desktop\practicing\图片笔记\前端\css\绝对定位_父级有定位.png)

  - 父元素没有定位，则以浏览器为准定位（Document 文档）

  ![绝对定位_父级无定位](C:\Users\admin\Desktop\practicing\图片笔记\前端\css\绝对定位_父级无定位.png)

- `fixed`：固定定位

  - 完全不占位置，如果盒子中没有内容，需要指定宽度，不能通过设置 `margin: auto` 设置水平居中
  - 以浏览器的窗口设置位置
    - 跟父元素没有任何关系；单独使用的
    - 不随滚动条滚动

### 边偏移

边偏移需要和定位模式联合使用，单独使用无效，`top`和 `bottom`不要同时使用，`left`和`right`不要同时使用

- `top`：顶端偏移量，定义元素相对于其父元素上边线的距离
- `bottom`：底部偏移量，定义元素相对于其父元素下边线的距离
- `left`：左侧偏移量，定义元素相对于其父元素左边线的距离
- `right`：右侧偏移量，定义元素相对于其父元素右边线的距离

### 绝对定位的盒子居中

因为绝对定位/固定定位的盒子不能通过设置`margin: auto`设置水平居中，可以按照下图的方法[^2]

1. `left: 50%;`：让盒子的左侧移动到父级元素的水平中心位置
2. `margin-left: -100px;`：让盒子向左移动自身宽度的一半

![绝对定位居中示意图](C:\Users\admin\Desktop\practicing\图片笔记\前端\css\绝对定位居中示意图.png)

[^2]:能否打乱顺序

## z-index

在使用定位布局时，可能会出现盒子重叠的情况。加了定位的盒子，默认后来者居上， 后面的盒子会压住前面的盒子。应用 z-index 层叠等级属性可以调整盒子的堆叠顺序

==注意：z-index 只能应用于相对定位、绝对定位和固定定位的元素，其他标准流、浮动和静态定位无效==

z-index 的特性如下：

1. 属性值：正整数、负整数或 0，默认值是 0，数值越大，盒子越靠上
2. 如果属性值相同，则按照书写顺序，后来居上
3. 数字后面不能加单位

## 图片/表单与文字垂直居中

对于文字居中对齐，是`text-align: center`；有宽度的块级元素居中对齐，是`margin: 0 auto;`那么对于垂直居中呢？

`vertical-align`垂直对齐只针对于行内元素或者行内块元素，通常用来控制图片/表单与文字的对齐

`vertical-align: baseline | top | middle | bottom `

![垂直居中](C:\Users\admin\Desktop\practicing\图片笔记\前端\css\垂直居中.jpg)



对于图片或者表单等行内块元素，他的底线会和父级盒子的基线对齐，图片底侧会有一个空白缝隙

解决方式：1. 让img标签添加`vertical-align:middle | top| bottom`等等，让图片不要和基线对齐 2. 让img标签添加`display：block;`转换为块级元素

## CSS Sprites（CSS精灵技术）

用户访问一个网站时，需要向服务器发送请求，网页上的每张图像都要经过一次请求才能展现给用户，然而，一个网页中往往会应用很多小的背景图像作为修饰，当网页中的图像过多时，服务器就会频繁地接受和发送请求，这将大大降低页面的加载速度。为了有效地减少服务器接受和发送请求的次数，提高页面的加载速度，使用CSS精灵将网页中的一些背景图像整合到一张大图中（精灵图），这样，当用户访问该页面时，只需向服务发送一次请求，网页中的背景图像即可全部展示出来。然而，各个网页元素通常只需要精灵图中不同位置的某个小图，要想精确定位到精灵图中的某个小图。我们需要使用CSS的

* `background-image`
* `background-repeat`
* `background-position`属性进行背景定位
* 其中最关键的是使用`background-position`属性精确地定位

css精灵技术主要针对于背景图片，插入的图片img是不需要这个技术的。

## 字体图标

图片缺点很明显，比如图片不但增加了总文件的大小，还增加了很多额外的http请求，这都会大大降低网页的性能的。更重要的是图片不能很好的进行缩放，因为图片放大和缩小会失真。 我们后面会学习移动端响应式，很多情况下希望我们的图标是可以缩放的。此时，一个非常重要的技术就是字体图标（iconfont)

字体图标可以做出跟图片一样可以做的事情，改变透明度、旋转度等；但是本质其实是文字，可以很随意的改变颜色、产生阴影、透明效果等等；本身体积更小，但携带的信息并没有削减；几乎支持所有的浏览器；移动端设备必备良药

![字体图标](C:\Users\admin\Desktop\practicing\图片笔记\前端\css\字体图标.png)

```html
/*让所有斜体 不倾斜*/
em,
i {
    font-style: normal;
}
<-- 声明字体图标 -->
<style>
    @font-face {
      font-family: 'icomoon';
      src:  url('fonts/icomoon.eot?7kkyc2');
      src:  url('fonts/icomoon.eot?7kkyc2#iefix') format('embedded-opentype'),
        url('fonts/icomoon.ttf?7kkyc2') format('truetype'),
        url('fonts/icomoon.woff?7kkyc2') format('woff'),
        url('fonts/icomoon.svg?7kkyc2#icomoon') format('svg');
      font-weight: normal;
      font-style: normal;
    }
    .shopcar {
		font-family: "icomoon";
	}
</style>
<body>
    <i class="shopcar"> </i>
</body>
```



## CSS其他属性

```css
1.去掉列表默认的样式
无序和有序列表前面默认的列表样式，在不同浏览器显示效果不一样，而且也比较难看，所以，我们一般上来就直接去掉这些列表样式就行了。 代码如下
li { list-style: none; }

2.圆角边框(CSS3)
border-radius:length; 可以为数值或百分比
border-radius: 左上角 右上角 右下角 左下角
border-radius: 50%; 让一个正方形变成圆（四个角都是圆角）
border-radius: 50% 0; 只有左下角不是圆角

3.盒子阴影(CSS3)
box-shadow:h-shadow水平阴影必需 v-shadow垂直阴影必需 blur模糊距离（虚实）可选 spread阴影尺寸（影子大小）可选 color阴影颜色可选 insert将外部阴影（outset是默认的，但是不能写）改为内部阴影可选；

4.鼠标样式
<ul>
  <li style="cursor:default">我是默认</li>
  <li style="cursor:pointer">我是小手</li>
  <li style="cursor:move">我是移动</li>
  <li style="cursor:text">我是文本</li>
  <li style="cursor:not-allowed">我是禁止</li>
</ul>

5.表单轮廓线
 outline : outline-color ||outline-style || outline-width 
<label for="username">姓名：</label><input type="text" id="username" name="username" value="张三" style="outline: solid rgb(255, 0, 242) 2px;">

6.文本域textarea默认可以拖动大小，但是实际开发中不可以拖动
<textarea  style="resize: none;"></textarea>

7.文本显示方式
white-space: normal; 默认处理方式
white-space: nowrap; 强制在同一行内显示所有文本，直到文本结束或者遭遇br标签对象才换行

8.文字溢出
text-overflow: clip; 不显示省略标记（...），而是简单的裁切 
text-overflow：ellipsis; 当对象内文本溢出时显示省略标记（...）一定要首先强制一行内显示，使用overflow将超出的部分隐藏，再显示省略标记达到效果
/*1. 先强制一行内显示文本*/
white-space: nowrap;
/*2. 超出的部分隐藏*/
overflow: hidden;
/*3. 文字用省略号替代超出的部分*/
text-overflow: ellipsis;
/*设置背景图片大小。图片可以保有其原有的尺寸，或者拉伸到新的尺寸，或者在保持其原有比例的同时缩放到元素的可用空间的尺寸*/
background-size:cover;
/*用来设置如何处理元素中的white space*/
white-space:pre-wrap;
/*指定了怎样在单词内断行*/
word-break
transition：/*过渡可以为一个元素在不同状态之间切换的时候定义不同的过渡效果。比如在不同的伪元素之间切换，像是 :hover，:active 或者通过 JavaScript 实现的状态变化。*/
```

## CSS的简写方法

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

## CSS书写建议

### 创建目录project

- img文件夹
  - 图片文件
- css文件夹
  - style.css
- js文件夹
  - main.js
- fonts文件夹
  - 字体类文件

- index.html
- favicon.ico

### class类名的命名

对于class类名的命名，以字母开头命名，且全部字母为小写，单词之间统一使用下划线 `_` 连接。常用命名推荐：

| ClassName              | 含义                                     |
| ---------------------- | ---------------------------------------- |
| about                  | 关于                                     |
| account                | 账户                                     |
| arrow                  | 箭头图标                                 |
| article                | 文章                                     |
| aside                  | 边栏                                     |
| audio                  | 音频                                     |
| avatar                 | 头像                                     |
| bg,background          | 背景                                     |
| bar                    | 栏（工具类）                             |
| branding               | 品牌化                                   |
| crumb,breadcrumbs      | 面包屑                                   |
| btn,button             | 按钮                                     |
| caption                | 标题，说明                               |
| category               | 分类                                     |
| chart                  | 图表                                     |
| clearfix               | 清除浮动                                 |
| close                  | 关闭                                     |
| col,column             | 列                                       |
| comment                | 评论                                     |
| community              | 社区                                     |
| container              | 容器                                     |
| content                | 内容                                     |
| copyright              | 版权                                     |
| current                | 当前态，选中态                           |
| default                | 默认                                     |
| description            | 描述                                     |
| details                | 细节                                     |
| disabled               | 不可用                                   |
| entry                  | 文章，博文                               |
| error                  | 错误                                     |
| even                   | 偶数，常用于多行列表或表格中             |
| fail                   | 失败（提示）                             |
| feature                | 专题                                     |
| fewer                  | 收起                                     |
| field                  | 用于表单的输入区域                       |
| figure                 | 图                                       |
| filter                 | 筛选                                     |
| first                  | 第一个，常用于列表中                     |
| footer                 | 页脚                                     |
| forum                  | 论坛                                     |
| gallery                | 画廊                                     |
| group                  | 模块，清除浮动                           |
| header                 | 页头                                     |
| help                   | 帮助                                     |
| hide                   | 隐藏                                     |
| hightlight             | 高亮                                     |
| home                   | 主页                                     |
| icon                   | 图标                                     |
| info,information       | 信息                                     |
| last                   | 最后一个，常用于列表中                   |
| links                  | 链接                                     |
| login                  | 登录                                     |
| logout                 | 退出                                     |
| logo                   | 标志                                     |
| main                   | 主体                                     |
| menu                   | 菜单                                     |
| meta                   | 作者、更新时间等信息栏，一般位于标题之下 |
| module                 | 模块                                     |
| more                   | 更多（展开）                             |
| msg,message            | 消息                                     |
| nav,navigation         | 导航                                     |
| next                   | 下一页                                   |
| nub                    | 小块                                     |
| odd                    | 奇数，常用于多行列表或表格中             |
| off                    | 鼠标离开                                 |
| on                     | 鼠标移过                                 |
| output                 | 输出                                     |
| pagination             | 分页                                     |
| pop,popup              | 弹窗                                     |
| preview                | 预览                                     |
| previous               | 上一页                                   |
| primary                | 主要                                     |
| progress               | 进度条                                   |
| promotion              | 促销                                     |
| rcommd,recommendations | 推荐                                     |
| reg,register           | 注册                                     |
| save                   | 保存                                     |
| search                 | 搜索                                     |
| secondary              | 次要                                     |
| section                | 区块                                     |
| selected               | 已选                                     |
| share                  | 分享                                     |
| show                   | 显示                                     |
| sidebar                | 边栏，侧栏                               |
| slide                  | 幻灯片，图片切换                         |
| sort                   | 排序                                     |
| sub                    | 次级的，子级的                           |
| submit                 | 提交                                     |
| subscribe              | 订阅                                     |
| subtitle               | 副标题                                   |
| success                | 成功（提示）                             |
| summary                | 摘要                                     |
| tab                    | 标签页                                   |
| table                  | 表格                                     |
| txt,text               | 文本                                     |
| thumbnail              | 缩略图                                   |
| time                   | 时间                                     |
| tips                   | 提示                                     |
| title                  | 标题                                     |
| video                  | 视频                                     |
| wrap                   | 容器，包，一般用于最外层                 |
| wrapper                | 容器，包，一般用于最外层                 |

### CSS属性书写顺序

建议遵循以下顺序：

1. 布局定位属性：display / position / float / clear / visibility / overflow（建议 display 第一个写，毕竟关系到模式）
2. 自身属性：width / height / margin / padding / border / background
3. 文本属性：color / font / text-decoration / text-align / vertical-align / white- space / break-word
4. 其他属性（CSS3）：content / cursor / border-radius / box-shadow / text-shadow / <u>background:linear-gradient</u>

```css
.jdc {
    display: block;
    position: relative;
    float: left;
    width: 100px;
    height: 100px;
    margin: 0 10px;
    padding: 20px 0;
    font-family: Arial, 'Helvetica Neue', Helvetica, sans-serif;
    color: #333;
    background: rgba(0,0,0,.5);
    -webkit-border-radius: 10px;
    -moz-border-radius: 10px;
    -o-border-radius: 10px;
    -ms-border-radius: 10px;
    border-radius: 10px;
}
```

书写时，注意分号和大括号

## chrome调试

在网页右键点击inspect，在左侧点击黑色箭头，出现我们需要的html元素，右侧是响应的css文件，可以鼠标点击后面的数值，按上箭头是调大数值，下箭头是调小数值，css文件的右上角是对应的html文件的行数

可以通过颜色判断盒子，蓝色是盒子的宽度高度；青色是内边距；橙色是外边距

**常见错误**

1. css文件中，如果出现黄色三角符号说明这句话有错误
2. 声明类名和html调用名不一致或者css文件引入不对，右边没有样式或是出现

```css
element.style{
}
```

# CSS3

## 选择器

### 属性选择器

==类选择器，属性选择器，伪类选择器==权重为10

![css3-属性选择器](C:\Users\admin\Desktop\practicing\图片笔记\前端\css\css3-属性选择器.png)

```css
button[disabled]{}
input[type="search"]{}
div[class^="icon"]{}
```

### 结构伪类选择器

![css3-结构伪类选择器](C:\Users\admin\Desktop\practicing\图片笔记\前端\css\css3-结构伪类选择器.png)

`nth-child`参数详解

- 注意：本质上就是选中第几个子元素
- `n`可以是数字、关键字、公式
- `n`如果是数字，就是选中第几个
- 常见的关键字有`even`偶数、`odd`奇数
- 常见的公式如下(如果`n`是公式，则从`0`开始计算)
- 但是第`0`个元素或者超出了元素的个数会被忽略

![css3-nth-child参数详解](C:\Users\admin\Desktop\practicing\图片笔记\前端\css\css3-nth-child参数详解.png)

```css
/* 需要满足是span并且是div里的第一个子元素，所以不是span的标签不能选取出来 */
div span:nth-child(1) {}
/* 可以用这个 */
div span:first-of-type {}
```

### 伪元素选择器

![css3-伪元素选择器](C:\Users\admin\Desktop\practicing\图片笔记\前端\css\css3-伪元素选择器.png)

伪类选择器注意事项

- ==`before`和`after`必须有`content`属性==
- `before`在内容前面，`after`在内容后面
- `before`和`after`创建的是一个元素，但是属于行内元素。创建出来的元素在`Dom`中查找不到，所以称为伪元素。伪元素和标签选择器一样，权重为 1

>我用类选择器测试过了不行，这里用标签选择器
>
>可以理解为一个伪元素的盒子

```html
<style>
header {
    width: 100%;
    height: 300px;
    border: 1px solid lightcoral;
}


header::after,
header::before {
    width: 20px;
    height: 50px;
    text-align: center;
    display: inline-block;
}

header::after {
    content: '\ea50';
    background-color: lightskyblue;
}

header::before {
    content: '1';
    background-color: mediumaquamarine;
}
</style>

<header>2</header>    
```

## 2D转换+3D转换

### 三维坐标系

- x 轴：水平向右，向右正值
- y 轴：垂直向下，向下正值
- z 轴：垂直屏幕，向屏幕外侧正值

### 移动`translate`

- `2D`的移动主要是指水平、垂直方向上的移动
- `translate`最大的优点就是不影响其他元素的位置
- `translate`中的100%单位，是相对于盒子本身的宽度和高度来进行计算的
- `tranlateZ`一般单位用px
- 行内标签没有效果

```css
/* x:x轴，y:y轴 z:z轴*/
transform: translate(x, y)
transform: translateX(n)
transfrom: translateY(n)

transform:tranlateX(n) translateY(n) translateZ(n) /*等价于*/
transform:translate3d(x,y,z)
/* 注意：x, y, z对应的值不能省略，不需要填写用0进行填充*/
```

### 3d透视`perspective`

- 透视也称为视距，所谓的视距就是人的眼睛到屏幕的距离，距离视觉点越近的在电脑平面成像越大，越远成像越小。==z轴越大(正值)，我们看到的物体就越大==
- 透视的单位是像素
- 透视需要写在被视察元素的父盒子上面（不是直接的父级也可以）

![css3-perspective](C:\Users\admin\Desktop\practicing\图片笔记\前端\css\css3-perspective.png)

### 2d转换中心点`transform-origin`

- 注意参数`x`和`y`用空格隔开
- `x y`默认旋转的中心点是元素的中心`(50% 50%)`，等价于`center center`
- 还可以给`x y`设置像素或者方位名词(`top | bottom | left | right | center`

```css
div:nth-of-type(2) {
    width: 200px;
    height: 200px;
    background-color: pink;
    margin: 100px auto;
    transition: all 1s;
    transform-origin: left bottom;
}

div:nth-of-type(2):hover {
    transform: scale(2, 1);
    transform: rotate(360deg)
}
```

### 转换`rotate`

- `rotate`里面跟度数，单位是`deg`
- 角度为正时，顺时针，角度为负时，逆时针
- 默认旋转的中心点是元素的中心点

> 这个rotate和translate每次相当于从原图转/移动，比如连续写两个rotate，每次都是从原图开始转而不是第二个是第一个的叠加。可以写在一行上

**3D旋转语法**

```css
transform: rotateX(45deg) /*沿着x轴正方向顺时针旋转45度（从x轴正方向看顺时针旋转），负值方向相反*/
transform: rotateY(45deg) /*沿着y轴正方向顺时针旋转45度（从y轴正方向看顺时针旋转），负值方向相反*/
transform: rotateZ(45deg) /*沿着z轴正方向顺时针旋转45度（从z轴正方向看顺时针旋转），负值方向相反*/
transform: rotate3d(x, y, z, 45deg) /*沿着自定义轴旋转 45 deg 为角度*/
transform: rotate3d(1, 1, 0, 45deg) /*沿x轴正方向和y轴正方向矢量和旋转（从这个矢量箭头指出方向看）45度*/
```

### 2d缩放`scale`

- `x`与`y`之间使用逗号进行分隔
- `transform: scale(1, 1)`：宽高都放大一倍，相当于没有放大
- `transform: scale(2, 1)`：宽度变为两倍，高度不变
- `transform: scale(2)`：宽和高都放大了二倍，如果只写了一个参数，第二个参数就和第一个参数一致
- `transform:scale(0.5, 0.5)`：缩小
- `scale`最大的优势：可以设置转换中心点缩放，默认以中心点缩放，而且不影响其他盒子

### 2d转换综合写法以及顺序问题

- 同时使用多个转换，其格式为`transform: translate() rotate() scale()`（同时进行）
- 顺序会影响到转换的效果(先旋转会改变坐标轴方向)
- 但我们同时有位置或者其他属性的时候，==**要将位移放到最前面**==。用到了那个轴必须先移动后旋转

### 3d呈现`transform-style`

- `transform-style: flat`：代表子元素不开启`3D`立体空间，默认的
- `transform-style: preserve-3d`子元素开启立体空间
- 代码写给父级，但是影响的是子盒子

## 动画

动画是CSS3中最具颠覆性的特征之一，可通过设置多个节点来精确的控制一个或者一组动画，从而实现复杂的动画效果。相比较过渡，动画可以实现更多变化，更多控制，连续播放等效果

动画的基本使用

- 先定义动画：`@keyframes identifier {}`
- 在调用定义好的动画： `animation-name | animation-duration`

### 动画序列

- `0%`/`from`是动画的开始，`100%`/`to`是动画的完成，里面的百分比是时间的划分，需要是整数
- 在`@keyframs`中规定某项CSS样式，就由创建当前样式逐渐改为新样式的动画效果
- 动画是使元素从一个样式逐渐变化为另一个样式的效果，可以改变任意多的样式任意多的次数

### 常用动画属性

![css3-常用动画属性](C:\Users\admin\Desktop\practicing\图片笔记\前端\css\css3-常用动画属性.png)

### 动画属性简写

- `animation-name`和`animation-duration`必须写
- 简写属性里面不包含`animation-paly-state`，经常和鼠标悬浮等其他配合使用
- 要想动画走回来，而不是直接调回来：`animation-direction: alternate`
- 盒子动画结束后，停在结束位置：`animation-fill-mode: forwards` 

```css
/* animation: 动画名称 持续时间 运动曲线 何时开始 播放次数 是否反方向 起始与结束状态 */
animation: name duration timing-function delay iteration-count direction fill-mode
```

### 速度曲线`timing-function`

`animation-timing-function`规定动画的速度曲线，默认是`ease`，`transition`也有一样的函数

![css3-速度曲线](C:\Users\admin\Desktop\practicing\图片笔记\前端\css\css3-速度曲线.png)

# 浏览器私有前缀

浏览器私有前缀是为了兼容老版本的写法，比较新版本的浏览器无需添加

`-moz`：代表firefox浏览器私有属性

`-ms-`代表ie浏览器私有属性

`-webkit`：代表safari、chrome私有属性

`-o-`：代表Opera私有属性

**推荐的兼容老版本浏览器的写法，先写私有前缀**

```css
-moz-border-radius: 10px;
-webkit-border-radius:10px;
-o-border-radius:10px;
border-radius:10px;
```



# Emmet Abbreviation

1. 直接输入`标签名+tab`
2. `div*3+tab`，可以快速生成3个div
3. 父子级关系可以使用`>`，例如`ul>li`
4. 兄弟级关系用`+`，例如`div+p`
5. `,classname`和`.idname`可以带上类和id名
6. 使用的div类名是带有顺序时，可以使用自增符号`$`

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

# 笔记

```css
1. float和position:absolute会自动将元素转换为行内块元素，不用设置display:inline-block，会有宽度和高度
2. 在使用line-height = height设置元素垂直居中对齐时，注意line-height要写在font下面，不然设置会被覆盖
3. 关于padding和margin：padding和border撑大了盒子（指盒子实际的大小大于自己设置的width和height），对于内容的样式也会应用在padding上，但是margin不会撑大盒子
4. 使用class时，注意继承的权重



```

