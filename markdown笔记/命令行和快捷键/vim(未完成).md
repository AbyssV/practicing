# 使用vimrc对vim定制

- rc=run command
- 系统级vimrc：对系统所有用户都生效
  - system vimrc file: `VIM/vimrc`

- 用户级vimrc：对个别用户生效
  - user vimrc file: `$HOME/.vimrc`
  - 2nd user vimrc file: `~/.vim/vimrc`

- 每一行作为一个命令执行
- 在Ubuntu配置vimrc
  - 全局路径：`/etc/vimrc`
  - 用户个人路径：`$HOME/.vimrc`
  - 建议：放在用户个人路径`$HOME/.vimrc`下


## 我的vimrc配置

在进入vim之后，在vim里面输入`:e ~/.vimrc`编辑vimrc

`''`/`"`：注释

```bash
"关闭vi兼容模式"
set nocompatible


"设置历史记录步数"
set history=1000

"开启相关插件"
"侦测文件类型"
filetype on
"载入文件类型插件"
filetype plugin on
"为特定文件类型载入相关缩进文件"
filetype indent on

"当文件在外部被修改时，自动更新该文件"
set autoread

"激活鼠标的使用"
set mouse=a
set selection=exclusive
set selectmode=mouse,key

"保存全局变量"
set viminfo+=!

"带有如下符号的单词不要被换行分割"
set iskeyword+=_,$,@,%,#,-

"通过使用: commands命令，告诉我们文件的哪一行被改变过"
set report=0

"被分割的窗口间显示空白，便于阅读"
set fillchars=vert:\ ,stl:\ ,stlnc:\

"""""""""""""""""""""""""""""""""
"""=>字体和颜色<="""
"""""""""""""""""""""""""""""""""
"自动开启语法高亮"
syntax enable

"设置字体"
"set guifont=dejaVu\ Sans\ MONO\ 10
set guifont=Courier_New:h10:cANSI

"设置颜色"
"colorscheme desert

"高亮显示当前行"
set cursorline
hi cursorline guibg=#00ff00
hi CursorColumn guibg=#00ff00

"高亮显示普通txt文件（需要txt.vim脚本）"
au BufRead,BufNewFile *  setfiletype txt

"""""""""""""""""""""""""""""""
"""=>代码折叠功能<="""
"""""""""""""""""""""""""""""""
"激活折叠功能"
set foldenable
"set nofen（这个是关闭折叠功能）"

"设置按照语法方式折叠（可简写set fdm=XX）"
"有6种折叠方法：
"manual   手工定义折叠"
"indent   更多的缩进表示更高级别的折叠"
"expr     用表达式来定义折叠"
"syntax   用语法高亮来定义折叠"
"diff     对没有更改的文本进行折叠"
"marker   对文中的标志进行折叠"
set foldmethod=manual
"set fdl=0（这个是不选用任何折叠方法）"

"设置折叠区域的宽度"
"如果不为0，则在屏幕左侧显示一个折叠标识列
"分别用“-”和“+”来表示打开和关闭的折叠
set foldcolumn=0

"设置折叠层数为3"
setlocal foldlevel=3

"设置为自动关闭折叠"
set foldclose=all

"用空格键来代替zo和zc快捷键实现开关折叠"
"zo O-pen a fold (打开折叠)
"zc C-lose a fold (关闭折叠)
"zf F-old creation (创建折叠)
"nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

"""""""""""""""""""""""""""""""""""
"""=>文字处理<="""
"""""""""""""""""""""""""""""""""""
"使用空格来替换Tab"
set expandtab

"设置所有的Tab和缩进为4个空格"
set tabstop=4

"设定<<和>>命令移动时的宽度为4"
set shiftwidth=4

"使得按退格键时可以一次删除4个空格"
set softtabstop=4
set smarttab

"缩进，自动缩进（继承前一行的缩进）"
"set autoindent 命令打开自动缩进，是下面配置的缩写
"可使用autoindent命令的简写，即“:set ai”和“:set noai”
"还可以使用“:set ai sw=4”在一个命令中打开缩进并设置缩进级别
set ai
set cindent

"智能缩进"
set si

"自动换行”
set wrap

"设置软宽度"
set sw=4

"行内替换"
set gdefault

""""""""""""""""""""""""""""""""""
"""=>Vim 界面<="""
""""""""""""""""""""""""""""""""""
"增强模式中的命令行自动完成操作"
set wildmenu

"显示标尺"
set ruler

"设置命令行的高度"
set cmdheight=1

"显示行数"
set nu

"不要图形按钮"
set go=

"在执行宏命令时，不进行显示重绘；在宏命令执行完成后，一次性重绘，以便提高性能"
set lz

"使回格键（backspace）正常处理indent, eol, start等"
set backspace=eol,start,indent

"允许空格键和光标键跨越行边界"
set whichwrap+=<,>,h,l

"设置魔术"
set magic

"关闭遇到错误时的声音提示"
"关闭错误信息响铃"
set noerrorbells

"关闭使用可视响铃代替呼叫"
set novisualbell

"高亮显示匹配的括号([{和}])"
set showmatch

"匹配括号高亮的时间（单位是十分之一秒）"
set mat=2

"光标移动到buffer的顶部和底部时保持3行距离"
set scrolloff=3

"搜索逐字符高亮"
set hlsearch
set incsearch

"搜索时不区分大小写"
"还可以使用简写（“:set ic”和“:set noic”）"
set ignorecase

"用浅色高亮显示当前行"
autocmd InsertLeave * se nocul
autocmd InsertEnter * se cul

" 输入的命令显示出来，看的清楚"
set showcmd

""""""""""""""""""""""""""""""""""""
"""=>编码设置<="""
""""""""""""""""""""""""""""""""""""
"设置编码"
set encoding=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936

"设置文件编码"
set fileencodings=utf-8

"设置终端编码"
set termencoding=utf-8

"设置语言编码"
set langmenu=zh_CN.UTF-8
set helplang=cn

"""""""""""""""""""""""""""""
"""=>其他设置<="""
"""""""""""""""""""""""""""""
"开启新行时使用智能自动缩进"
set smartindent
set cin
set showmatch

"在处理未保存或只读文件的时候，弹出确认"
set confirm

"隐藏工具栏"
set guioptions-=T

"隐藏菜单栏"
set guioptions-=m

"置空错误铃声的终端代码"
set vb t_vb=

"显示状态栏（默认值为1，表示无法显示状态栏）"
set laststatus=2

"状态行显示的内容"
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}

"粘贴不换行问题的解决方法"
set pastetoggle=<F9>

"设置背景颜色"
set background=dark

"文件类型自动检测，代码智能补全"
set completeopt=longest,preview,menu

"共享剪切板"
set clipboard+=unnamed

"从不备份"
set nobackup
set noswapfile

"自动保存"
set autowrite

"显示中文帮助"
if version >= 603
        set helplang=cn
            set encoding=utf-8
endif

"设置高亮相关项"
highlight Search ctermbg=black ctermfg=white guifg=white guibg=black

""""""""""""""""""""""""""""""""
"""=>在shell脚本开头自动增加解释器以及作者等版权信息<="""
""""""""""""""""""""""""""""""""
"新建.py,.cc,.sh,.java文件，自动插入文件头"
autocmd BufNewFile *.py,*.cc,*.sh,*.java exec ":call SetTitle()"
"定义函数SetTitle，自动插入文件头"
func SetTitle()
    if expand ("%:e") == 'sh'
        call setline(1, "#!/bin/bash")
        call setline(2, "#Author:bert")
        call setline(3, "#Blog:https://blog.51cto.com/zpf666")
        call setline(4, "#Time:".strftime("%F %T"))
        call setline(5, "#Name:".expand("%"))
        call setline(6, "#Version:V1.0")
        call setline(7, "#Description:This is a production script.")
    endif
endfunc

```

