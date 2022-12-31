# Flask介绍

Flask诞生于2010年，是Armin ronacher用Python语言基于Werkzeug工具箱编写的轻量级Web开发框架。

Flask本身相当于一个内核，其他几乎所有的功能都要用到扩展（邮件扩展Flask-Mail，用户认证Flask-Login，数据库Flask-SQLAlchemy），都需要用第三方的扩展来实现。比如可以用Flask扩展加入ORM、窗体验证工具，文件上传、身份验证等。Flask 没有默认使用的数据库，你可以选择 MySQL，也可以用 NoSQL。

其WSGI工具箱采用Werkzeug（路由模块），模板引擎则使用Jinja2。这两个也是Flask框架的核心

## 与Django对比

django提供了

1. `django-admin`快速创建项目工程目录
2. `manage.py`管理项目工程
3. orm模型（数据库抽象层）
4. admin后台管理站点
5. 缓存机制
6. 文件存储系统
7. 用户认证系统

而这些，flask都没有，都需要扩展包来提供

# 工程搭建

## 环境安装

```
# 虚拟环境
mkvirtualenv  # 创建虚拟环境
rmvirtualenv  # 删除虚拟环境
workon  # 进入虚拟环境、查看所有虚拟环境
deactivate  # 退出虚拟环境

# pip
pip install  # 安装依赖包
pip uninstall  # 卸载依赖包
pip list  # 查看已安装的依赖包
pip freeze  # 冻结当前环境的依赖包
```

## Flask对象初始化参数

Flask 程序实例在创建的时候，需要默认传入当前 Flask 程序所指定的包(模块)，接下来就来详细查看一下 Flask 应用程序在创建的时候一些需要我们关注的参数：

- `import_name`
  - Flask程序所在的包(模块)，传 `__name__` 就可以
  - 其可以决定 Flask 在访问静态文件时查找的路径
- `static_url_path`
  - 静态文件访问路径，可以不传，默认为：`/ + static_folder`
- `static_folder`
  - 静态文件存储的文件夹，可以不传，默认为 `static`
- `template_folder`
  - 模板文件存储的文件夹，可以不传，默认为 `templates`

`app.py`

```python
# 导入Flask类
from flask import Flask

# 顺着这个可以找到flask项目的文件目录，这里是.../flaskProject。这样静态文件存储的文件夹（默认static）和模板文件（默认template）存储的文件夹的目录就不用指明了，flask会按照默认目录找
app = Flask(__name__)
# 修改参数的情况下
# 访问127.0.0.1:5000/静态文件访问路径/文件名.后缀才可以访问到图片
# app = Flask(__name__, static_url_path='/静态文件访问路径', static_folder='静态文件存储的文件夹') static_folder需要存在，默认会在当前目录(flaskProject)下找，静态文件访问路径不需要真实存在，用来访问静态文件

# 装饰器的作用是将路由映射到视图函数index
# 定义视图
@app.route('/')
def hello_world():  # put application's code here
    return 'Hello World!'

# Flask应用程序实例的run方法启动WEB服务器
if __name__ == '__main__':
    app.run() # 默认
    # 可以指定运行的主机IP地址，端口，是否开启调试模式
    """
    关于DEBUG调试模式
    1. 程序代码修改后可以自动重启服务器
    2. 在服务器出现相关错误的时候可以直接将错误信息返回到前端进行展示
    """
    # app.run(host="0.0.0.0", port=5000, debug = True)，新版本使用命令行
```

<u>命令行运行</u>

```bash
python app.py # 有app.run()
flask run
flask run -h 0.0.0.0 -p 8000 绑定地址 端口
python -m flask run # 如果上面的不行
flask run --host 0.0.0.0 --port=50001 --debugger --reload
```

## 应用程序配置参数

对于Flask对象<u>初始化参数</u>仅仅设置的是Flask本身的属性，比如：

- Flask从哪里读取静态文件
- Flask从哪里读取模板文件
- ...

等等。

