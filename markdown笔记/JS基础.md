# JS介绍

浏览器本身并不会执行JS代码，而是通过内置JavaScript引擎(解释器) 来执行JS代码 。JS引擎执行代码时逐行解释每一句源码（转换为机器语言），然后由计算机去执行，所以JavaScript语言归为脚本语言，会逐行解释执行

## JS的组成

1. ECMAScript：ECMAScript是由ECMA国际（原欧洲计算机制造商协会）进行标准化的一门编程语言，这种语言在万维网上应用广泛，它往往被称为JavaScript或JScript，但实际上后两者是ECMAScript语言的实现和扩展
2. 文档对象模型（Document Object Model，简称DOM）：是W3C组织推荐的处理可扩展标记语言的标准编程接口。通过DOM提供的接口可以对页面上的各种元素进行操作（大小、位置、颜色等）
3. ECMAScript（Browser Object Model，简称BOM) ：是指浏览器对象模型，它提供了独立于内容的、可以与浏览器窗口进行互动的对象结构。通过BOM可以操作浏览器窗口，比如弹出框、控制浏览器跳转、获取分辨率等

## JavaScript的三种使用方式

- 内联式（主要用于事件）

  - `<input type="button" name="" onclick="alert('ok！');">`
  - 可以将单行或少量JS代码写在HTML标签的事件属性中（以`on`开头的属性），如：`onclick`
  - 注意单双引号的使用：在HTML中我们推荐使用双引号，JS中我们推荐使用单引号
  - 可读性差， 在html中编写JS大量代码时，不方便阅读
  - 引号易错，引号多层嵌套匹配时，非常容易弄混
  - 特殊情况下使用

- 嵌入式

  - ```html
    <script type="text/javascript"> <!-- type=可以省略 --> 
        // 单行注释
        /* 多
        行
        注
        释 */
        alert('显示1');
        console.log('显示2');
        prompt('显示3');
    </script>
    ```

- 外部式css样式，写在单独的一个文件中

  - `<script type="text/javascript" src="js/index.js"></script>`
  - 利于HTML页面代码结构化，把大段JS代码独立到HTML页面之外，既美观，也方便文件级别的复用
  - 引用外部JS文件的script标签中间不可以写代码
  - 适合于JS代码量比较大的情况

**注意：**

我们可以将JavaScript代码放在html文件中任何位置，但是我们一般放在网页的`<head>`或者`<body>`部分。 <u>放在`<head>`部分最常用的方式是在页面中`<head>`部分放置`<script>`元素，浏览器解析`<head>`部分就会执行这个代码，然后才解析页面的其余部分。 放在`<body>`部分 JavaScript代码在网页读取到该语句的时候就会执行。</u>

javascript作为一种脚本语言可以放在html页面中任何位置，但是浏览器解释html时是按先后顺序的，所以前面的script就先被执行。比如进行页面显示初始化的js必须放在`<head>`里面，因为初始化都要求提前进行（如给页面body设置css等）；而如果是通过事件调用执行的`function`那么对位置没什么要求的。

比如使用`document.getElementById`时，该标签还没有定义，所以这个语句要写在这个标签后面

## 标志符，关键字和保留字

### 标识符

    标识(zhi)符：就是指开发人员为变量、属性、函数、参数取的名字。
    标识符不能是关键字或保留字。

### 关键字

```javascript
关键字：是指 JS本身已经使用了的字，不能再用它们充当变量名、方法名。

包括：break、case、catch、continue、default、delete、do、else、finally、for、function、if、in、instanceof、new、return、switch、this、throw、try、typeof、var、void、while、with 等。
```

### 保留字

    保留字：实际上就是预留的“关键字”，意思是现在虽然还不是关键字，但是未来可能会成为关键字，同样不能使用它们当变量名或方法名。
    
    包括：boolean、byte、char、class、const、debugger、double、enum、export、extends、fimal、float、goto、implements、import、int、interface、long、mative、package、private、protected、public、short、static、super、synchronized、throws、transient、volatile 等。
    
    注意：如果将保留字用作变量名或函数名，那么除非将来的浏览器实现了该保留字，否则很可能收不到任何错误消息。当浏览器将其实现后，该单词将被看做关键字，如此将出现关键字错误。

