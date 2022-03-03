# Web API介绍

API（Application Programming Interface，应用程序编程接口）是一些预先定义的函数，目的是提供应用程序与开发人员基于某软件或硬件得以访问一组例程的能力，而又无需访问源码，无需理解其内部工作机制细节，只需直接调用使用即可。Web API是浏览器提供的一套操作浏览器功能和页面元素的API (BOM和DOM)

# DOM

文档对象模型（Document Object Model，简称DOM），是[W3C](https://baike.baidu.com/item/W3C)组织推荐的处理[可扩展标记语言](https://baike.baidu.com/item/%E5%8F%AF%E6%89%A9%E5%B1%95%E7%BD%AE%E6%A0%87%E8%AF%AD%E8%A8%80)（html或者xhtml）的标准[编程接口](https://baike.baidu.com/item/%E7%BC%96%E7%A8%8B%E6%8E%A5%E5%8F%A3)。

DOM树又称为文档树模型，把文档映射成树形结构，通过节点对象对其处理，处理的结果可以加入到当前的页面。

- 文档：一个页面就是一个文档，DOM中使用`document`表示
- 节点：网页中的所有内容，在文档树中都是节点（标签、属性、文本、注释等），使用`node`表示
- 标签节点：网页中的所有标签，通常称为元素节点，又简称为“元素”，使用`element`表示

## 获取元素

```javascript
document.getElementById(id)
/*作用：根据ID获取元素对象
参数：id值，区分大小写的字符串
返回值：元素对象或null*/

document.getElementsByTagName('标签名') / element.getElementsByTagName('标签名')
/*作用：根据标签名获取元素对象
参数：标签名
返回值：元素对象集合（伪数组，数组元素是元素对象）
注意：1. 因为得到的是一个对象的集合，所以需要遍历 2. 得到元素对象是动态的。当页面增加了标签，这个集合中也就增加了元素*/

document.getElementsByName();

// H5新增获取元素方式
document.getElementsByClassName('类名') // 根据类名返回元素对象集合
document.querySelector('选择器') // 根据指定选择器返回第一个元素对象，选择器需要加符号
document.querySelectorAll('选择器') // 根据指定选择器返回，选择器需要加符号

// 获取特殊元素
document.body // 返回body元素对象
document.documentElement // 返回html元素对象
```

## 操作元素

JavaScript的DOM操作可以改变网页内容、结构和样式，我们可以利用DOM操作元素来改变元素里面的内容、属性等。（注意：这些操作都是通过元素对象的属性实现的）

### 改变元素文本内容+修改元素属性+修改元素样式

```javascript
// 1. 改变元素内容
// 这两个属性是可读写的
element.innerText // 从起始位置到终止位置的内容，但它不会识别html，同时空格和换行也会去掉。
element.innerHTML // 从起始位置到终止位置的全部内容，包括html标签，同时保留空格和换行
var div = document.querySelector('div');
div.innerText = '<strong>今天是：</strong> 2019'; // <span>会以文本形式显示出来，不会被识别
div.innerHTML = '<strong>今天是：</strong> 2019'; // 文字会加粗
var p = document.querySelector('p');
console.log(p.innerText); // 没有空格，没有<span>
console.log(p.innerHTML); // 有空格，有<span>

// 2. 修改元素属性
// 2.1 获取和修改内置属性值（元素本身自带的属性）
element.属性名 // 获取属性的值
element.属性名 = 值 // 修改属性的值
// 利用dom可以操作如下表单元素的属性：type/value/checked/selected/disabled
zxy.onclick = function() {
    img.src = 'images/zxy.jpg';
    img.title = '张学友思密达';
}
ldh.onclick = function() {
    img.src = 'images/ldh.jpg';
    img.title = '刘德华';
}
// 2.2 获取,修改和移除自定义的属性
element.getAttribute('属性');
element.setAttribute('属性');
element.removeAttribute('属性');
<body>
    <div id="demo" index="1" class="nav"></div>
<script>
	var div = document.querySelector('div');
    console.log(div.id); // demo
    console.log(div.index); // undefined
    console.log(div.getAttribute('id')); // demo
    console.log(div.getAttribute('index')); // 1

    div.id = 'test';
    div.className = 'navs';
    console.log(div.id); // test
    console.log(div.className); // navs

    div.setAttribute('index', 2);
    div.setAttribute('class', 'footer');
    console.log(div.getAttribute('index')); // 2
    console.log(div.getAttribute('class')); // footer

	div.removeAttribute('index');
</script>
</body>


// 3. 修改元素样式
// 行内样式操作
element.style 
/*注意：1.JS里面的样式采取驼峰命名法，比如fontSize, backgroundColor 
2. 修改style样式操作，产生的是行内样式，css权重比较高*/
div.onclick = function() {
    this.style.backgroundColor = 'purple';
    this.style.width = '250px';
}


// 类名样式操作
element.className 
/*注意：1. 如果样式修改较多，可以采取操作类名方式修改元素样式 
2. class因为是个保留字，因此使用className来操作元素类名属性
3. className会直接更改元素的类名，会覆盖原先的类名*/
test.onclick = function() {
    // 如果想要保留原先的类名，我们可以用多类名选择器
    // this.className = 'change';
    this.className = 'first change';
}
```

#### 排他思想

如果有同一组元素，我们想要某一个元素实现某种样式， 需要用到循环的排他思想算法：

1. 所有元素全部清除样式

2. 给当前元素设置样式

3. 注意顺序不能颠倒，首先干掉其他人，再设置自己

```js
<button>按钮1</button>
<button>按钮2</button>
<button>按钮3</button>
<button>按钮4</button>
<button>按钮5</button>
<script>
    // 1. 获取所有按钮元素
    var btns = document.getElementsByTagName('button');
    // btns得到的是伪数组。里面的每一个元素btns[i]
    for (var i = 0; i < btns.length; i++) {
        btns[i].onclick = function() {
            // 我们先把所有的按钮背景颜色去掉
            for (var i = 0; i < btns.length; i++) {
                btns[i].style.backgroundColor = '';
            }
            // 然后才让当前的元素背景颜色为pink
            this.style.backgroundColor = 'pink';
        }
    }
</script>
```

### H5自定义属性

自定义属性目的：是为了保存并使用数据。有些数据可以保存到页面中而不用保存到数据库中

自定义属性获取是通过`getAttribute('属性')` 获取

但是有些自定义属性很容易引起歧义，不容易判断是元素的内置属性还是自定义属性。H5给我们新增了自定义属性：

![设置h5自定义属性](C:\Users\admin\Desktop\practicing\图片笔记\前端\webAPI\设置h5自定义属性.png)

![获取h5自定义属性](C:\Users\admin\Desktop\practicing\图片笔记\前端\webAPI\获取h5自定义属性.png)

```html
<body>
	<div getTime="20" data-index="2" data-list-name="andy"></div>
	<script>
		var div = document.querySelector('div');
		console.log(div.getTime); // undefined
		console.log(div.getAttribute('getTime')); // 20
		div.setAttribute('data-time', 20);
		console.log(div.getAttribute('data-index')); // 2
		console.log(div.getAttribute('data-list-name')); // andy
		// h5新增的获取自定义属性的方法 它只能获取data-开头的
		// dataset 是一个集合里面存放了所有以data开头的自定义属性
		console.log(div.dataset); // DOMStringMap
		console.log(div.dataset.index); // 2
		console.log(div.dataset['index']); //2  
		// 如果自定义属性里面有多个-链接的单词，我们获取的时候采取驼峰命名法
		console.log(div.dataset.listName); // andy
		console.log(div.dataset['listName']); // andy
	</script>
</body>
```

## 操作节点

### 节点概述

网页中的所有内容都是节点（标签、属性、文本、注释等），在DOM 中，节点使用`node`来表示

HTML DOM 树中的所有节点均可通过JavaScrip 进行访问，所有HTML元素（节点）均可被修改，也可以创建或删除

一般地，节点至少拥有`nodeType`（节点类型）、`nodeName`（节点名称）和`nodeValue`（节点值）这三个基本属性

- 元素节点nodeType为1
- 属性节点nodeType为2
- 文本节点nodeType为3（包含文字、空格、换行等）

我们在实际开发中，节点操作主要操作的是元素节点

### 节点层级

![dom树](C:\Users\admin\Desktop\practicing\图片笔记\前端\webAPI\dom树.png)

```html
<body>
	<div class="box">
		<ul type="square">
			<li class="sbox-1">1</li>
			<li class="sbox-2">2</li>
			<li class="sbox-3">3</li>
			<li>4</li>
			<li>5</li>
			<li>6</li>
		</ul>
	</div>

	<script>

		// 节点属性
		var box = document.getElementsByTagName("ul")[0];
		// 节点的名称，是只读的。元素节点的nodeName与标签名相同，属性节点的nodeName是属性的名称，文本节点的nodeName是#text，文档节点的nodeName是#document
		document.write("<p>" + box.nodeName + "</p>"); // UL
		
        // 节点的类型，是只读的。1-元素；2-属性；3-文本；8-注释；9-文档
		document.write("<p>" + box.nodeType + "</p>"); // 1
		
        // 节点的值。元素节点的nodeValue是undefined或null，属性节点的nodeValue是属性的值，文本节点的nodeValue是文本自身
		document.write("<p>" + box.nodeValue + "</p>"); // null
		
        // 获取/修改元素节点的属性值
		console.log(box.getAttribute("type")); // square
		// 如果不存在具有指定名称的属性，该方法将创建一个新属性
		box.setAttribute("type", "circle");
// ----------------------------------------------------------------------------------------
		// 遍历节点树
		// 访问选定元素节点下的所有子节点的列表，返回的值可以看作是一个数组，他具有length属性。该集合为即时更新的集合
        // 包含了所有的子节点，包括元素节点，文本节点等。节点之间的空白符，在firefox、chrome、opera、safari浏览器是文本节点。
        // 如果只想获得里面的元素节点，则需要专门处理，所以不提倡使用childNodes
		console.log(box.childNodes); // NodeList(13){#text(\n\t\t\t), (li+#text)*6}
		
        // parentNode.children是一个只读属性，返回所有的子元素节点。它只返回子元素节点，其余节点不返回（这个是我们重点掌握的）。虽然是一个非标准，但是得到了各个浏览器的支持，因此我们可以放心使用
		console.log(box.children); // HTMLCollection(6)
        
        // firstChild属性返回childNodes数组的第一个子节点。如果选定的节点没有子节点，则该属性返回NULL。与elementNode.childNodes[0]是同样的效果
        console.log(box.firstChild); // #text "\n\t\t\t"
		
        // lastChild属性返回childNodes数组的最后一个子节点。如果选定的节点没有子节点，则该属性返回NULL。与elementNode.childNodes[elementNode.childNodes.length-1]是同样的效果
		console.log(box.lastChild); // #text "\n\t\t"
        
         // 实际开发中，firstChild和lastChild包含其他节点，操作不方便，而firstElementChild和lastElementChild又有兼容性问题，所以我们用parentNode,children[0]和parentNode.children[parentNode.children.length-1]获得第一个和最后一个元素节点
        // parentNode.firstElementChild返回第一个元素子节点，找不到则返回null
        console.log(box.firstElementChild); // li
		
        // parentNode.lastElementChild返回最后一个元素子节点，找不到则返回null
        console.log(box.lastElementChild); // li
		
        // 获取指定节点的最近的一个父节点，父节点只能有一个，如果指定的节点没有父节点则返回null
		console.log(box.parentNode); // class="box"
		
        // 获取当前元素的下一个兄弟节点，找不到则返回null
		console.log(box.nextSibling); // #text "\n\t"
        
        // 获取当前元素的下一个兄弟元素节点，找不到则返回null
        console.log(box.nextElementSibling);
		
        // 获取当前元素的上一个兄弟节点，找不到则返回null
		console.log(box.previousSibling); // #text "\n\t\t"
        
        // 获取当前元素的上一个兄弟元素节点，找不到则返回null
        console.log(box.previousElementSibling); 
        
        // 自己封装一个兼容性的函数解决.nextElementSibling和previousElementSibling的兼容性问题
        function getNextElementSibling(element) {
            var el = element;
            while (el = el.nextSibling) {
                if (el.nodeType === 1) {
                    return el;
                }
            }
            return null;
        }  

// ----------------------------------------------------------------------------------------
		// DOM操作
		/* 		appendChild(newnode); // 将一个节点添加到指定父节点的子节点列表末尾。类似于css里面的after伪元素
				insertBefore(newnode, node); // 将一个节点添加到父节点的指定子节点前面。类似于css里面的before伪元素
				nodeObject.removeChild(node); // 从子节点列表中删除某个节点。如删除成功，此方法可返回被删除的节点，如失败，则返回NULL
				node.replaceChild(newnode, oldnew); // 实现子节点(对象)的替换。返回被替换对象的引用。注意：1.当oldnode被替换时，所有与之相关的属性内容都将被移除 2. newnode必须先被建立
				document.createElement(tagName); // 创建元素节点。此方法可返回一个Element对象。因为这个元素原先不存在，是根据我们的需求动态生成的，所以我们也称为动态创建元素节点
				document.createTextNode(data); // 创建新的文本节点，返回新创建的Text节点 */
		var newNode = document.createElement("p");
		newNode.className = "text";
		var textNode = document.createTextNode("Welcome to my page");
		newNode.appendChild(textNode);
		document.body.appendChild(newNode);


        // 一些没用过的

		insertAdjacentHTML(); //appendChild不支持追加字符串的子元素,insertAdjacentHTML支持追加字符串的元素，这个方法可以代替creadElement+innerHTML
		remove() // 可以直接删除指定的元素
		node.index
		node.click() // 手动调用点击事件，不用手动触发
		node && node.click() // callback，如果node存在再执行后续的点击操作


		window.getSelection ? window.getSelection().removeAllRanges() : document.selection.empty(); // 禁止双击
		input.select() // 让文本框里的文字处于选定状态
        
        addEventListener('click', function(){});



	</script>
</body>
```



## 事件

JavaScript使我们有能力创建动态页面，而事件是可以被JavaScript侦测到的行为。

简单理解： **触发--- 响应机制**。

网页中的每个元素都可以产生某些可以触发JavaScript的事件，例如，我们可以在用户点击某按钮时产生一个事件，然后去执行某些操作。

**事件三要素**

- 事件源：触发事件的元素
- 事件类型： 例如`click`点击事件
- 事件处理程序：事件触发后要执行的代码(函数形式)，事件处理函数

**执行事件的步骤**

- 获取事件源
- 注册事件（绑定事件）
- 添加事件处理程序（采取函数赋值形式）

## 常见的事件

```javascript
// 事件响应
onclick // 鼠标单击
onmouseover // 鼠标经过
onmouseout // 鼠标移开
onchange // 文本框内容改变
onselect // 文本框内容被选中
onfocus  // 获得鼠标焦点
onblur // 失去鼠标焦点
onmousemove // 鼠标移动
onmouseup // 鼠标弹起
onmousedown // 鼠标按下
onload // 网页导入
onunload // 关闭网页
ondblclick // 双击事件
onkeyup // 键盘按下事件 e.keyCode==13 如果用户按下回车键(ASCII码)

// 浏览器对象方法
alert() // 显示带有一段消息和一个确认按钮的警告框
prompt() // 显示可提示用户输入的对话框
confirm() // 显示带有一段消息以及确认按钮和取消按钮的对话框
open() // 打开一个新的浏览器窗口或查找一个已命名的窗口
close() // 关闭浏览器窗口
print() // 打印当前窗口的内容
focus() // 把键盘焦点给予一个窗口
blur() // 把键盘焦点从顶层窗口移开
moveBy() // 可相对窗口的当前坐标把它移动指定的像素
moveTo() // 把窗口的左上角移动到一个指定的坐标
resizeBy() // 按照指定的像素调整窗口的大小
resizeTo() // 把窗口的大小调整到指定的宽度和高度
scrollBy() // 按照指定的像素值来滚动内容
scrollTo() // 把内容滚动到指定的坐标
setInterval() // 每隔指定的时间执行代码
clearInterval() // 取消setInterval()的设置
setTimeout() // 在指定的延迟时间之后来执行代码
clearTimeout() // 取消setTimeout()的设置

// history对象（window可省略）
window.history.length // 返回浏览器历史列表中的url数量
window.history.back() // 加载history列表中的前一个url，相当于go(-1)
window.history.forward() // 加载history列表中的下一个url，相当于go(1)
window.history.go() // 加载history列表中的某个具体的页面

// location对象
location.hash
location.host
location.hostname
location.href
location.pathname
location.port
location.protocol
location.search
location.assign() // 加载新的文档
location.reload() // 重新加载当前文档
location.replace() // 用新的文档替换当前文档

// navigator对象
navigator.appCodeName
navigator.appName
navigator.appVersion
navigator.platform
navigator.userAgent

// screen对象（window可省略）
window.screen.availHeight
window.screen.availWidth
window.screen.colorDepth
window.screen.pixelDepth
window.screen.height
window.screen.width
```



# 一些DOM方法

```html
<body>
	<div class="box">
		<ul type="square">
			<li class="sbox-1">1</li>
			<li class="sbox-2">2</li>
			<li class="sbox-3">3</li>
			<li>4</li>
			<li>5</li>
			<li>6</li>
		</ul>
	</div>

	<script>
		// 获取节点，注意必须是document.
		/* 		document.getElementById();
				document.getElementsByName();
				document.getElementsByClassName(); */


		// 节点属性
		var box = document.getElementsByTagName("ul")[0];
		// 节点的名称，是只读的。元素节点的nodeName与标签名相同，属性节点的nodeName是属性的名称，文本节点的nodeName是#text，文档节点的nodeName是#document
		document.write("<p>" + box.nodeName + "</p>"); // UL
		// 节点的类型，是只读的。1-元素；2-属性；3-文本；8-注释；9-文档
		document.write("<p>" + box.nodeType + "</p>"); // 1
		// 节点的值。元素节点的nodeValue是undefined或null，属性节点的nodeValue是属性的值，文本节点的nodeValue是文本自身
		document.write("<p>" + box.nodeValue + "</p>"); // null
		// 获取/修改元素节点的属性值
		console.log(box.getAttribute("type")); // square
		// 如果不存在具有指定名称的属性，该方法将创建一个新属性
		box.setAttribute("type", "circle");

		// 遍历节点树
		// 访问选定元素节点下的所有子节点的列表，返回的值可以看作是一个数组，他具有length属性。节点之间的空白符，在firefox、chrome、opera、safari浏览器是文本节点
		console.log(box.childNodes); // NodeList(13){#text(\n\t\t\t), (li+#text)*6}
		// firstChild属性返回childNodes数组的第一个子节点。如果选定的节点没有子节点，则该属性返回NULL。与elementNode.childNodes[0]是同样的效果
		console.log(box.firstChild); // #text "\n\t\t\t"
		// lastChild属性返回childNodes数组的最后一个子节点。如果选定的节点没有子节点，则该属性返回NULL。与elementNode.childNodes[elementNode.childNodes.length-1]是同样的效果
		console.log(box.lastChild); // #text "\n\t\t"
		// 获取指定节点的父节点，父节点只能有一个
		console.log(box.parentNode); // class="box"
		// 获取前一个兄弟节点
		console.log(box.nextSibling); // #text "\n\t"
		// 获取后一个兄弟节点
		console.log(box.previousSibling); // #text "\n\t\t"

		// DOM操作
		/* 		appendChild(newnode); // 在指定节点的最后一个子节点列表之后添加一个新的子节点
				insertBefore(newnode, node); // 在已有的子节点前插入一个新的子节点
				nodeObject.removeChild(node); // 从子节点列表中删除某个节点。如删除成功，此方法可返回被删除的节点，如失败，则返回NULL
				node.replaceChild(newnode, oldnew); // 实现子节点(对象)的替换。返回被替换对象的引用。注意：1.当oldnode被替换时，所有与之相关的属性内容都将被移除 2. newnode必须先被建立
				document.createElement(tagName); // 创建元素节点。此方法可返回一个Element对象
				document.createTextNode(data); // 创建新的文本节点，返回新创建的Text节点 */
		var newNode = document.createElement("p");
		newNode.className = "text";
		var textNode = document.createTextNode("Welcome to my page");
		newNode.appendChild(textNode);
		document.body.appendChild(newNode);


        // 一些没用过的

		insertAdjacentHTML(); //appendChild不支持追加字符串的子元素,insertAdjacentHTML支持追加字符串的元素，这个方法可以代替creadElement+innerHTML
		remove() // 可以直接删除指定的元素
		node.index
		node.click() // 手动调用点击事件，不用手动触发
		node && node.click() // callback，如果node存在再执行后续的点击操作


		window.getSelection ? window.getSelection().removeAllRanges() : document.selection.empty(); // 禁止双击
		input.select() // 让文本框里的文字处于选定状态
        
        addEventListener('click', function(){});



	</script>
</body>

```