<u>应用程序配置参数</u>设置的是一个Web应用工程的相关信息，比如：

- 数据库的连接信息
- 日志的配置信息
- 自定义的配置信息
- ...

等等

Django将所有配置信息都放到了`settings.py`文件中，而Flask则不同。Flask将配置信息保存到了`app.config`属性中，该属性可以按照字典类型进行操作

### 读取

1. `app.config.get(name)`
2. `app.config[name]`

### 1. 从配置对象中加载配置信息app.config.from_object(object)

- `app.config.from_object(配置对象)`

```python
class DefaultConfig(object):
    """默认配置，注意大写"""
    SECRET_KEY = 'TPmi4aLWRbyVq8zu9v82dWYW1'

app = Flask(__name__)

app.config.from_object(DefaultConfig) # 传刚才的类

@app.route("/")
def index():
    print(app.config['SECRET_KEY'])
    return "hello world"
```

**应用场景：**作为默认配置写在程序代码中 

可以继承

```python
class DevelopmentConfig(DefaultConfig):
    DEBUG=True
```

**缺点：**敏感信息暴露

### 2. 从配置文件中加载配置信息app.config.from_pyfile('file_name.py')

- 配置文件`setting.py`
- `app.config.from_pyfile(配置文件)`

```python
# setting.py
SECRET_KEY = 'TPmi4aLWRbyVq8zu9v82dWYW1'

# helloworld.py
app = Flask(__name__)

app.config.from_pyfile('setting.py')

@app.route("/")
def index():
    print(app.config['SECRET_KEY'])
    return "hello world"
```

**应用场景：**在项目中使用固定的配置文件

**缺点：**不能继承，文件路径固定（例如在linux和windows系统中）

### 3. 从环境变量中加载配置信息PROJECT_SETTING

>**环境变量**（environment variables）一般是指在操作系统中用来指定操作系统运行**环境**的一些参数，如：临时文件夹位置和系统文件夹位置等。 **环境变量**是在操作系统中一个具有特定名字的对象，它包含了一个或者多个应用程序所将使用到的信息

Flask使用环境变量加载配置的本质是通过环境变量值找到配置文件，再读取配置文件的信息，其使用方式为`app.config.from_envvar('环境变量名')`。环境变量的值为配置文件的绝对路径

先在终端中执行如下命令

```bash
export PROJECT_SETTING='~/Desktop/setting.py'
```

再运行如下代码

```python
app = Flask(__name__)

app.config.from_envvar('PROJECT_SETTING', silent=True)

@app.route("/")
def index():
    print(app.config['SECRET_KEY'])
    return "hello world"
```

关于`silent`的说明：

表示系统环境变量中没有设置相应值时是否抛出异常

- `False`表示不安静的处理，没有值时报错通知，默认为`False`
- `True`表示安静的处理，即时没有值也让`Flask`正常的运行下去

**应用场景：** 配置文件的地址不固定；在代码中不想暴露真实的配置文件地址，只在运行代码的服务器上才有真实配置文件的信息

**缺点：**需要设置环境变量

### 项目中的常用方式

使用配置对象加载默认配置，使用环境变量覆盖不想出现在代码中的敏感配置信息

```python
def create_flask_app(config):
    """
    创建Flask应用
    :param config: 配置对象
    :return: Flask应用
    """
    app = Flask(__name__)
    app.config.from_object(config) # 保证程序可以正常运行

    # 从环境变量指向的配置文件中读取的配置信息会覆盖掉从配置对象中加载的同名参数
    app.config.from_envvar("PROJECT_SETTING", silent=True)
    return app

# 封装-工厂函数
class DefaultConfig(object):
    """默认配置"""
    SECRET_KEY = 'itcast1'

# 继承，运行在调试模式下
class DevelopmentConfig(DefaultConfig):
    DEBUG=True # 示例，debug版本不是这么开的

# app = create_flask_app(DefaultConfig)
app = create_flask_app(DevelopmentConfig)

@app.route("/")
def index():
    print(app.config['SECRET_KEY'])
    return "hello world"
```

