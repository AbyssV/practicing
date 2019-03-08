# vs code

**Visual Studio IntelliCode** auto-complete suggestions based on machine learning models, Microsoft Python Language Server privodes faster startup and completion performance

**docker** container supports multiple languages. Check for more info

**VS Live Share** collaborate with others remotely on any languages and OS; edit and debug together, with shared terminals; great for pair programming and code reviews

- I downloaded Anaconda VScode extension but I don't know how to use it
- you can split windows, terminals in vscode
- when debugging, you can edit expressions in **watch** window, you can also enter that expression in debug console. **add configuration** to edit debugging configuration
- you can configure your own task (works like shortcuts)
- vscode supports unit test, you need to configure it and import unit test library
- vscode has integration with Emmet, so if you type ```!```(exclamation mark) and press ```Enter``` that will generate an HTML boilerplate for you including all the tags you need for it to render correctly on mobile device

## c/c++

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



## python

Remember to change python path

Based on my knowledge, there are three running environment for python - **conda environment, virtual environment, and global environment.** conda is for running Anaconda. Under global environment, all the dependencies you installed are globally, while under virtual environment they are kind of locally and will not affect global environment. 

### shortcuts

- ```.code``` to run vscode under current directory (need to install extension)
-  ```cmd+Shift+p``` for command palette (```cmd+p``` for **help**?)
- ```Tab``` to shift all your code one tab, ```Tab+Shift``` to back shift your code one tab
-  to run selected code
- ```cmd+Shift+o``` to check all your methods(symbols) 
- if you want to create a python file ```main.py``` under folder **app**, you can create a folder ```app/main.py``` to create the folder and python file

### notes

- you can modify your own ```.pylintrc``` file to customize messages
- you can create a virtual environment, conda environment and corresponding terminal shell using vscode (check how to create virtual environments, download requirements)
- 
- 
- 





## Java





