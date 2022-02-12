**working directory**, **staged snapshot**, and **commit history**

```
git --version
git update-git-for-windows
```

git中的选项解释

```
-d
--delete：删除

-D
--delete --force的快捷键

-f
--force：强制

-m
--move：移动或重命名

-M
--move --force的快捷键

-r
--remote：远程

-a
--all：所有
```



### git config

```
cd /c/Users/"Yating Liu"/Desktop/Inf43Hw3
git config --global user.name "Peter Anteater"
git config --global user.email "panteat@uci.edu"
```

To look at all your configuration information: ```git config --global -l```

```--global```表示该电脑下的所有仓库都会使用这个配置

在windows和mac上，backslash(\\)和forward slash(/)是不一样的，在文件名有空格时，使用引号(```""```)

### set up new repo locally

```
git init //create a local git repo
```

```
git status (branch master)
git add file1.txt/git stage file1.txt //git stageis really just another name for git add.
git add *.txt
git commit -a -m "Now has my major"/git commit -am "Now has my major" //usually i use this
```

when you `add` a file you are telling git to keep track of it.`add` also tells Git to **stage** the file, which means put it in the stage of being ready to be committed

>```git add .``` vs. ```git add -A``` vs. ```git add -p```
>
>The difference is that ```git add -A``` also stages files in higher directories that still belong to the same git repository. ```git add .``` only affects the current directory and subdirectories. 
>
>you use the `git add` command to stage a new or modified file. *However, to stage the deletion of a file, you need to use the **git rm*** So run the commands `git add file1.txt` and `git rm file2.txt` to set the stage
>
>And better than ```git add .``` is ```git add -p``` because it will interactively ask what to stage, this will show you all the changes again and will show you comment/logging that you forgot to remove as well. Also commit often, as large changes tend to be hard to review/oversee.