## 开发服务器启动方式（推荐）FLASK_APP

在1.0版本之后，Flask调整了开发服务器的启动方式，由代码编写`app.run()`语句调整为命令`flask run`启动

```python
1. 不用再写app.run()（在程序中）
# if __name__ == '__main__':
#     app.run() # 默认

2. 配置环境变量（在终端）
export FLASK_APP=helloworld
export FLASK_ENV=production 运行在生产模式，未指明环境变量则默认为此方式
export FLASK_ENV=development 运行在开发模式

3. 运行（在终端）
flask run
flask run -h 0.0.0.0 -p 8000 绑定地址 端口
python -m flask run # 如果上面的不行
```

## Debug模式的作用

1. 后端出现错误，会返回真实的错误信息给前端
2. 修改代码后，自动重启开发服务器

# 路由

## 查询路由信息

1.命令行方式

```
flask routes
```

2.在程序中获取

```python
print(app.url_map) # map object，迭代器
# 遍历
for rule in app.url_map.iter_rules():
    print('name={} path={}'.format(rule.endpoint, rule.rule))
    
# 以json的方式返回应用内的所有路由信息
import json
@app.route('/')
def route_map():
    rules_iterator = app.url_map.iter_rules()
    return json.dumps({rule.endpoint: rule.rule for rule in rules_iterator})
```

## 指定请求方式

