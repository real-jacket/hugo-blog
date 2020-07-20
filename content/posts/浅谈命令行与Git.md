---
title: 浅谈命令行与Git
date: 2018-07-03 16:50:07
tags: ['Git']
hiddenFromHomePage: true
---

## 一些基本命令行的使用

### ls

用法：显示当前所在目录的所有文件。一般有三个参数，
`ls -a`：显示全部文件，这里的全部文件包括平时看不见的隐藏文件（文件名以.开头）。
`ls -l`：显示文件的更多信息。如图所示，可以看到一般有两种前缀：`drwxr-xr-x`，其中的 d 表示目录，r 表示 read 可读，w 表示 write 可写，x 表示可读可写，后面的 r-x、r-x 分别表示主人与客人的权限，都是可读可写。最后的则是文件创建时间跟文件名字。
`ls -al`：这个则是上述两种之和，实测 windows 上`ls -al`与`ls -la`作用一样，不知是不是所有命令行都是这样，后期可以探索下！

![ls命令演示](https://video.jirengu.com/xdml/file/d86144a6-7fb6-45ce-9cbb-3af63788fcb8/2018-6-26-12-21-7.png)

### cat

用法：常用来显示文件内容，后接文件名。

![cat命令演示](https://video.jirengu.com/xdml/file/d86144a6-7fb6-45ce-9cbb-3af63788fcb8/2018-6-26-12-29-16.png)

### mv

用法：常用来移动文件。
使用 mv 后面跟两个参数，源路径与目标路径。图中示例线罗列了两个目录中的文件，然后移动 2.html，最终对比可以发现 2.html 从 demo-2 中移动到 demo-1。

![mv命令演示.png](https://video.jirengu.com/xdml/file/d86144a6-7fb6-45ce-9cbb-3af63788fcb8/2018-6-26-12-40-40.png)

### touch

用法：常用来创建文件。
后接文件名，只能用来创建文件，不能用来创建目录，否则只会创建出一个不带后缀的文件。
当文件已经 存在的时候，则会覆盖文件，注意示意图中的时间可以判断。

![touch命令演示](https://video.jirengu.com/xdml/file/d86144a6-7fb6-45ce-9cbb-3af63788fcb8/2018-6-26-13-5-50.png)

### 使用[explainshell.com](https://explainshell.com)网站

进入网站后，输入你想查询的命令，例如`ls`，查询后会显示该命令的意思，点击该命令则会显示`ls`的相关参数及用法。

![](https://video.jirengu.com/xdml/file/d86144a6-7fb6-45ce-9cbb-3af63788fcb8/2018-6-26-14-22-58.png)

![explainshell.com使用示意图](https://video.jirengu.com/xdml/file/d86144a6-7fb6-45ce-9cbb-3af63788fcb8/2018-6-26-14-23-21.png)

## git 简单入门

### git init

`git inint`初始化本地仓库。它会在当成目录下初始化一个本地仓库，并自动生成一个隐藏的.git 文件，这个.git 文件就是本地仓库。
使用`ls -al`就可以发现多了一个.git 文件。

### git add

当前目录有三个区域，工作区、暂存区、本地仓库（.git 文件）。
`git add xxx`命令则是把 xxx 添加到暂存区中，如图中将 1.txt 文件添加到暂存区中。

### git commit

`git commit -m "xxxx"`将暂存区中的内容（已经 git add 过的内容）提交到本地仓库中（.git），`-m "xxxx"`并为此次提交备注信息，方便以后查询。
`git commit -v`提交时显示所有的更改 diff，会与本地仓库对比。图中修改了 1.txt 文件内容。

![](https://video.jirengu.com/xdml/file/d86144a6-7fb6-45ce-9cbb-3af63788fcb8/2018-6-26-14-48-11.png)
![git 入门示意图](https://video.jirengu.com/xdml/file/d86144a6-7fb6-45ce-9cbb-3af63788fcb8/2018-6-26-15-36-31.png)