# 变量定义

JavaScript 是一种弱类型语言，也就是说不需要指定变量的类型，JavaScript的变量类型由它的值来决定， 定义变量需要用关键字`var`, 一条JavaScript语句应该以`;`结尾。使用该关键字声明变量后，计算机会自动为变量分配内存空间

在代码运行时，变量的数据类型是由 JS引擎根据`=`右边变量值的数据类型来判断的，运行完毕之后，变量就确定了数据类型。JavaScript拥有动态类型，同时也意味着相同的变量可用作不同的类型

定义变量的语法格式: `var 变量名 = 值;`

**声明变量特殊情况**

| 情况                           | 说明                    | 结果      |
| ------------------------------ | ----------------------- | --------- |
| var  age ; console.log (age);  | 只声明 不赋值           | undefined |
| console.log(age)               | 不声明 不赋值  直接使用 | 报错      |
| age   = 10; console.log (age); | 不声明   只赋值         | 10        |

## 数据类型

js中有六种数据类型，包括五种基本数据类型和一种复杂数据类型(object)。

5种基本数据类型：

1. `number`：数字类型，`21`（整数），`21.37`（小数），`010`（十进制8），`0xA`（十六进制10）

   - 在JS中八进制前面加`0`，十六进制前面加`0x`
   - JavaScript中数值的最大：`Number.MAX_VALUE` = 1.7976931348623157e+308
   - 最小：`Number.MIN_VALUE` = 5e-324
   - 无穷大：`Infinity`
   - 无穷小：`-Infinity`
   - 非数值Not a number：`NaN`
     - `isNaN('Junk')`的结果为`true`。用来判断一个变量是否为非数字的类型，返回`true`或者`false`

2. `string`：字符串类型，单引号或双引号，推荐单引号

   - `strMsg.length`获取字符串长度
   - 多个字符串之间可以使用`+`进行拼接，其拼接方式为`字符串 + 任何类型` = 拼接之后的新字符串。拼接前会把与字符串相加的任何类型转成字符串，再拼接成一个新的字符串

3. `boolean`：布尔类型true或false

   - 布尔型和数字型相加的时候，`true`的值为 1 ，`false`的值为 0
     - `true+1`的结果为2

4. `undefined`：undefined类型，变量声明未初始化，它的值就是undefined

   ```javascript
   var variable;
   console.log(variable);           // undefined
   console.log('你好' + variable);  // 你好undefined
   console.log(11 + variable);     // NaN
   console.log(true + variable);   //  NaN
   ```

5. `null`：null类型，表示空对象，如果定义的变量将来准备保存对象，可以将变量初始化为null，在页面上获取不到对象，返回的值就是null

```javascript
var vari = null;
console.log('你好' + vari);  // 你好null
console.log(11 + vari);     // 11
console.log(true + vari);   //  1
```

![基本数据类型](C:\Users\admin\Desktop\practicing\图片笔记\前端\js\基本数据类型.png)

1种复合类型：

1. object 后面学习的**数组、函数和JavaScript对象**都属于复合类型

## `typeof`获取变量的类型

```javascript
/* 由于js历史原因，设计之前没有null类型，null值归属于object类型，后续js语言迭代后也没进行修改 */
var type = typeof(oObj); // typeof oObj用这个没有括号的版本
alert(type); // 返回string

var obj = {
    name: '张三',
    age: 16,
}
console.log(obj['age']);
console.log(typeof obj); // object
```

## 数据类型转换

1. 转换成string类型
   1. `toString()`：`var num=10; alert(num.toString());`
   2. `String()`强制转换：`var num=10; alert(String(num));`
   3. `+`号隐式转换：`var num=10; alert(num+'');`