请先查看[HTTP请求方法](https://blog.csdn.net/weixin_39959236/article/details/110463453)

在Flask中，定义路由其默认的请求方式为：

- GET

- OPTIONS(自带)

- HEAD(自带)：只返回GET请求处理时的响应头，不返回响应体

Flask会自动封装OPTIONS和HEAD，不需要手动写

用`methods`参数可以自己指定一个接口的请求方式

```python
@app.route("/itcast1", methods=["POST"])
def view_func_1():
    return "hello world 1"

@app.route("/itcast2", methods=["GET", "POST"])
def view_func_2():
    return "hello world 2"
```

### OPTIONS请求方式和CORS跨域

关于CROS请查看[使用CORS解决跨域问题](https://www.jianshu.com/p/98d4bc7565b2)和[跨域资源共享 CORS 详解](https://www.ruanyifeng.com/blog/2016/04/cors.html)博客。简单地来说，对于跨域的非简单请求，浏览器会先发送一个`OPTIONS`的预检请求。可以这么理解，`OPTIONS`是用于询问服务器接口信息的

# 蓝图

>在一个Flask应用项目中，如果业务视图过多，可否将以某种方式划分出的业务单元单独维护，将每个单元用到的视图、静态文件、模板文件等独立分开？
>
>例如从业务角度上，可将整个应用划分为用户模块单元、商品模块单元、订单模块单元，如何分别开发这些不同单元，并最终整合到一个项目应用中？

在Flask中，使用蓝图Blueprint来分模块组织管理。

蓝图实际可以理解为是一个存储一组视图方法的容器对象，其具有如下特点：

- 一个应用可以具有多个Blueprint
- 可以将一个Blueprint注册到任何一个未使用的URL下比如 “/user”、“/goods”
- Blueprint可以单独具有自己的模板、静态文件或者其它的通用操作方法，它并不是必须要实现应用的视图和函数的
- ==在一个应用初始化时，就应该要注册需要使用的Blueprint==

但是一个Blueprint并不是一个完整的应用，它不能独立于应用运行，而必须要注册到某一个应用中。

## 使用蓝图

1.创建一个蓝图对象

```python
user_bp=Blueprint('user',__name__) # ‘user’表示蓝图的名字，__name__表示从当前蓝图默认目录下查找
```

2.在这个蓝图对象上进行操作，注册路由，指定静态文件夹，注册模版过滤器

```python
@user_bp.route('/login')
def user_profile():
    return 'login page'
```

3.在应用对象上注册这个蓝图对象

```python
app.register_blueprint(user_bp)
# 注册时可以指定前缀
app.register_blueprint(user_bp, url_prefix='/user') # 访问http://127.0.0.1:5000/user/login
app.register_blueprint(goods_bp, url_prefix='/goods') # http://127.0.0.1:5000/goods/login

# 静态文件目录
"""
和应用对象不同，蓝图对象创建时不会默认注册静态目录的路由。需要我们在创建时指定 static_folder 参数
"""
admin = Blueprint("admin",__name__,static_folder='static_admin') # 将蓝图所在目录下的static_admin目录设置为静态目录
app.register_blueprint(admin,url_prefix='/admin')
# 可以使用/admin/static_admin/<filename>访问static_admin目录下的静态文件了

# 也可通过static_url_path改变访问路径
admin = Blueprint("admin",__name__,static_folder='static_admin',static_url_path='/lib')
app.register_blueprint(admin,url_prefix='/admin')
# 可以使用/admin/lib/static_admin/<filename>访问static_admin目录下的静态文件了

# 模板文件目录
"""
蓝图对象默认的模板目录为系统的模版目录，可以在创建蓝图对象时使用 template_folder 关键字参数设置模板目录
"""
admin = Blueprint('admin',__name__,template_folder='my_templates')
```

### 目录（包）蓝图

对于一个打算包含多个文件的蓝图，通常将创建蓝图对象放到Python包的`__init__.py`文件中

```
--------- project # 工程目录
  |------ main.py # 启动文件
  |------ user  #用户蓝图
  |  |--- __init__.py  # 此处创建蓝图对象
  |  |--- passport.py  
  |  |--- profile.py
  |  |--- ...
  |
  |------ goods # 商品蓝图
  |  |--- __init__.py
  |  |--- ...
  |...
```

```python
# module name: goods 
# goods/__init__.py
from flask import Blueprint
goods_bp = Blueprint('goods', __name__)
from . import views # 防止循环引用

# goods/views.py
from . import goods.bp
@user_bp.route('/login')
def user_profile():
    return 'login page'

# project/main.py
from goods import goods_bp
app.register_blueprint(goods_bp)
```

# 处理来自客户端的请求

>在视图编写中需要读取客户端请求携带的数据时，如何才能正确的取出数据呢？
>
>请求携带的数据可能出现在HTTP报文中的不同位置，需要使用不同的方法来获取参数

## URL路径参数（动态路由）

例如，有一个请求访问的接口地址为`/users/123`，其中`123`实际上为具体的请求参数，表明请求123号用户的信息。此时如何从url中提取出123的数据？

Flask不同于Django直接在定义路由时编写正则表达式的方式，而是采用转换器语法：

```python
@app.route('/users/<user_id>')
def user_info(user_id):
    print(type(user_id))
    return 'hello user {}'.format(user_id)
# 等价于
@app.route('/users/<string:user_id>')
def user_info(user_id):
    print(type(user_id))
    return 'hello user {}'.format(user_id)
```


此处的`<>`即是一个转换器，默认为**字符串**类型，即将该位置的数据以字符串格式进行匹配、并以字符串为数据类型类型、 user_id为参数名传入视图

**Flask也提供其他类型的转换器**

```python
DEFAULT_CONVERTERS = {
    'default':          UnicodeConverter,
    'string':           UnicodeConverter,
    'any':              AnyConverter,# 在一定范围内
    'path':             PathConverter,
    'int':              IntegerConverter,
    'float':            FloatConverter,
    'uuid':             UUIDConverter,
}
```

以整型匹配数据，可以如下使用：

```python
@app.route('/users/<int:user_id>') # 要求输入整型并会自动转换成整型
def user_info(user_id):
    print(type(user_id))
    return 'hello user {}'.format(user_id)


@app.route('/users/<int(min=1):user_id>')
def user_info(user_id):
    print(type(user_id))
    return 'hello user {}'.format(user_id)
```

### 自定义转换器BaseConverter

1.创建转换器类，保存匹配时的正则表达式

```python
from werkzeug.routing import BaseConverter

class MobileConverter(BaseConverter):
    """
    手机号格式
    """
    # 注意regex名字固定
    regex = r'1[3-9]\d{9}'
```

2.将自定义的转换器告知Flask应用

```python
app = Flask(__name__)

# 将自定义转换器添加到转换器字典中，并指定转换器使用时名字为: mobile
app.url_map.converters['mobile'] = MobileConverter
```

3.在使用转换器的地方定义使用

```python
@app.route('/sms_codes/<mobile:mob_num>')
def send_sms_code(mob_num):
    return 'send sms code to {}'.format(mob_num)
```

## 使用request对象读取请求传递的参数

不同位置的参数都存放在request的不同属性中

| 属性    | 说明                           | 类型           |
| :------ | :----------------------------- | :------------- |
| data    | 记录请求的数据，并转换为字符串 | *              |
| form    | 记录请求中的表单数据           | MultiDict      |
| args    | 记录请求中的查询参数           | MultiDict      |
| cookies | 记录请求中的cookie信息         | Dict           |
| headers | 记录请求中的报文头             | EnvironHeaders |
| method  | 记录请求使用的HTTP方法         | GET/POST       |
| url     | 记录请求的URL地址              | string         |
| files   | 记录请求上传的文件             | *              |

例如想要获取请求`/articles?channel_id=1`中`channel_id`的参数，可以按如下方式使用：

```python
from flask import request

@app.route('/articles')
def get_articles():
    channel_id = request.args.get('channel_id')
    return 'you wanna get articles of channel {}'.format(channel_id)
```

使用POSTMAN客户端上传图片到服务器，并保存到服务器中

```python
from flask import request

@app.route('/upload', methods=['POST'])
def upload_file():
    f = request.files['pic']
    # with open('./demo.png', 'wb') as new_file:
    #     new_file.write(f.read())
    f.save('./demo.png') # 等价
    return 'ok'
```

# 给客户端发送响应信息

## 返回模板render_template

使用`render_template`方法渲染模板并返回响应体

```html
<!-- templates/index.html -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
我的模板html内容
<br/>{{ my_str }}
<br/>{{ my_int }}
</body>
</html>
```

```python
from flask import render_template

@app.route('/')
def index():
    data = {
        my_str = "zhangsan"
        my_int = 123
    }
    return render_template('index.html', **data)

# 也可以使用jsonify

@app.route('/')
def index():
    data = {
        my_str = "zhangsan"
        my_int = 123
    }
    return render_template('index.html', **data)
```

## 重定向redirect

```python
from flask import redirect

@app.route('/demo2')
def demo2():
    return redirect('http://www.itheima.com') # 注意这里一定要写protocol，不然就是本地的protocol
```

## jsonify返回json

相比`json.dumps()`将字典转换成json格式，`jsonify`除了转换成json格式字符串，并且设置了响应头`Content-Type:application/json`

```python
from flask import jsonify

@app.route('/demo3')
def demo3():
    json_dict = {
        "user_id": 10,
        "user_name": "laowang"
    }
    return jsonify(json_dict)
```

## 自定义状态码和响应头

### 1.元祖方式

可以返回一个元组，这样的元组必须是`(response, status, headers)`的形式，且至少包含一个元素。 `status `值会覆盖状态代码，`headers`可以是一个列表或字典，作为额外的消息标头值

```python
@app.route('/demo4')
def demo4():
    # return '状态码为 666', 666, [('Itcast', 'Python')] # headers可以是一个列表或字典，代表itcast: Python
    return '状态码为 666', 666, {'Itcast': 'Python'}
```

### 2.make_response方式

```python
@app.route('/demo5')
def demo5():
    resp = make_response('make response测试')
        resp.headers[“Itcast”] = “Python”
        resp.status = “404 not found” # 必须是状态码和描述信息
    return resp
```

# Cookie与Session

## 设置Cookie

```python
from flask import Flask, make_response

app = Flask(__name__)

@app.route('/cookie')
def set_cookie():
    """
    在响应对象中响应头(Reponse Headers)的位置添加了Set-Cookie:username=itheima; Path=\
    """
    response = make_response('hello world') # 只能是make_response的方式设置响应体
    response.set_cookie('username', 'itheima', max_age=3600) # 设置有效期为3600秒
    return resp
```

## 读取Cookie

```python
from flask import request

@app.route('/get_cookie')
def get_cookie():
    resp = request.cookies.get('username')
    return resp
```

## 删除Cookie

```python
from flask import request

@app.route('/delete_cookie')
def delete_cookie():
    """
    在响应对象中响应头(Reponse Headers)的位置设置了了Set-Cookie的过期时间在很久之前，浏览器发现后会自动清除Cookie
    """
    response = make_response('hello world')
    response.delete_cookie('username')
    return response
```

## 设置Session

Flask将保存的数据放在了浏览器当中，Flask中SECRET_KEY有签名的特性，以保证私密防止修改

```python
from flask import session
# 需要先设置SECRET_KEY
class DefaultConfig(object):
    SECRET_KEY = 'fih9fh9eh9gh2'

app.config.from_object(DefaultConfig)
# 或者直接设置
app.secret_key='xihwidfw9efw'

@app.route('/set_session')
def set_session():
    session['username'] = 'itcast'
    session['passward'] = '1234'
    return 'set session ok'
```

## 读取Session

```python
@app.route('/get_session')
def get_session():
    username = session.get('username')
    passward = session.get('passward')
    return 'get session username {} and passward {}'.format(username, passward)
```

# 异常处理

## HTTP 异常主动抛出abort()

- `abort`方法：抛出一个给定状态代码的 HTTPException 或者 指定响应，例如想要用一个页面未找到异常来终止请求，你可以调用 abort(404)
- 参数：`code` – HTTP的错误状态码。抛出状态码的话，只能抛出 HTTP 协议的错误状态码

```python
from flask import Flask, abort

@app.route('/articles')
def get_articles():
    channel_id = request.args.get('channel_id')
    if channel_id is None:
        abort(400)
    return "you wanna get article of channel id {}".format(channel_id)
```

## 捕获错误@app.errorhandler

- `errorhandler`装饰器
  - 注册一个错误处理程序，当程序抛出指定错误状态码的时候，就会调用该装饰器所装饰的方法，并返回指定的错误信息
- 参数：
  - `code_or_exception` – HTTP的错误状态码或指定异常

例如统一处理状态码为500的错误给用户友好的提示：

```python
@app.errorhandler(500)
def internal_server_error(e):
    return '服务器搬家了'
```

捕获指定异常

```python
@app.errorhandler(ZeroDivisionError)
def zero_division_error(e):
    return '除数不能为0'
```

# 请求钩子

## 启动中间件/中间层的作用

[middleware1  ->  Class Middleware1

​									def pre_process

​									def after_process(response)

​											....

​											return resp

middleware2

middleware3]



请求的处理过程  pre_process  -> view -> after_process

request 请求支持 处理流程

middleware1.pre_process() -> m2.pre_process() -> m3.pre_process()

-> view() -> m3.after_process() -> m2.after_process() -> m1.after_process() -> client

中间件处理 不区分具体是哪个视图 ，对所有视图通通生效

## 请求钩子装饰器

在客户端和服务器交互的过程中，有些准备工作或扫尾工作需要处理，比如：

- 在请求开始时，建立数据库连接；
- 在请求开始时，根据需求进行权限校验；
- 在请求结束时，指定数据的交互格式；

为了让每个视图函数避免编写重复功能的代码，Flask提供了通用设施的功能，即请求钩子

请求钩子是通过装饰器的形式实现，Flask支持如下四种请求钩子：

- `before_first_request`
  - 在处理第一个请求前执行
- `before_request`
  - 在每次请求前执行
  - 如果在某修饰的函数中返回了一个响应，视图函数将不再被调用
- `after_request`
  - 如果没有抛出错误，在每次请求后执行
  - 接受一个参数：视图函数作出的响应
  - 在此函数中可以对响应值在返回之前做最后一步修改处理
  - 需要将参数中的响应在此参数中进行返回
- `teardown_request`
  - 在每次请求后执行
  - 接受一个参数：错误信息，如果有相关错误抛出

```python
from flask import Flask, abort

app = Flask(__name__)

# 在第一次请求之前调用，可以在此方法内部做一些初始化操作
@app.before_first_request
def before_first_request():
    print("before_first_request")


# 在每一次请求之前调用，这时候已经有请求了，可能在这个方法里面做请求的校验
# 如果请求的校验不成功，可以直接在此方法中进行响应，直接return之后那么就不会执行视图函数
@app.before_request
def before_request():
    print("before_request")
    # if 请求不符合条件:
    #     return "laowang"


# 在执行完视图函数之后会调用，并且会把视图函数所生成的响应传入,可以在此方法中对响应做最后一步统一的处理
@app.after_request
def after_request(response):
    print("after_request")
    response.headers["Content-Type"] = "application/json"
    return response


# 请每一次请求之后都会调用，会接受一个参数，参数是服务器出现的错误信息
@app.teardown_request
def teardown_request(response):
    print("teardown_request")


@app.route('/')
def index():
    return 'index'

# 在第1次请求时的打印
"""
before_first_request
before_request
after_request
teardown_request
"""
```

# 上下文

上下文：即语境，语意，在程序中可以理解为在代码执行到某一时刻时，根据之前代码所做的操作以及下文即将要执行的逻辑，可以决定在当前时刻下可以使用到的变量，或者可以完成的事情

Flask中有两种上下文，请求上下文和应用上下文

Flask中上下文对象：相当于一个容器，保存了 Flask 程序运行过程中的一些信息

## 请求上下文request context

在 flask 中，可以直接在视图函数中使用`request`这个对象进行获取相关数据，而`request`就是请求上下文的对象，保存了当前本次请求的相关数据，请求上下文对象有：`request`、`session`

- `request`
  - 封装了HTTP请求的内容，针对的是http请求。举例：`user = request.args.get('user')`，获取的是get请求的参数
- `session`
  - 用来记录请求会话中的信息，针对的是用户信息。举例：`session['name'] = user.id`，可以记录用户信息。还可以通过`session.get('name')`获取用户信息

### 在外部使用请求上下文`request`、`session`

可以通过`with`语句进行使用

```python
>>> from flask import Flask
>>> app = Flask('')
>>> request.args  # 错误，没有上下文环境
报错
>>> environ = {'wsgi.version':(1,0), 'wsgi.input': '', 'REQUEST_METHOD': 'GET', 'PATH_INFO': '/', 'SERVER_NAME': 'itcast server', 'wsgi.url_scheme': 'http', 'SERVER_PORT': '80'}  # 模拟解析客户端请求之后的wsgi字典数据
>>> with app.request_context(environ):  # 借助with语句使用request_context创建请求上下文
...     print(request.path)
...   
/
```

## 应用上下文application context

它的字面意思是应用上下文，但它不是一直存在的，它只是`request context`中的一个对 `app`的代理(人)，所谓local proxy。它的作用主要是帮助 request 获取当前的应用，它是伴 request 而生，随 request 而灭的。

应用上下文对象有：`current_app`，`g`

### 1.current_app

应用程序上下文，用于存储应用程序中的变量，可以通过`current_app.name`打印当前app的名称，也可以在`current_app`中存储一些变量，例如：

- 应用的启动脚本是哪个文件，启动时指定了哪些参数
- 加载了哪些配置文件，导入了哪些配置
- 连了哪个数据库
- 有哪些public的工具类、常量
- 应用跑再哪个机器上，IP多少，内存多大

```python
from flask import Flask, current_app

app1 = Flask(__name__)
app2 = Flask(__name__)

# 以redis客户端对象为例
# 用字符串表示创建的redis客户端
# 为了方便在各个视图中使用，将创建的redis客户端对象保存到flask app中，
# 后续可以在视图中使用current_app.redis_cli获取
app1.redis_cli = 'app1 redis client'
app2.redis_cli = 'app2 redis client'

@app1.route('/route11')
def route11():
    return current_app.redis_cli

@app1.route('/route12')
def route12():
    return current_app.redis_cli

@app2.route('/route21')
def route21():
    return current_app.redis_cli

@app2.route('/route22')
def route22():
    return current_app.redis_cli
```

运行时分两次输入命令行，但是可以同时运行（需绑定不同的端口号）

```
export FLASK_APP=current_app_demo:app1
flask run

export FLASK_APP=current_app_demo:app2
flask run -p 8000
```

作用：`current_app`就是当前运行的flask app，在代码不方便直接操作flask的app对象时，可以操作current_app就等价于操作flask app对象。（我的理解：也可以在蓝图中`import`并使用`current_app`，但是感觉实际用处不大）

### 2.g对象

`g`作为 flask 程序全局的一个临时变量，充当中间媒介的作用，我们可以通过它在一次请求调用的多个函数间传递一些数据。**<u>每次请求都会重设这个变量</u>**

global

```python
def f1():
    global a
    a = 10
    global b
    b = 20
    print(a + b)

def f2():
    a = 30
    b = 50
    print(a + b)

f1() # 30
f2() # 80
```

我的理解：g对象和global类似。另外这个在实际应用上除了少些一些变量名外不觉得很实用

```python
def db_query(user_id, user_name):
    print('user_id={} user_name={}'.format(user_id, user_name))

@app.route('/')
def get_user_profile():
    user_id = 123
    user_name = 'itcast'
    db_query(user_id, user_name)
    return 'hello world'

# 等价于
from flask import Flask, g

app = Flask(__name__)

def db_query():
    user_id = g.user_id
    user_name = g.user_name
    print('user_id={} user_name={}'.format(user_id, user_name))

@app.route('/')
def get_user_profile():
    g.user_id = 123
    g.user_name = 'itcast'
    db_query()
    return 'hello world'
```

### 在外部使用应用上下文current_app、g

可以通过`with`语句进行使用

```python
>>> from flask import Flask
>>> app = Flask('')
>>> app.redis_cli = 'redis client'
>>> 
>>> from flask import current_app
>>> current_app.redis_cli   # 错误，没有上下文环境
报错
>>> with app.app_context():  # 借助with语句使用app_context创建应用上下文
...     print(current_app.redis_cli)
...
redis client
```

## g对象与请求钩子的综合案例

- 建立认证机制，这里用user_id简化
- 对于登录用户返回页面，对于未登录用户利用装饰器返回401

```python
from flask import Flask, abort, g

app = Flask(__name__)

@app.before_request
def authentication():
    """
    利用before_request请求钩子，在进入所有视图前先尝试判断用户身份
    :return:
    """
    # TODO 此处利用鉴权机制（如cookie、session、jwt等）鉴别用户身份信息
    # if 已登录用户，用户有身份信息
    g.user_id = 123
    # else 未登录用户，用户无身份信息
    # g.user_id = None

def login_required(func):
    def wrapper(*args, **kwargs):
        if g.user_id is not None:
            return func(*args, **kwargs)
        else:
            abort(401)

    return wrapper

@app.route('/')
def index():
    return 'home page user_id={}'.format(g.user_id)

@app.route('/profile')
@login_required
def get_user_profile():
    return 'user profile page user_id={}'.format(g.user_id)
```

## 上下文的实现原理

上下文实现的原理是Threadlocal 线程局部变量

我们在`from flask import request `时，`request`像是全局变量

对于两条请求

`/articles?channel_id=123`  -> request.args.get('channel_id')  -> 123  Thread  id A

`/articles?channel_id=124`  -> request.args.get('channel_id')  -> 124  Thread id B

在这里`request.args`存储了多个值，相当于字典

request.args = {

​		'thread_a_id': 123,

​		'thread_b_id': 124

}

