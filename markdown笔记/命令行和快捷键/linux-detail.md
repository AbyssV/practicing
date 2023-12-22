# awk

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

