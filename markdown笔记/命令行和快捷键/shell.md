# 变量和字符串

- 变量命名：注意，变量名和等号之间不能有空格，这可能和你熟悉的所有编程语言都不一样。同时，变量名的命名须遵循如下规则：

  - 命名只能使用英文字母，数字和下划线，首个字符不能以数字开头。

  - 中间不能有空格，可以使用下划线 **_**。在shell脚本中使用空格会起到分割参数的作用，有时候可能会造成混淆
  - 不能使用标点符号。
  - 不能使用bash里的关键字（可用help命令查看保留关键字）。
- 单双引号：字符串可以用单引号，也可以用双引号，也可以不用引号

  - 单引号里的任何字符都会原样输出，其中的变量不会被转义；
  - 单引号字串中不能出现单独一个的单引号（对单引号使用转义符后也不行），但可成对出现，作为字符串拼接使用。
  - 双引号里可以有变量，定义的字符串会将变量值进行替换。双引号里可以出现转义字符
- `printf`格式化字符串
  - 语法：`printf  format-string  [arguments...]`
  - 默认的`printf`不会像`echo`自动添加换行符，我们可以手动添加`\n`
  - `%s %c %d %f`都是格式替代符，`％s`输出一个字符串，`％d`整型输出，`％c`输出一个字符，`％f`输出实数，以小数形式输出。
  - `%-10s`指一个宽度为 10 个字符（`-`表示左对齐，没有则表示右对齐），任何字符都会被显示在 10 个字符宽的字符内，如果不足则自动以空格填充，超过也会将内容全部显示出来。
  - `%-4.2f`指格式化为小数，其中`.2`指保留2位小数。
  - `%b`相对应的参数被视为含有要被处理的转义序列之字符串

- 变量名外面的花括号是可选的，加不加都行，加花括号是为了帮助解释器识别变量的边界。推荐给所有变量加上花括号，这是个好的编程习惯
- 使用`readonly`命令可以将变量定义为只读变量，只读变量的值不能被改变
- 使用`unset`命令可以删除变量。变量被删除后不能再次使用。`unset`命令不能删除只读变量。
- `read`命令一个一个词组地接收输入的参数，每个词组需要使用空格进行分隔；如果输入的词组个数大于需要的参数个数，则多出的词组将被作为整体为最后一个参数接收，参数说明：
  - `-p` 输入提示文字
  - `-n` 输入字符长度限制(达到6位，自动结束)
  - `-t` 输入限时
  - `-s` 隐藏输入内容

```sh
#!/bin/bash

:<<!
我是多行注释
我也是注释
!

your_name="zhangsan"
readonly your_name
# 双引号里可以有变量；双引号里可以出现转义字符
echo `date`
echo "-------------开启转义----------------"
str="Hello, I know you are \"$your_name\"! \n"
echo -e $str # -e 开启转义  
echo "Hello, I know you are \"$your_name\"! \n"
echo "------------不开启转义----------------"
echo 'Hello, I know you are \"$your_name\"! \n'
echo "-------------------------------"
echo "the length of str: ${#str}" # 获取字符串长度
echo "the length of str: `expr length "${str}"`" # 获取字符串长度
echo "get 1-3 characters: ${str:1:3}" # 从第2个字符开始获取3个字符
echo `expr index "$str" gs` # 查看字符g或s的位置（哪个字母先出现就计算哪个）
echo "----------输入new_name----------"
read -p "please enter two new names: " -n 20 -s new_name new_name2 # 从标准输入中读取一行,并把输入行的每个字段的值指定给 shell 变量
echo "my new name is $new_name $new_name2"
unset $new_name

echo "------------显示换行----------------"
echo -e "OK! \n" # -e 开启转义
echo "It is a test"

echo "-------------显示不换行----------------"
echo -e "OK! \c" # -e 开启转义 \c 不换行
echo "It is a test"

echo "-------------使用printf----------------"
printf "%-10s %-8s %-4s\n" 姓名 性别 体重kg  
printf "%-10s %-8s %-4.2f\n" 郭靖 男 66.1234 
printf "%-10s %-8s %-4.2f\n" 杨过 男 48.6543 
printf "%-10s %-8s %-4.2f\n" 郭芙 女 47.9876

echo "-------------printf更多例子----------------"
# format-string为双引号
printf "%d %s\n" 1 "abc"
# 单引号与双引号效果一样 
printf '%d %s\n' 1 "abc" 
# 没有引号也可以输出
printf %s abcdef

# 格式只指定了一个参数，但多出的参数仍然会按照该格式输出，format-string 被重用
printf %s abc def
printf "%s\n" abc def
printf "%s %s %s\n" a b c d e f g h i j

# 如果没有 arguments，那么 %s 用NULL代替，%d 用 0 代替
printf "%s and %d \n"
```



