---
title: 入门nodejs
date: 2018-09-04 16:05:10
tags: ['node']
categories: ['node']
hiddenFromHomePage: true
draft: true
---

## 网络与 IP

HTTP 协议的底层是由 TCP 和 IP 协议（TCP/IP）构建的

### 什么是 TCP

TCP 传输控制协议（Transmission Control Protocol）：按层次分，TCP 位于传输层，提供可靠的字节流服务。
换句话说，为了更容易的传输大数据，TCP 协议会把数据分割成以报文段为单位的数据包进行管理，并且 TCP 协议能够确认数据最终是否到达对方（一般指所谓的三次握手）。

1. TCP 与 UDP 的区别：
   简答：TCP 可靠、面向连接、相对 UDP 较慢；UDP 不可靠，不面向连接、相对 TCP 较快。搞定。
2. TCP 的三次握手：
   - 简答：每次建立连接前，客户端和服务端之前都要先进行三次对话才开始正式传输内容，三次对话大概是这样的：
     1. 客户端：我要连接你了，可以吗
     2. 服务端：嗯，我准备好了，连接我吧
     3. 客户端：那我连接你咯。
     4. 开始后面步骤
   - 详细解答：握手过程中使用了 TCP 的标志（flag）——SYG（synchronize）和 ACG（acknowledge）
     1. 发送端：发送一个带 SYG 标志的数据包给对方
     2. 接收端：收到后，回传一个带 SYG/ACK 标志的数据包以示传达确认信息
     3. 发送端：收到后，再回传一个带 ACK 标志的数据包，代表握手结束。

### IP 网络协议（Internet Protocol）

从层次上分，IP 网络协议位于网络层，其作用是把各种数据包传送给对方，为了确保数据传送到正确的对象，则需要满足一些条件，其中最重要的两个便是：IP 地址与 MAC 地址

- IP 地址指明了节点被分配到的地址
- MAC 地址是指的网卡所属的固定地址

> 注意：
> IP 是一种网络协议，而 IP 地址是类似 127.0.0.1 的地址。
> IP 地址可以与 MAC 地址进行匹配。IP 地址可换，而 MAC 地址基本不会变。

