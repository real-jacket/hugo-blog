---
title: js中的数据类型转换
date: 2018-07-24 17:41:31
tags: ['技术']
---

js 中有 6 个基本数据类型：number、string、boolean、Symbol、null、undefined 与一个复杂的数据类型 object，object 又可以分为三个子类型：狭义的对象 object、数组 array 与函数 function。这些数据类型之间有些是可以相互转换的，然而转换前我们得知道怎么判断这些数据类型。

## 如何判断一个值的数据类型

JavaScript 有三种方法，可以确定一个值到底是什么类型。

- `typeof`运算符
- `instanceof`运算符
- `Object.prototype.toString`方法

#### typeOf 运算符

`typeOf`运算符可以返回一个值的数据类型，数值、字符串、布尔值分别返回`number`、`string`、`boolean`，`undefined`返回`undefined`，对象返回`obeject`，数组`[]`返回`object`。

> 注意：函数则会返回`function`（虽然函数是个对象），`null`则会返回`object`（虽然 null 不是个对象 ，主要是为了兼容以前的代码）。

#### instanceof 运算符

后面补充

#### Object.prototype.toString 方法

后面补充

## 数据类型的转换

### 手动转换

手动转换主要有是三个方法：Number()、String()和 Boolean()三个函数，手动将各类型的值分别转换成数字、字符串和布尔值。

#### 1.Number()

1. 原始类型值

- 数值：转换后还是原来的值。
- 字符串：如果可以被解析为数值，则转换为相应的数值。否则，返回`NaN`。
  空字符串会转为 0。
- 布尔值：`true`转成 1，`false`转成 0。
- `undefined`：转成`NaN`。
- `null`：转成 0。

2. 对象

- 规则：对于对象，一般返回 NaN，但是如果是包含单个数值的数组则会返回对应的数值。

```js
Number({ a: 1 }) // NaN
Number([1, 2, 3]) // NaN
Number([4]) // 4
```

- 原因解析：涉及到 Number 的转换规则。
  > 1.调用对象自身的 `typeOf`方法。如果返回原始类型的值，则直接对该值使用`Number`函数，不再进行后续步骤。 2.如果`valueOf`方法返回的还是对象，则改为调用对象自身的`toString`方法。如果`toString`方法返回原始类型的值，则对该值使用`Number`函数，不再进行后续步骤。 3.如果`toString`方法返回的是对象，就报错。

```js
var obj = { x: 1 }
Number(obj) // NaN

Number({}) // NaN
```

3. parseInt()与 parseFloat()

- `parseInt`方法用于将字符串转为整数。
  1、如果字符串头部有空格，空格会被自动去除。`parseInt('123') // 123`
  2、如果 parseInt 的参数不是字符串，则会先转为字符串再转换。`parseInt(' 81') // 81`
  3、如果 parseInt 的参数不是字符串，则会先转为字符串再转换。`parseInt(1.23) // 1`
  4、字符串转为整数的时候，是一个个字符依次转换，如果遇到不能转为数字的字符，就不再进行下去，返回已经转好的部分。如果第一个便不能转化成数字，则会返回 NaN。`parseInt('8a') // 8`,`parseInt('12.34') // 12`，`parseInt('abc') // NaN`
  5、parseInt 方法还可以接受第二个参数（2 到 36 之间），表示被解析的值的进制，返回该值对应的十进制数，默认为十进制。`parseInt('1000', 2) // 8`,`parseInt('1000') // 1000`
- `parseFloat`方法用于将一个字符串转为浮点数。
  1、如果字符串符合科学计数法，则会进行相应的转换。
  2、如果字符串包含不能转为浮点数的字符，则不再进行往后转换，返回已经转好的部分。
  `parseFloat`方法会自动过滤字符串前导的空格。
  3、如果参数不是字符串，或者字符串的第一个字符不能转化为浮点数，则返回 NaN。

#### 2. String()

`String`方法可以将任意类型的值转化成字符串。

1. 原始类型的值
   数值、字符串、布尔值、undefined、null：转为相应的字符串。
2. 对象
   String 方法的参数如果是对象，返回一个类型字符串；如果是数组，返回该数组的字符串形式。
   背后的转换规则与`Number`方法基本相同,只是互换了 valueOf 方法和 toString 方法的执行顺序。

```js
String({ a: 1 }) // "[object Object]"
```

#### 3.Boolean()

`Boolean`函数可以将任意类型的值转为布尔值。<br>转换规则：除了这五个值:`undefined、null、-0或0、NaN、''(空字符串)`的转换结果为 false，其余的值皆为`true`。

```js
Boolean(undefined) // false
Boolean(null) // false
Boolean(0) // false
Boolean(NaN) // false
Boolean('') // false
Boolean({}) // true
Boolean([]) // true
Boolean(new Boolean(false)) // true
```

### 自动转换

三种情况下的自动转换数据：

1. 不同类型的数据相互运算。

```js
123 + 'abc' // "123abc"
```

2. 对非布尔值类型的数据求布尔值。

```js
if ('abc') {
	console.log('hello')
} // "hello"
```

3. 对非数值类型的值使用一元运算符（即`+`和`-`）。

```js
;+{ foo: 'bar' } + // NaN
'abc' - // NaN
	[1, 2, 3] // NaN
'1' +
0 + // 1
'1' + // 1
	true // 1
'' + null // 'null'
```

#### 自动转换成布尔值

JavaScript 遇到预期为布尔值的地方（比如 if 语句的条件部分），就会将非布尔值的参数自动转换为布尔值。系统内部会自动调用 Boolean 函数。

#### 自动转换成字符串

JavaScript 遇到预期为数值的地方，就会将参数值自动转换为数值。系统内部会自动调用 Number 函数。
除了加法运算符（+）有可能把运算子转为字符串，其他运算符都会把运算子自动转成数值。