## printf 的转义序列

| 序列  | 说明                                                         |
| :---- | :----------------------------------------------------------- |
| \a    | 警告字符`$`，通常为ASCII的BEL字符                            |
| \b    | 后退                                                         |
| \c    | 抑制（不显示）输出结果中任何结尾的换行字符（只在%b格式指示符控制下的参数字符串中有效），而且，任何留在参数里的字符、任何接下来的参数以及任何留在格式字符串中的字符，都被忽略 |
| \f    | 换页（formfeed）                                             |
| \n    | 换行                                                         |
| \r    | 回车（Carriage return）                                      |
| \t    | 水平制表符                                                   |
| \v    | 垂直制表符                                                   |
| \\    | 一个字面上的反斜杠字符                                       |
| \ddd  | 表示1到3位数八进制值的字符。仅在格式字符串中有效             |
| \0ddd | 表示1到3位的八进制值字符                                     |



## 运行

注意，一定要写成 `./test.sh`，而不是`test.sh`，运行其它二进制的程序也一样，直接写`test.sh`，linux 系统会去 PATH 里寻找有没有叫`test.sh`的，而只有 `/bin`, `/sbin`, `/usr/bin`，`/usr/sbin`等在 PATH 里，你的当前目录通常不在 PATH 里，所以写成`test.sh`是会找不到命令的，要用`./test.sh`告诉系统说，就在当前目录找。

```bash
chmod +x ./test.sh  #使脚本具有执行权限
./test.sh  #执行脚本
# 这种方式运行的脚本，不需要在第一行指定解释器信息
/bin/sh test.sh
/bin/php test.php 
```



# 传递参数

