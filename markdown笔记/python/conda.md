# conda command

```bash
# 检查conda版本
conda --version
# 查看包括版本的更多信息
conda info
# 查看conda帮助信息
conda -h
# 更新Anaconda
conda update conda
# 更新所有包
conda update --all
# 列举当前活跃环境下的所有包
conda list
conda list beautifulsoup4
# 查找指定的包信息，模糊查找，即模糊匹配，只要含py字符串的包名就能匹配到
conda search numpy  
# 查找包，--full-name表示精确查找，即完全匹配名为numpy的包
conda search --full-name numpy
# 在当前活跃环境安装包
conda install beautifulsoup4
# 删除当前环境的包
conda remove beautifulsoup4
# 列举一个非当前活跃环境下的所有包
conda list -n your_env_name
-----------------------------虚拟环境的操作，加上--name和虚拟环境名称-----------------------------
# 查看conda环境管理命令帮助信息
conda create --help
# 创建不同的python版本，直接写出版本号就好了
conda create -n env_name python=3.5
# 指定python版本,以及多个包
conda create -n env_name python=3.4 scipy=0.15.0 astroib numpy
# 复制存在的虚拟环境A，生成新环境B
conda create -n envB --clone envA

# 查看某个指定环境的已安装包
conda list -n env_name
# 为指定环境安装某个包，也可以通过-c指定通过某个channel安装
conda install -n env_name package_name
# 更新指定环境下安装的某个包
conda update -n env_name scrapy
# 删除指定环境安装的包
conda remove -n env_name package_name
# 激活虚拟环境
activate env_name / source activate env_name
# 退出虚拟环境
deactivate / source deactivate
# 删除一个已有环境
conda remove --name env_name --all
# 列出系统存在虚拟环境
conda info -e
conda env list
# 克隆一个环境
conda create --name clone_env --clone envname   # clone_env 代指克隆得到的新环境的名称，envname 代指被克隆的环境的名称
-----------------------------------生成requiremtns--------------------------------------------
# 当使用Conda管理Python环境和包时，你通常会使用Conda自己的导出和导入机制，而不是使用pip freeze。虽然pip freeze仍然可以用于导出某些通过pip安装的包，但它可能不会捕获通过Conda安装的所有包和依赖项
# 你可以使用conda env export命令将当前激活的Conda环境导出到一个YAML文件。这个文件将包括Conda和pip安装的所有包及其精确版本
conda env export > environment.yml
# 要在另一台计算机或同一台计算机的不同位置重新创建环境，你可以使用以下命令，这将从 environment.yml 文件创建一个新的 Conda 环境，并安装其中列出的所有包和版本。
conda env create -f environment.yml

# 如果不使用yml文件
conda list -e > requirements.txt
conda install --yes --file requirements.txt

---------------------------------------更换源-----------------------------------------------
# 查看当前下载源
conda config --show channels
# 配置国内安装的镜像，也可以该文件，参见备忘录
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/r
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/pro
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/msys2
conda config --set show_channel_urls yes
# 清除添加的所有下载源
conda config --remove-key channels
# 删除指定镜像源
conda config --remove channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
--------------------------------------魔法函数----------------------------------------------
%matplotlib inline
!pip install
```

# Jupyter Notebook

`%matplotlib inline`是ipython的魔法函数，可以使matplotlib绘制的图像嵌入在jupyter notebook的单元格里。除此之外还有计算内存，时间的魔法函数
