# pip

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

To generate a requirement file: `pip freeze > requirements.txt`

Install a list of requirements specified in a Requirements File: ```pip install -r requirements.txt```

To uninstall: ```pip uninstall [options] -r <requirements file> ...```

For more information, check [python documentation](https://packaging.python.org/tutorials/installing-packages/#installing-packages)

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

## 虚拟环境

 virtual environments have their own installation directories and they don’t share libraries with other virtual environments.

Currently, there are two common tools for creating Python virtual environments:

- **venv** is available by default in Python 3.3 and later, and installs pip and setuptools into created virtual environments in Python 3.4 and later.
- **virtualenv** needs to be installed separately, but supports Python 2.7+ and Python 3.3+, and pip, setuptools and wheel are always installed into created virtual environments by default (regardless of Python version).

## `pipenv`

```bash
# 以ubuntu系统级的python3.10为例
# 安装pip
sudo apt-get install python3-pip
# 安装pipenv
pip install --user pipenv
# 配置环境变量
export PATH="$PATH:$HOME/.local/bin"
source ~/.bashrc


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

## `venv`

```bash
# install pipenv
pip install --user pipenv
# install packages for your project
cd my_project
pipenv install requests 
# create a virtual environment
python3 -m venv my_project/test_env
source myproject/test_env/bin/activate
# quit
deactivate
```

## `virtualenv`

目前只有这个比较稳定（因为被很多人试过了），保险起见还是用这个吧~

```bash
# 安装虚拟环境
sudo pip install --user virtualenv
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



# 更换源

```
vi ~/.pip/pip.conf

[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
[install]
trusted-host=pypi.tuna.tsinghua.edu.cn
```