# 注意点

大写和很多快捷键的效果是类似的，例如`G`等价于`Shift+g`

大写通常表示上一个

# 进入vim

` vi -r filename`：在上次正用vi编辑时发生系统崩溃，恢复filename

`vi hello.txt +8`：进入hello.txt的第8行

`:w another_file`：将相同的内容写在another_file中

`:e another_file`：切换到another_file并继续修改another_file，`e`表示`edit`。按tab会给文件名的自动提示

`Ctrl-g/G`：查看文件信息，先按`g`更加详细

# vim 的工作模式

- 正常模式：打开文件进入的是命令模式。按 `Esc`/`Ctrl+c`进入命令模式
- 插入模式：press `i` to write text
- 命令模式：press `:` to manipulate text
- 替换模式：按 `r` 替换文本
- 可视化（一般，行，块）模式：按 `V` 选中文本块

# 命令模式

- `:help :w`/`:help w`：打开`:w`/`w`命令的帮助文档
- `:q` ：退出，会提示是否保存
- `:qa!`
  - `q` means quit
  - `a` means all buffer(you may have several files open)
  - `!` means force, no warning
- `:w`：保存
  - 也可`:w 文件名`将相同的内容写在另一个file中

- `:ls` 显示打开的缓存
- `:wq`/`:x`/`ZZ` 保存退出
- `/搜索的内容`/`?搜索的内容`：向前/向后搜索指定内容
  - `N`上一个结果，`n`下一个结果
  - 可以使用正则表达式


