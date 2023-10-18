# Docker常用命令

docker有缓存，因此`COPY. .`的之前可以把不常改的文件`COPY`后运行`RUN`

```bash
-------------------------------docker镜像----------------------------
docker tag e6f yating/nodejs:v1.0 # 用户名/镜像名:版本
-# a列出本地所有的镜像（含中间层镜像），-q只显示镜像ID
docker image ls -a # 列出所有镜像
docker image -f since=mongo:3.2 # filter出mongo:3.2之后建立的镜像，也可用after
docker image prune # 删除虚悬镜像，指被同款的镜像顶掉的老版本镜像
docker rmi -f 镜像名 / docker imgage rm
docker rmi -f $(docker image -qa) 删除所有镜像
docker history 镜像名 # 查看镜像内的历史记录 

docker login
docker logout
docker push yating/nodejs:v1.0 # push到registry
docker search # 从docker hub上搜索镜像
docker search --limit 5 redis # 只列出前5个
docker search --filter=stars=5000 # 仅显示收藏数在5000以上的镜像
docker pull # 从registry下载镜像，下载镜像没有注明版本默认最新版
--------------------------------docker容器------------------------------
docker rm -fv 容器名/ docker container rm 容器名 # 删除前最好停止。-v 或 --volumes 选项的作用是删除与容器关联的卷（volumes）。容器可以与一个或多个卷关联，这些卷用于在容器之间或容器与宿主机之间持久地存储数据。当你删除一个容器时，如果不使用 -v 或 --volumes 选项，容器的卷不会被自动删除。这意味着，即使容器被删除，卷上的数据仍然存在并占用磁盘空间。使用 -v 选项可以确保在删除容器时同时删除这些卷，从而释放与它们关联的存储空间。
docker container prine # 删除所有处于终止状态的容器
docker inspect 容器名 # 查看容器运行的各种数据
docker container ls #  列出正在运行的所有容器
docker ps -a # 列出所有容器
docker ps -l # 查看最后一次运行的容器
docker ps -f status=exited # 查看停止的容器
docker start # 启动一个或多个已经停止的容器
docker stop # 停止一个或多个正在运行的容器
docker restatr # 重启

docker diff 容器名 # 查看容器存储层改动
docker cp 本机文件 容器名称:容器目录 # 将本机文件拷贝到容器

# --name为基于镜像test_image为容器指定名称flask_project
# -d: 后台运行容器并返回容器ID，也即启动守护式容器(后台运行)
# -i：以交互模式运行容器，通常与 -t 同时使用
# -t：为容器重新分配一个伪输入终端，通常与 -i 同时使用；也即启动交互式容器(前台有伪终端，等待交互)
# -p: 指定端口映射 -p 8080:80
# -e：表示设置环境变量
# -rm：退出容器后将之删除，避免浪费空间。我们不用
# --privileged=true：解决挂载时没有权限的问题
# 第二个-v表示本机的node_modules不要覆盖容器的node_modules，ro表示对本机的文件read only。因为我们是整个文件复制（也可以写个.dockerignore）
# 使用镜像创建并启动一个容器（如果镜像不存在就从registry上下载）
docker run -it centos /bin/bash # 使用镜像centos:latest以交互模式启动一个容器,在容器内执行/bin/bash命令
docker run -d -v /User/yating/Desktop/project/:/project:ro -v /project/node_modules -p 3000:3000 --name flask_project test_image
exit # 退出容器，退出时会关闭容器，而docker start不会


# 进入容器，使用exit退出容器不会导致容器停止
docker exec -it 容器ID COMMAND [ARG...]

--------------------------------迁移和备份------------------------------
# 注意：不要使用docker commit保存镜像，保存镜像请用Dockerfile
# 这个因为 1. 除了真正修改的内容，其他的无关内容也会被修改，因此改动变为黑箱操作 2.介于docker分层存储的概念，因此后期的每一次修改都会添加新的层，让镜像更臃肿（因为上层的东西不会丢失）
docker --author "lin" --message "change html files" commit 容器名称 镜像名称 # 将文件存储层保存为镜像

# Docker 还提供了 docker save 和 docker load 命令，用以将镜像保存为一个文件，然后传输到另一个位置上，再加载进来。这是在没有 Docker Registry 时的做法，现在已经不推荐，镜像迁移应该直接使用 Docker Registry，无论是直接使用 Docker Hub 还是使用内网私有 Registry 都可以。
docker save -o tar文件名 镜像文件名 # 将镜像备份为tar文件
docker load -i tar文件名# 根据tar文件恢复为镜像
# 如果我们结合这两个命令以及 ssh 甚至 pv 的话，利用 Linux 强大的管道，我们可以写一个命令完成从一个机器将镜像迁移到另一个机器，并且带进度条的功能：
docker save <镜像名> | bzip2 | pv | ssh <用户名>@<主机名> 'cat | docker load'

# 导出容器
docker export 容器ID > 文件名.tar
docker export 452435 > redis:6.0.8.tar

# 注意 被docker export出来的镜像在启动的时候需要指定command
# 导入镜像
# 注：用户既可以使用 docker load 来导入镜像存储文件到本地镜像库，也可以使用 docker import 来导入一个容器快照到本地镜像库。这两者的区别在于容器快照文件将丢弃所有的历史记录和元数据信息（即仅保存容器当时的快照状态），而镜像存储文件将保存完整记录，体积也要大。此外，从容器快照文件导入时可以重新指定标签等元数据信息
docker import - 文件名.tar 镜像用户/镜像名:镜像版本号 # 也支持压缩包
docker import redis:6.0.8.tar yik/redis:6.0.8 redis-server
--------------------------------其他------------------------------
#查看镜像/容器/数据卷所占的空间
docker system df
# 查看docker的运行状态
docker stats
# 用于获取和查看 Docker 容器的日志输出。这些日志通常是容器内主进程（通常由 CMD 或 ENTRYPOINT 指令指定）在 stdout（标准输出）和 stderr（标准错误）上的输出
docker logs --tail 10 --timestamps container_name 
--------------------------------Dockerfile------------------------------
# 这个.是上下文路径，
docker build -t test_image . # -t表示给镜像命名为test_image，.表示基于当前目录的Dockerfile来构建镜像



```

