---
title: 实现一个简单的jQuery
date: 2018-08-01 22:46:54
tags: ['']
---

jQuery 说到底是一个函数对象，一个通过原生 js 实现了某些功能的函数，被封装成了一个 js 对象。jQuery 类似`{0:xx,1:xx,length:2,····}`的伪数组，知道原理后，我们自己也可以实现一个简单的`jQuery`。
实现简单的获取元素，增加 class 类，以及修改元素文本的功能。

```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>一个简单的jQuery</title>
</head>
<style>
  .red{
    color:red;
  }
  .green{
    color:green;
  }
</style>
<body>
  <ul>
    <li class="item1">第1项</li>
    <li class="item2">第2项</li>
    <li class="item3">第3项</li>
    <li class="item4">第4项</li>
  </ul>
</body>
</htmnl>
```

## 首先，通过原生 JS 实现上述功能

```js
//获取所有的li元素
var items = document.querySelectorAll('li')
//为所有的li增加red类
for (let i = 0; i < items.length; i++) {
	items[i].classList.add('red')
}
//修改所有的li文本
for (let i = 0; i < items.length; i++) {
	items[i].textContent = 'hi'
}
```

## 封装这两个函数

```js
var items = document.querySelectorAll('li')

function addClass(e) {
	for (let i = 0; i < items.length; i++) {
		items[i].classList.add(e)
	}
}
addClass('red')

function setText(e) {
	for (let i = 0; i < items.length; i++) {
		items[i].textContent = e
	}
}
setText('hi')
```

## 将上面的对象及方法封装成一个对象，并对空间命名

```js
var node = {}

var items = document.querySelectorAll('li')

for (let i = 0; i < items.length; i++) {
	node[i] = items[i]
}

node.length = items.length

node.addClass = function (e) {
	for (let i = 0; i < node.length; i++) {
		node[i].classList.add(e)
	}
}

node.setText = function (e) {
	for (let i = 0; i < node.length; i++) {
		node[i].textContent = e
	}
}

node.addClass('red')
node.setText('hi')
```

## 把 node 对象也封装进去，使它变成一个函数对象，更像 jQuery

```js
window.jQuery = function (nodeorselector) {
	var node = {}

	var items = document.querySelectorAll(nodeorselector)

	for (let i = 0; i < items.length; i++) {
		node[i] = items[i]
	}

	node.length = items.length

	node.addClass = function (e) {
		for (let i = 0; i < this.length; i++) {
			this[i].classList.add(e)
		}
	}

	node.setText = function (e) {
		for (let i = 0; i < this.length; i++) {
			this[i].textContent = e
		}
	}

	return ndoe
}

var $li = jQuery('li')
$li.addClass('red')
$li.setText('hi')
```

最后，`console.log($li)`可以看到一个如图所示的伪数组，有`addClass`方法与`setText`方法，`jQuery`本质也是如此，便可以对 jQuery 有更深的认识。
![$li实际上是一个对象](https://upload-images.jianshu.io/upload_images/12812641-571fa12f2b8e149f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
