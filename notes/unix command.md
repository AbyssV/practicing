### File System

1. `ls`

   `ls -1`

   `ls -1 | grep m`

2. `cd ~`

   `cd /`回到根目录

   `cd ..`回到上一级目录

3. `echo 'Hello World'`

   `echo $USER
    echo ​$HOME`
   ` echo ~`
   ` echo 'Hello World' > foo.txt`
   ` echo 'Hey How' >> foo.txt`

`touch`创建空文件

`cp file1 file2 dir1`将文件file1、file2复制到目录dir1

`cp -r dir1 dirl2`将dir1下的所有文件(`-r`)及子目录复制到dir2

`mv file1 file3`将当前目录下文件file1更名为file3

`mv file2 dir2`将文件file2移动到目录dir2下

`rm file3`删除文件file3 (rmdir 命令只能删除空的文件夹)

`rm -r dir1`删除目录dir1(`-r`连同子目录删除。`-f`强制删除， 即忽略不存在的文件)

`cat`显示文件内容 (`space`显示下一行`enter`显示下一页)

`cat file1 file2`依顺序显示file1,file2的内容

`cat file1 file2>file3`把file1,file2的内容结合起来，再“重定向（`>`）”到file3文件中， 如果file3是已经存在的文件，那么它本身的内容被覆盖，而变成file1+file2的内容

`cat file1>>file2`这将变成将file1的文件内容“附加”到file2的文件后面，而file2的内容依然存在，这种重定向符`>>`比`>`常用，可以多多利用

`more`分页显示文件内容

`head -20`查看文件的前几行

`tail -30`查看文件的后几行

`clear`这个命令是用来清除屏幕的，它不需要任何参数

`grep -n name *.[chS]`用于查找文件中符合字符串的哪行。

### vim 

`:wq`保存并退出`q!`不保存文件并退出vi

` vi -r filename`在上次正用vi编辑时发生系统崩溃，恢复filename

`)`光标移至句尾 `(`光标移至句首

`H`光标移至屏幕顶行 `M`光标移至屏幕中间行 `L`光标移至屏幕最后行

`0`（注意是数字零）光标移至当前行首 `$`光标移至当前行尾

`Ctrl+u`向文件首翻半屏`Ctrl＋b`向文件首翻一屏

`Ctrl+d`向文件尾翻半屏 `Ctrl+f`向文件尾翻一屏

`yy`/ `p`

（复制当前行）拷贝一行到剪贴板或取出剪贴板中内容的命令（`:n`切换文件）

 `/string`/`?string`

 从光标所在处向后或向前查找相应的字符串的命令。`N`上一个，`n`下一个

`x`删除字符 `dd`删除整行到行首 `d$`删除整行到行尾

### attention

1. unless you specify `-i` (negate case lock), all files, folders and directories named with an upper case will not be shown

2. the `rm -rf/` command means remove (`rm`) - recursive (`r`) - force (`f`) home (`/`) and it will delete every folder, file and directory within your Linux OS. It is equivalent of wiping your entire hard drive clean.

3. `/` means root.