> **镜像构建上下文**
>
> 一般来说，应该会将 `Dockerfile` 置于一个空目录下，或者项目根目录下。如果该目录下没有所需文件，那么应该把所需文件复制一份过来。如果目录下有些东西确实不希望构建时传给 Docker 引擎，那么可以用 `.gitignore`一样的语法写一个 `.dockerignore`，该文件是用于剔除不需要作为上下文传递给 Docker 引擎的。
>
> Q：使用docker时，如何确定文件目录地址呢？例如，我在Dockerfile中写入`COPY dist/ /usr/share/nginx.html/`随后执行`docker build -t docker-demo .`那么这个`.`是否指Dockerfile所在的目录？而dist/的位置则是基于Dockerfile所在的目录？
>
> A：是的，你的理解是正确的。
>
> 当你使用 `docker build` 命令并提供 `.` 作为上下文（context）的路径时，`.` 指的是当前目录，通常是你的 `Dockerfile` 所在的位置。Docker 使用这个上下文来执行构建，这意味着它会考虑这个目录中的所有文件和子目录。这里的 `dist/` 是基于 `Dockerfile` 所在的目录的相对路径。确保你在执行 `docker build` 时的当前工作目录包含所有你想在 Docker 映像中使用的文件。不在这个上下文中的文件是无法被 `Dockerfile` 访问的。



# Dcokerfile