与其他脚本语言不同的是，bash使用了很多特殊的变量来表示参数、错误代码和相关变量。下面是列举来其中一些变量，更完整的列表可以参考 [这里](https://www.tldp.org/LDP/abs/html/special-chars.html)。

- `$0` - 脚本名
- `$1` 到 `$9` - 脚本的参数。 `$1` 是第一个参数，依此类推。
- `$*` -  以一个单字符串显示所有向脚本传递的参数。
- `$@` - 与$*相同，但是使用时加引号，并在引号中返回每个参数。
- `$#` -  传递到脚本的参数个数
- `$?` - 前一个命令的返回值。仅对其上一条指令负责，一旦函数返回后其返回值没有立即保存入参数，那么其返回值将不再能通过`$?`获得
- `$$` - 当前脚本的进程识别码
- `$!` - 后台运行的最后一个进程的ID号
- `!!` - 完整的上一条命令，包括参数。常见应用：当你因为权限不足执行命令失败时，可以使用 `sudo !!`再尝试一次。
- `$_` - 上一条命令的最后一个参数。如果你正在使用的是交互式 shell，你可以通过按下 `Esc` 之后键入 . 来获取这个值。

`$*`与`$@`区别：

- 相同点：都是引用所有参数。
- 不同点：只有在双引号中体现出来。假设在脚本运行时写了三个参数 1、2、3，则 `$* `等价于 "1 2 3"（传递了一个参数），而`$@`等价于 "1" "2" "3"（传递了三个参数）。

```bash
#!/bin/bash
echo "传递的第二个参数为：$2";
echo "参数的数量为：$#";
echo "将参数作为一个字符串显示：$*";
```



# 数组

数组中可以存放多个值。Bash Shell 只支持一维数组，不支持多维数组。初始化时不需要定义数组大小。数组元素的下标由 0 开始。数组用括号来表示，元素用空格分割开

```bash
#!/bin/bash

# 创建数组，获取数组长度，索引数组
array_name=(1 2 3 4 5)
echo "数组的全部元素：${array_name[@]}"
echo "数组的长度：${#array_name[@]}"

name="zhangsan"
array_name2=(A B "C" $name)
array_name2[5]=F

# 关联数组，类似字典，键值是唯一的
declare -A site=(["name"]="zhangsan" ["addr"]="jiangning" ["hobby"]="game")

# 等价于
# declare -A site
# site["name"]="zhangsan"
# site["addr"]="jiangning"
# site["hobby"]="game"

echo "Addr的值为：${site["addr"]}"
echo "数组的键为：${!site[@]}"
echo "数组的值为：${site[@]}"
echo "数组的长度为：${#site[@]}"
```

# 运算符

**注意：**条件表达式要放在方括号之间，并且要有空格，例如: `[$a==$b]`是错误的，必须写成 `[ $a == $b ]`

## 算数运算符

原生bash不支持简单的数学运算，但是可以通过其他命令来实现，例如`awk`和`expr`，`expr`最常用。`expr`是一款表达式计算工具，使用它能完成表达式的求值操作

注意：

- 表达式和运算符之间要有空格，例如`2+2`是不对的，必须写成`2 + 2`，这与我们熟悉的大多数编程语言不一样。
- 完整的表达式要被反引号包含
- 乘号(`*`)前边必须加反斜杠(`\`)才能实现乘法运算
- 在 MAC 中 shell 的 expr 语法是：`$((表达式))`，此处表达式中的 `*` 不需要转义符号 `\`' 。

下表列出了常用的算术运算符，假定变量 a 为 10，变量 b 为 20：

| 运算符 | 说明                                          | 举例                          |
| :----- | :-------------------------------------------- | :---------------------------- |
| +      | 加法                                          | `expr $a + $b` 结果为 30。    |
| -      | 减法                                          | `expr $a - $b` 结果为 -10。   |
| *      | 乘法                                          | `expr $a \* $b` 结果为  200。 |
| /      | 除法                                          | `expr $b / $a` 结果为 2。     |
| %      | 取余                                          | `expr $b % $a` 结果为 0。     |
| =      | 赋值                                          | `a=$b` 把变量 b 的值赋给 a。  |
| ==     | 相等。用于比较两个数字，相同则返回 true。     | `[ $a == $b ]` 返回 false。   |
| !=     | 不相等。用于比较两个数字，不相同则返回 true。 | `[ $a != $b ]` 返回 true。    |



## 关系运算符

关系运算符只支持数字，不支持字符串，除非字符串的值是数字。

| 运算符 | 说明                                                  | 举例                         |
| :----- | :---------------------------------------------------- | :--------------------------- |
| -eq    | 检测两个数是否相等，相等返回 true。                   | `[ $a -eq $b ]` 返回 false。 |
| -ne    | 检测两个数是否不相等，不相等返回 true。               | `[ $a -ne $b ]` 返回 true。  |
| -gt    | 检测左边的数是否大于右边的，如果是，则返回 true。     | `[ $a -gt $b ]` 返回 false。 |
| -lt    | 检测左边的数是否小于右边的，如果是，则返回 true。     | `[ $a -lt $b ]` 返回 true。  |
| -ge    | 检测左边的数是否大于等于右边的，如果是，则返回 true。 | `[ $a -ge $b ]` 返回 false。 |
| -le    | 检测左边的数是否小于等于右边的，如果是，则返回 true。 | `[ $a -le $b ]` 返回 true。  |



## 布尔运算符

| 运算符 | 说明                                                | 举例                                       |
| :----- | :-------------------------------------------------- | :----------------------------------------- |
| !      | 非运算，表达式为 true 则返回 false，否则返回 true。 | `[ ! false ]` 返回 true。                  |
| -o     | 或运算，有一个表达式为 true 则返回 true。           | `[ $a -lt 20 -o $b -gt 100 ]` 返回 true。  |
| -a     | 与运算，两个表达式都为 true 才返回 true。           | `[ $a -lt 20 -a $b -gt 100 ]` 返回 false。 |



## 逻辑运算符

| 运算符 | 说明       | 举例                                        |
| :----- | :--------- | :------------------------------------------ |
| &&     | 逻辑的 AND | `[[ $a -lt 100 && $b -gt 100 ]]` 返回 false |
| \|\|   | 逻辑的 OR  | `[[ $a -lt 100 || $b -gt 100 ]] `返回 true  |

虽然`-a`和`&&`都有逻辑 与的含义，但它们的使用上下文是不同的。`-a`专门用于 test 或`[ ]`条件语句中，而`&&`是一个更通用的控制运算符，用于检查命令的执行状态。在现代 Bash 脚本中，建议使用`[[ ]]`条件测试和`&&`，因为它们更具可读性并提供更强大的功能。

你不能直接在单个`[  ]`条件测试中使用`&&`。这是因为`[ ]`是 test 命令的一个简化形式，而`&&`是 shell 的控制运算符，不是`test`命令的一个参数。



## 字符串运算符

下表列出了常用的字符串运算符，假定变量 a 为 "abc"，变量 b 为 "efg"：

| 运算符 | 说明                                         | 举例                       |
| :----- | :------------------------------------------- | :------------------------- |
| =      | 检测两个字符串是否相等，相等返回 true。      | `[ $a = $b ]` 返回 false。 |
| !=     | 检测两个字符串是否不相等，不相等返回 true。  | `[ $a != $b ]` 返回 true。 |
| -z     | 检测字符串长度是否为0，为0返回 true。        | `[ -z $a ]` 返回 false。   |
| -n     | 检测字符串长度是否不为 0，不为 0 返回 true。 | `[ -n "$a" ]` 返回 true。  |
| $      | 检测字符串是否不为空，不为空返回 true。      | `[ $a ]` 返回 true。       |



## 文件测试运算符

文件测试运算符用于检测 Unix 文件的各种属性。

变量 file 表示文件 **/var/www/runoob/test.sh**，它的大小为 100 字节，具有 **rwx** 权限。下面的代码，将检测该文件的各种属性

| 操作符  | 说明                                                         | 举例                      |
| :------ | :----------------------------------------------------------- | :------------------------ |
| -b file | 检测文件是否是块设备文件，如果是，则返回 true。              | [ -b $file ] 返回 false。 |
| -c file | 检测文件是否是字符设备文件，如果是，则返回 true。            | [ -c $file ] 返回 false。 |
| -d file | 检测文件是否是目录，如果是，则返回 true。                    | [ -d $file ] 返回 false。 |
| -f file | 检测文件是否是普通文件（既不是目录，也不是设备文件），如果是，则返回 true。 | [ -f $file ] 返回 true。  |
| -g file | 检测文件是否设置了 SGID 位，如果是，则返回 true。            | [ -g $file ] 返回 false。 |
| -k file | 检测文件是否设置了粘着位(Sticky Bit)，如果是，则返回 true。  | [ -k $file ] 返回 false。 |
| -p file | 检测文件是否是有名管道，如果是，则返回 true。                | [ -p $file ] 返回 false。 |
| -u file | 检测文件是否设置了 SUID 位，如果是，则返回 true。            | [ -u $file ] 返回 false。 |
| -r file | 检测文件是否可读，如果是，则返回 true。                      | [ -r $file ] 返回 true。  |
| -w file | 检测文件是否可写，如果是，则返回 true。                      | [ -w $file ] 返回 true。  |
| -x file | 检测文件是否可执行，如果是，则返回 true。                    | [ -x $file ] 返回 true。  |
| -s file | 检测文件是否为空（文件大小是否大于0），不为空返回 true。     | [ -s $file ] 返回 true。  |
| -e file | 检测文件（包括目录）是否存在，如果是，则返回 true。          | [ -e $file ] 返回 true。  |

其他检查符：

- **-S**: 判断某文件是否 socket。
- **-L**: 检测文件是否存在并且是一个符号链接。



```bash
#!/bin/bash

# 算术运算符
echo "-------------算数运算符----------------"
val=`expr 2 + 2` # 注意表达式和运算符中要有空格
a=10
b=20
echo "sum: `expr $a + $b`"
echo "substract: `expr $a - $b`"
echo "multiplication: `expr $a \* $b`" # 必须有反斜杠
echo "division: `expr $b / $a`"
echo "mod: `expr $b % $a`"
if [ $a == $b ]
then
    echo "a equals b"
fi

if [ $a != $b ]
then
	echo "a not equals b"
fi

# 关系运算符只支持数字，不支持字符串，除非字符串的值是数字
# 注意什么都不会打印，需要像上面的一样包在if then else fi里
echo "-------------布尔运算符----------------"
echo `[ $a -eq $b ]` # 打印空行
echo `[ $a -ne $b ]`
echo `[ $a -gt $b -o $a -lt $b ]`
echo `[ $a -le $b -a $a -ge $b ]`
if [ $a -le $b -a $a -ge $b ]
then 
	echo "a equals b"
else
	echo "a not equals b"

fi

echo "-------------逻辑运算符----------------"
# 更推荐
if [[ $a -le $b && $b -gt 100 ]]; then 
	echo "wrong!"
else
	echo "correct!"

fi

if [ $a -le $b ] || [ $b -gt 100 ]; then 
	echo "corrent!"
else
	echo "wrong!"

fi

echo "-------------字符串运算符----------------"
a='abc'
b='efg'
if [ -z $a ]
then
   echo "-z $a : 字符串长度为 0"
else
   echo "-z $a : 字符串长度不为 0"
fi
if [ -n "$a" ]
then
   echo "-n $a : 字符串长度不为 0"
else
   echo "-n $a : 字符串长度为 0"
fi
if [ $a ]
then
   echo "$a : 字符串不为空"
else
   echo "$a : 字符串为空"
fi

echo "-------------文件测试运算符----------------"
file="./stringPrac.sh"
if [ -r $file ]
then
   echo "文件可读"
else
   echo "文件不可读"
fi
if [ -w $file ]
then
   echo "文件可写"
else
   echo "文件不可写"
fi
if [ -x $file ]
then
   echo "文件可执行"
else
   echo "文件不可执行"
fi
if [ -f $file ]
then
   echo "文件为普通文件"
else
   echo "文件为特殊文件"
fi
if [ -d $file ]
then
   echo "文件是个目录"
else
   echo "文件不是个目录"
fi
if [ -s $file ]
then
   echo "文件不为空"
else
   echo "文件为空"
fi
if [ -e $file ]
then
   echo "文件存在"
else
   echo "文件不存在"
fi
```



## test命令

Shell中的 test 命令用于检查某个条件是否成立，它可以进行数值、字符和文件三个方面的测试。

```bash
#!/bin/bash
printf -- "---------------测试数值----------------------\n"
num1=100
num2=100
if test $[num1] -eq $[num2]
then
    echo '两个数相等！'
else
    echo '两个数不相等！'
fi
printf -- "---------------测试字符串----------------------\n"
num1="ru1noob"
num2="runoob"
if test $num1 = $num2
then
    echo '两个字符串相等!'
else
    echo '两个字符串不相等!'
fi
printf -- "---------------测试文件----------------------\n"
cd /home/yating/桌面/study
if test -e ./stringPrac.sh -o -e ./arrPrac.sh
then
    echo '至少有一个文件存在!'
else
    echo '两个文件都不存在'
fi

echo "--------------------------------------------"
# 代码中的 [] 执行基本的算数运算，如：
a=5
b=6
result=$[a+b] # 注意等号两边不能有空格
echo "a+b 为： $result"
```



# 流程控制



## if then elif then else fi

```bash
# 1.
if condition
then
    command1 
    command2
    ...
    commandN 
fi
# 2.
if condition
then
    command1 
    command2
    ...
    commandN
else
    command
fi
# 3.
if condition1
then
    command1
elif condition2 
then 
    command2
else
    commandN
fi
# 写成一行
if [ $(ps -ef | grep -c "ssh") -gt 1 ]; then echo "ssh running"; fi
```

### 代码

if else 的`[...]`判断语句中大于使用`-gt`，小于使用`-lt`。如果使用`((...))`作为判断语句，大于和小于可以直接使用`>`和`<`

```bash
#!/bin/bash


a=10
b=20
if [ $a == $b ]
then
    echo "a 等于 b"
elif [ $a -gt $b ]
then
    echo "a 大于 b"
elif [ $a -lt $b ]
then
    echo "a 小于 b"
else
    echo "没有符合的条件"
fi


a=10
b=20
if (( $a == $b ))
then
    echo "a 等于 b"
elif (( $a > $b ))
then
    echo "a 大于 b"
elif (( $a < $b ))
then
    echo "a 小于 b"
else
    echo "没有符合的条件"
fi
```



## for in do done

```bash
for var in item1 item2 ... itemN
do
    command1
    command2
    ...
    commandN
done

# 写成一行
for var in item1 item2 ... itemN; do command1; command2… done;

# 无限循环
for (( ; ; ))


# 例如
for str in This is a string
do
    echo $str
done

max=5
for index in `seq $max`
do
    echo $index
done
```



## while do done

```bash
while condition
do
    command
done

# 无限循环
while :
do
    command
done
# 或
while true
do
    command
done

# 例如
int=1
while(( $int<=5 ))
do
    echo $int
    let "int++"
done

echo '按下 <CTRL-D> 退出'
echo -n '输入你最喜欢的网站名: '
while read FILM
do
    echo "是的！$FILM 是一个好网站"
done
```



## until

until 循环与 while 循环在处理方式上刚好相反，until 循环执行一系列命令，如果返回值为 false，则继续执行循环体内的语句，否则跳出循环

一般 while 循环优于 until 循环，但在某些时候—也只是极少数情况下，until 循环更加有用。

```bash
until condition
do
    command
done

a=0

until [ ! $a -lt 5 ]
do
    echo $a
    a=`expr $a + 1`
done
```

## case esac

`case ... esac`为多选择语句，与其他语言中的`switch ... case`语句类似，是一种多分支选择结构，每个`case`分支用右圆括号开始，用两个分号`;;`表示`break`，即执行结束，跳出整个`case ... esac`语句，`esac`（就是 case 反过来）作为结束标记。

可以用 case 语句匹配一个值与一个模式，如果匹配成功，执行相匹配的命令；如果无一匹配模式，使用星号 * 捕获该值，再执行后面的命令。

```bash
case 值 in
模式1)
    command1
    command2
    ...
    commandN
    ;;
模式2)
    command1
    command2
    ...
    commandN
    ;;