- `:s/要替换的内容/替换后的内容`：替换first occurrence
- `:s/要替换的内容/替换后的内容/g`：全局替换，`g`表示全局

- `:s/要替换的内容/替换后的内容/gc`：全局替换，`c`表示逐个询问
- ` :h vim-modes-intro`：vim内置文档
- `:version`：查看vim版本。或者在终端输入`vim --version`

# 插入模式

## 编辑操作

| 命令               | 说明                                                         |
| :----------------- | :----------------------------------------------------------- |
| o/O                | 在之下/之上插入行                                            |
| yy                 | yank ≈ copy，复制整行。注意不能只输入一个`y`，不然vim不知道复制什么 |
| y2w                | yank 2 words，包括当前单词                                   |
| p/P                | put ≈ paste，粘贴在当前字符之后/之前                         |
| x/X                | 删除/剪切当前字符 / 删除/剪切当前字符前1个字符。我们`xp`可以交换两个连续字符的位置 |
| s                  | 替换字符                                                     |
| 4dd                | 向下删除/剪切整行到行首（包括当前行）4次。注意不能只输入一个`d`，不然vim不知道删什么 |
| d+移动             | db删除上一个词，d)删除到句尾，d/good删除所有匹配good的词     |
| c+移动             | cw change word。删除当前词并进入insert mode。c/h从当前字符删到h之前并进入insertion mode |
| u/ctr+r            | undo/redo                                                    |
| >>/:>              | 往右缩进                                                     |
| <</:<              | 往左缩进                                                     |
| :m,n> / :m>(n-m+1) | m到n行缩进 / 从m开始缩进n行（包含m行）(:m>n 等价于命令 :m,m+n-1>) |
| .                  | 重复上一次命令操作，类似Excel中的F4                          |
| V                  | visual line mode。选中当前行（有时需要复制多行，`V+G`）      |
| ctrl+v             | visual block mode。ctrl+v l 4 j c选中2*8个block，修改第1行会修改后续 |

### 组合删除

`[count]operation`/`[count]{motion}`

前面的数字表示编辑操作的次数，后面的数字表示移动操作的次数

| [count]operation / [count]{motion} | 定义                                                         |
| ---------------------------------- | ------------------------------------------------------------ |
| `5dw`                          | 删除正向五个单词（必须在词首）                                  |
| `dh`/`dj`/`dk`/`dl`         | 删除到上下左右一个操作前的字符，`dk`删除上面一整行,`dj`删除下面一整行 |
| `d$`/`D`                   | 删除光标到行尾的字符                                         |
| `d^`                           | 删除光标到行首的字符                                         |
| `D3w`                          | 正向删除3w动作                                               |
| `2d3w`                         | 正向删除3w动作 两次                                          |

# 正常模式

## 移动操作

| 命令                       | 说明                                                         |
| -------------------------- | ------------------------------------------------------------ |
| 10k/10j/10h/10l            | 上移(10个字符)/下移(10个字符)/左移(10个字符)/右移(10个字符)。 可以用arrow key，但是会让你移开键盘常用位置 |
| 10w/W                      | 移动到下10个单词词首，大写W不包含特殊字符                    |
| b/B                        | 移动到上一个单词词首                                         |
| 10e/E                      | 移动到下10单词词尾，大写E不包含特殊字符                      |
| ge                         | 移动到下一单词词尾                                           |
| (/)                        | 光标移至句首/句尾。句指以`.`/`!`/`?`+`EOF`/`tab`/`space`     |
| {/}                        | 光标移至段首/段位。段指以空行开头空行结尾                    |
| 0                          | 光标移至行首，包含缩进空格                                   |
| ^/$                        | 光标移至行首第一个非空格字符/行尾                            |
| shift+6/shift+4            | 回到当前行的行首/回到当前行的行末                            |
| H/M/L                      | 光标移至屏幕顶行/中间行/最后行                               |
| gg/G                       | 回到第一行/回到最后一行                                      |
| ctrl+u/ctrl+d              | 向上翻半页/向下翻半页                                        |
| 2ctrl+b/ctrl+f             | 上两屏/下一屏                                                |
| 数字+G/数字+gg/:数字+Enter | 回到指定行                                                   |
|                            |                                                              |





