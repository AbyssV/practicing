 # PyCharm

## Tips

- 如果你在条件句前忘记键入```if```，在该句子最后增添```.if```并点击```Tab```键，PyCharm将修复该`if`条件句。该用法同样适用于```True.while```。这即是PyCharm的Postfix Completion功能，它可以帮助用户减少退格键使用次数。或者选中语句，按住`Ctrl+Alt+T`环绕
- 输入`main Enter`PyCharm会自动输入`if __name__ == __main__:`
- 要快速查看插入符号处的文档，请按`Ctrl+Q`（查看|快速文档）。
- 如果光标位于方法调用的括号之间，按下`Ctrl+P`将弹出一个有效参数列表。
- (`Ctrl+Shift+J`快捷键将两行合并为一行，并删除不必要的空格以符合您的代码样式。)
- `Ctrl+Shift+Backspace`（导航|上一个编辑位置）将您带回到您在代码中进行更改的最后一个地方。
- 使用`Ctrl+Shift+F7`（Edit|Find|突出显示文件中的用法）快速突出显示当前文件中某些变量的用法。`F3`/`Shift+F3`向后或向前浏览。按`Esc`退出
- 要查看您的本地文件更改历史记录，请调用本地历史记录|显示上下文菜单中的历史记录（Local History|Show History）。 您可以浏览不同的文件版本，查看差异并回滚到任何以前的版本。
- 使用`Alt+Up`和`Alt+Down`在编辑器中快速移动方法。
- 使用`Ctrl+Shift+V`快捷键选择并将最近的剪贴板内容插入到文本中。如果不选择文本，`Ctrl+C`会复制当前行到剪切板。`Ctrl+Alt+Shift+V`纯文本粘贴
- 您可以通过按`Ctrl+O`(代码|覆盖方法）轻松地覆盖基类的方法。
- `Alt+Insert`智能生成常用代码
- `Alt+Enter`智能提示
- `Ctrl+Alt+V`会自动生成局部变量接受
- 为了帮助您了解主菜单中每个项目的用途，将鼠标指针放在该项目上时，其简短说明会显示在应用程序框架底部的状态栏中。

## 一些常用设置

- 插件介绍：https://www.2bboy.com/archives/153.html

- PyCharm中的设置是可以导入和导出的，**Manage IDE Settings -> Export Settings**可以保存当前PyCharm中的设置

- 在**Editer -> File and Code Templates -> python scripts**输入如下

  ```python
    #!/usr/bin/env python
    # `-*- coding: utf-8 -*-`
    """
    __title__ = '$Package_name'
    __author__ = '$USER'
    __mtime__ = '$DATE'
    """
  ```

- PyCharm默认是自动保存的，习惯自己按```Ctrl+S```全部保存的可以进行如下设置：

- **Appearance & Behavior -> System Settings -> Save files if IDE is idle for xx seconds**的勾去掉

- 对于常用的快捷键，可以设置为visual studio, eclipse一样的：

  - **Keymap -> Visual Studio**

- PyCharm中默认是不能用`Ctrl+'+'`滚轮改变字体大小的，可以在**Genral -> Mouse Control -> Change font size with Control+Mouse Wheel**打上勾

- 设置缩进符为制表符```Tab```

  - **Editor -> Code Style -> Python -> 勾选Use tab character -> Python -> 勾选Use tab character**，其他的语言代码同理设置

- ==显示行号与空白字符==

  - **Editor -> General -> Appearance -> 勾选“Show line numbers”; “Show whitespaces”; “Show method separators”**

- 去掉默认折叠

  - **Editor -> General -> Code Folding** 

  

## 在 PyCharm 中搜索和导航

在大项目中，我们很难记住每个事物的位置，因此快速导航和搜索非常重要。PyCharm可以提供这些功能。

- 在当前文件中搜索代码段：在Mac系统中使用`Cmd+F`键，在Windows或 Linux系统中使用`Ctrl+F`键。

  在整个项目中搜索代码段：在Mac系统中使用`Cmd+Shift+F`键，在Windows或Linux系统中使用`Ctrl+Shift+F`键。

- 搜索类：在Mac系统中使用`Cmd+O`键，在Windows或Linux系统中使用`Ctrl+N`键。

- 搜索文件：在Mac系统中使用`Cmd+Shift+O`键，在Windows或Linux系统中使用`Ctrl+Shift+N`键。

- **如果你不知道要搜索的是文件、类还是代码段，则搜索全部：按两次 Shift 键。**

导航可使用以下快捷键：

- 前往变量的声明：在Mac系统中使用`Cmd`键，在Windows或Linux系统中使用`Ctrl`键，然后单击变量。
- 寻找类、方法或文件的用法：使用`Alt+F7`键。
- 查看近期更改：使用`Shift+Alt+C`键，或者在主菜单中点击View → Recent Changes。
- 查看近期文件：在Mac系统中使用`Cmd+E`键，在Windows或Linux系统中使用`Ctrl+E`键，或者在主菜单中点击View → Recent Files。
- 多次跳转后在导航历史中前进和后退：在Mac系统中使用`Cmd+[`/`Cmd+]`键，在Windows或Linux系统中使用`Ctrl+Alt+Left`/`Ctrl+Alt+Right`键。

