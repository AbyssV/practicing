# 安装

```bash
# windows
scoop install nginx
choco install nginx
# linux
$ apt install nginx
# mac
$ brew install nginx
# docker
$ docker pull nginx
# 或编译安装
$ ./configure
$ make
$ make install
```

# 启动

```bash
$ nginx # 此时浏览器输入114.55.112.117登录我的网站可以看到nginx的欢迎页面
# 查看网络及端口号
$ ps -ef | grep nginx
# 如果报错，可能是端口号被占用
$ lsof -i:80
$ netstat -ntlp|grep 80
$ kill -9 进程id
# nginx命令
$ nginx -s quit # 优雅停止
$ nginx -s stop # 立即停止
$ nginx -s reload # 重载配置文件
$ nginx -s reopen # 重新打开日志文件
$ nginx -V # 查看安装目录，配置参数，配置文件位置，日志文件的位置

# 查看nginx配置文件nginx.conf文件位置
# 常见位置
# /etc/nginx/conf
# /usr/local/etc/nginx
# /opt/homebrew/etc/nginx
# 查看nginx -V后的--conf-path=.../nginx/nginx.conf
$ nginx -t # 查看配置文件位置，检查配置是否正确

# 查看安装目录
# 查看nginx -V后的--prefix=
```







```
location / { # 这里的/是相对于安装目录的更目录
    root html;
    index index.html index.htm;
}
```

