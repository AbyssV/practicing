字符串和数组

```sh
#!/bin/bash

:<<'
我是多行注释
'

your_name="zhangsan"
readonly your_name
# 双引号里可以有变量；双引号里可以出现转义字符
str="Hello, I know you are \"$your_name\"! \n"
echo -e $str
echo "the length of str: ${#str}" # 获取字符串长度
echo "get 1-3 characters: "${str:1:3}" # 从第2个字符开始获取3个字符
echo `expr index "$str" gs` # 查看字符g或s的位置（哪个字母先出现就计算哪个）
unset $your_name


for skill in Ada Coffe Action Java; do
    echo "I am good at ${skill}Script" # 如果不给skill变量加花括号，写成echo "I am good at $skillScript"，解释器就会把$skillScript当成一个变量（其值为空）
    
# 创建数据
array_name = (1 2 3 4 5)
echo "数组的全部元素：${array_name[@]}"
echo "数组的长度：${#array_name[@]}"
done



```



执行

```bash
# 以可执行程序运行
chmod +x ./test.sh
./test.sh
# 以可执行参数运行，这种方式运行的脚本，不需要在第一行指定解释器信息，写了也没用
/bin/sh test.sh
/bin/php test.php
```