esac

echo '输入 1 到 4 之间的数字:'
echo '你输入的数字为:'
read aNum
case $aNum in
    1)  echo '你选择了 1'
    ;;
    2)  echo '你选择了 2'
    ;;
    3)  echo '你选择了 3'
    ;;
    4)  echo '你选择了 4'
    ;;
    *)  echo '你没有输入 1 到 4 之间的数字'
    ;;
esac
```



## break / continue

`break` 命令允许跳出所有循环（终止执行后面的所有循环）。

`continue`不会跳出所有循环，仅仅跳出当前循环。

```bash
while :
do
    echo -n "输入 1 到 5 之间的数字:"
    read aNum
    case $aNum in
    1|2|3|4|5) echo "你输入的数字为 $aNum!"
    ;;
    *) echo "你输入的数字不是 1 到 5 之间的! 游戏结束"
        break
    ;;
    esac
done
```



# 函数

- 可以带参数，也可以不带参数。带参数时，在函数体内部，通过 `$n`的形式来获取参数的值，例如，`$1`表示第一个参数，`$2`表示第二个参数...
  - 注意，`$10`不能获取第十个参数，获取第十个参数需要`${10}`。当n>=10时，需要使用`${n}`来获取参数
  - 可以使用`return`返回值，也可以不返回，不返回将以最后一条命令运行结果作为返回值。 return后跟数值n(0-255)
- 所有函数在使用前必须定义。这意味着必须将函数放在脚本开始部分，直至shell解释器首次发现它时，才可以使用。调用函数仅使用其函数名即可
- 通过source 来加载函数，随后可以在 bash 中直接使用

```bash
#!/bin/bash
funWithReturn(){
    echo "这个函数会对输入的两个数字进行相加运算..."
    echo "输入第一个数字: "
    read aNum
    echo "输入第二个数字: "
    read anotherNum
    echo "两个数字分别为 $aNum 和 $anotherNum !"
    return $(($aNum+$anotherNum))
}
funWithReturn
echo "输入的两个数字之和为 $? !"
```



# Shell 输入/输出重定向

大多数 UNIX 系统命令从你的终端接受输入并将所产生的输出发送回到您的终端。一个命令通常从一个叫标准输入的地方读取输入，默认情况下，这恰好是你的终端。同样，一个命令通常将其输出写入到标准输出，默认情况下，这也是你的终端。

一般情况下，每个 Unix/Linux 命令运行时都会打开三个文件：

- 标准输入文件(stdin)：stdin的文件描述符为0，Unix程序默认从stdin读取数据。
- 标准输出文件(stdout)：stdout 的文件描述符为1，Unix程序默认向stdout输出数据。
- 标准错误文件(stderr)：stderr的文件描述符为2，Unix程序会向stderr流中写入错误信息。

重定向命令列表如下：

| 命令            | 说明                                                         |
| :-------------- | :----------------------------------------------------------- |
| command > file  | 将输出重定向到 file。                                        |
| command < file  | 将输入重定向到 file。                                        |
| command >> file | 将输出以追加的方式重定向到 file。                            |
| n > file        | 将文件描述符为 n 的文件重定向到 file。                       |
| n >> file       | 将文件描述符为 n 的文件以追加的方式重定向到 file。           |
| n >& m          | 将输出文件 m 和 n 合并。放在`>`后面的`&`，表示重定向的目标不是一个文件，而是一个文件描述符 |
| n <& m          | 将输入文件 m 和 n 合并。                                     |
| << tag          | 将开始标记 tag 和结束标记 tag 之间的内容作为输入。           |
| 2&>1            | 混合输出错误的和正确的都输出                                 |

```bash
command1 < infile > outfile # 同时替换输入和输出，执行command1，从文件infile读取内容，然后将输出写入到outfile中
# 将 stdout 和 stderr 合并后重定向到 file
# 换言之 2>1 代表将stderr重定向到当前路径下文件名为1的regular file中，而2>&1代表将stderr重定向到文件描述符为1的文件(即/dev/stdout)中，这个文件就是stdout在file system中的映射
# 这里的 2 和 > 之间不可以有空格
command > file 2>&1
# 或
command >> file 2>&1
```

## Here Document

Here Document 是 Shell 中的一种特殊的重定向方式，用来将输入重定向到一个交互式 Shell 脚本或程序。它的作用是将两个 delimiter 之间的内容(document) 作为输入传递给 command。我们可以将 Here Document 用在命令行和脚本中

注意：

- 结尾的`delimiter`一定要顶格写，前面不能有任何字符，后面也不能有任何字符，包括空格和 tab 缩进。
- 开始的`delimiter`前后的空格会被忽略掉

它的基本的形式如下：

```bash
command << delimiter
    document
