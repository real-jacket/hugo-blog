---
title: express 入门
date: 2018-10-25 17:33:04
tags: ['express']
categories: [' node', ' express']
---

## 什么是 Express？

官网介绍：Express 是基于 Node.js 平台，快速、开放、极简的 Web 开发框架。
个人理解：我们都知道 node.js 是后端版本的 js 语言实现，自然 Express 更加注重的是后端的处理，它的页面是通过数据与模版渲染而成，注重的是逻辑的交互。与其它常见的前端框架不同，像 Vue、React 等基本思想都是数据驱动视图，我们不必去关注后台是怎么实现的，只注重数据的操作。而 Express 恰恰相反。

## 写一个 hello word

### 安装

安装 node.js 后，在工作目录下运行一下命令

```bash
//通过 npm init 命令为你的应用创建一个 package.json 文件。
npm init
//安装Express
npm install express --save
```

### hello word

创建一个 app.js 文件，内容如下

```js
const express = require('express')
const app = express()

app.get('/', (req, res) => res.send('Hello World!'))

app.listen(3000, () => console.log('Example app listening on port 3000!'))
```

然后在在浏览器中打开http://localhost:3000/，就可以看到网页了，就这么简单。

## Express application generator

Express 提供给我们一个可以快速创建一个应用的骨架的应用生成器：express-generator。它可以帮助我们快速建立一个网站基本需要的所有文件。

### 本地安装

```bash
npm install express-generator
```

### 创建应用

通过命令 express -h 可以查看可用的命令参数，其中`-f`强制在非空目录下创建应用，`-v`表示 view 的模版引擎。

```bash
npx express . -f -e

//安装依赖
npm install
```

表示在强制（-f）在当前目录（.）下创建 view=ejs（ -e 模版引擎） 的应用。根目录下会生成下述文件：

![目录结构](https://upload-images.jianshu.io/upload_images/12812641-540834276a7cfa13.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 基本运行

运行命令

```js
DEBUG=sticky-note:* npm start
//或者直接
npm start
```

然后在浏览器中打开 http://localhost:3000/ 网址就可以看到这个应用了。

我们在 package.json 文件中可以看到 npm start 是命令 node ./bin/www 的缩写，实际运行了 bin/www 文件，打开 www 文件我们会发现会去运行根目录下的 app.js 文件。
![package.json](https://upload-images.jianshu.io/upload_images/12812641-9979e66d02007b6d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

在 app.js 文件中，重要的如下几行代码：

![app.js](https://upload-images.jianshu.io/upload_images/12812641-a04a0f265b54325f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

设置模版引擎与路由跳转，当页面跳转至不同的路由时，运行 router 下对应的文件，获取数据与 view 下的模版结合渲染页面。看看 router 目录下的 index.js 文件，响应的同时，通过 render 函数对数据与模版的结合渲染页面。

![index.js](https://upload-images.jianshu.io/upload_images/12812641-e06a651cb3ca8dbc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### Express 的 MVC

我们仔细观察目录会发现，express 具有 MVC 的思想：

- routes 控制路由的跳转，逻辑行为操作：C
- view 是页面的模版，视图：V
- 应该还有一个获取数据的 model

这样看来，结构与思想上都具备 MVC 的思想。