在互联网中，一般一个设备对应一个 IP 地址。通俗理解，IP 地址分为内网 IP 与外网 IP
![内网与外网](https://upload-images.jianshu.io/upload_images/12812641-4f2969ccc48bde69.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 电信服务商提供 DNS 服务，你从网页中输入的网址首先会去电信查找对应的 IP 地址。
- 路由器有一个「内网 IP」与一个「外网 IP」。
  - 内网中的设备可以互相访问（比如你可以用电脑或手机进入 http://192.168.1.1 来查看你的路由器），但是不能直接访问外网，内网设备想要访问外网，就必须经过路由器中转。
  - 外网中的设备可以互相访问（比如 qq.com 可以把首页发送给你的路由器，你的路由器有外网 IP），但是外网中的设备无法访问你的内网设备。
  - 外网的资源通过路由器的中转传达至内网的各个设备中，路由器在其中充当指路人的角色。
- 路由器没有固定的「外网 IP」，都是临时分配的，类似 14.17.32.21，每次路由器重启都会被重新分配一个 IP 地址。
- 路由器与其 wifi 组成整个内网，在内网中的每个设备都有一个对应的「外网 IP」，类似 192.168.1.1，这个内网 IP 也不是固定的，一般设备断开 wifi 重连都会改变内网 IP 地址。
- 两个特殊的 IP，本地 IP 127.0.0.1 代表设备自身，特别的 IP 0.0.0.0 不表示任何设备。

### 端口

端口其实就是一个编号，并不是一种硬件。
一个服务器（硬件）不一定只提供一种服务，比如一个服务器既提供 HTTP 服务，又提供 FTP 服务，还提供 SMTP 服务（邮件服务），那么只用一个 IP 是无法告诉服务器你想要使用哪种服务。

所以这里有一个重要的原则：一个端口对应一个服务。

- HTTP 服务 80 端口
- HTTPS 服务 443 端口
- FTP 服务 21 端口

每个机器一共有 65535（2 的 16 次方减一）个端口（协议规定）

1. 0 到 1023（2 的 10 次方减一）号端口留给系统使用。
2. 其他端口用户用
3. 如果端口被占用，需要停掉该端口的服务才能再次使用。

## 写一个简易的 HTTP Server

### 创建一个后台服务

任何网络服务应用程序总是要先创建一个服务对象。这在 Node.js 中通常通过 createServer 方法。

```js
var http = require('http')

var server = http.createServer(function (request, response) {
	// magic happens here!
})
```

每当有 HTTP 请求到达服务器时，`createServer` 中传入的函数就被自动执行。所以这个函数也被称为是请求处理函数。
当一个 HTTP 到达服务端，node 调用 request 处理程序，并产生一些唾手可得的对象用以处理传输，这些对象就是 request 和 response。。

### 监听端口

实际上，为了处理请求，listen 方法需要在 server 对象上被显式调用。在大多数情况下，你只要把端口号作为参数传入 listen 方法中，作为监听端口即可。

```js
var port = process.argv[2] //命令的第三个参数

server.listen(port)
```

### 请求方法、访问地址以及请求头

当处理一个请求时，第一件事你需要做的是看一下这个方法和其访问地址，以此决定你到底采取何种合理的行为。Node 通过把这些行为属性附加到 request 对象上，使得我们处理起来相对而言可以轻松一些。

```js
var method = request.method
var path = request.url
```

这里的 `method` 总是一个普通的 HTTP 方法动作行为 (verb)，`path` 是指没有服务器协议和 端口号的完整访问地址。一个典型的访问地址通常意味着包括第三个斜杠以及后面的所有内容。
请求头也不是很难得到，它们也在 request 对象里，称为 headers。

```js
var headers = request.headers
var userAgent = headers['user-agent']
```

> 所有的请求头全是小写字母，而不管实际上它们是怎么进行传输的。所以在无论任何 情况下，解析请求头就得到了简化。
> 如果一些请求头出现重复，它们的值不是被覆盖，就是通过英文分号进行分割。

### 设置响应头

响应头通过一个 `setHeader` 的属性很方便的设置。

```js
response.setHeader('Content-Type', 'application/json')
response.setHeader('X-Powered-By', 'bacon')
```

设置响应头时，它们的名字是大小写敏感的。如果你重复设置响应头，最后一次设置的值也就是系统得到的值。

### 发送响应体

既然 `response` 对象是一个 `WritableStre`，向客户端写入返回体只是一个普通的流方法的问题。

```js
response.write(
	'<!DOCTYPE>\n<html>' +
		'<head><link rel="stylesheet" href="/style.js">' +
		'</head><body>' +
		'<h1>你好</h1>' +
		'<script src="/script.html"></script>' +
		'</body></html>'
)
response.end()
```

也可以将响应体放在`end`方法中。

### 关于错误

请求与响应若是发生错误，则会自动触发自身的`error`事件。如果你不去处理监听这个事件，此错误将被抛出，这导致你的程序崩溃。 你应该无论如何都要添加 'error' 事件去监听你的请求对象，哪怕你只是做一个日志或者用你自己的独有方式去处理。

```js
request.on('error', function () {
	// This prints the error message and stack trace to `stderr`.
	console.error(err)
})

response.on('error', function () {
	// This prints the error message and stack trace to `stderr`.
	console.error(err)
})
```

### HTTP 状态码

如果你嫌麻烦不想设置它，返回客户端的默认状态码总是 200。当然，不是每个 HTTP 返回码必须都是 200，在某些情况下你一定希望返回一个不同的状态码，所以你应该设置 statusCode 属性。

```js
response.statusCode = 404
```

### 代码示例

```js
var http = require('http')
var fs = require('fs')
var url = require('url')
var port = process.argv[2]

if (!port) {
	console.log('请指定端口号好不啦？\nnode server.js 8888 这样不会吗？')
	process.exit(1)
}

var server = http.createServer(function (request, response) {
	var parsedUrl = url.parse(request.url, true)
	var path = request.url
	var query = ''
	if (path.indexOf('?') >= 0) {
		query = path.substring(path.indexOf('?'))
	}
	var pathNoQuery = parsedUrl.pathname
	var queryObject = parsedUrl.query
	var method = request.method

	/******** 从这里开始看，上面不要看 ************/

	console.log('HTTP 路径为\n' + path)
	if (path == '/style.js') {
		response.setHeader('Content-Type', 'text/css; charset=utf-8')
		response.write('body{background-color: #ddd;}h1{color: red;}')
		response.end()
	} else if (path == '/script.html') {
		response.setHeader('Content-Type', 'text/javascript; charset=utf-8')
		response.write('alert("这是JS执行的")')
		response.end()
	} else if (path == '/index.css') {
		response.setHeader('Content-Type', 'text/html; charset=utf-8')
		response.write(
			'<!DOCTYPE>\n<html>' +
				'<head><link rel="stylesheet" href="/style.js">' +
				'</head><body>' +
				'<h1>你好</h1>' +
				'<script src="/script.html"></script>' +
				'</body></html>'
		)
		response.end()
	} else {
		response.statusCode = 404
		response.end()
	}

	/******** 代码结束，下面不要看 ************/
})

server.listen(port)
console.log('监听 ' + port + ' 成功\n请用在空中转体720度然后用电饭煲打开 http://localhost:' + port)
```

以上内容参考[node 官网](https://nodejs.org/zh-cn/docs/guides/anatomy-of-an-http-transaction/#),感兴趣的可以去看看。