```dockerfile
FROM image_name:tag # 定义基础镜像
MAINTAINER lyt yatinl4@uci.edu # 声明镜像的创建者
LABEL authors="yating" version="1.0" description="这是一个web应用"# 为镜像添加元数据
# ARG 构建参数和 ENV 的效果一样，都是设置环境变量。所不同的是，ARG 所设置的构建环境的环境变量，在将来容器运行时是不会存在这些环境变量的。但是不要因此就使用 ARG 保存密码之类的信息，因为 docker history 还是可以看到所有值的
ENV VERSION=1.0 DEBUG=on \
    NAME="Happy Feet"
ENV JAVA_HOME /usr/java1.8/# 设置环境变量，以供其他命令使用，其他命令使用时，只需要${VERSION}即可
EXPOSE 3306 # 声明容器运行时提供服务的端口，这只是一个声明，在容器运行时并不会因为这个声明应用就会开启这个端口的服务。在 Dockerfile 中写入这样的声明有两个好处，一个是帮助镜像使用者理解这个镜像服务的守护端口，以方便配置映射；另一个用处则是在运行时使用随机端口映射时，也就是 docker run -P 时，会自动随机映射 EXPOSE 的端口
ONBUILD RUN ["npm","install"] # ONBUILD 是一个特殊的指令，它后面跟的是其它指令，比如 RUN, COPY 等，而这些指令，在当前镜像构建时并不会被执行。只有当以当前镜像为基础镜像，去构建下一级镜像的时候才会被执行


# 为了防止运行时用户忘记将动态文件（例如执行mysql）所保存目录挂载为卷，在 Dockerfile 中，我们可以事先指定某些目录挂载为匿名卷，这样在运行时如果用户不指定挂载，其应用也可以正常运行，不会向容器存储层写入大量数据
VOLUME /data #这里的 /data 目录就会在容器运行时自动挂载为匿名卷，任何向 /data 中写入的信息都不会记录进容器存储层，从而保证了容器存储层的无状态化。当然，运行容器时可以覆盖这个挂载设置。比如：
$ docker run -d -v mydata:/data xxxx # 在这行命令中，就使用了 mydata 这个命名卷挂载到了 /data 这个位置，替代了 Dockerfile 中定义的匿名卷的挂载配置

WORKDIR path_dir # 设置容器当前目录

RUN groupadd -r redis && useradd -r -g redis redis
USER redis  # 改变之后层的执行 RUN, CMD 以及 ENTRYPOINT 这类命令的身份。这个用户必须是事先建立好的，否则无法切换。
RUN [ "redis-server" ]

# 使用COPY指令，源文件的各种元数据都会保留。比如读、写、执行权限、文件变更时间等。这个特性对于镜像定制很有用
# 在使用COPY和ADD指令的时候还可以加上 --chown=<user>:<group> 选项来改变文件的所属用户及所属组
COPY source_dir/file dest_dir/file # 将宿主机的文件复制到容器内，不会解压缩
ADD source_dir/file dest_dir/file # 和COPY类似，会在复制后自动解压缩文件，不解压缩不要使用add

CMD ["nginx","-g","demon off;"]
ENTRYPOINT ["nginx","-g","demon off;"] # cmd的值将作为entrypoint的参数

```

## `ENV`补充

当你在 `Dockerfile` 中使用 `ENV <key>=<value>` 指令设置环境变量时，你确实为运行在容器中的进程设置了环境变量，但这与在 `~/.bashrc` 文件中设置的环境变量有所不同。

1. `ENV` 指令设置的环境变量
   - 这些变量是全局的，意味着它们适用于容器中的所有进程。
   - 当你启动一个容器时，使用 `docker run` 的 `-e` 选项可以覆盖它们。
   - 这些变量在容器的所有层中都是可用的，这包括后续的 `RUN`, `CMD`, `ENTRYPOINT` 等指令。
2. 在 `~/.bashrc` 中设置的环境变量
   - 它们特定于用户，并且仅在启动 bash shell 时加载。
   - 这些变量仅对由该特定 bash shell 启动的进程可用。
   - 在 Docker 容器的上下文中，通常不建议使用 `~/.bashrc` 来设置环境变量，除非你有一个特定的用例，需要这些变量仅在 bash session 中可用。

总之，`ENV` 在 `Dockerfile` 中设置的环境变量更为全局和持久，而在 `~/.bashrc` 中设置的环境变量更为局部并且仅在 bash session 中有效。在大多数 Docker 用例中，你可能更希望使用 `ENV` 指令来确保容器中的所有进程都可以访问这些变量。

## `CMD`说明