2. 转换为number类型
   1. `parseInt(string)`转换为整数数值型：`parseInt('10')`
   2. `parseFloat(string)`转换为浮点型数值型：`parseFloat('10.5')`
   3. `Number()`强制转换：`Number('10')`
   4. 算术运算符隐式转换：`'10'-5`
3. 转换为boolean类型
   1. `Boolean()`：`Boolean('true')`
   2. 代表空、否定的值会被转换为`false`，如 `''`、`0`、`NaN`、`null`、`undefined`，其余值都会被转换为 `true`

## 变量命名规范

- 区分大小写
- 第一个字符必须是字母、下划线（`_`）或者美元符号（`$`），不能以数字开头
- 其他字符可以是字母(`A-Za-z`)、数字(`0-9`)、下划线(`_`)、美元符号(`$`)
- 不能使用JavaScript关键词与JavaScript保留字
- 变量虽然也可以不声明，直接使用，但不规范，需要先声明，后使用

### 标志符命名规范

- 变量、函数的命名必须要有意义
- 变量的名称一般用名词  
- 函数的名称一般用动词  

### 操作符规范

```javascript
// 操作符的左右两侧各保留一个空格
for (var i = 1; i <= 5; i++) {
   if (i == 3) {)
```

单行注释规范：单行注释前面注意有个空格

其他规范：关键词、操作符之间后加空格	

```javascript
for (var i = 1; i <= 5; i++) {
   if (i == 3) {
       break; // 单行注释前面注意有个空格
   }
   console.log('我正在吃第' + i + '个包子呢');
}
```

### 匈牙利命名风格

- 对象o Object 比如：oDiv
- 数组a Array 比如：aItems
- 字符串s String 比如：sUserName
- 整数i Integer 比如：iItemCount
- 布尔值b Boolean 比如：bIsComplete
- 浮点数f Float 比如：fPrice
- 函数fn Function 比如：fnHandler

```javascript
 //同时定义多个变量可以用","隔开，公用一个‘var’关键字
var iNum = 45,sTr='qwe',sCount='68';
// number
var iOne = 10.1;
// string
var sStr = '1234';
// boolean; 
var bIsTrue = false;
// undefined
var unData;
// null空对象
var nullData = null;
// object对象类型
var oObj = {
   name:"隔壁老王",
   age:88
}
```

## JavaScript对象

JavaScript 中的所有事物都是对象：字符串、数值、数组、函数等都可以认为是对象，此外，JavaScript 允许自定义对象，对象可以拥有属性和方法，对象的属性用来描述对象的特征，对象的方法用来描述对象的行为和功能

### 创建对象

创建自定义javascript对象有两种方式:

1. 通过顶级Object类型来实例化一个对象
2. 通过对象字面量创建一个对象
3. 利用构造函数创建对象，通过`new`关键字创建对象的过程我们也称为对象实例化
   - 构造函数约定首字母大写
   - 函数内的属性和方法前面需要添加`this`，表示当前对象的属性和方法
   - 构造函数中不需要`return`返回结果
   - 当我们创建对象的时候，必须用`new`来调用构造函数
   - `new`关键字的作用
     - 在构造函数代码开始执行之前，创建一个空对象
     - 修改this的指向，把this指向创建出来的空对象
     - 执行函数的代码
     - 在函数完成之后，返回this---即创建出来的对象

```javascript
// Object类创建对象的示例代码:
<script>
    var oPerson = new Object();
    // 添加属性：
    oPerson.name = 'tom';
    oPerson.age = '25';
    // 添加方法：
    oPerson.sayName = function(){
        alert(this.name);
    }
    // 调用属性和方法：
    alert(oPerson.age);
    oPerson.sayName();

// 对象字面量创建对象的示例代码:
    var oPerson2 = {
        name:'Rose',
        age: 18,
        sayName:function(){
            alert('My name is' + this.name);
        }
    }
    // 调用属性和方法：
    alert(oPerson2.age);
	alert(oPerson2['age']);
    oPerson2.sayName();

	// 使用构造函数创建对象
	function 构造函数名(形参1,形参2,形参3) {
         this.属性名1 = 参数1;
         this.属性名2 = 参数2;
         this.属性名3 = 参数3;
         this.方法名 = 函数体;
	}

    function Student(name, age, grade){
        this.name = name;
        this.age = age;
        this.grade = grade;
        this.call = function(){console.log('i am '+ name);}
    }

    s1 = new Student('张三', 12, [100, 99, 102]);
    // 调用
	s1.call(); 	
    // 遍历
	for (k in s1){
        console.log(k);
        console.log(s1[k]);
    }
</script>
```

