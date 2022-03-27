---
title: css页面位置的一些相关问题
date: 2018-07-08 20:53:35
tags: ['css']
categories: ['Web']
hiddenFromHomePage: true
draft: true
---

## 左右布局

&emsp;关于页面布局，正常情况下是按“文档流”来走的，也就是从上到下布局。如果要实现左右布局（横向布局）的话，则需要破坏正常的文档流。一般我们使用`float`来实现：![左右布局](https://upload-images.jianshu.io/upload_images/12812641-bffab616a4cab188.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
我们会发现棕色的色向上移动了,而里面的文本 C 却没有发生变化。这就是浮动发生后发生的脱离文档流带来的 bug。所以我们一般在浮动后都会给其父元素添加属性消除浮动带来的影响：

> .clearfix::after {
> &emsp; content:'';
> &emsp;display:block;
> &emsp;clear:both;
> }
> ![清除浮动](https://upload-images.jianshu.io/upload_images/12812641-251d96f99a0a0f15.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 左中右布局

左中右布局也属于横向布局，其实就在右边再加一个`<div>`而已。再就利用定位属性，在页面中实现左中右布局。

## 水平居中

实现水平居中的方式有多种，常见的：

- 如果是文本的话，使用`text-align="center"`即可实现；
- 如果是块状元素的话，直接通过设置`margin: 0 auto;`即可实现`<div>`居中；

![左右居中](https://upload-images.jianshu.io/upload_images/12812641-967469b306ae2890.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 垂直居中

实现垂直居中并不容易，目前最基本的几种方式：

- 文本居中利用文字行高等于所在元素高度：`line-height`=`height`实现；如果知道文本确切的行高与其高度，则可以利用 padding 上下相等实现文本居中。
- `<div>`居中最简单的利用上下`margin`相等或者`margin: auto 0;`实现；
- 当父元素高度由子元素高度决定时，则可以设置上下`padding`相等实现垂直居中。或者知道确切的父子元素的高度，也可以通过合理的设计实现垂直居中。![垂直居中](https://upload-images.jianshu.io/upload_images/12812641-b81ebce275b1be53.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