`CMD` 指令用于指定容器启动时的默认命令，`RUN`是在构建镜像时要运行的命令，当启动`docker run`运行容器的时候，`CMD`的值可以在命令行被覆盖。比如，`ubuntu` 镜像默认的 `CMD` 是 `/bin/bash`，如果我们直接 `docker run -it ubuntu` 的话，会直接进入 `bash`。我们也可以在运行时指定运行别的命令，如 `docker run -it ubuntu cat /etc/os-release`。这就是用 `cat /etc/os-release` 命令替换了默认的 `/bin/bash` 命令了，输出了系统版本信息。

它的格式和 `RUN` `ENTRYPOINT` 相似，也是两种格式：

- `shell` 格式：`CMD <命令>`
- `exec` 格式：`CMD ["可执行文件", "参数1", "参数2"...]`
- 参数列表格式：`CMD ["参数1", "参数2"...]`。在指定了 `ENTRYPOINT` 指令后，用 `CMD` 指定具体的参数。

```dockerfile
CMD echo $HOME # 这是shell格式
CMD ["sh","-C","echo $HOME"] # 在实际执行时，通常会被变更为此
```

## `ENTRYPOINT`说明

`ENTRYPOINT` 的目的和 `CMD` 一样，都是在指定容器启动程序及参数。`ENTRYPOINT` 在运行时也可以替代，不过比 `CMD`要略显繁琐，需要通过 `docker run` 的参数 `--entrypoint` 来指定。

当指定了 `ENTRYPOINT` 后，`CMD` 的含义就发生了改变，不再是直接的运行其命令，而是将 `CMD` 的内容作为参数传给 `ENTRYPOINT` 指令。

简单的来说，如果使用了`ENTRYPOINT`，例如`ENTRYPOINT ["curl", "-s", "http://myip.ipip.net"]`，那么此时无论是直接在CMD中使用`CMD ["-i"]`，或是在运行容器时使用`docker run myip -i`（注意这个`-i`会覆盖掉Dockerfile里的`CMD`），这个`-i`都会被当做`ENTRYPOINT`命令之后的参数。

## `shell`例子

`SHELL` 指令可以指定 `RUN` `ENTRYPOINT` `CMD` 指令的 shell，Linux 中默认为 `["/bin/sh", "-c"]`

两个 `RUN` 运行同一命令，第二个 `RUN` 运行的命令会打印出每条命令并当遇到错误时退出。

```dockerfile
SHELL ["/bin/sh", "-c"]
RUN lll ; ls
SHELL ["/bin/sh", "-cex"]
RUN lll ; ls
```

当 `ENTRYPOINT` `CMD` 以 shell 格式指定时，`SHELL` 指令所指定的 shell 也会成为这两个指令的 shell

```dockerfile
SHELL ["/bin/sh", "-cex"]
# /bin/sh -cex "nginx"
ENTRYPOINT nginx
```

```dockerfile
SHELL ["/bin/sh", "-cex"]
# /bin/sh -cex "nginx"
CMD nginx
```

## `ONBUILD`例子

```dockerfile
# 当Dokerfile出现问题，我们手动修改时，这样当基础镜像更新时，各个项目可以不用同步Dockerfile的变化
FROM node:slim
RUN mkdir /app
WORKDIR /app
ONBUILD COPY ./package.json /app
ONBUILD RUN [ "npm", "install" ]
ONBUILD COPY . /app/
CMD [ "npm", "start" ]

# 然后各个项目的 Dockerfile 就变成了简单地：
FROM my-node

```

## `run`例子

注意`RUN`还支持函数调用的格式，例如`RUN ["可执行文件","参数1","参数2"]`

```dockerfile
FROM debian:stretch
# 一定要将无关的东西删除，并清除apt缓存文件，这样构建下一层镜像的时候，这些无关的东西就不会被带上去
RUN set -x; buildDeps='gcc libc6-dev make wget' \
    && apt-get update \
    && apt-get install -y $buildDeps \
    && wget -O redis.tar.gz "http://download.redis.io/releases/redis-5.0.3.tar.gz" \
    && mkdir -p /usr/src/redis \
    && tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1 \
    && make -C /usr/src/redis \
    && make -C /usr/src/redis install \
    && rm -rf /var/lib/apt/lists/* \
    && rm redis.tar.gz \
    && rm -r /usr/src/redis \
    && apt-get purge -y --auto-remove $buildDeps
```

