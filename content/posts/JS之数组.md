---
title: JS之数组
date: 2018-09-15 10:53:30
tags: ['JS']
---

## Array 定义

数组是按次序排列的一组值，每个值都有一个下标，按顺序从零开始。
数组自带一个属性 length，表示数组的长度即有多少个值，其数值为最后一个值下标+1。
数组是一种特殊的对象，他的键名是按次序排列的一组整数，而他的键值可以是任意值。
判断数组方法： Array.isArray()

## 创建一个数组

创建数组的方式有两种：

- 使用 Array 构造函数
  根据给构造函数传递参数的不同，生成不同的数组
  - 传递一个数值，创建一个给定数量的数组
    `var colors = new Array(3)`创建一个包含 3 项的数组
  - 传递其它类型的参数，创建一个包含该参数的一个数组
    `var names = new Array('blue')`创建一个包含 blue 字符串的数组
- 使用数组字面量表示法

## 数组的增删查改

### 数组的增删

1. length 属性：
   可以通过设置数组的 length 属性，从数组的末尾移除项或向数组中添加新项。
2. 栈方法：
   模仿栈数据结构的方法，后进先出。
   push 与 pop 方法都改变了原数组，只是返回值不同，push 返回改变后数组的长度 length，而 pop 返回数组移除的最后一项。
   - `push()`
     接受任意数量的参数，将它们逐个添加到数组的末尾，并返回修改的的数组的长度（length）
   - `pop()`
     从数组末尾移除最后一项，减少数组的 length 值，并返回移除的项
3. 队列方法：
   模仿队列数据结构的方法，先进先出。
   shift 与 push 方法可以实现队列那样的行为
   - `shift()`
     移除数组的第一项，减少数组的 length 值，并返回移除的项
   - `unshift()`同 shift 相反，与 push 类似
     接受任意数量的参数，将他们逐个添加到数组的开头，并返回数修改后的数组的长度

### 数组的查改

1. 获取数组中元素的位置：返回的是索引
   接受两个参数，要查找的项和表示查找起点位置的索引，第二个参数可选，默认为 0。返回要查找的项在数组中的位置（索引），如果没找到返回-1。
   查找比较每一项时，会使用全等操作符（===）
   - `indexOf()`从开头向末尾查找
   - `lastIndexOf()`从末尾向开头查找
   ```js
   var numbers = [1, 2, 3, 4, 5, 6, 5, 4, 3, 2, 1]
   console.log(numbers.indexOf(4)) // 3
   console.log(numbers.lastIndexOf(4)) // 7
   console.log(numbers.indexOf(4, 4)) // 7
   console.log(numbers.lastIndexOf(4, 4)) // 3
   console.log(numbers.lastIndexOf(4, 3)) // 3
   console.log(numbers.lastIndexOf(4, 2)) // -1
   console.log(numbers.lastIndexOf(0)) // -1
   ```
2. 数组的拼接：

- `concat()`方法：基于当前数组的所有项创建一个新的数组。
  将传入的值，添加到该数组中，并返回一个新的数组。如果传入的是一个或多个数组，则将传入的数组中的每一项添加到该数组中。如果不是数组，则会被简单的添加到数组的末尾。

```js
var colors = ['red', 'green', 'blue']
var colors2 = colors.concat('yellow', ['blcak', 'grey'])

console.log(colors2) // ["red","green","blue","yellow","blcak","grey"]
```

- `join()`方法：以指定参数作为分隔符，将所有数组成员连接为一个字符串返回。如果不提供参数，默认用逗号分隔。

```js
var a = [1, 2, 3, 4]

a.join(' ') // '1 2 3 4'
a.join(' | ') // "1 | 2 | 3 | 4"
a.join() // "1,2,3,4"
```

3. 数组的截取：
   `slice()`方法：基于当前数组中的一个或多个项创建一个新数组。
   接受 2 个参数，即要返回数的起始位置和结束位置（不包括）。可以省略第二个参数，默认返回从起始位置到末尾的数组。该方法返回的是一个新数组，并不会影响原数组。
