# art-template模板引擎

如果UI结构比较复杂，则拼接字符串的时候需要格外注意引号之前的嵌套。且一旦需求发生变化，修改起来也非常麻烦。

模板引擎，顾名思义，它可以根据程序员指定的模板结构和数据，自动生成一个完整的HTML页面。

`art-template`是一个简约、超快的模板引擎。[中文官网首页](http://aui.github.io/art-template/zh-cn/index.html)。在浏览器中访问[页面](http://aui.github.io/art-template/zh-cn/docs/installation.html)，找到下载链接后，鼠标右键，选择[链接另存为]，将art-template下载到本地，然后，通过 `<script> `标签加载到网页上进行使用。

**art-template的使用步骤**

1. 导入art-template
2. 定义数据
3. 定义模板
4. 调用template函数
5. 渲染HTML结构

**即通过字符串拼接的形式，来渲染UI结构**

## 手动拼接

```html
<body>
  <div id="title"></div>
  <div>姓名：<span id="name"></span></div>
  <div>年龄：<span id="age"></span></div>
  <div>会员：<span id="isVIP"></span></div>
  <div>注册时间：<span id="regTime"></span></div>
  <div>爱好：
    <ul id="hobby">
      <li>爱好1</li>
      <li>爱好2</li>
    </ul>
  </div>

  <script>
    var data = {
      title: '<h3>用户信息</h3>',
      name: 'zs',
      age: 20,
      isVIP: true,
      regTime: new Date(),
      hobby: ['吃饭', '睡觉', '打豆豆']
    }


    $(function () {
      $('#name').html(data.name)
      $('#title').html(data.title)
      $('#age').html(data.age)
      $('#isVIP').html(data.isVIP)
      $('#regTime').html(data.regTime)

      var rows = []
      $.each(data.hobby, function (i, item) {
        rows.push('<li>' + item + '</li>')
      })
      $('#hobby').html(rows.join(''))
    })
  </script>
</body>
```



## 标准语法

art-template提供了`{{ }}`这种语法格式，在`{{ }}`内可以进行变量输出，或循环数组等操作，这种`{{ }}`语法在art-template中被称为标准语法。

1. `{{value}}`
2. `{{obj.key}}`
3. `{{obj['key']}}`
4. `{{a ? b : c}}`
5. `{{a || b}}`
6. `{{a + b}}`
7. ...

在`{{ }}`语法中，可以进行变量的输出、对象属性的输出、三元表达式输出、逻辑或输出、加减乘除等表达式输出

### 原文输出

如果要输出的value值中，包含了HTML标签结构，则需要使用原文输出语法，才能保证HTML标签被正常渲染

`{{@ value }}`

### 条件输出

如果要实现条件输出，则可以在`{{ }}`中使用`if … else if … /if`的方式，进行按需输出

`{{if flag}} 按需输出的内容 {{/if}}`

`{{if flag1}} 按需输出的内容 {{else if flag2}} 按需输出的内容 {{/if}}`

### 循环输出

如果要实现循环输出，则可以在`{{ }}`内，通过`each`语法循环数组，当前循环的索引使用`$index`进行访问，当前的循环项使用`$value`进行访问

```
{{each arr}}
    {{$index}} {{$value}}
{{/each}}
```

### 过滤器

过滤器的本质，就是一个function处理函数。过滤器语法类似管道操作符，它的上一个输出作为下一个输入

`{{value | filterName}}`返回的是处理`value`之后的新值

定义过滤器的基本语法：`template.defaults.imports.filterName = function(value){/*return处理的结果*/}`

定义一个格式化时间的过滤器`dateFormat`如下

```javascript
// 在html中需要渲染的元素
<span>{{$value.time | dateFormat}}</span>
// 在js中定义过滤器
template.defaults.imports.dateFormat = function(dtStr) {
    var dt = new Date(dtStr)

    var y = dt.getFullYear()
    var m = padZero(dt.getMonth() + 1)
    var d = padZero(dt.getDate())

    var hh = padZero(dt.getHours())
    var mm = padZero(dt.getMinutes())
    var ss = padZero(dt.getSeconds())
    return y + '-' + m + '-' + d + ' ' + hh + ':' + mm + ':' + ss// 注意过滤器最后一定要return一个值
}
function padZero(n) {
    if (n < 10) {
        return '0' + n
    } else {
        return n
    }
}
```



## 使用art-template拼接

```html
<body>
    <div id="container"></div>

    <script type="text/html" id="tpl-user">
        <div id="title">{{@title}}</div>
        <div>姓名：<span id="name">{{name}}</span></div>
        <div>年龄：<span id="age">{{age}}</span></div>
        <div>会员：
            <span id="isVIP">
                {{if isVIP === 0}}
                    false
                {{else if isVIP === 1}}
                    true
                {{/if}}
            </span>
        </div>
        <div>注册时间：<span id="regTime">{{regTime | dateFormat}}</span></div>
        <div>爱好：
            <ul id="hobby">
                {{each hobby}}
                    <li>{{$value}}</li>
                {{/each}}
            </ul>
       </div>
    </script>

    <script>
        // 定义处理时间的过滤器
        template.defaults.imports.dateFormat = function (date) {
            var y = date.getFullYear()
            var m = date.getMonth() + 1
            var d = date.getDate()
            return y + '-' + m + '-' + d
        }
        // 2. 定义需要渲染的数据
        var data = { title: '<h3>用户信息</h3>', name: 'zs', age: 20, isVIP: 1, hobby: ['吃饭', '睡觉', '打豆豆'], regTime: new Date() }
        // 4. 调用 template 函数
        var htmlStr = template('tpl-user', data)
        console.log(htmlStr)
        // 5. 渲染HTML结构
        $('#container').html(htmlStr)
    </script>
</body>
```

## 代码

```html
<head>
    <!-- 1. 导入模板引擎 -->
    <!-- 在 window 全局，多一个函数，叫做 template('模板的Id', 需要渲染的数据对象) -->
    <script src="js/jquery.min.js"></script>
</head>

<body>
    <div id="container"></div>
    <!-- 3. 定义模板 -->
    <!-- 3.1 模板的HTML结构，必须定义到script中 -->
    <!-- 如果不指定type，默认是text/javascript -->
    <script type="text/html" id="tpl-user">
    <h1>{{name}}    ------    {{age}}</h1>
    {{@ test}}

    <div>
      {{if flag === 0}}
      flag的值是0
      {{else if flag === 1}}
      flag的值是1
      {{/if}}
    </div>

    <ul>
      {{each hobby}}
      <li>索引是:{{$index}}，循环项是:{{$value}}</li>
      {{/each}}
    </ul>

    <h3>{{regTime | dateFormat}}</h3>
  </script>

    <script>
        // 定义处理时间的过滤器
        template.defaults.imports.dateFormat = function (date) {
            var y = date.getFullYear()
            var m = date.getMonth() + 1
            var d = date.getDate()
            return y + '-' + m + '-' + d
        }
        // 2. 定义需要渲染的数据
        var data = { name: 'zs', age: 20, test: '<h3>测试原文输出</h3>', flag: 1, hobby: ['吃饭', '睡觉', '写代码'], regTime: new Date() }
        // 4. 调用 template 函数
        var htmlStr = template('tpl-user', data)
        console.log(htmlStr)
        // 5. 渲染HTML结构
        $('#container').html(htmlStr)
    </script>
</body>
```