## 改变权限

如果以 `root` 执行的脚本，在执行期间希望改变身份，比如希望以某个已经建立好的用户来运行某个服务进程，不要使用 `su` 或者 `sudo`，这些都需要比较麻烦的配置，而且在 TTY 缺失的环境下经常出错。建议使用 [`gosu`](https://github.com/tianon/gosu)。

```dockerfile
# 建立 redis 用户，并使用 gosu 换另一个用户执行命令
RUN groupadd -r redis && useradd -r -g redis redis
# 下载 gosu
RUN wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/1.12/gosu-amd64" \
&& chmod +x /usr/local/bin/gosu \
&& gosu nobody true
# 设置 CMD，并以另外的用户执行
CMD [ "exec", "gosu", "redis", "redis-server" ]
```



# 数据卷

`数据卷` 是一个可供一个或多个容器使用的特殊目录，它绕过 UnionFS，可以提供很多有用的特性：

- `数据卷` 可以在容器之间共享和重用
- 对 `数据卷` 的修改会立马生效
- 对 `数据卷` 的更新，不会影响镜像
- `数据卷` 默认会一直存在，即使容器被删除

> 注意：`数据卷` 的使用，类似于 Linux 下对目录或文件进行 mount，镜像中的被指定为挂载点的目录中的文件会复制到数据卷中（仅数据卷为空时会复制）

```
docker volumn create pgdata # 创建数据卷
docker volumn ls # 查看所有的数据卷
docker volumn inspect pgdata # 查看指定数据卷的信息
docker run -itd --name postgres_proj\
-mount source=pgdata,target=/var/lib/postgresql/data =p 5432:5432 postgres # 启动一个挂载数据卷的容器，在一次docker run中可以挂载多个数据卷
docker inspect postgres_proj # 查看容器信息，数据卷信息在Mount下
docker volumn rm pgdata # 删除数据卷，如果需要在删除容器的同时移除数据卷。可以在删除容器的时候使用 docker rm -v 这个命令
docker volumn prune # 删除无主的数据卷

```

## 挂载主机目录作为数据卷

使用 `--mount` 标记可以指定挂载一个本地主机的目录到容器中去，也可以从主机挂载单个文件到容器中。下面的命令加载主机的 `/src/webapp` 目录到容器的 `/usr/share/nginx/html`目录。这个功能在进行测试的时候十分方便，比如用户可以放置一些程序到本地目录中，来查看容器是否正常工作。**<u>本地目录的路径必须是绝对路径</u>**，以前使用 `-v` 参数时如果本地目录不存在 Docker 会自动为你创建一个文件夹，现在使用 `--mount` 参数时如果本地目录不存在，Docker 会报错。

```
$ docker run -d -P \
    --name web \
    # -v /src/webapp:/usr/share/nginx/html \
    --mount type=bind,source=/src/webapp,target=/usr/share/nginx/html \
    nginx:alpine
```



Docker 挂载主机目录的默认权限是 `读写`，用户也可以通过增加 `readonly` 指定为 `只读`。加了 `readonly` 之后，就挂载为 `只读` 了。如果你在容器内 `/usr/share/nginx/html` 目录新建文件，会报错

```
$ docker run -d -P \
    --name web \
    # -v /src/webapp:/usr/share/nginx/html:ro \
    --mount type=bind,source=/src/webapp,target=/usr/share/nginx/html,readonly \
    nginx:alpine
```



# 访问仓库

## Docker Hub

见[Docker常用命令](#Docker常用命令)

## 私有仓库

用不上，略



# docker-compose

允许用户通过一个单独的 `docker-compose.yml` 模板文件（YAML 格式）来定义一组相关联的应用容器为一个项目（project）

## 命令

- `build`：`docker-compose build [options] [SERVICE...]`：构建（重新构建）项目中的服务容器。服务容器一旦构建后，将会带上一个标记名，例如对于 web 项目中的一个 db 容器，可能是 web_db。可以随时在项目目录下运行 `docker-compose build` 来重新构建服务。

  - `--force-rm` 删除构建过程中的临时容器。

  - `--no-cache` 构建镜像过程中不使用 cache（这将加长构建过程）。

  - `--pull` 始终尝试通过 pull 来获取更新版本的镜像。

- `scale`：`docker-compose scale [options] [SERVICE=NUM...]`设置指定服务运行的容器个数。通过 `service=num` 的参数来设置数量。例如：

  - `docker-compose scale web=3 db=2`将启动 3 个容器运行 web 服务，2 个容器运行 db 服务。一般的，当指定数目多于该服务当前实际运行容器，将新创建并启动容器；反之，将停止容器。

  - `-t, --timeout TIMEOUT` 停止容器时候的超时（默认为 10 秒）。

- `start`：`docker-compose start [SERVICE...]`：启动已经存在的服务容器。

- `stop` ：`docker-compose stop [options] [SERVICE...]`停止已经处于运行状态的容器，但不删除它。通过 `docker-compose start` 可以再次启动这些容器。
  - `-t, --timeout TIMEOUT` 停止容器时候的超时（默认为 10 秒）。

- `restart` ：`docker-compose restart [options] [SERVICE...]`重启项目中的服务。

  - `-t, --timeout TIMEOUT` 指定重启前停止容器的超时（默认为 10 秒）

- `pause` ： `docker-compose pause [SERVICE...]`：暂停一个服务容器

- `unpause` ： `docker-compose unpause [SERVICE...]`：恢复处于暂停状态中的服务。

- `up` ：`docker-compose up [options] [SERVICE...]`：该命令十分强大，它将尝试自动完成包括构建镜像，（重新）创建服务，启动服务，并关联服务相关容器的一系列操作。链接的服务都将会被自动启动，除非已经处于运行状态。**可以说，大部分时候都可以直接通过该命令来启动一个项目**。默认情况，`docker-compose up` 启动的容器都在前台，控制台将会同时打印所有容器的输出信息，可以很方便进行调试。当通过 `Ctrl-C` 停止命令时，所有容器将会停止。

  - 如果使用 `docker-compose up -d`，将会在后台启动并运行所有的容器。**一般推荐生产环境下使用该选项。**

  - 默认情况，如果服务容器已经存在，`docker-compose up` 将会尝试停止容器，然后重新创建（保持使用 `volumes-from` 挂载的卷），以保证新启动的服务匹配 `docker-compose.yml` 文件的最新内容。如果用户不希望容器被停止并重新创建，可以使用 `docker-compose up --no-recreate`。这样将只会启动处于停止状态的容器，而忽略已经运行的服务。如果用户只想重新部署某个服务，可以使用 `docker-compose up --no-deps -d <SERVICE_NAME>` 来重新创建服务并后台停止旧服务，启动新服务，并不会影响到其所依赖的服务。

  - `-d` 在后台运行服务容器。

  - `--no-color` 不使用颜色来区分不同的服务的控制台输出。

  - `--no-deps` 不启动服务所链接的容器。

  - `--force-recreate` 强制重新创建容器，不能与 `--no-recreate` 同时使用。

  - `--no-recreate` 如果容器已经存在了，则不重新创建，不能与 `--force-recreate` 同时使用。

  - `--no-build` 不自动构建缺失的服务镜像。

  - `-t, --timeout TIMEOUT` 停止容器时候的超时（默认为 10 秒）。

- `down`：此命令将会停止 `up` 命令所启动的容器，并移除网络
- `pull`：`docker-compose pull [options] [SERVICE...]`拉取服务依赖的镜像。
  - `--ignore-pull-failures` 忽略拉取镜像过程中的错误。

- `push`：推送服务依赖的镜像到 Docker 镜像仓库

- `run`：`docker-compose run [options] [-p PORT...] [-e KEY=VAL...] SERVICE [COMMAND] [ARGS...]`在指定服务上执行一个命令。例如：

  - `docker-compose run ubuntu ping docker.com`：将会启动一个 ubuntu 服务容器，并执行 `ping docker.com` 命令。默认情况下，如果存在关联，则所有关联的服务将会自动被启动，除非这些服务已经在运行中。该命令类似启动容器后运行指定的命令，相关卷、链接等等都将会按照配置自动创建。

  - 两个不同点：

    - 给定命令将会覆盖原有的自动运行命令；

    - 不会自动创建端口，以避免冲突。

  - 如果不希望自动启动关联的容器，可以使用 `--no-deps` 选项，例如`docker-compose run --no-deps web python manage.py shell`将不会启动 web 容器所关联的其它容器。

  - `-d` 后台运行容器。

  - `--name NAME` 为容器指定一个名字。

  - `--entrypoint CMD` 覆盖默认的容器启动指令。

  - `-e KEY=VAL` 设置环境变量值，可多次使用选项来设置多个环境变量。

  - `-u, --user=""` 指定运行容器的用户名或者 uid。

  - `--no-deps` 不自动启动关联的服务容器。

  - `--rm` 运行命令后自动删除容器，`d` 模式下将忽略。
    - 推荐使用`docker-compose exec`

  - `-p, --publish=[]` 映射容器端口到本地主机。

  - `--service-ports` 配置服务端口并映射到本地主机。

  - `-T` 不分配伪 tty，意味着依赖 tty 的指令将无法运行。

-  `top`：查看各个服务容器内运行的进程。

-  `ps`：`docker-compose ps [options] [SERVICE...]`列出项目中目前的所有容器。
  - `-q` 只打印容器的 ID 信息。
-  `logs`：`docker-compose logs [options] [SERVICE...]`查看服务容器的输出。默认情况下，docker-compose 将对不同的服务输出使用不同的颜色来区分。可以通过 `--no-color` 来关闭颜色。该命令在调试问题的时候十分有用。

- `docker-compose port [options] SERVICE PRIVATE_PORT`：打印某个容器端口所映射的公共端口。

  - `--protocol=proto` 指定端口协议，tcp（默认值）或者 udp。

  - `--index=index` 如果同一服务存在多个容器，指定命令对象容器的序号（默认为 1）。

-  `docker-compose kill [options] [SERVICE...]`：通过发送 `SIGKILL` 信号来强制停止服务容器。支持通过 `-s` 参数来指定发送的信号，例如通过如下指令发送 `SIGINT` 信号。

  - `docker-compose kill -s SIGINT`

- `docker-compose rm [options] [SERVICE...]`：删除所有（停止状态的）服务容器。推荐先执行 `docker-compose stop` 命令来停止容器。

  - `-f, --force` 强制直接删除，包括非停止状态的容器。一般尽量不要使用该选项。

  - `-v` 删除容器所挂载的数据卷。

- `config`：验证 Compose 文件格式是否正确，若正确则显示配置，若格式错误显示错误原因

- `images`：列出 Compose 文件中包含的镜像。

- `docker-compose version`：打印版本信息。

```bash
docker-compose -f test.yml up -d --build  # 不用--build下次就会使用之前的缓存，用了就会重新构建，-d后台运行
docker-compose up single_project_service # 单独启动某个服务
docker-compose down -v # 清除对应的volume
```



## 选项

`docker-compose` 命令的基本的使用格式是：`docker-compose [-f=<arg>...] [options] [COMMAND] [ARGS...]`

- `-f, --file FILE` 指定使用的 Compose 模板文件，默认为 `docker-compose.yml`，可以多次指定。

- `-p, --project-name NAME` 指定项目名称，默认将使用所在目录名称作为项目名。

- `--verbose` 输出更多调试信息。

- `-v, --version` 打印版本并退出。





```yaml
version: "3.8"
services:
  flask_project:
    build: .
    ports: 
      - "3000:3000"
    volumns:
      - ./:/project:ro
      - /project/node_modules

# 公司项目
version: '1'
services:
  flask_project:
    image: # if not specified, should use build
    environment:
      - DATABASE_URL=postgresql://username:password@db:5432/databasename
    command: start-server.sh
    ports:
      - "8000:8000"
    depends_on:
      - postgres
    volumes:
      - /home/analysis-platform:/home/analysis-platform
      - /var/log/supervisor:/var/log/supervisor

  postgres:
    image: 
    environment:
	  - POSTGRES_USER=muscle
      - POSTGRES_PASSWORD=123456
      - POSTGRES_DB=rsdam
    ports:
      - "5432:5432"
    volumes:
      - pgdata:/var/lib/postgresql/data

volumes:
  pgdata:
 




docker-compose up -
docker-compose down 
docker-compose exec flask_project flask db upgrade # 升级数据库

```

# Docker网络

```bash
$ docker run -d -p 80:80 nginx:alpine # 绑定本地所有接口上的所有地址
$ docker run -d -p 127.0.0.1:80:80 nginx:alpine # 映射指定地址
$ docker run -d -p 127.0.0.1::80 nginx:alpine # 绑定 localhost 的任意端口到容器的 80 端口，本地主机会自动分配一个端口
$ docker run -d -p 127.0.0.1:80:80/udp nginx:alpine # 使用 udp 标记来指定 udp 端口
$ docker port fa 80 # 查看当前映射的端口配置，也可以查看到绑定的地址


```



## 高级用法

```bash
ip address
ip -json addrss show dev veth | jq . # 查看veth ip
docker network ls # 查看docker网络
docker network inspect bridge | jq '.[0] | {Name:.Name, Id:.Id, Driver:.Driver, IPAM:.IPAM.Config, Containers:.Containers, Options:.Options}' # 查看默认bridge网络（哪些容器在这个bridge里）
docker run -d --name egg1 --hostname egg1 praqma/network-multitool # 创建使用默认bridge的容器

docker network create --driver bridge naihe-bridge # 创建自定义bridge
docker network inspect naihe-bridge | jq '.[0] | {Name:.Name, Id:.Id, Driver:.Driver, IPAM:.IPAM.Config, Containers:.Containers, Options:.Options}' # 查看自定义bridge
docker run -d --name naihe1 --hostname naihe1 --network naihe-bridge praqma/network-multitool # 创建使用自定义bridge的容器，可以ping name，表示有DNS解析
docker network rm naihe-bridge # 删除自定义bridge网络，默认的bridge

docker run -it --network none  praqma/network-multitool


# 如果容器已经在运行状态，将其连接到新的网络并设置别名
docker netwrok connect --alias db naihe-bridge container_name
# 查看容器的网络信息
docker inspect container_name
# 如要查看别名，在"Networks"下的"Aliases"下
```

> 关于--network-alias和hostname
>
> 是的，`--hostname` 和 `--network-alias` 这两个选项在 Docker 中有不同的用途和意义。
>
> 1. `--hostname naihe1`:
>    - 这个选项设置容器**内部的主机名**。当你进入容器并运行 `hostname` 命令时，你会看到这个设置的名称（
>    - 它主要**影响容器内部的主机名，以及任何依赖于主机名的软件或进程。**
> 2. `--network-alias=naihe1`:
>    - 当你使用 Docker 网络（尤其是用户定义的 bridge、overlay 或其他网络），`--network-alias` 选项允许你给容器一个或多个网络别名。
>    - 在网络中的其他容器可以使用这个别名来访问该容器。换句话说，**网络别名提供了一种方式，使得容器可以通过多个名称在网络上被找到。**
>    - 例如，如果你有一个 Web 服务器容器，并希望它既可以通过 "web" 也可以通过 "api" 被访问，你可以给它两个网络别名。
>
> 总结来说，`--hostname` 用于设置容器内的主机名，而 `--network-alias` 用于设置容器在 Docker 网络中的别名，使其他容器可以使用这个别名来访问它。
>
> 当你希望从一个容器访问另一个容器（例如，从工程项目的容器访问postgres容器）并使用别名作为hostname，你应该使用 `--network-alias` 选项。
>
> 以下是原因和详细解释：
>
> 1. **容器间通信**：当容器之间进行通信时，它们主要依赖于 Docker 的网络功能。Docker的用户定义网络（如 bridge、overlay 等）允许容器通过其容器名或网络别名来互相查找。
> 2. **`--network-alias`**：这个选项提供了为容器设置网络别名的能力。当你为postgres容器设置一个网络别名（例如 "db"），你的工程项目容器就可以使用这个别名 "db" 来访问它，而不是使用它的容器ID或容器名。
> 3. **`--hostname`**：这是设置容器内部的主机名。它并不影响其他容器如何访问该容器。在大多数情况下，`--hostname` 的主要用途是满足那些依赖特定主机名的应用程序或服务。



