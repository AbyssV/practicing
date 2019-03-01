### vs code

#### c/c++

```
// the following code block is about how to configure cygwin terminal, for me i'm using git bash instead, so the path is for git bash
// cygwin 的安装目录
"terminal.integrated.shell.windows": "C:\\extension\\cygwin64\\bin\\bash.exe",
// 使得 cygwin 切换到当前工作目录
"terminal.integrated.env.windows": {
"CHERE_INVOKING": "1"
},
// 使 cygwin 能够在 vscode 中正常使用 Shell 命令
"terminal.integrated.shellArgs.windows": [
"-l"
],
```

Seems like Mingw and Cygwin are similar things?

I like Cygwin cz it provides unix-style command line. 

There is more about how to configuring g++ on my youtube folder *other cs videos*, remember to change debug path, include path, you can also change **argvs** and **group**

To compile and run cpp program, run ```gcc hello.cpp -o hello```, then run ```./hello```

The difference between gcc compiler and g++ compiler (they are actually not compiler, but ask for GNU compiler), is that for .cpp file, both gcc and g++ view it as cpp file, while for .c file,  gcc view it as c file but g++ view it as cpp file. They also include different #indef, search for more details. 



 #### python

Remember to change python path

Based on my knowledge, there are three running environment for python - **conda environment, virtual environment, and global environment.** conda is for running Anaconda. Under global environment, all the dependencies you installed are globally, while under virtual environment they are kind of locally and will not affect global environment. 



#### Java