4. 数组的`splice()`方法
   splice 方法接受三个参数：要删除第一项的位置，删除的项数，要插入的项（可以是多个）。
   最终返回一个包含删除项的数组，如果没有（第二个参数为 0），则返回空数组。
   根据三个参数的不同，可以实现三种功能：
   - 删除：`splice(0,2)`删除数组的前两项
   - 插入：`splice(2,0,"red","blue")`会从当前数组位置 2 开始插入字符串
   - 替换：`splice(2,1,"red","blue")`会删除掉 2 位置的项，然后从位置 2 开始插入字符串

## 数组的迭代

每一个方法接受两个参数：

- 每一项运行的函数：该函数接受三个参数：
  - 数组的每一项（item）
  - 该项在数组中的位置（index）（可省略）
  - 数组对象本身（Array）（可省略）
- 运行该函数的作用域对象：影响 this 的值。

`every()`:对数组的每一项运行给定函数，当每一项都返回 true 时，every()返回 true。
`some()`:对数组的每一项裕兴给定函数，当其中任一项返回 true，some()返回 true。
`filter()`:对数组的每一项运行给定函数，数组中返回 true 的项，组成一个新数组返回。
`map()`:对数组的每一项运行给定函数，返回对每一项函数运行的结果(返回的值)组成的新数组。
`forEach()`:对数组的每一项运行给定函数，无返回值。

> 注意：
> 前面四中方法都是返回一个新的值，并没有改变原数组，而 forEach 操作了原数组
> forEach 本质与 for in 循环类似，forEach 方法无法中断执行，总是会将所有成员遍历完。如果希望符合某种条件时，就中断遍历，要使用 for 循环。

```js
var numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]

var everyN = numbers.every((item) => {
	return item > 0
})
everyN // true
var someN = numbers.some((item) => {
	return item % 2 === 0
})
someN // true
var filterN = numbers.filter((item) => {
	return item % 2 === 0
})
//
filterN //[2,4,6,8]

var mapN = numbers.map((item) => {
	return item * 2
})
mapN // [2,4,6,8,10,12,14,16,18]

var forEachN = numbers.forEach((item) => {
	item = item + 2
})
```

## 数组的归并

接受两个参数：

1. 每一项上调用的函数
   这个函数接受 4 个参数：

   - 前一个值
   - 当前值
   - 项的索引
   - 数组对象

2. 作为归并基础的初始值

函数返回的值都会作为初始值传给下一项，即数组的第一项调用函数的返回值会作为数组第二项调用函数的初始值参数。
迭代(遍历)数组的所有项，返回最终值。

- `reduce()`: 从第一项开始遍历数组
- `reduceRight()`：从最后一项向第一项遍历数组

```js
var values = [1, 2, 3, 4, 5]

values.reduce((prev, cur, index, array) => {
	return prev + cur
})
// ((((1+2)+3)+4)+5) == 15
```

## 数组的排序

- sort()
  sort()方法会先调用数组每一项的 tostring()方法，然后比较得到的字符串，确定如何排序，所以实际排序的是每一项的 unicode 编码顺序。
  改进：接受一个比较函数。
  如果第一个参数应该位于第二个参数前则返回一个负数，如果两个参数相等则返回 0，如果第一个参数应该位于第二个参数之后则返回一个正数。

  ```js
  function compare(val1, val2) {
  	if (val < val2) {
  		return -1
  	} else if (val1 > val2) {
  		return 1
  	} else {
  		return 0
  	}
  }
  z

  //上述代码优化
  function compare(val1, val2) {
  	return val1 - val2
  }
  //从小到大

  var values = [0, 5, 8, 7, 10]

  values.sort(compare)

  values // [0,5,7,8,10]
  ```

- reverse()
  reverse()反转数组项的顺序

## 数组的去重

- 计数排序逻辑：（只能正整数）

  ```js
  var a = [4, 2, 5, 6, 3, 4, 5]

  function removeSame(array) {
  	var hashTab = {}
  	for (let i = 0; i < a.length; i++) {
  		if (a[i] in hashTab) {
  			// 什么也不做
  		} else {
  			hashTab[a[i]] = true
  		}
  	}
  	//hashTab: {4: true, 2: true, 5: true, 6:true, 3: true}
  	return Object.keys(hashTab) // ['4','2','5','6','3']
  }
  ```
