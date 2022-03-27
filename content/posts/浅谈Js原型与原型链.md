---
title: 浅谈Js原型与原型链
date: 2018-07-28 21:58:31
tags: ['JS']
categories: ['JS']
hiddenFromHomePage: true
draft: true
---

关于 JS 面向对象，我们首先需要了解的一个问题，就是什么是内存！

## `var a = 1` 发生了什么？

&nbsp; &nbsp;我们常说的内存是指的插在电脑上的内存条，一个 8g 的内存条大概 40%分配给系统，大概 1G 分配给浏览器，而分配给浏览的 1G 中大概 200m 分配给了 JS。电脑只存 0 跟 1，我们的代码存到内存里会经过一些列操作。
&nbsp; &nbsp;内存有栈内存(Stack)与堆内存(Heap)，JS 中简单类型(number、string、boolean、symble、null、undefined)的值一般储存在 Stack 栈内存中，复杂类型的值储存在 Heap 堆内存(以 Heap 地址存入，一般是对地址的引用)，以下以简单的图示声明到内存发生的操作。

> **简单类型的值一般操作 Stack 栈内存** >**复杂类型值同时操作 Stack 栈内存与 Heap 堆内存**
>
> 以下为一些内存的简单示意
> ![a](https://upload-images.jianshu.io/upload_images/12812641-3b2cc58f402de362.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240) > ![b](https://upload-images.jianshu.io/upload_images/12812641-171878c0d4498d13.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240) > ![c](https://upload-images.jianshu.io/upload_images/12812641-b498bc0d28700760.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240) > ![d](https://upload-images.jianshu.io/upload_images/12812641-548638a7036913a6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

对于上述代码中都有一个 b=a 的操作，这称为“拷贝”，将栈内存与堆内存完全拷贝过来又称为“深拷贝”，对所有的基本类型而言都是深拷贝（因为没有堆内存）。对于复杂类型，只拷贝了栈内存而没有拷贝堆内存，就是“浅拷贝”。简单理解，b=a，b 变不影响 a 就是深拷贝，b 变导致 a 变就是浅拷贝。

## JS 面向对象

我们浏览器刚打开的时候，里面就内置了很多属性，这就是为什么一开始浏览器就占据很多内存的部分原因。对于浏览器自带的对象，全局对象 global，浏览器里称为 window。这些自带的属性中一部分是基于 ECMAScript 标准，一部分是浏览器自己的（私有的，不同浏览器不同），以谷歌浏览器为例：

- ECMAScript 标准：
  - parseInt
  - parseFloat
  - Number
  - Boolean
  - String
  - Object
- Google 浏览器私有：
  - alert（弹窗提示）
  - promote（用户填写）
  - confirm（确认）
  - console（开发者）
  - document（文档）DOM
  - history（浏览器）BOM

对于`var a = 1`，为什么可以调用 toString 方法就可以理解了。调用该方法的时候，浏览器会自动虚拟（拷贝）一个对象，然后调用其中的 tostring，调用完后则消失。

### 关于原型与原型链

JavaScript 常被描述为一种基于原型的语言 (prototype-based language)——每个对象拥有一个原型对象，对象以其原型为模板、从原型继承方法和属性。原型对象也可能拥有原型，并从中继承方法和属性，一层一层、以此类推。这种关系常被称为原型链 (prototype chain)，它解释了为何一个对象会拥有定义在其他对象中的属性和方法。
准确地说，这些属性和方法定义在 Object 的构造器函数(constructor functions)之上的 prototype 属性上，而非对象实例本身。
![一个关于原型链的简单示意图](https://upload-images.jianshu.io/upload_images/12812641-738570ee957671b9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

> 要记住的一个公式
> `var _______ = new ______`
> 类型：对象&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;类型：函数对象
> var 对象 = new 函数()
> 对象._ \_proto_ \_ == 函数.prototype