delimiter
# 输出结果为 3 行
$ wc -l << EOF
    欢迎来到
    菜鸟教程
    www.runoob.com
EOF
```

## /dev/null 文件

如果希望执行某个命令，但又不希望在屏幕上显示输出结果，那么可以将输出重定向到`/dev/null`。`/dev/null`是一个特殊的文件，写入到它的内容都会被丢弃；如果尝试从该文件读取内容，那么什么也读不到。但是`/dev/null`文件非常有用，将命令的输出重定向到它，会起到"禁止输出"的效果。

如果希望屏蔽 stdout 和 stderr，可以这样写：

```bash
$ command > /dev/null 2>&1
```



# 文件包含

和其他语言一样，Shell 也可以包含外部脚本。这样可以很方便的封装一些公用的代码作为一个独立的文件

```bash
# test1.sh
#!/bin/bash
url="http://www.runoob.com"

# test2.sh
#!/bin/bash
#使用 . 号来引用test1.sh 文件， 注意点号(.)和文件名中间有一空格
. ./test1.sh
# 或者使用以下包含文件代码
# source ./test1.sh
echo "菜鸟教程官网地址：$url"
```



# 补充

## 命令替换和进程替换

当您通过 `( CMD )` 这样的方式来执行`CMD` 这个命令时，它的输出结果会替换掉 `$( CMD )` 。例如，如果执行 `for file in $(ls)` ，shell首先将调用`ls` ，然后遍历得到的这些返回值。还有一个冷门的类似特性是进程替换（process substitution）， `<( CMD )` 会执行 `CMD` 并将结果输出到一个临时文件中，并将 `<( CMD )` 替换成临时文件名。这在我们希望返回值通过文件而不是STDIN传递时很有用。例如， `diff <(ls foo) <(ls bar)` 会显示文件夹 `foo` 和 `bar` 中包含文件的不同。

说了很多，现在该看例子了，下面这个例子展示了一部分上面提到的特性。这段脚本会遍历我们提供的参数，使用`grep` 搜索字符串 `foobar`，如果没有找到，则将其作为注释追加到文件中。

```bash
#!/bin/bash

