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

To generate a requirement file: `pip freeze > requirements.txt`。使用`pip list --format=freeze> requirements.txt`会保留依赖包的版本号

Install a list of requirements specified in a Requirements File: ```pip install [-i https://pypi.tuna.tsinghua.edu.cn/simple] -r requirements.txt```

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

将pip和virtualenv结合，适合复杂的虚拟环境管理

pipenv的工作方式是基于项目目录的，它在每个项目的基础上创建和管理虚拟环境，而不是全局地管理所有虚拟环境。每个虚拟环境与项目目录相关联。

如果想要通过名称管理和切换不同的虚拟环境，可以考虑`virtualenvwrapper`，它是`virtualenv`的一个扩展，提供了更高级的虚拟环境管理功能，包括命名环境和切换环境。

### 开发依赖和生产依赖

在 Python 项目开发中，通常会有两类依赖：**项目依赖**和**开发依赖**。

1. **项目依赖**：这些是您的项目在生产环境中运行时所必需的库。例如，如果您正在开发一个网站，那么 Flask 或 Django 可能是项目依赖。
2. **开发依赖**：这些是仅在开发过程中需要的库，而在生产环境中通常不需要。这包括诸如单元测试库（如 pytest）、代码格式化工具（如 black 或 flake8）、或其他用于辅助开发和测试的工具。

当您使用 `pipenv install <package>` 命令安装依赖时，这些依赖默认被视为项目依赖，并会被添加到 `Pipfile` 的 `[packages]` 部分。相反，当您使用 `pipenv install <package> --dev` 命令安装依赖时，这些依赖被视为开发依赖，并会被添加到 `Pipfile` 的 `[dev-packages]` 部分。这样做的好处是，它帮助您区分生产依赖和开发依赖，使得您的项目更加清晰和易于管理。

例如，如果您想要仅为开发环境安装 `pytest`，您会运行：

```bash
$ pipenv install pytest --dev
```

这样，`pytest` 就会被添加到 `Pipfile` 的 `[dev-packages]` 部分，而不是 `[packages]` 部分。

在部署到生产环境时，通常只会安装 `[packages]` 部分列出的依赖，而 `[dev-packages]` 中的依赖则不会被安装，这有助于减少生产环境的依赖大小和复杂性。

### `pipenv`的生产依赖

实际上，当您运行 `pip freeze > requirements.txt` 命令时，它会列出当前虚拟环境中安装的所有包，包括开发依赖和项目依赖。这意味着如果您在虚拟环境中安装了开发依赖，它们也会出现在 `requirements.txt` 文件中。这是因为 `pip freeze` 只是简单地列出了当前环境中安装的所有包，而不区分它们是作为项目依赖还是开发依赖被安装的。

如果您使用 `pipenv` 管理项目依赖，通常不需要使用 `pip freeze` 来生成 `requirements.txt` 文件。`pipenv` 使用 `Pipfile` 和 `Pipfile.lock` 来管理依赖，这两个文件比传统的 `requirements.txt` 提供了更多信息和更好的依赖管理。

- `Pipfile` 替代了 `requirements.txt`，提供了更清晰的依赖声明。
- `Pipfile.lock` 确保了依赖在所有环境中的一致性。

```bash
# 导出项目依赖
# 即 Pipfile 中 [packages] 部分的内容
pipenv lock -r > requirements.txt
# 导出开发依赖
# 即 Pipfile 中 [dev-packages] 部分的内容
pipenv lock -r --dev-only > dev-requirements.txt
# 导出完整的 Pipfile.lock
# Pipfile.lock 文件包含了依赖的确切版本和哈希值，确保了在不同环境中可以重现相同的安装。要导出这个文件，只需将其复制到所需位置即可
cp Pipfile.lock /path/to/destination

# 要在新机器上重建环境，您可以这样做：
# 1.将 Pipfile 和 Pipfile.lock 复制到新项目目录。
# 2.在新项目目录中运行 pipenv install（对于包含所有依赖的环境）或 pipenv install --dev（如果还需要开发依赖）。
```

### pipenv使用

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

# 这条命令会指出pidfile的存储地址和新的虚拟环境的存储地址。pidfile中会有安装包，依赖包和配置环境等相关信息
pipenv --where # 查看项目位置
pipenv --py # 查看解释器信息

# 进入项目目录，安装3.10虚拟环境
pipenv --python 3.10
# 激活/进入虚拟环境，如果不存在虚拟环境会自动安装一个
pipenv shell
# 退出虚拟环境
exit
# 安装包
pipenv install requests
# 卸载包
pipenv uninstall requests
# 更新包
pipenv update requests
# 更新所有包
pipenv update
# 查看包的依赖结构
pipenv graph
# 查看虚拟环境信息，如目录位置
pipenv --venv
# 在虚拟环境中执行命令而不进入shell
pipenv run <command>
# 删除虚拟环境
# Pipfile和Pipfile.lock是pipenv管理依赖的两个关键文件。Pipfile声明了依赖项，Pipfile.lock用于确保这些依赖在所有环境中一致
# 注意 pipenv --rm 只是把创建的虚拟环境删除了，但Pipfile和Pipfile.lock还存。下次如果想要创建与项目myproject相同的虚拟环境时：只要打 cmd，切换到myproject目录下执行命令 pip install 即可
pipenv --rm
# 使用pipenv install -r requirements.txt安装第三方的模块
pipenv install -r requirements.txt
# 查看第三方安装的模块依赖，可导出到requirements.txt
pipenv lock -r -i https://pypi.org/simple
```

## `venv`

较为简单，且在python3.3后作为标准库的一部分不需要额外安装

```bash
sudo apt-get install python3-venv
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

比较灵活，或需要在旧版本的python上创建虚拟环境。需要通过pip额外安装

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

换源时，若是临时使用，可加`-i`

```
vi ~/.pip/pip.conf

[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
[install]
trusted-host=pypi.tuna.tsinghua.edu.cn
```

查看有哪些源`pip config list`
