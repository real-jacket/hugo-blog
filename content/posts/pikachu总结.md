---
title: pikachu总结
date: 2018-08-26 10:05:57
tags: ['总结', '项目']
categories: ['总结']
hiddenFromHomePage: true
draft: true
---

## 简介

利用纯 css 画一个皮卡丘，再用 js 使它动起来，js 部分可以参考会动的简历。
主要知识点：

1. 利用定位居中：

```css
.nose {
	width: 0;
	position: absolute;
	left: 50%;
	margin-left: -12px; // transform: translateX(-50%);
}
```

2. 画 pikachu 的嘴唇
   只设置一部分 border 及相关属性。

```css
.upperLip {
	width: 65px;
	height: 30px;
	border: 3px black solid;
	border-top: none;
	border-right: none;
	border-bottom-left-radius: 120px 65px;
}
```

> `border-radius`分开设置的时候，是先设置上下，后设置左右。

3. 椭圆
   `border-radius: 15px/10px;`

## 遇到的问题

- 调速问题
  `setInterval`函数只会读取一次时间，可以利用`setTimeout`递归调用自身实现，从而读取时间。
  ```js
    let n = 0;
    let id = setInterval(()=>{
        n += 1;
        domcode.innerHTML = prefix + css.substring(0,n)；
        stylecode.innerHTML = prefix + css.substring(0,n);
        domcode.scrollTop = domcode.scrollHeight;
        if(n >= css.length){
            window.clearInterval(id)
        }
    },50)
    可以转换成
    let n = 0;
    let id = setTimeout(function adjust(){//注意给函数名字，方便调用。
        n += 1;
        domcode.innerHTML =prefix +  code.substring(0,n);
        style.innerHTML = prefix + code.substring(0,n);
        domcode.scrollTop = domcode.scrollHeight;
        if(n < code.length){
            id = setTimeout(adjust,time)
        }else{
            clearTimeout(id)
        }
    },time)
  ```
- 点击按钮调速实现
  点击的按钮切换状态，要注意 class 类的转变。`class="slow"`===>`class="slow active"`,此时利用 class 类做条件判断应该选择`slow activc`而非`slow`
  ![](https://upload-images.jianshu.io/upload_images/12812641-720d3c7e444085c3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