echo "Starting program at $(date)" # date会被替换成日期和时间

echo "Running program $0 with $# arguments with pid $$"

for file in "$@"; do
    grep foobar "$file" > /dev/null 2> /dev/null
    # 如果模式没有找到，则grep退出状态为 1
    # 我们将标准输出流和标准错误流重定向到Null，因为我们并不关心这些信息
    if [[ $? -ne 0 ]]; then
        echo "File $file does not have any foobar, adding one"
        echo "# foobar" >> "$file"
    fi
done
```

在条件语句中，我们比较 `$?` 是否等于0。 Bash实现了许多类似的比较操作，您可以查看 [`test 手册`](https://man7.org/linux/man-pages/man1/test.1.html)。 **在bash中进行比较时，尽量使用双方括号 `[[ ]]` 而不是单方括号 `[ ]`，这样会降低犯错的几率**，尽管这样并不能兼容 `sh`。 更详细的说明参见[这里](http://mywiki.wooledge.org/BashFAQ/031)。

## 通配符

当执行脚本时，我们经常需要提供形式类似的参数。bash使我们可以轻松的实现这一操作，它可以基于文件扩展名展开表达式。这一技术被称为shell的 *通配*（*globbing*）

- 通配符 - 当你想要利用通配符进行匹配时，你可以分别使用 `?` 和 `*` 来匹配一个或任意个字符。例如，对于文件`foo`, `foo1`, `foo2`, `foo10` 和 `bar`, `rm foo?`这条命令会删除`foo1` 和 `foo2` ，而`rm foo*` 则会删除除了`bar`之外的所有文件。
- 花括号`{}` - 当你有一系列的指令，其中包含一段公共子串时，可以用花括号来自动展开这些命令。这在批量移动或转换文件时非常方便。

```bash
convert image.{png,jpg}
# 会展开为
convert image.png image.jpg