### 遍历对象

`for...in`语句用于对数组或者对象的属性进行循环操作

```javascript
for (变量 in 对象名字) {
    // 在此执行代码
}
```

## Array数组对象

数组是指一组数据的集合，其中的每个数据被称作元素，==数组存储的数据可以是任何类型（数字、字符、布尔值等）==。下标用来访问数组元素的序号（数组下标从0开始），不支持负数下标 ，如果访问时数组没有和索引值对应的元素，则得到的值是`undefined`

### 创建数组

1. 利用`new`创建数组
2. 利用数组字面量创建数组

注意，在使用`var arr = new Array();`创建数组时

- 如果没有传递参数，创建出的是空数组
- 如果只传入一个参数，则参数规定了数组的长度
- 如果传入了多个参数，则参数称为数组的元素

```javascript
// 创建数组的两种方式
// 1. 利用new创建数组  
var aList = new Array(1,2,3);
// 如果设置的length属性值大于数组的元素个数，则会在数组末尾出现空白元素（undefined）
var aList3 = new Array(8) //即使指定了长度为8，仍然可以将元素存储在规定长度以外。
aList[6]=10;
document.write("数组的长度是："+aList.length); //数组的长度是：7
// 2. 利用数组字面量创建数组
var aList2 = [[1,2,3],['a','b','c']];
Array.isArray(aList2) // true
```

### 添加删除数组元素

![数组增删](C:\Users\admin\Desktop\practicing\图片笔记\前端\js\数组增删.png)

### 数组排序

![数组排序](C:\Users\admin\Desktop\practicing\图片笔记\前端\js\数组排序.png)

```javascript
var arr = [19, 21, 56, 73, 24, 66];
// arr.sort();
// arr.sort(function compareFn(a, b){return b-a;});
arr.sort((a, b) => b - a)
console.log(arr.join());
```

`sort()`方法可以传参也可以传函数

### 数组索引

![数组索引](C:\Users\admin\Desktop\practicing\图片笔记\前端\js\数组索引.png)

### 数组转换为字符串

![数组转化为字符串](C:\Users\admin\Desktop\practicing\图片笔记\前端\js\数组转化为字符串.png)

`join`方法如果不传入参数，则按照 `, `拼接元素

### 其他方法

`Array.isArray()`用于判断一个对象是否为数组，`isArray()`是HTML5中提供的方法

![数组其他方法](C:\Users\admin\Desktop\practicing\图片笔记\前端\js\数组其他方法.png)

# 运算符

## 算术运算符

`+`，`-`， `*`， `/`（取模）， `%`，`++`（自增），`--`（自减），`+=`，`-=`，`*=`，`/=`，`%=`

浮点数的精度问题：浮点数值的最高精度是17位小数，但在进行算术计算时其精确度远远不如整数，浮点数值的最高精度是 17 位小数，但在进行算术计算时其精确度远远不如整数，所以不要直接判断两个浮点数是否相等

## 比较运算符

假如 x = 5, 查看比较后的结果:

| 比较运算符 |                       描述                       |                 例子                 |
| :--------: | :----------------------------------------------: | :----------------------------------: |
|     ==     | 等于（比较的是值，比较时会自动进行数据类型转换） |           x == 8 为 false            |
|    ===     |                 全等（值和类型）                 | x =\== 5 为 true; x === "5" 为 false |
|     !=     |                      不等于                      |            x != 8 为 true            |
|     >      |                       大于                       |            x > 8 为 false            |
|     <      |                       小于                       |            x < 8 为 true             |
|     >=     |                    大于或等于                    |           x >= 8 为 false            |
|     <=     |                    小于或等于                    |            x <= 8 为 true            |

## 逻辑运算符

假如 x=6, y=3, 查看比较后的结果:

| 比较运算符 | 描述 |             例子              |
| :--------: | :--: | :---------------------------: |
|     &&     | and  |   (x < 10 && y > 1) 为 true   |
|    \|\|    |  or  | (x == 5 \|\| y == 5) 为 false |
|     !      | not  |       !(x == y) 为 true       |

### 短路逻辑

短路运算的原理：当有多个表达式（值）时，左边的表达式值可以确定结果时，就不再继续运算右边的表达式的值[^2]

[^2]: 结果和python执行的结果相同

```javascript
console.log(123 && 456);        // 456
console.log(0 && 456);          // 0
console.log(123 && 45 6&& 789);  // 789
console.log(123 || 456);         //  123
console.log(0 ||  456);          //  456
console.log(123 || 456 || 789);  //  123
```

## 运算符优先级

![运算符优先级](C:\Users\admin\Desktop\practicing\图片笔记\前端\js\运算符优先级.png)

- 一元运算符里面的逻辑非优先级很高
- 逻辑与比逻辑或优先级高

# 条件和循环语句

- `switch`语句进行条件判断后直接执行到程序的条件语句，效率更高。而`if…else`语句有几种条件，就得判断多少次。当分支比较少时，`if… else`语句的执行效率比`switch`语句高；当分支比较多时，`switch`语句的执行效率比较高，而且结构更清晰。 

```html
<script type="text/javascript">
    // if条件语句
	if(条件1) {条件1成立时执行的代码}
	else if(条件2) {条件2成立时执行的代码}
	...
	else if(条件n) {条件n成立时执行的代码}
	else {条件1、2至n不成立时执行的代码}
    // 三元表达式
    表达式1 ? 表达式2 : 表达式3;
    
    // switch条件语句，如果存在匹配全等(===) ，则与该case关联的代码块会被执行，并在遇到break时停止，整个switch语句代码执行结束，若所有的case的值都和表达式的值不匹配，则执行default里的代码
    switch (表达式或值){
        case 表达式/值1:
            执行代码块 1
            break;
        case 表达式/值2:
            执行代码块 2
            break;
        ...
        case 表达式/值n:
            执行代码块 n
            break;
        default:
            与 case值1 、 case值2...case值n 不同时执行的代码
    }
    
    // for循环 
    for (初始化变量;循环条件;循环迭代){
		循环语句
        continue; //break;
    }
    
	// while循环
    while (判断条件){
	    循环语句
    }
    
    // do...while循环: 它保证循环体至少被执行一次。因为它是先执行代码，后判断条件，如果条件为真，继续循环。
    do{
        循环语句
    }while (判断条件)
</script>

<script type="text/javascript">
    // 匿名函数的写法。页面标签和数据都加载完成以后会触发onload事件
	window.onload = function(){
		var oDiv = document.getElementById('div1');
    }
</script>
```

# 函数

在JavaScript中，形参的默认值是`undefined`。在函数形参和实参数量不匹配时

- 实参个数等于形参个数 ：输出正确结果
- 实参个数小于形参个数 ：多的形参定义为`undefined`，结果为`NaN`
- 实参个数大于形参个数 ：只取到形参的个数

在使用`return`语句时，函数会停止执行，并返回指定的值，如果函数没有`return`，返回的值是`undefined`

```javascript
// 声明函数，function 是声明函数的关键字，必须小写
function 函数名(形参1, 形参2 , 形参3...) { // 可以定义任意多的参数，用逗号分隔
  // 函数体
}
// 调用函数，调用的时候千万不要忘记添加小括号
函数名(实参1, 实参2, 实参3...);  // 通过调用函数名来执行函数体代码

// 匿名函数
// 这是函数表达式写法，匿名函数后面跟分号结束
var fn = function(){...}；
// 调用的方式，函数调用必须写到函数体下面
fn();
```

