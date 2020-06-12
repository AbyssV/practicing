### 使用vimrc对vim定制

- rc=run command

- 系统级vimrc：对系统所有用户都生效 和用户级vimrc：对个别用户生效

- 每一行作为一个命令执行

#### vimrc使用

```:version``` 查看vim版本

```:e ~/.vimrc```：编辑vimrc

```''```：注释

```/search```/```?search```：查找search

```
system vimrc file: "$VIM/vimrc"
user vimrc file: "$HOME/.vimrc"
2nd user vimrc file: "~/.vim/vimrc"
```



### vim的四种模式

#### 普通模式()

打开默认模式

移查删改

#### 可视(```v```)

对一整块区域进行操作

#### 插入(```i```)

添加文本

#### 命令

和普通模式类似

```:h vim-modes-intro```

```^/0```：移动到行首/包含缩进空格

```$```： 移动到行尾巴



