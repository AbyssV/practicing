```bash
# 更新Anaconda
conda update conda

# 更新所有包
conda update --all

# 添加清华源
# 执行以下命令
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
conda config --set show_channel_urls yes
# https://blog.csdn.net/qq_18941425/article/details/80201966

# Ubuntu Anaconda 使用改文件的方式添加清华源
https://mirrors.tuna.tsinghua.edu.cn/help/ubuntu/

# remove some packages
conda remove beautifulsoup4
```