cp /path/to/project/{foo,bar,baz}.sh /newpath
# 会展开为
cp /path/to/project/foo.sh /path/to/project/bar.sh /path/to/project/baz.sh /newpath

# 也可以结合通配使用
mv *{.py,.sh} folder
# 会移动所有 *.py 和 *.sh 文件

mkdir foo bar
# 下面命令会创建foo/a, foo/b, ... foo/h, bar/a, bar/b, ... bar/h这些文件
touch {foo,bar}/{a..h}
touch foo/x bar/y
# 比较文件夹 foo 和 bar 中包含文件的不同
diff <(ls foo) <(ls bar)
# 输出
# < x
# ---
# > y
```

编写 `bash` 脚本有时候会很别扭和反直觉。例如 [shellcheck](https://github.com/koalaman/shellcheck) 这样的工具可以帮助你定位sh/bash脚本中的错误。

## shebang

注意，脚本并不一定只有用 bash 写才能在终端里调用。比如说，这是一段 Python 脚本，作用是将输入的参数倒序输出：

```python
#!/usr/local/bin/python
import sys
for arg in reversed(sys.argv[1:]):
    print(arg)
```

内核知道去用 python 解释器而不是 shell 命令来运行这段脚本，是因为脚本的开头第一行的 [shebang](https://en.wikipedia.org/wiki/Shebang_(Unix))。

在 `shebang` 行中使用 [`env`](https://man7.org/linux/man-pages/man1/env.1.html) 命令是一种好的实践，它会利用环境变量中的程序来解析该脚本，这样就提高来您的脚本的可移植性。`env` 会利用我们第一节讲座中介绍过的`PATH` 环境变量来进行定位。 例如，使用了`env`的shebang看上去时这样的`#!/usr/bin/env python`。

shell函数和脚本有如下一些不同点：

- 函数只能与shell使用相同的语言，脚本可以使用任意语言。因此在脚本中包含 `shebang` 是很重要的。
- 函数仅在定义时被加载，脚本会在每次被执行时加载。这让函数的加载比脚本略快一些，但每次修改函数定义，都要重新加载一次。
- 函数会在当前的shell环境中执行，脚本会在单独的进程中执行。因此，函数可以对环境变量进行更改，比如改变当前工作目录，脚本则不行。脚本需要使用 [`export`](https://man7.org/linux/man-pages/man1/export.1p.html) 将环境变量导出，并将值传递给环境变量。
- 与其他程序语言一样，函数可以提高代码模块性、代码复用性并创建清晰性的结构。shell脚本中往往也会包含它们自己的函数定义。



