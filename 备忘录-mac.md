# python

## 安装配置python3

进入`~/.bash_profile`并添加

```bash
# 配置python3
PATH="/Library/Frameworks/Python.framework/Versions/3.9/bin:${PATH}"
export PATH
alias python="/Library/Frameworks/Python.framework/Versions/3.9/bin/python3"
# 配置pip3
export PATH=$PATH:/Library/Frameworks/Python.framework/Versions/3.9/bin/pip3.9
alias pip="/Library/Frameworks/Python.framework/Versions/3.9/bin/pip3.9"
```

## 路径

```bash
# 我的python默认路径
 ~  which virtualenvwrapper.sh
/Library/Frameworks/Python.framework/Versions/3.9/bin/virtualenvwrapper.sh
 ~  which python
python: aliased to /Library/Frameworks/Python.framework/Versions/3.9/bin/python3
```

## Conda

### conda退出base环境

安装conda后取消命令行前出现的base，取消每次启动自动激活conda的基础环境

方法一：

每次在命令行通过`conda deactivate`退出base环境回到系统自动的环境

方法二

1，通过将auto_activate_base参数设置为false实现：

`conda config --set auto_activate_base false`

2，那要进入的话通过`conda activate base`

3，如果反悔了还是希望base一直留着的话通过`conda config --set auto_activate_base true`来恢复

`conda activate spacename`//环境的名称



# Homebrew

## 常用命令

`brew deps`显示了该包依赖的其他包，强烈建议在安装包之前三步走：`search`, `deps`, ` info`，这样会极大程度上避免安装和自身不兼容的包。而且防止安装许多不需要的包。

关于`brew link`则需要了解一个概念-> keg-only ，字面翻译，装在桶里。也就是说这个软件虽然被brew下载下来了，但是却没有被系统所使用，也就是没有被加入到环境变量里。默认`brew install`是进行了`brew link`操作的，但是如果出现冲突，软件就会变成keg-only状态，这时候需要`brew link`使brew安装的软件发挥作用。同时，如果不想使用brew安装的软件，`brew unlink`就是很好的选择，环境变量会指向其他的包。比如使用brew安装python，很容易会和环境中原来的python冲突，`brew unlink`则会失能brewpython。这时候需要仔细看自己将要安装的包的依赖里是否有python，如果有的话很可能会出现意想不到的情况。

细心的朋友可能发现，我安装IINA没有使用`brew install`，而是使用了`brew cask install`。他们的区别是什么呢？`brew install`安装的东西，在brew里被称作formula，其实也就是从网上下载源码，然后make，build，这样就可以在本地安装对应软件。`brew cask install`安装的则是已经编译打包好的软件包。不难想象`brew cask`安装的软件很容易的被移动到了applications文件夹里。

```bash
brew list # 列出所有安装的包
brew search + 包名 # 在源中搜索期望的包
brew info + 包名 # 在源中搜索期望的包，并且打印更详细的信息
brew install + 包名 # 安装对应的包
brew uninstall + 包名 # 卸载已经安装的包
brew update # 升级brew

brew deps + 包名 # 显示包的依赖
brew link + 包名 # 将包link到环境中
brew unlink + 包名 # brew link的逆操作
```

