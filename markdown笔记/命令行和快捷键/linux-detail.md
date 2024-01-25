#Shell 工具

### tldr

有时候手册内容(`--help` / `man`)太过详实，让我们难以在其中查找哪些最常用的标记和语法。 [TLDR pages](https://tldr.sh/) 是一个很不错的替代品，它提供了一些案例，可以帮助您快速找到正确的选项。例如，自己就常常在tldr上搜索[`tar`](https://tldr.ostera.io/tar) 和 [`ffmpeg`](https://tldr.ostera.io/ffmpeg) 的用法。

### auto-suggestions

这一特性最初是由 [fish](https://fishshell.com/) shell 创建的，它可以根据您最近使用过的开头相同的命令，动态地对当前对shell命令进行补全。这一功能在 [zsh](https://github.com/zsh-users/zsh-autosuggestions) 中也可以使用，它可以极大的提高用户体验。

### fasd / autojump

之前对所有操作我们都默认一个前提，即您已经位于想要执行命令的目录下，但是如何才能高效地在目录间随意切换呢？有很多简便的方法可以做到，比如设置alias，使用 [ln -s](https://man7.org/linux/man-pages/man1/ln.1.html) 创建符号连接等。而开发者们已经想到了很多更为精妙的解决方案。

由于本课程的目的是尽可能对你的日常习惯进行优化。因此，我们可以使用[`fasd`](https://github.com/clvv/fasd)和 [autojump](https://github.com/wting/autojump) 这两个工具来查找最常用或最近使用的文件和目录。

Fasd 基于 [*frecency* ](https://developer.mozilla.org/en-US/docs/Mozilla/Tech/Places/Frecency_algorithm)对文件和文件排序，也就是说它会同时针对频率（*frequency*）和时效（*recency*）进行排序。默认情况下，`fasd`使用命令 `z` 帮助我们快速切换到最常访问的目录。例如， 如果您经常访问`/home/user/files/cool_project` 目录，那么可以直接使用 `z cool` 跳转到该目录。对于 autojump，则使用`j cool`代替即可。

还有一些更复杂的工具可以用来概览目录结构，例如 [`tree`](https://linux.die.net/man/1/tree), [`broot`](https://github.com/Canop/broot) 或更加完整的文件管理器，例如 [`nnn`](https://github.com/jarun/nnn) 或 [`ranger`](https://github.com/ranger/ranger)。



# 命令详解

## find / fd / locate

程序员们面对的最常见的重复任务就是查找文件或目录。所有的类UNIX系统都包含一个名为 [`find`](https://man7.org/linux/man-pages/man1/find.1.html) 的工具，它是 shell 上用于查找文件的绝佳工具。`find`命令会递归地搜索符合条件的文件，例如：

```bash
# 查找所有名称为src的文件夹
find . -name src -type d
# 查找所有文件夹路径中包含test的python文件
find . -path '*/test/*.py' -type f # 这个/表示目录的/
# 查找前一天修改的所有文件
find . -mtime -1
# 查找所有大小在500k至10M的tar.gz文件
find . -size +500k -size -10M -name '*.tar.gz'
```

除了列出所寻找的文件之外，find 还能对所有查找到的文件进行操作。这能极大地简化一些单调的任务。

```bash
# 删除全部扩展名为.tmp 的文件
find . -name '*.tmp' -exec rm {} \;
# 查找全部的 PNG 文件并将其转换为 JPG
find . -name '*.png' -exec convert {} {}.jpg \;
```

尽管 `find` 用途广泛，它的语法却比较难以记忆。例如，为了查找满足模式 `PATTERN` 的文件，您需要执行 `find -name '*PATTERN*'` (如果您希望模式匹配时是不区分大小写，可以使用`-iname`选项）

您当然可以使用 alias 设置别名来简化上述操作，但 shell 的哲学之一便是寻找（更好用的）替代方案。 记住，shell 最好的特性就是您只是在调用程序，因此您只要找到合适的替代程序即可（甚至自己编写）。

例如，[`fd`](https://github.com/sharkdp/fd) 就是一个更简单、更快速、更友好的程序，它可以用来作为`find`的替代品。它有很多不错的默认设置，例如输出着色、默认支持正则匹配、支持unicode并且我认为它的语法更符合直觉。以模式`PATTERN` 搜索的语法是 `fd PATTERN`。

大多数人都认为 `find` 和 `fd` 已经很好用了，但是有的人可能想知道，我们是不是可以有更高效的方法，例如不要每次都搜索文件而是通过编译索引或建立数据库的方式来实现更加快速地搜索。

这就要靠 [`locate`](https://man7.org/linux/man-pages/man1/locate.1.html) 了。 `locate` 使用一个由 [`updatedb`](https://man7.org/linux/man-pages/man1/updatedb.1.html)负责更新的数据库，在大多数系统中 `updatedb` 都会通过 [`cron`](https://man7.org/linux/man-pages/man8/cron.8.html) 每日更新。这便需要我们在速度和时效性之间作出权衡。而且，`find` 和类似的工具可以通过别的属性比如文件大小、修改时间或是权限来查找文件，`locate`则只能通过文件名。 [这里](https://unix.stackexchange.com/questions/60205/locate-vs-find-usage-pros-and-cons-of-each-other)有一个更详细的对比。

## grep / rg / ack / ag

查找文件是很有用的技能，但是很多时候您的目标其实是查看文件的内容。一个最常见的场景是您希望查找具有某种模式的全部文件，并找它们的位置。

为了实现这一点，很多类UNIX的系统都提供了[`grep`](https://man7.org/linux/man-pages/man1/grep.1.html)命令，它是用于对输入文本进行匹配的通用工具。它是一个非常重要的shell工具，我们会在后续的数据清理课程中深入的探讨它。

`grep` 有很多选项，这也使它成为一个非常全能的工具。其中我经常使用的有 `-C` ：获取查找结果的上下文（Context）；`-v` 将对结果进行反选（Invert），也就是输出不匹配的结果。举例来说， `grep -C 5` 会输出匹配结果前后五行。当需要搜索大量文件的时候，使用 `-R` 会递归地进入子目录并搜索所有的文本文件。

但是，我们有很多办法可以对 `grep -R` 进行改进，例如使其忽略`.git` 文件夹，使用多CPU等等。

因此也出现了很多它的替代品，包括 [ack](https://beyondgrep.com/), [ag](https://github.com/ggreer/the_silver_searcher) 和 [rg](https://github.com/BurntSushi/ripgrep)。它们都特别好用，但是功能也都差不多，我比较常用的是 ripgrep (`rg`) ，因为它速度快，而且用法非常符合直觉。例子如下：

```bash
# 查找所有使用了 requests 库的文件
rg -t py 'import requests'
# 查找所有没有写 shebang 的文件（包含隐藏文件）
rg -u --files-without-match "^#!"
# 查找所有的foo字符串，并打印其之后的5行
rg foo -A 5
# 打印匹配的统计信息（匹配的行和文件的数量）
rg --stats PATTERN
```

与 `find`/`fd` 一样，重要的是你要知道有些问题使用合适的工具就会迎刃而解，而具体选择哪个工具则不是那么重要。

## history / fzf

目前为止，我们已经学习了如何查找文件和代码，但随着你使用shell的时间越来越久，您可能想要找到之前输入过的某条命令。首先，按向上的方向键会显示你使用过的上一条命令，继续按上键则会遍历整个历史记录。

`history` 命令允许您以程序员的方式来访问shell中输入的历史命令。这个命令会在标准输出中打印shell中的里面命令。如果我们要搜索历史记录，则可以利用管道将输出结果传递给 `grep` 进行模式搜索。 `history | grep find` 会打印包含find子串的命令。

对于大多数的shell来说，您可以使用 `Ctrl+R` 对命令历史记录进行回溯搜索。敲 `Ctrl+R` 后您可以输入子串来进行匹配，查找历史命令行。

反复按下就会在所有搜索结果中循环。在 [zsh](https://github.com/zsh-users/zsh-history-substring-search) 中，使用方向键上或下也可以完成这项工作。

`Ctrl+R` 可以配合 [fzf](https://github.com/junegunn/fzf/wiki/Configuring-shell-key-bindings#ctrl-r) 使用。`fzf` 是一个通用对模糊查找工具，它可以和很多命令一起使用。这里我们可以对历史命令进行模糊查找并将结果以赏心悦目的格式输出。

你可以修改 shell history 的行为，例如，如果在命令的开头加上一个空格，它就不会被加进shell记录中。当你输入包含密码或是其他敏感信息的命令时会用到这一特性。 为此你需要在`.bashrc`中添加`HISTCONTROL=ignorespace`或者向`.zshrc` 添加 `setopt HIST_IGNORE_SPACE`。 如果你不小心忘了在前面加空格，可以通过编辑。`bash_history`或 `.zhistory` 来手动地从历史记录中移除那一项。

## !

Q: 在vim中，输入`:.!where bash`会发生什么

A: 在 Vim 中，`.` 表示当前行，`!` 表示在 shell 中执行命令，因此 `:.!where bash` 会在 shell 中执行 `where bash` 命令，并将输出替换为当前行。

`where` 命令用于在 Windows 系统中定位可执行文件的位置。在 Unix-like 系统中，相应的命令是 `which`。

所以如果你在 Windows 上运行 Vim，并且你的系统路径中包含 bash（例如，如果你安装了 Git Bash 或 Windows Subsystem for Linux），那么 `:.!where bash` 将替换当前行为 bash 的路径。

如果你在 Unix-like 系统上运行 Vim，你应该使用 `:.!which bash` 来达到相同的效果。

Q: 在shell命令行中如何有技巧的使用`!`

A: 在 shell 命令行中，`!` 是一个非常强大的操作符，可以用于多种方式。

1. **引用历史命令**: `!n` 会执行历史列表中的第 `n` 个命令。例如，`!5` 会执行历史列表中的第 5 个命令。
2. **引用最近的命令**: `!!` 会执行最近的命令。这是一个非常有用的技巧，例如，如果你忘了在一个命令前加 `sudo`，你可以简单地输入 `sudo !!`。
3. **引用最近的参数**: `!$` 会引用最近命令的最后一个参数。这是一个很好的技巧，例如，如果你刚刚创建了一个目录 `mkdir mydir`，然后你可以输入 `cd !$` 来切换到这个目录。
4. **按字符串引用命令**: `!string` 会执行最近的以 `string` 开头的命令。例如，如果你刚刚执行了 `cat myfile.txt`，你可以输入 `!cat` 来再次执行这个命令。
5. **按命令搜索**: `!?string` 会执行最近的包含 `string` 的命令。例如，如果你刚刚执行了 `grep -r "mystring" *`，你可以输入 `!?grep` 来再次执行这个命令。
6. **忽略历史记录**: 在命令前加一个空格将不会将命令添加到历史记录中。这对于输入密码或其他敏感信息很有用。

注意：在使用 `!` 时要小心，因为它可能会导致意外的结果，尤其是当你不记得历史命令时。在执行任何带有 `!` 的命令之前，最好先检查历史记录，可以使用 `history` 命令来查看。

## awk

```bash
# 打印出docker ps结果的第一列并从第二行开始取值，将结果传给docker stop
docker ps -a | awk '{print $1}' | tail -n +2 | xargs docker stop
# $NF是内置变量，uniq去掉重名，但是只会去掉相邻的，因此需要加sort
awk -F "/" '/^\// {print $NF}' /etc/shells | sort uniq # /正则表达式/，注意\是escape转义
# 长度大于15的行
awk 'length($0) > 7' /etc/shells
# 还有if，substr，match
awk 'BEGIN{for(i=1;i<=10;i++) print "这个数字", i, "的平方为",i*i}'
docker ps | awk '!match($NF, /^test/) {print NR, $NF}' # NR内置的指令，表示行号
```

## exec

在 Shell 中，`exec` 命令用于替换当前的 shell 进程，用指定的命令执行一个新程序。当使用 `exec` 执行命令时，不会启动新的进程，而是在当前的 shell 进程内执行。

`exec` 的主要用途和特点包括：

1. **替换当前 Shell**: 使用 `exec` 命令执行程序时，该程序会取代当前的 shell 进程。程序执行完毕后，不会返回到原来的 shell。
2. **节省资源**: 由于不创建新的进程，使用 `exec` 可以节省系统资源。这在脚本中特别有用，尤其是在有限资源的环境中。
3. **修改当前 Shell 环境**: `exec` 还可以用于修改当前 shell 的环境。例如，使用 `exec` 更改文件描述符的重定向。
4. **不返回到原 Shell**:一旦 `exec` 命令的程序执行完毕，shell 会话就会结束，因为原来的 shell 进程已被新程序替代。
5. **用于 Shell 脚本**: 在 shell 脚本中，`exec` 常被用来替换当前脚本的进程，执行新命令，这样可以避免创建新的子进程。

示例

1. **使用 exec 执行程序**:

   ```bash
   bashCopy code
   exec ls
   ```

   这将执行 `ls` 命令，并且 shell 会话将结束，因为 `ls` 会取代当前 shell 进程。

2. **更改文件描述符**:

   ```bash
   bashCopy code
   exec 3>output.txt
   ```

   这将打开文件 `output.txt` 并将其分配给文件描述符 3，供当前 shell 进程使用。

使用 `exec` 时需要小心，因为一旦执行了 `exec` 命令，当前的 shell 或脚本就会被替换，不会执行 `exec` 后的任何命令。这意味着在脚本中使用 `exec` 后的所有代码都将不会执行，除非 `exec` 执行的命令失败。



## mount

用于挂载文件系统。在 Unix 和 Unix-like 系统中，挂载是将一个文件系统连接到当前文件系统结构的过程，通常是在一个预先定义的目录点。这允许你访问这个文件系统，就好像它是当前系统的一部分一样。

`mount` 命令的主要用途和功能包括：

1. **挂载文件系统**:
   - 将外部设备（如硬盘驱动器、USB 驱动器、CD-ROM）或远程文件系统（如 NFS、SMB/CIFS）挂载到指定的目录。
2. **访问不同类型的文件系统**:
   - 允许系统访问不同类型的文件系统，如 ext3/ext4、NTFS、FAT32 等。
3. **挂载网络文件系统**:
   - 可以挂载网络文件系统，使网络上的资源就像本地资源一样可用。
4. **读取/写入权限管理**:
   - 挂载时可以指定不同的读写权限和选项，例如只读、读写、同步或异步等。
5. **自动和手动挂载**:
   - 文件系统可以手动挂载，也可以通过 `/etc/fstab` 文件进行自动挂载。
6. **管理虚拟文件系统**:
   - `mount` 命令也用于挂载虚拟文件系统，如 proc 文件系统、sysfs 文件系统等。

使用 `mount` 命令时，通常需要指定要挂载的设备和挂载点（即目录）。例如，要将名为 `/dev/sdb1` 的设备挂载到 `/mnt/usb` 目录，可以使用以下命令：

```
bashCopy code
mount /dev/sdb1 /mnt/usb
```

`mount` 命令还常与 `umount` 命令一起使用，`umount` 用于卸载已挂载的文件系统。正确地挂载和卸载文件系统对于保护数据安全和维护系统稳定性非常重要。



# IO多路复用

## select / poll / epoll

事件的轮询，回调

In Linux, `select`, `poll`, and `epoll` are mechanisms used for monitoring multiple file descriptors to see if they are ready for I/O operations like reading or writing. They are often used in network programming and other scenarios where an application needs to handle multiple simultaneous connections or I/O streams.

- `select`: allows a program to monitor multiple file descriptors, waiting until one or more of the descriptors is ready for some I/O operation.

- `poll`: provides similar functionality to `select` but uses a different interface that some find more convenient. It also does not have some of the limitations of `select`, such as the maximum number of file descriptors that can be monitored.

- `epoll`: is a more scalable I/O event notification mechanism, specifically designed to handle a large number of monitored file descriptors. It's more efficient than `select` and `poll` for applications that need to monitor many file descriptors, especially on high-load systems.

