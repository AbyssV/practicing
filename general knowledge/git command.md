# mostly on local repo

```
cd /c/Users/"Yating Liu"/Desktop/Inf43Hw3
```

to change the current folder/directory

```
git config --global user.name "Peter Anteater"
git config --global user.email "panteat@uci.edu"
```

To look at all your configuration information: `git config --global -l`

```
git init
```

create a local Git repo

initialize empty Git repository in 

```
git status (branch master)
git add file1.txt
```

when you `add` a file you are telling Git to keep track of it.`add` also tells Git to **stage** the file, which means put it in the stage of being ready to be committed

```git add .``` vs ```git add -A```

The difference is that ```git add -A``` also stages files in higher directories that still belong to the same git repository. ```git add .``` only affects the current directory and subdirectories. 

you use the `git add` command to stage a new or modified file. *However, to stage the deletion of a file, you need to use the **git rm*** So run the commands `git add file1.txt` and `git rm file2.txt` to set the stage

```git rm --cached filename.extension``` It will not remove the file from the staging area only, but entirely from tracking. If you just want to remove a file from staging please use ```git reset filename.extension```.



And better than ```git add .``` is ```git add -p``` because it will interactively ask what to stage, this will show you all the changes again and will show you comment / logging that you forgot to remove as well. Also commit often, as large changes tend to be hard to review / oversee.

```touch .gitignore```
create a file named **.gitignore**. You can use text editor to open this file, write down the files for directories that you want to ignore in repo. The ignored files will not be shown during execution. 

So use this command when you don't want to upload some files.



```
git commit -m "Committing a new file with my name"
```

when you `commit`, you in effect copy all staged files to the repository. The `-m` is a flag (that's what the hyphen indicates) which tells Git that the following string is a message to record with the commit.

the string can be changed to other name

```
git commit -a -m "Now has my major"
```

the power of the `-a` flag is that it tells git to automatically stage all tracked, modified files before the commit

you can also explicitly stage a file. Run `git stage file1.txt`. Now run `git commit -m "Added favorite restaurant"` to commit. **`git stage` is really just another name for `git add`**.

```
git commit --amend -m "Added favorite restaurant and movie"
```

amend your commit message 

```
git reset --hard xxxx
```

the version after xxxx will be deleted, to push to remote repo, you have to use `git push -f`

```
git revert
```

in `git reset`, you delete the older commit and move the head backwards, in` git revert` you are introducing an order version to the current branch and move the head forward. When you merge with another branch, the changes may be introduced again in using reset, but will not be introduced if using revert. 

```
git checkout xxxx
```

replacing xxxx with the **first** four digits/characters from that hash (thankfully typing in the entire hash is not required). You will see a frightening message about a detached HEAD. git can keep track of separate, parallel, streams of edits to a project. Each stream of edits is called a branch, and a branch can have a name. For instance, multiple programmers who are working on and commiting changes to the same file will probably establish different branches. HEAD is git-ese for the current (not necessarily the last) commit in the current branch. Since we've gone back in time and are potentially (but haven't yet) starting a new branch, HEAD is "detached" (from any established, named branch)

```
git checkout HEAD~1 file2.txt
```

Now you decide you actually wanted to keep file2.txt, but you deleted it! Fortunately, you had added it to git, so you can still get it back. HEAD represents the most recent commit or snapshot. ~1 tells Git to go back one version from the most recent snapshot (i.e., HEAD). In this older snapshot, file2.txt still existed, and checkout tells Git to retrieve it

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

the **>** is a shell command that redirects the output of the program on **>**'s left to the file named on **>**'s right

```
git clone https://github.com/reddit/reddit.git
```

use git to view the Reddit source code repository hosted on GitHub. Start git, use cd to navigate to an empty folder, and run the command. You now have a local copy (on your computer) of the remote repository. It's important to understand that **this is not only a copy of the source code, but also a copy of the history of changes stored by git. And since it's a local repository, all the commands you used in the previous part of the assignment will work**

**`git remote`add just creates an entry in your git config that specifies a name for a particular URL. You must have an existing git repo to use this.**

**`git clone` creates a new git repository by copying an existing one located at the URI you specify.**

**`git clone` contains more commands.**



`git log -1 -p --before='2014-03-31 11:52:45'`
this is nothing new except for the `--before='2014-03-31 11:52:45'` part. That tells git you only want to see log entries for changes made before March 31, 2014 at 11:52:45am. As you saw in part B, the `-1` means you only want to see one entry, and the `-p`means you want to see a diff of the changes

`git log --reverse`
since we have a complete copy of the Reddit project's repository, we also have a copy of every snapshot going all the way back to the beginning of the project. To see the log entries for the earliest commits, run the command

`git log -1 4778b17e939e119417cc5ec25b82c4e9a65621b2`
`git show 4778b17e939e119417cc5ec25b82c4e9a65621b24`
(Don't forget that you can use only the first four digits/characters of the hash. If git complains that the short SHA1 is ambiguous (because more than one commit has the same first four digits), try adding a few more digits from the long hash.)

`git log --skip=100 -5`
one more git log option to know about is --skip=N, where N is a non-negative integer. This means to skip N commits before starting to show the commit output



# mostly on remote repo

```git remote``` 

the list of remote repos connected to your local project

`git remote add origin (url of the server)`
`git push -u origin your branch name (same as git push git@github.com:git/git.git )`
`git pull origin your branch name`
pull all the information on the server to the local repository
`git clone url`
clone the repository

`git checkout -b name `
create a new branch with name
`git branch `
see all the branch, the current branch is green

```git branch your_branch_name```

create a new branch

`git checkout your_branch_name`
switch to another branch
`git branch -d`
delete branch

```
git checkout the main branch
git merge the branch you want to merge into the main branch
```

`git fetch`
compared to git pull, git fetch will not do merge

**(on github)** pull request, and you can comment. If accepted, you can merge to the master branch
and you can delete branch(that branch is gone only on the cloud