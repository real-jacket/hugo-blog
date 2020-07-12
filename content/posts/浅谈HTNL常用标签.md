---
title: 浅谈HTNL常用标签
date: 2018-07-05 17:39:41
tags: ['技术文章']
---

# HTML 常用标签

HTML 常用标签有：a、form、input、button、h1、p、ul、ol、small、strong、div、span、kbd、video、audio、svg 等等。

## 组成文档结构的标签

主要用来构成整个文档大概的框架：`<head>`、`<title>`、`<body>`、`<h1>`、`<p>`、`<ul>`、`<ol>`、`<ol>`、`<li>`、`<div>`、`<span>`等等。

- `<head>`、`<body>`标签
  组成整个页面的头和身体，大部分内容放在`<body>`中，`<head>`中有一般只有一个标题`<title>`。
- `<h1>`标题标签，
  一共有 6 个从`<h1>`~`<h6>`，对应着 6 级标题，反正够你用了。
  其中`<h1>`~`<h3>`对浏览器友好，意思就是这三个标题能够更容易被浏览器搜索到。
- `<p>`段落标签（paragraph）
  用来标识一段段落的。
- `<div>`盒标签（盒模型）
  我们常说的盒模型就指的`<div>`，主要作用就是把页面划分成一块一块，就像一个盒子般，里面嵌套其它内容。
- `<span>`块标签
  作用类似于`<div>`，但是`<span>`是把一行里面的内容分块。
- `<ul>`、`<ol>`、`<li>`列表标签
  `<ul>`或`<ol>`包含几个`<li>`组成一个列表。
  `<ul>`(unordered list)无序列表，展现的列表是无序的，`<li>`前面一般是一个标志。而`<ol>`(ordered list)是有序列表，`<li>`前面会自动排序。

## 多媒体嵌入

主要用来插入一些多媒体内容：`<img>`、`<video>`、`<audio>`、`<ifram>`、`<svg>`。

- `<img>`插入图片
  1. `src`图片的来源。
  2. `alt`图片无法正常加载时显示的内容。
  3. `title`鼠标悬停在图片上显示的内容。
- `<video>`插入视屏、`<audio>`插入音频
  `src`视屏来源
- `<ifram>`插入网页（少用）
- `<svg>`插入画板

## 文本内容修饰的标签

主要用来修饰文本内容：`<a>`、`<small>`、`<strong>`、`<em>`等等

- `<a>`（anchor 锚点）超链接标签（使用 GET 方法跳转页面）
  可以创建一个到其他网页、文件、同一页面内的位置、电子邮件地址或任何其他 URL 的超链接。
  _ href 属性：
  如果指向域名则跳转对应的域名(http://qq.com) ，如果指向文件（http 中存在 Content-Type：application）则下载文件。（不支持 file 协议）。 #锚点，页面跳转后不发起请求，跳转到顶部。
  伪协议：后接一段 JavaScript 代码，直接实现代码。`javascript: alert('1')`弹出对话框 1，`javascript: ;`点击后什么都不做。
  _ target 属性： 1. "\_blank" 在新页面打开 2. "\_self" 在当前页面打开 3. "\_parent" 当存在`<ifram>`时会在父页面打开 4. "\_top"当存在多个`<ifram>`（≥3）时，会在最外层页面打开 \* download 属性：表示 a 标签不再跳转链接，而是强制下载文件，href 是域名则下载网页。
- `<strong>`加粗标签
  表示文本十分重要，一般用粗体显示。不同于`<b>`标签（同样加粗文本），`<strong>`强调内容与形式，内容很重要，而`<b>`强调形式。
- `<small>`缩小标签
  使文本的字体变小一号，一般被定义为表示边注释和附属细则。
- `<em>`斜体标签
  使文本内容变成斜体，标记出需要用户着重阅读的内容。与`<strong>`类似，`<em>`也有一个`<i>`标签表示斜体。同样的，`<em>`强调内容与形式，内容很重要，而`<i>`强调形式。

## HTML 表单

常用来提交内容：`<form>`、`<input>`、`<button>`、`<label>`

- `<form>`主要用来提交内容(使用 POST 方法跳转页面，提交的内容放在请求的第四部分)
  1. action 属性：发起请求后跳转的页面。
  2. `method="post"`（默认为 GET）使用 POST 发起请求。
  3. `target`同`<a>`标签
- `<input>`标签
  1.  `type="submit"`：提交按钮（如果`<form>`没有 submit 则无法提交）
      如果一个只有一个按钮`<button>`，会自动升级为提交按钮。
      如果该标签明确定义 type=“button”，则不会升级，依然为按钮。
  2.  `type="checkbox"`多选框`<type=“radio”>`单选框
      1. 两者均必须使用 value 属性定义此控件被提交时的值，使用 checked 属性指示控件是否被选择。
      2. `<label>`标签：通常将按钮囊括在里面，点击囊括在内的任何区域都视为被选择。
         `<label><input type="checkbox">爱我</label>`当点击爱我时，没有点击按钮，也会被视为被选中了。
         也可以把`<label>`放在里面将内容囊括起来，利用 for 属性与 id 属性达到同样的效果.
         `<input type="checkbox" id="xxxx"><label for="xxx">爱我</label>`
  3.  `type="select"`下拉菜单选择
      1. `<option>`标签下拉菜单的选项，`select`属性表示默认选择，`disabled`表示不可选中。
      2. `mutiple`属性表示多选
  4.  `type="textarea"`输入文本框
      1. `resize:none`文本框默认宽高不固定，该属性表示固定宽高。一般利用 css 固定宽高。
      2. `height: 100; width: 200;`设定文本框宽高，一般利用 css 固定宽高。
      3. `rows:10`文本框输入的内容设定的行数。

## HTML 表格

常用来表示数据（少用）：`<table>`标签里只能有以下标签

- `<thead>`表头>`<tr>`行（table row）>`<th>`标题单元格
- `<tbody>`表格>`<tr>`行>`<td>`单元格（table data）
- `<tfoot>`表注