> 以下待补充

# vim register/clipboard

`:register`/`:reg`：查看寄存器

`:h reg`：查看帮助文档

|    类型    |           含义           |    表达方式    |     举例     |                       特点                        |
| :--------: | :----------------------: | :------------: | :----------: | :-----------------------------------------------: |
| 无名寄存器 |        默认寄存器        |       ""       |    "" p=p    |                 会被最后一条覆盖                  |
| 数字寄存器 | “+{0-9} 缓存最近10次操作 | "0<br />"{0-9} | "0p<br />"1p | 0用于复制专用<br />1-9用于最近9次行删除或修改记录 |
| 有名寄存器 |       26英文字命名       |  "[a-z]/[A-Z]  |     "ayw     |            "A会通过^J追加到" a寄存器中            |
| 黑洞寄存器 |         有去无回         |       "_       |     "_dw     |           只想删除而不想覆盖无名寄存器            |

## example

```bash
# 在正常模式下，输入要复制的文本
"a 
# 复制到寄存器a
yy 
#-----一些其他操作
"a
# 移动到下一行并从寄存器a粘贴
jP
```

# 修改，查找和替换

#### 修改

|  按键操作   |                   定义                    |
| :---------: | :---------------------------------------: |
|  Shift+i/A  |          插入模式并移动到行首/尾          |
|     a/i     |               光标后/前插入               |
| [n]+O/o+ESC | 行前/后插入n次，再按`ESC`可以看到效果 |
|  [n]+i+ESC  |              插入模式重复n次              |

#### 转换

|          按键操作           |                  定义                   |
| :-------------------------: | :-------------------------------------: |
|              ~              |           单个字符大小写转换            |
| g ~ w （这里的w表示motion） |     单词大小写转换，**必须在行首**      |
|         g ~ $/g ~ ~         |             整行大小写转换              |
|        gU/uw (upper)        | 单词转换成大/小写，**不必在行首**，推荐 |

#### 查找

|      按键操作      |                         定义                         |
| :----------------: | :--------------------------------------------------: |
|     F/f{char}      |                向下/向上查找单个字符                 |
|      t{char}       |            查找字符前一个字符*好像没啥用*            |
| dt{char}/df{space} |             删除光标到查找字符之间的字符             |
|      /{char}       | 命令行查找，`n`向下逐个查找，`N`向上逐个查找 |

#### 查找替换

语法：[range]s(ubstitute)/{pattern}/{string}/[flags]  

|      按键操作      |             定义             |
| :----------------: | :--------------------------: |
| s/going/rolling/g  | 当前行所有going替换成rolling |
| %s/going/rolling/g |        %匹配所有范围         |

 #### 直接替换

|                        按键操作                         |                             定义                             |
| :-----------------------------------------------------: | :----------------------------------------------------------: |
|                        Shift+r/R                        | 替换模式，按`ESC`退出`REPLCE`模式，*直接覆盖写了，类似我按了平常误按了insert* |
|                            r                            |                         单个字符替换                         |
| cw（`c`已经被`change`占领了，只能用`yank`） |               修改单个字符，效果类似`dwi`                |
|                   c$/C 类似于d操作符                    |                     修改光标之后行内内容                     |



# 多窗口操作（分屏）与标签分组

#### 多窗口（分屏）操作

都是Ctrl+w, w:window

|              指令               |              含义              |
| :-----------------------------: | :----------------------------: |
|        `vim O/o[n]`         | 水平/垂直分屏 n：数字，o：open |
| `Ctrl+w c/q` c:close q:quit | 关闭当前窗口/最后一个窗口时退  |
|      `Ctrl+w s`s:split      |     上下分割当前打开的文件     |
|       `:sp filename`        |  上下分割，并打开一个新的文件  |
|         `Ctrl+w v`          |     左右分割当前打开的文件     |
|       `:vsp filename`       |  左右分割，并打开一个新的文件  |