## `arguments`的使用

当不确定有多少个参数传递的时候，可以用`arguments`来获取。JavaScript中，`arguments`实际上它是当前函数的一个内置对象。所有函数都内置了一个`arguments`对象，`arguments`对象中存储了传递的所有实参。`arguments`展示形式是一个伪数组，因此可以进行遍历。伪数组具有以下特点：

- 具有`length`属性
- 按索引方式储存数据
- 不具有数组的`push`，`pop`等方法

注意：在函数内部使用该对象，用此对象获取函数调用时传的实参。

```javascript
function showArgu(){
    for (var i=0; i<arguments.length;i++){
        document.write(arguments[i]+"<br \>");
    }
}
showArgu(1, 2, 3);
```

## 变量作用域

变量作用域就是变量的使用范围，变量分为:

- 局部变量：在函数内使用的变量，只能在函数内部使用
  - 特殊情况下，在函数内不使用 var 声明的变量也是全局变量（不建议使用）
  - 函数的形参实际上就是局部变量
  - 在任何一个地方都可以使用，只有在浏览器关闭时才会被销毁，因此比较占内存

- 全局变量：在函数外定义的变量，可以在不同函数内使用。并且不同函数内可以共享全局变量
  - 只在函数内部使用，当其所在的代码块被执行时，会被初始化；当代码块运行结束后，就会被销毁，因此更节省内存空间


注意JS没有块级`{}`作用域

```html
function localTest(out){
    out = 10;
}
localTest(num);
alert(num); // 100

<script type="text/javascript">
    /* 函数调用：
    函数中'return'关键字的作用:
    1、返回函数中的值
    2、执行完return函数执行结束
    */
    var iNum = 1;
    function fnAdd(iNum01,iNum02){
        var iRs = iNum01 + iNum02; //var就相当于找盒子的动作，在JavaScript中是关键字（即保留字），这个关键字的作用是声明变量，并为"变量"准备位置(即内存）
        return iRs;
        alert('here!');
    }
    function fnModify(){
        iNum++;
    }
    var iCount = fnAdd(3,4);
    alert(iCount);  //弹出7
    // js可以将数字类型和字符串类型直接进行拼接，底层自动把数字类型转成字符串（隐式类型转换）
    alert("函数外访问的全局变量":+iNum) //弹出2
</script>
<script type="text/javascript">
    //计时器
    var num=0;
    var stop=0;
    function numCount(){
        document.getElementById('clocker').value=num;
        num++;
        stop = setTimeout("numCount()", 1000);
}
    function stopClocker(){
        // 销毁定时器，返回值表示创建定时器返回的id，通俗理解就是创建的第几个定时器
        clearTimeout(stop); //不同函数内可以共享全局变量
    }
</script>
<form action="">
    <input type="text" id="clocker">
    <input type="button" value="Start" onClick="numCount()">
    <input type="button" value="Stop" onclick="stopClocker()">
</form>
```

# JS内置对象

JavaScript中的对象分为3种：自定义对象 、内置对象、 浏览器对象

自定义对象和内置对象是JS基础内容，属于ECMAScript，浏览器对象属于JS独有的， JS API讲解内置对象就是指JS 语言自带的一些对象，这些对象供开发者使用，并提供了一些常用的或是最基本而必要的功能（属性和方法），内置对象最大的优点就是帮助我们快速开发。JavaScript提供了多个内置对象：`Math`、`Date` 、`Array`、`String`等

`instanceof`可以判断一个对象是否是某个构造函数的实例

## Math对象

Math对象不是构造函数，它具有数学常数和函数的属性和方法。跟数学相关的运算（求绝对值，取整、最大值等）可以使用Math中的成员