when you `commit`, you in effect copy all staged files to the repository. The `-m` is a flag (that's what the hyphen indicates) which tells git that the following string is a message to record with the commit.

```
git commit -m "Committing a new file with my name"
```

the power of the `-a` flag is that it tells git to automatically stage ==all== tracked, modified files before the commit

```
git commit -a -m "Now has my major"/git commit -am "Now has my major"
```

amend your commit message 

```
git commit --amend -m "Added favorite restaurant and movie"
```



### ```git reset```, ```git revert``` and ```git checkout```

```
git reset filename.extension //从暂存区删除指定文件
git rm --cached filename.extension//从暂存区删除该文件，并将其设置为未跟踪
git reset --hard xxxx
git reset --hard HEAD       //(going back to HEAD)
git reset --hard HEAD^      //(going back to the commit before HEAD)
git reset --hard HEAD~2     //(going back two commits before HEAD)
git reset --hard HEAD@{1}   //undo a hard reset on Git
```

The purpose of the ```git reset``` command is to move the current HEAD to the commit specified (in this case, the HEAD itself, one commit before HEAD and so on).

**the version after xxxx will be deleted, to push to remote repo, you have to use ```git push -f``` because remote origin still has HEAD points to the deleted commit**

for more about ```git reset```, check [this stackflow thread](https://stackoverflow.com/questions/2530060/in-plain-english-what-does-git-reset-do) with many details (```--hard```, ```--mixed```, ```--soft```)

```
git revert
```

in `git reset`, you delete the older commit and move the head backwards, in` git revert` you are introducing an order version to the current branch and move the head forward. When you merge with another branch, the changes may be introduced again in using reset, but will not be introduced if using revert. 

This method would not have the disadvantage of ```git reset```, it would point HEAD to newly created reverting commit and it is ok to directly push the changes to remote without using the ```-f``` option.

check [this](https://www.pixelstech.net/article/1549115148-git-reset-vs-git-revert) simple article to see the difference between ```git reset``` and ```git reverse```

```
git checkout xxxx
```

replacing xxxx with the **first** four digits/characters from that hash (thankfully typing in the entire hash is not required). You will see a frightening message about a detached HEAD. git can keep track of separate, parallel, streams of edits to a project. Each stream of edits is called a branch, and a branch can have a name. For instance, multiple programmers who are working on and commiting changes to the same file will probably establish different branches. HEAD is git-ese for the current (not necessarily the last) commit in the current branch.**Since we've gone back in time and are potentially (but haven't yet) starting a new branch, HEAD is "detached" (from any established, named branch)**

This is useful for quickly inspecting an old version of your project. However, since there is no branch reference to the current HEAD, this puts you in a detached HEAD state. **This can be dangerous if you start adding new commits because there will be no way to get back to them after you switch to another branch. **For this reason, you should always create a new branch before adding commits to a detached HEAD.

```
git checkout HEAD~2 foo.py
```

the following command makes `foo.py` in the working directory match the one from the 2nd-to-last commit



Checking out a file is similar to using `git reset` with a file path, except it updates the *working directory* instead of the stage. Unlike the commit-level version of this command, this does not move the `HEAD` reference, which means that you won’t switch branches.

Just like the commit-level invocation of `git checkout`, this can be used to inspect old versions of a project—but the scope is limited to the specified file.

If you stage and commit the checked-out file, this has the effect of “reverting” to the old version of that file. Note that this removes *all* of the subsequent changes to the file, whereas the `git revert` command undoes only the changes introduced by the specified commit.

Like `git reset`, this is commonly used with `HEAD` as the commit reference. For instance, `git checkout HEAD foo.py` has the effect of discarding unstaged changes to `foo.py`. This is similar behavior to `git reset HEAD --hard`, but it operates only on the specified file.

>This is an update to the "Commit History" tree. The ```git checkout``` command can be used in a commit, or file level scope. A file level checkout will change the file's contents to those of the specific commit.
>
>A revert is an operation that takes a specified commit and creates a new commit which inverses the specified commit. git revert can only be run at a commit level scope and has no file level functionality.
>
>A reset is an operation that takes a specified commit and resets the "three trees" to match the state of the repository at that specified commit. A reset can be invoked in three different modes which correspond to the three trees.
>
>Checkout and reset are generally used for making local or private 'undos'. They modify the history of a repository that can cause conflicts when pushing to remote shared repositories. Revert is considered a safe operation for 'public undos' as it creates new history which can be shared remotely and doesn't overwrite history remote team members may be dependent on.

*check [this](https://www.atlassian.com/git/tutorials/resetting-checking-out-and-reverting) to see the detailed usage of ```git reset```, ```git revese``` and ```git checkout``` on commits and files. It's very detailed and complete.

```
git rm --cached filename.extension
```

参考这篇很清楚[rm 、git rm 、git rm --cached的区别](https://www.cnblogs.com/everfight/p/git_rm_usage.html)

It will not remove the file from the staging area only, but entirely from tracking. If you just want to remove a file from staging please use ```git reset filename.extension```.

When invoked with a file path, `git reset` updates the *staged snapshot* to match the version from the specified commit. For example, this command will fetch the version of `foo.py` in the 2nd-to-last commit and stage it for the next commit:

```
git reset HEAD~2 foo.py
```

As with the commit-level version of ```git reset```, this is more commonly used with HEAD rather than an arbitrary commit. Running ```git reset HEAD foo.py``` will unstage foo.py. The changes it contains will still be present in the working directory. The `--soft`, `--mixed`, and `--hard` flags do not have any effect on the file-level version of `git reset`, as the staged snapshot is *always* updated, and the working directory is *never* updated.



我个人觉得checkout只是单纯的把HEAD移走（但是因为HEAD和当前的branch detached了，可能会回不去，适合看order version），```git checkout file```是将file恢复到某个commit，并且工作区也会相应改变。reset是将最近的commit删除，并将HEAD往后移，reset的三种模式-hard，mix，soft分别对应工作区+stage snopshot+commit history，snopshot+commit hisotry(default)，commit history。 ```git reset file```是unstage某个file，reset file不会改变工作区的文件，但是checkout file会改变工作区的文件。revert是加上之前的commit并且将HEAD向前移达到撤回操作的效果。git rm会先删除工作区的文件，然后将删除的操作commit，而加上--cache则会在stage里删除，但是在working directory保留。每一个commit都对应一个log，每一个log都有HEAD做标记



### ```git log```

```
git log
```

this will display the history of changes made to the repository

```
git log -p -3
```

the `-p` flag will show you the diffs for each change. The -3 will limit what's displayed to the last 3 log entries

Note: A command such as `git log` sends text output to the shell using a bash command named *less* to display one windowfull of output at a time (*less* is named after a similar, earlier utility named *more*, in a classic example of hilarious techie humor). At the : prompt, you can press **h** for help, **q** to exit, **Enter** to advance one line, or **Space** to advance one screenfull

```
git log -p > git_log_partB.txt
```

the **>** is a shell command that redirects the output of the program on **>**'s left to the file named on **>**'s right.

```
git log -1 -p --before='2014-03-31 11:52:45'
```

this is nothing new except for the `--before='2014-03-31 11:52:45'` part. That tells git you only want to see log entries for changes made before **March 31, 2014 at 11:52:45am**. As you saw in part B, the `-1` means you only want to see one entry, and the `-p`means you want to see a diff of the changes

```
git log --reverse
```

since we have a complete copy of the Reddit project's repository, we also have a copy of every snapshot going all the way back to the beginning of the project. To see the log entries for the **earliest** commits

```
git log -1 4778b17e939e119417cc5ec25b82c4e9a65621b2
git show 4778b17e939e119417cc5ec25b82c4e9a65621b24
```

(Don't forget that you can use only the first four digits/characters of the hash. If git complains that the short SHA1 is ambiguous (because more than one commit has the same first four digits), try adding a few more digits from the long hash.)

```
git log --skip=100 -5
```

one more git log option to know about is --skip=N, where N is a non-negative integer. This means to skip N commits before starting to show the commit output



### 版本管理

tag可以用来回滚

```
git tag //查看所有标签 
git tag tagname [commit ID] //创建标签
git tag -a tagname -m "comment" //指定提交信息 
git tag -d tagname //删除标签
git tag -r //查看远程版本
git push origin tagname //发布远程版本(本地版本push到远程)
git push origin :refs/tags/[name] //删除远程版本
```



### 分支管理

```
git checkout -b branch_name //create a new branch with name and switch to it
git branch branch_name //create a new branch
git branch //see all the local branch, the current branch is green with asterisk 
git branch -r //see remote branch
git branch -a //see local and remote branch
git checkout branch_name //switch to another branch 
git branch -m old_name new_name //rename branch name
git branch -d branch_name //delete local branch -d选项只能删除已经参与了合并的分支，对于未有合并的分支是无法删除的。如果想强制删除一个分支，可以使用-D选项
it branch -d -r branch_name 
git push origin:branch_name //delete remote branch and push to server
git merge branch_name //merge branch
git push origin branch_name //push local branch to server
git dff <source_branch> <target_branch> //view changes between two branches
```



### Remote Git Repo set up

```
git remote
```

the list of remote repos connected to your local project

#### 创建SSH key

```
ssh-keygen -t rsa -C "yatinl4@uci.edu"
cd /c/Users/liuyating
cd .ssh/
cd id_rsa.pub
ssh -T git@github.com
```

#### 添加远程仓库

```
git remote add origin git@github.com:tylerdemo/demo4.git //url of the server
git remote -v //查看远程仓库
git remote rm name //删除远程仓库
git pull origin branch_name --allow-related-histories //master或其他branch。如果你和别人用一样的代码库，这个命令可以让从远程存储库提取最新版本，更新你的本地版本，这样你就能在同伴工作的基础上继续写代码了
git push -u origin master //-u代表本地的master, master或其他branch
git push origin branch_name//push branch to remote repository
```

如果是clone，默认仓库是绑定上去的，所以```git clone```的repo，通过```git push```就可以了

```
git clone url
git clone branch_name https://github.com/reddit/reddit.git
```

You now have a local copy (on your computer) of the remote repository. It's important to understand that **this is not only a copy of the source code, but also a copy of the history of changes stored by git. **

#### ```git remote add``` vs. ```git clone```

- **```git remote add``` just creates an entry in your git config that specifies a name for a particular URL. You must have an existing git repo to use this.**
- **```git clone ```creates a new git repository by copying an existing one located at the URI you specify.**
- `git clone` contains more commands

`git pull`和`git fetch`

```
git fetch <远程主机名> //这个命令将某个远程主机的更新全部取回本地
git fetch <远程主机名> <分支名> //取回特定分支的更新，注意之间有空格
git fetch origin master //取回origin主机的master分支
git log -p FETCH_HEAD //取回更新后，会返回一个FETCH_HEAD，指的是某个branch在服务器上的最新状态，我们可以在本地通过它查看刚取回的更新信息

git fetch origin master //从远程主机的master分支拉取最新内容 
git merge FETCH_HEAD    //将拉取下来的最新内容合并到当前所在的分支中
相当于 git pull <远程主机名> <远程分支名>:<本地分支名>
git pull和git fetch的区别在于git fetch是将远程主机的最新内容拉到本地，用户在检查了以后决定是否合并到工作本机分支中。而git pull则是将远程主机的最新内容拉下来后直接合并，即git pull = git fetch + git merge，这样可能会产生冲突，需要手动解决
```



### Other

**(on github)** pull request, and you can comment. If accepted, you can merge to the master branch
and you can delete branch(that branch is gone only on the cloud)



```
touch .gitignore
```

create a file named **.gitignore**. You can use text editor to open this file, write down the files for directories that you want to ignore in repo. The ignored files will not be shown during execution. 

So use this command when you don't want to upload some files.





# 示例

本文是从master分支拉出的two，然后合并回master

1. ~~切换到master分支：git checkout master~~
2. 创建并切换到two分支：git checkout -b two
3. ~~将two分支push到远程仓库（与本地仓库同步）：git push origin two~~
4. 修改two分支上的内容并提交到本地仓库：git commit -a -m"修改子分支"
5. 将two分支上的修改提交到远程仓库：git push origin two

6. two分支上的修改ok后，切换到master分支：git checkout master（注意，只有checkout切换到当前分支后，pull代码，才能看见当前分支的代码，如果没有checkout到当前分支，pull了也在相应文件夹下也看不见当前分支的代码，而是上次checkout的代码）

7. 将two分支合并到master分支：git merge --no-ff two，把two的修改merge到master。--no-ff 选项不使用fast-forward方式合并，保留分支的commit历史

8. 将合并之后的代码push到远程仓库：git push origin master


此例是父分支和自分支之间的merge操作，爷孙分支亦如此，旁系分支合并亦然



将master分支内容合并到dev分支
1、切换到你所在分支dev：git checkout dev

2、git merge master

3、将本地内容push到dev分支：git push