#### 移动分屏和尺寸变动

|      指令       |        含义        |
| :-------------: | :----------------: |
| `Ctrl+ w K` |      向上移动      |
| `Ctrl+ w J` |      向下移动      |
| `Ctrl+ w L``  |      向右移动      |
| `Ctrl+ w H` |      向左移动      |
| `Ctrl+ w +` |      增加高度      |
| `Ctrl+ w -` |      减少高度      |
| `Ctrl+ w =` | 让所有屏的高度一致 |

#### 标签

标签就是容纳一系列窗口的容器，类似浏览器的标签

|           指令           |              含义               |
| :----------------------: | :-----------------------------: |
|  `:tabnew filename`  |           新建标签页            |
|      `:tabfind`      |   查找并在新标签页中打开文件    |
|       `:tabs`        |     显示已打开标签页的列表      |
|     `:tabclose`      |         关闭当前标签页          |
|      `:tabonly`      |      仅保留当前标签页打开       |
| `:tabn/p/first/last` | 移动到下/上/第一/最后一个标签页 |
|       `:tabm`        |   将当前标签页放置到指定位置    |

#### 标签操作和命令键

|                          指令                          |                             含义                             |
| :----------------------------------------------------: | :----------------------------------------------------------: |
|                       `gt/T`                       |              移动到下/上一个标签（命令模式下）               |
|                      `{i}gt`                       |                      移动到i位置的标签                       |
|         `noremap <C-L> <Esc>:tabnext<CR>`          |                     vimrc中自定义快捷键                      |
| `noremap <C-H>` <br />`<Esc>: tabprevious<CR>` |                     vimrc中自定义快捷键                      |
|                      `:tabe`                       |                     编辑标签中的某个文件                     |
|                `tabm 0 `/`tabm`                | 移动当前tab到第一个/最后一个。0相当于第一个。和`:tabnfirst`/`:tabnlast`效果相同 |
|                     `tabm {i}`                     |                     移动当前tab到i+1位置                     |

# 缓冲区和多文件编辑

#### 缓冲区

Buffer是内存中的一块缓冲区域，用于临时存放vim打开过的文件

##### 缓冲区操作

|               指令               |                             含义                             |
| :------------------------------: | :----------------------------------------------------------: |
|        `:bp`(revious)        |                         上一个缓冲区                         |
|          `:bn`(ext)          |                         下一个缓冲区                         |
|         `:bf`(irst)          |                        到第一个缓冲区                        |
|          `:bl`(ast)          |                       到最后一个缓冲区                       |
| `:b buffer Number/File_name` |                          指定缓冲区                          |
|           `:ball`            |                        编辑所有缓冲区                        |
|        `Ctrl + ^/b#`         |               切换到前一个buffer（交换buffer）               |
|           `:qall!`           |                        退出全部缓冲区                        |
|           `:wall!`           |                        写入全部缓冲区                        |
|           `:badd`            |            添加一个新缓冲区，但不设置为当前缓冲区            |
|         `:bd`(elete)         |                          删除缓冲区                          |
| `:n,m/%bd`(`%`匹配所有)  |                删除n到m编号/所有的缓冲区文件                 |
|        `bufdo {CMD}`         | `bufdo set number`/`bufdo set nonumber`，批量操作缓冲区列表 |
|          `:E /:bd`           |              打开文件目录列表/返回到最初buffer               |



##### 缓冲区列表

查看：`:files` / `:buffers` / `:ls`

**详细解释**

1. `1`：缓冲区序列号
2. `#/%a`：指示状态，当前文件是active
3. 文件名
4. 光标位置

**缓冲区列表指示状态**

| 标记 |                 含义                 |
| :--: | :----------------------------------: |
|  a   |    激活缓冲区，缓冲区被加载且显示    |
|  h   |   隐藏缓冲区，缓冲区被加载但不显示   |
|  %   |       当前缓冲区。光标所在位置       |
|  #   |              交换缓冲区              |
|  =   |              只读缓冲区              |
|  +   |            已经更改缓冲区            |
|  -   | 不可改缓冲区，'modifiable'选项不置位 |