| 属性、方法名            | 功能                                   |
| ----------------------- | -------------------------------------- |
| Math.PI                 | 圆周率                                 |
| Math.floor()            | 向下取整                               |
| Math.ceil()             | 向上取整                               |
| Math.round()            | 四舍五入版 就近取整   注意-3.5结果是-3 |
| Math.abs()              | 绝对值                                 |
| Math.max() / Math.min() | 求最大和最小值                         |
| Math.random()           | 获取范围在[0,1)内的随机值              |

## Date对象

Date对象和Math对象不一样，`Date`是一个构造函数，所以使用时需要实例化后才能使用其中具体方法和属性。Date 实例用来处理日期和时间

![Date实例的方法和属性](C:\Users\admin\Desktop\practicing\图片笔记\前端\js\Date实例的方法和属性.png)

```javascript
var d1 = new Date(); // 获取当前日期和时间
var d2 = new Date('2021/1/20'); // 指定日期
console.log(d1.getDay());
console.log(d1 instanceof Array); // false
console.log(d1 instanceof Date); // true
```

## String对象

### 基本包装类型

为了方便操作基本数据类型，JavaScript还提供了三个特殊的引用类型：`String`、`Number`和`Boolean`

基本包装类型就是把简单数据类型包装成为复杂数据类型，这样基本数据类型就有了属性和方法[^1]

[^1]: 类似Java的自动装箱和拆箱，JS的处理也是自动的

### 字符串的值不可变

虽然看上去可以改变内容，但其实是地址变了，内存中新开辟了一个内存空间

### 简单数据类型和复杂数据类型

简单类型（基本数据类型、值类型）在存储时变量中存储的是值本身，包括string，number，boolean，undefined，null；复杂数据类型（引用类型）在存储时变量中存储的仅仅是地址（引用），通过`new`关键字创建的对象（系统对象、自定义对象），如Object、Array、Date等。

栈由操作系统自动分配释放存放函数的参数值、局部变量的值等。其操作方式类似于数据结构中的栈；堆存储复杂类型（对象），一般由程序员分配释放，若程序员不释放，由垃圾回收机制回收。值类型变量的数据直接存放在变量（栈空间）中，引用类型变量（栈空间）里存放的是地址，真正的对象实例存放在堆空间中

函数的形参也可以看做是一个变量，当我们把一个值类型变量作为参数传给函数的形参时，其实是把变量在栈空间里的值复制了一份给形参，那么在方法内部对形参做任何修改，都不会影响到的外部变量；当我们把引用类型变量传给形参时，其实是把变量在栈空间里保存的堆地址复制给了形参，形参和实参其实保存的是同一个堆地址，所以操作的是同一个对象

```javascript
function fn(a) {
    a++;
    console.log(a); 
}
var x = 10;
fn(x); // 11
console.log(x); //10

function Person(name) {
    this.name = name;
}
function f1(x) { // x = p
    console.log(x.name); // 2 刘德华    
    x.name = "张学友";
    console.log(x.name); // 3 张学友  
}
var p = new Person("刘德华");
console.log(p.name);    // 1 刘德华  
f1(p);
console.log(p.name);    // 4 张学友
```

### 字符串方法

字符串通过基本包装类型可以调用部分方法来操作字符串，以下是返回指定字符的位置的方法（查找）

![字符串方法根据字符返回位置](C:\Users\admin\Desktop\practicing\图片笔记\前端\js\字符串方法根据字符返回位置.png)

以下是根据位置返回指定位置上的字符（索引）

![字符串根据位置返回字符](C:\Users\admin\Desktop\practicing\图片笔记\前端\js\字符串根据位置返回字符.png)

字符串操作方法

![字符串操作方法](C:\Users\admin\Desktop\practicing\图片笔记\前端\js\字符串操作方法.png)

`replce()`和`split()`

```javascript
var longString = 'shaonianzhangsanfeng';
var newString = longString.replace('shaonian','laonian');

writeP(newString);
writeP(longString.split('a'));
```

