---
title: HTTP入门
date: 2018-08-20 09:35:58
tags: ['学习笔记']
---

## 基本概念

### 三个基本概念

1. URI：统一资源资源标志符(Uniform Resource Identifier)
2. HTTP：超文本传输协议(HyperText Transfer Protocal)
3. HTML：超文本标记语言(HyperText Markup Language)

### URI

URI 是一个用于标识某一互联网资源名称的字符串，也就是由某个协议方案表示的资源的定位标识符。
URI 常见的两种形式：

- URN(Uniform Resource Name):用字符串标识某一互联网资源。ISBN: 9787115275790 就是一个 URN，通过 URN 你可以确定一个「唯一的」资源。
- URL(Uniform Resource Locator）：我们一般使用 URL 作为网址，表示资源的地址。https://www.baidu.com/s?wd=hello&rsv_spt=1#5 就是一个 URL，通过 URL 你可以确定一个「唯一的」地址（网址）。
  其包括：协议+登录信息（可选）+域名(服务器地址)+服务器端口号+路径+查询字符串+锚点(片段标识符)：
  ![URL的常见组成](https://upload-images.jianshu.io/upload_images/12812641-460eed5fd5e2cb6d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### DNS

DNS（Domain Name System）域名系统，是一种负责域名解析协议，它提供域名到 ip 地址之间的解析服务。
使用命令行 `nslookup baiducom` 可以看到 baidu.com 的 ip 地址。
使用命令行`ping baidu.com`命令，可以查看该网址能否联通。

## 请求与响应

### 服务器与浏览器的交互

Server + Clilent +　 HTTP 协议

- 浏览器负责发起请求
- 服务器在 80 端口接受内容
- 服务器返回请求的内容

HTTP 协议作用就是指导浏览器与服务器如何进行通信。

### HTTP 请求

请求主要由 4 部分组成：

> POST / HTTP/1.1
> Host: www.baidu.com
> User-Agent: curl/7.54.0
> Accept: \*/\*
> Content-Type: application/x-www-form-urlencoded
> Content-Length: 10

请求的格式：

> 1 动词 路径 协议/版本
> 2 Key1: value1
> 2 Key2: value2
> 2 Key3: value3
> 2 Content-Type: application/x-www-form-urlencoded
> 2 Content-Length: 10
> 2 Host: www.baidu.com
> 2 User-Agent: curl/7.54.0
> 3
> 4 要上传的数据

1. 第一部分

- 动词`POST`是一种请求方法，常见的请求方法有：GET POST PUT PATCH DELETE HEAD OPTIONS 等。
- 路径`/`，包括查询参数，但是不包括锚点。如果没有写路径则默认“/”。
- `HTTP/1.1`指的发起请求遵循的协议与协议版本，目前主要使用 HTTP 协议。

2. 第二部分：
   第二部分内容主要是以`key:calue`的形式。

- `Host: www.baidu.com`表示请求的域名
- `User-Agent: curl/7.54.0`表示发起请求使用的软件及版本号
- `Accept: */*`表示接收所有
- `Content-Length: 10`表示第四部分内容的长度
- `Content-Type: application/x-www-form-urlencoded`标注第四部分内容的格式

3. 第三部分则是一个空行，主要作用分开第二部分与第四部分。
4. 第四部分则是需要上传的数据。

### HTTP 响应

响应是对请求做出的回应，其内容格式类似请求，也主要由 4 部分组成：

> HTTP/1.1 302 Found
> Connection: Keep-Alive
> Content-Length: 17931
> Content-Type: text/html
> Date: Tue, 10 Oct 2017 09:19:47 GMT
> Etag: "54d9749e-460b"
> Server: bfe/1.0.8.18
>
> \<html>
> \<head>
> \<meta http-equiv="content-type" content="text/html;charset=utf-8"> ……

响应格式：

> 1 协议/版本号 状态码 状态解释
> 2 Key1: value1
> 2 Key2: value2
> 2 Content-Length: 17931
> 2 Content-Type: text/html
> 3
> 4 要下载的内容

1. 第一部分示例：`HTTP/1.1 200 OK`
   `200`是一个状态码，表示响应的结果状态，后面对应的`OK`是状态解释。状态码以数字 1、2、3、4、5 开头，分为五种。
1. 第二部分示例：

- `Connection: Keep-Alive`
- `Content-Length: 17931`响应第四部分内容的长度
- `Content-Type: text/html`响应的内容格式
- `Date: Tue, 10 Oct 2017 09:19:47 GMT`响应的时间
- `Etag: "54d9749e-460b"`响应的标签
- `Server: bfe/1.0.8.18`响应的服务器

3. 第三部分依然是空行，分隔第二部分与第四部分
4. 响应的内容，需要下载的内容

### 使用 chrome 查看请求与响应

1. 打开「Network」
2. 地址栏输入网址
3. 打开开发者工具
4. 在「Network」点击，查看 request，点击「view source」
5. 点击「view source」
6. 点击后可以看到请求的前三部分了
7. 如果有请求的第四部分，那么在「FormData」或「Payload」里面可以看到

### 常见的 HTTP 状态码

- 1xx 　 Informational（信息性状态码）　接受的请求正在处理
- 2xx 　 Success（成功状态码）　请求正常处理完毕
  - 200 ok 　表示响应成功，从客户端发来的请求在服务器被正常处理了。
  - 204 No Content 　表示服务器接受的请求已成功处理，但没有资源返回。
  - 206 Partial Conyent 　表示客户端进行了范围请求，服务器成功执行了这部分的 GET 请求。
- 3xx 　 Redirection（重定向状态码）　需要进行的附加操作以完成请求
  - 301 Moved Permanently 　表示永久性重定向，请求的资源已经被分配到新的 URI。
  - 302 Found 　表示临时性重定向，请求的资源被分配了新的 URI，希望用户此次使用新的 URI 访问。
  - 305 Use Proxy 　表示被请求的资源必须通过指定代理才能被访问。
- 4xx 　 Client Error（客户端错误状态码）　服务器无法处理请求
  - 400 Bad Request 　表示请求报文中存在语法错误。
  - 401 Unauthorized 　表示发送的请求需要有通过 HTTP 认证的认证信息。
  - 403 Forbidden 　表示队请求的资源的访问被服务器拒绝了。
  - 404 Not Found 　服务器上无法找到请求的资源。
- 5xx 　 Server（服务器错误状态码）　服务器处理请求出错
  - 500 Internet Server Error 　表示服务器在执行请求时发生错误。
  - 503 Service Unavailable 　表示服务器处于超负载或正在进行停机维护。

## 使用 curl 命令发起请求

`curl -s -v -H "Frank: xxx" -- "https://www.baidu.com"`
使用该命令可以创造一个请求，请求访问百度。
`curl -X POST -s -v -H "Frank: xxx" -- "https://www.baidu.com"`
新增的`-X POST`表示请求的方法为 POST，没有这个则默认 GET。
`curl -X POST -d "1234567890" -s -v -H "Frank: xxx" -- "https://www.baidu.com"`
新增的 `-d "1234567890"`d 表示 date 数据，表示上传了引号中的数据。
