---
title: '关于this的一道面试题'
subtitle: ''
date: 2020-09-02T12:32:41+08:00
lastmod: 2020-09-02T22:40:41+08:00
draft: false
toc:
  enable: true
weight: false
categories: ['JS']
tags: ['JS', 'this']
---

# 关于 this 的一道面试题

## 问题

首先贴代码：

```javascript
let length = 10
function fn() {
	console.log(this.length)
}
let obj = {
	length: 5,
	method(fn) {
		fn()
		arguments[0]()
	},
}

obj.method(fn, 1)
```

请问最后打印出什么？

- 第一个 fn()  不确定是什么，一般为 0/undefined。
- 第二个 arguments\[0\]()  为 2，是函数调用的实参个数。

## 分析

### 函数的返回值是由什么决定的？

- 调用时输入的参数  params
- 定义时的环境  env

那么 Js 函数调用时， `obj.method(fn,1)`  这个函数调用时，参数只有 fn 跟 1 么？

- 隐式参数
  1. arguments：传入函数所有参数（实参）的集合
  2. this：执行上下文（就是一个对象），与函数调用相关联的对象，这个就跟定义时的环境有关。
- 显式参数括号内的参数: fn、1

### 明确 this 的传入，将 this 显式化

由于 this  的模糊性，通过 call  转化将 this  显式传入：

- obj.method(fn,1) ===> obj.method.call(obj,fn,1)
- fn() ===> fn.call(undefined) //  这里默认为  this  为全局环境（window/global）
- arguments[0]() ===> arguments[0].call(arguments)

由上面可以看出：三个函数调用，传入的 this 。
注意： 这里需要注意 fn 作为参数传进来，相当于进行了一次隐式赋值，即 var fn = fn。即函数内部的 fn 等与 外面的 fn。

### 关于  let  变量声明

我们知道  var  声明的变量是全局变量，作用域为全局，通常挂在 window  下。let  声明的变量局部变量，mdn 中关于 let  是这么定义：“**let**  语句声明一个块级作用域的本地变量，并且可选的将其初始化为一个值。”但是如果在全局环境下进行 let  声明，这个变量会挂在  window  下么？在  mdn  中关于顶级环境的问题也给出了说明，“At the top level of programs and functions, **`let`**, unlike **`var`**, does not create a property on the global object.”说明不会挂载在 window  下。

### window.length  到底是什么

window.length  为当前页面中  ifram  的个数。

## 延伸

```javascript
let length = 10
function fn() {
	console.log(length)
	console.log(this.length)
}
let obj = {
	length: 5,
	method(fn) {
		let length = 3
		fn()
		arguments[0]()
		console.log(this.length)
		console.log(length)
	},
}

obj.method(fn, 1)
```

## 总结

1. 函数调用时的  this  为该函数的执行上下文。
1. 函数调用默认会隐式的传两个参数，this  与  arguments
1. 在不清楚  this  时，将  this  显示的传入。
