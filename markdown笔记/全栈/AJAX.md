# JSON

json是JavaScript Object Notation的首字母缩写，翻译过来就是javascript对象表示法，这里说的json就是**类似于javascript对象的字符串**，它同时是一种**数据格式**，目前这种数据格式比较流行，逐渐替换掉了传统的xml数据格式，web开发的时候经常使用json数据格式

json有两种格式：

1. 对象格式：对象格式的json数据，使用一对大括号`{}`，大括号里面放入`key:value`形式的键值对，多个键值对使用逗号分隔。
   - json中的(key)属性名称和字符串值需要用==**双引号**==引起来，用单引号或者不用引号会导致读取数据错误。
2. 数组格式
   - 数组格式的json数据，使用一对中括号`[]`，中括号里面的数据使用逗号分隔。

```javascript
JSON.stringify
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

基于浏览器的开发者工具分析通信过程

1. 打开Chrome浏览器
2. <kbd>Ctrl+Shift+I</kbd> 打开 Chrome 的开发者工具
3. 切换到Network面板
4. 选中Doc页签
5. 刷新页面，分析客户端与服务器的通信过程





# AJAX

ajax是Asynchronous JavaScript and XML的简写，ajax是一个前后台配合的技术，它可以让javascript发送**异步的http请求（同时发送多个请求，不用等待）**，与后台通信进行数据的获取，ajax最大的优点是**实现局部刷新**，ajax可以发送http请求，当获取到后台数据的时候更新页面显示数据实现局部刷新，在这里大家只需要记住，当前端页面想和后台服务器进行数据交互就可以使用ajax了。

这里提示一下大家，**==在html页面使用ajax需要在web服务器环境下运行==, 一般向自己的web服务器发送ajax请求。**

## AJAX的使用(jQuery)

浏览器中提供的XMLHttpRequest用法比较复杂，所以jQuery对XMLHttpRequest进行了封装，提供了一系列Ajax相关的函数，极大地降低了Ajax的使用难度。jQuery 中发起 Ajax 请求最常用的三个方法如下：

1. `$.get(url, [data], [callback], [type])`
   - get请求通常用于获取服务端资源（向服务器要资源）例如：根据URL地址，从服务器获取HTML文件、css文件、js文件、图片文件、数据资源等
   - `url`：待载入页面的URL地址
   - `data`：待发送 Key/value 参数
   - `callback`：载入成功时回调函数
   - `type`：返回内容格式，xml, html, script, json, text, _default
2. `$.post(url,[data],[callback],[type])`
   - post请求通常用于向服务器提交数据（往服务器发送资源）例如：登录时向服务器提交的登录信息、注册时向服务器提交的注册信息、添加用户时向服务器提交的用户信息等各种数据提交操作
   - `url`：发送请求地址。
   - `data`：待发送 Key/value 参数
   - `callback`：发送成功时回调函数
   - `type`：返回内容格式，xml, html, script, json, text, _default
3. `$.ajax({url: url, type: 'POST'/'GET', data: {}, success: function(){}, ...}})`
   - jQuery底层AJAX实现。简单易用的高层实现见`$.get`, `$.post`等。`$.ajax()`返回其创建的`XMLHttpRequest`对象。大多数情况下你无需直接操作该函数，除非你需要操作不常用的选项，以获得更多的灵活性。注意，所有的选项都可以通过`$.ajaxSetup()函数`来全局设置
   - `url`：一个用来包含发送请求的URL字符串
   - `type`：请求的方式，例如`GET`或`POST`。 默认为`GET`。注意：其它HTTP请求方法，如`PUT`和`DELETE`也可以使用，但仅部分浏览器支持
   - `data: { }`：这次请求要携带的数据
   - `success: function(data, textStatus, jqXHR)`：请求成功之后的回调函数
   - `async: boolean(默认true)`：默认设置下，所有请求均为异步请求。如果需要发送同步请求，请将此选项设置为 false。注意，同步请求将锁住浏览器，用户其它操作必须等待请求完成才可以执行
   - `dataType`：预期服务器返回的数据类型。如果不指定，jQuery将自动根据HTTP包MIME信息来智能判断，比如XMLMIME类型就被识别为XML
   - `error: function (XMLHttpRequest, textStatus, errorThrown)`：(默认: 自动判断 (xml 或 html)) 请求失败时调用此函数。有以下三个参数：`XMLHttpRequest`对象、错误信息、（可选）捕获的异常对象。如果发生了错误，错误信息（第二个参数）除了得到`null`之外，还可能是`timeout`, `error`, `notmodified`和`parsererror`
   - `contents`
   - `contentType`
   - `context`
   - ...

```html
<!-- 该案例中CORS的问题至今未解决 -->
<body>
    <button id="btnPOST">发起POST请求</button>
    <button id="btnGETINFO">发起单参数的GET请求</button>
    <script>
        $(function () {
            // 使用get方式发送请求，name=李四会以?name=李四&..&..的形式出现在地址栏后
            $('#btnGETINFO').on('click', function () {
                $.get('http://www.liulongbin.top:3006/api/getbooks', { id: 1 }, function (res) {
                    console.log(res)
                })
            })

            // 使用post方式发送请求，name=李四会出现在请求体内
            // 这里没有指定http协议头和ip地址和端口号，那么默认ajax请求会自动帮我们加上
            // 如果请求的是自己的web服务器可以不要加上http协议地址，请求别人服务器的数据需要加上http协议地址
            $('#btnPOST').on('click', function () {
                $.post('http://www.liulongbin.top:3006/api/addbook', { bookname: '水浒传', author: '施耐庵', publisher: '天津图书出版社' }, function (res) {
                    console.log(res)
                })
            })

            $('#btnPOST').on('click', function () {
                $.ajax({
                    // 请求的资源地址，不指定ip地址和端口号表示请求的是自己的服务器资源数据
                    url: 'http://www.liulongbin.top:3006/api/addbook',
                    // 请求方式，GET或POST，可以是小写
                    type: "GET",
                    // 指定对服务器数据的解析格式，常用的是'json'格式
                    dataType: "JSON",
                    // data：表示发送给web服务器的数据, 没有数据不需要设置
                    // 设置请求成功后的执行的函数
                    success: function (response) {
                        console.log(response);
                        // 数据请求回来以后可以绑定给html中的某个标签控件，实现局部刷新
                    },
                    // 设置请求失败后的执行的函数
                    error: function () {
                        alert("请求失败,请稍后再试!");
                    },
                    // async 设置是否异步，默认值是'true'，表示异步，一般不用写
                    async: true
                });
            })
        });
    </script>
</body>
```



