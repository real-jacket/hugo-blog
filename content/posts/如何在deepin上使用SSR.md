---
title: 如何在deepin上使用SSR
date: 2018-08-21 10:16:57
tags: ['deepin']
hiddenFromHomePage: true
draft: true
---

### 背景

前段时间由于某些原因，我从使用 ss 转到 ssr，之前使用的 windows 系统有好用的 ssr 客户端，但后来为了更好的学习前端转到 deepin 深度系统。
由于是 ubantu 类系统，刚开始没有找到好用的 ssr 客户端，使用的是命令行的方式，这种方式带来的不便之处就是系统处于全局代理，由此造成的结果便是你用网易云音乐听歌会发现被代理，此时我才知道网易云音乐在海外大部分歌是没法听的，估计海外的同胞想用网易云来听歌都要进国内吧。哈哈哈，这让我想起《围城》里的一句话：

> 婚姻是一座围城，城外的人想进去，城里的人想出来

废话不多说，接下来介绍在 deepin 下（也就是 ubantu 下）如何使用 ssr，主要有两种方法：

- 方法 1：基于命令行实现
- 方法 2：使用 electron-ssr 客户端

第一种方法很常见，网上搜一大堆教程，在此不再赘述，本文主要介绍第二种方法。方法 1 使用的是命令行，而此种方法使用的图形界面，图形界面对于小白而言总是很友好的。

### 下载客户端 electron-ssr

在[ssr](https://github.com/shadowsocksrr/shadowsocks-rss)作者 Github 官网下载 electron-ssr([下载直达](https://github.com/erguotou520/electron-ssr/releases))找到最新的 deb 版本。本文使用的是[electron-ssr_0.2.3_amd.deb](https://github.com/erguotou520/electron-ssr/releases/download/v0.2.3/electron-ssr_0.2.3_amd64.deb)

### 使用命令行安装：

`sudo dpkg -i electron-ssr_0.2.3_amd64.deb`
打开客户端。
注意： 1. 要在安装包所在的目录使用，记得修改安装包的文件名。 2. 如果打开客户端半天没有反应，重启电脑即可。

### 添加 ssr 配置信息

跟在 window 上使用一样，正常添加服务器相关配置即可。
![electron-ssr界面](https://upload-images.jianshu.io/upload_images/12812641-b80fbfcbf493e9f9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 终端代理

如果想在终端中使用代理，在配置中选中[http 代理](https://github.com/erguotou520/electron-ssr/blob/master/docs/HTTP_PROXY.md)。
![终端代理](https://upload-images.jianshu.io/upload_images/12812641-7fbb95d6bf7d9e82.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
在命令行里输入下列代码设置命令行代理：

```bash
export http_proxy="http://127.0.0.1:http代理端口"
export https_proxy="http://127.0.0.1:http代理端口"
```

之后你便会惊奇的发现 Google 的同时，网易云音乐可以听歌了，不用像谷歌百度搜的那样，听歌的时候关掉系统代理，现在想起来是不是很脑残！！
本文主要参考[MTPAS 博客](https://huur.cn/course/1513.html)、ssr 作者[Github](https://github.com/shadowsocksrr/shadowsocks-rss)及 electron-ssr 作者[Github](https://github.com/erguotou520/electron-ssr)。
