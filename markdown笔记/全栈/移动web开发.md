# 移动web开发

## 移动端基础

### 浏览器现状

PC端常见浏览器：360浏览器、谷歌浏览器、火狐浏览器、QQ浏览器、百度浏览器、搜狗浏览器、IE浏览器

移动端常见浏览器：UC浏览器，QQ浏览器，欧朋浏览器，百度手机浏览器，360安全浏览器，谷歌浏览器，搜狗手机浏览器，猎豹浏览器，以及其他杂牌浏览器

国内的UC和QQ，百度等手机浏览器都是根据Webkit修改过来的内核，国内尚无自主研发的内核，就像国内的手机操作系统都是基于Android修改开发的一样

总结：兼容移动端主流浏览器，处理Webkit内核浏览器即可。

### 手机屏幕的现状

+ 移动端设备屏幕尺寸非常多，碎片化严重。
+ Android设备有多种分辨率：480x800, 480x854, 540x960, 720x1280，1080x1920等，还有传说中的2K，4k屏。
+ 近年来iPhone的碎片化也加剧了，其设备的主要分辨率有：640x960, 640x1136, 750x1334, 1242x2208等。
+ 作为开发者无需关注这些分辨率，因为我们常用的尺寸单位是 px 。

## 视口

视口（`viewport`）就是浏览器显示页面内容的屏幕区域。 视口可以分为布局视口、视觉视口和理想视口

### 布局视口 layout viewport

一般移动设备的浏览器都默认设置了一个布局视口，用于解决早期的PC端页面在手机上显示的问题

iOS，Android基本都将这个视口分辨率设置为 980px，所以PC上的网页大多都能在手机上呈现，只不过元素看上去很小，一般默认可以通过手动缩放网页

### 视觉视口 visual viewport

字面意思，它是用户正在看到的网站的区域。注意：是网站的区域

我们可以通过缩放去操作视觉视口，但不会影响布局视口，布局视口仍保持原来的宽度

### 理想视口 ideal viewport

为了使网站在移动端有最理想的浏览和阅读宽度而设定。理想视口，对设备来讲，是最理想的视口尺寸。需要手动添写`meta`视口标签通知浏览器操作

`meta`视口标签的主要目的：布局视口的宽度应该与理想视口的宽度一致，简单理解就是设备有多宽，我们布局的视口就多宽

### meta标签

![meta标签](C:\Users\admin\Desktop\practicing\图片笔记\前端\mobile web\meta标签.png)

最标准的viewport设置

+ 视口宽度和设备保持一致
+ 视口的默认缩放比例1.0
+ 不允许用户自行缩放
+ 最大允许的缩放比例1.0
+ 最小允许的缩放比例1.0

## 多倍图

### 物理像素&物理像素比

物理像素点指的是屏幕显示的最小颗粒，是物理真实存在的。这是厂商在出厂时就设置好了。比如苹果6是750 * 1334。我们开发时候的css 1px不是一定等于1个物理像素的。

一个px的能显示的物理像素点的个数，称为物理像素比或屏幕像素比。如果把1张100 * 100的图片放到手机里面会按照物理像素比给我们缩放（2倍图像会在移动端显示成50 * 50的页面）

lRetina（视网膜屏幕）是一种显示技术，可以将把更多的物理像素点压缩至一块屏幕里，从而达到更高的分辨率，并提高屏幕显示的细腻程度。

对于一张 50px * 50px 的图片在手机或 Retina 屏中打开，按照刚才的物理像素比会放大倍数，这样会造成图片模

在标准的viewport设置中，使用倍图来提高图片质量，解决在高清设备中的模糊问题

## 移动开发选择

### 1. 单独制作移动端页面（主流）

通常情况下，网址域名前面加`m`(mobile)可以打开移动端。通过判断设备，如果是移动设备打开，则跳到移动端页面。  

也就是说，PC端和移动端为两套网站，pc端是pc断的样式，移动端在写一套，专门针对移动端适配的一套网站

### 2. 响应式页面兼容移动端（其次）

响应式网站：即pc和移动端共用一套网站，只不过在不同屏幕下，样式会自动适配

## 移动端技术解决方案

### 1. 移动端浏览器兼容问题

移动端浏览器基本以webkit内核为主，因此我们就考虑webkit兼容性问题。我们可以放心使用 H5 标签和 CSS3 样式。同时我们浏览器的私有前缀我们只需要考虑添加 webkit 即可

### 2. 移动端公共样式

移动端 CSS 初始化推荐使用`normalize.css`

官网地址： <http://necolas.github.io/normalize.css/>

### 移动端特殊样式

**CSS3`box-size`**

移动端可以全部CSS3 盒子模型。PC端如果完全需要兼容，我们就用传统模式，如果不考虑兼容性，我们就选择 CSS3 盒子模型

```css
/*CSS3盒子模型 盒子的宽度=CSS中设置的宽度（width里面包含了border和padding）*/
box-sizing: border-box;
/*传统盒子模型 盒子的宽度=CSS中设置的width+border+padding*/
box-sizing: content-box;   

/*CSS3盒子模型*/
box-sizing: border-box;
-webkit-box-sizing: border-box;
/*点击高亮我们需要清除清除  设置为transparent 完成透明*/
-webkit-tap-highlight-color: transparent;
/*在移动端浏览器默认的外观在iOS上加上这个属性才能给按钮和输入框自定义样式*/
-webkit-appearance: none;
/*禁用长按页面时的弹出菜单*/
img,a { -webkit-touch-callout: none; }
```

## 移动端常见布局

移动端单独制作

+ 流式布局（百分比布局）
+ flex弹性布局（强烈推荐）
+ less+rem+媒体查询布局
+ 混合布局

响应式

+ 媒体查询
+ bootstarp

# 流式布局

流式布局，就是百分比布局，也称非固定像素布局。

通过盒子的宽度设置成百分比来根据屏幕的宽度来进行伸缩，不受固定像素的限制，内容向两侧填充。

流式布局方式是移动web开发使用的比较常见的布局方式。

```html
<style>
    * {
        margin: 0;
        padding: 0;
    }

    section {
        width: 100%;
        max-width: 980px; /*拉伸超过这个宽度拉伸屏幕div的大小也不会变化*/
        min-width: 320px; /*拉伸小于这个宽度拉伸屏幕div的大小也不会变化*/
        margin: 0 auto;
    }

    section div {
        float: left;
        width: 50%;
        height: 400px;
    }

    section div:nth-child(1) {
        background-color: pink;
    }

    section div:nth-child(2) {
        background-color: purple;
    }
</style>
</head>

<body>
    <section>
        <div></div>
        <div></div>
    </section>
</body>
```

# Flex布局

+ flex是flexible Box的缩写，意为"弹性布局"，用来为盒状模型提供最大的灵活性，任何一个容器都可以指定为flex布局
+ 当我们为父盒子设为flex布局以后，子元素的float（浮动）、clear（清除浮动）和vertical-align（flex会垂直居中）属性将失效
+ flex布局又叫伸缩布局 、弹性布局 、伸缩盒布局 、弹性盒布局 
+ 采用Flex布局的元素，称为 Flex 容器（flex container），简称"容器"。它的所有子元素自动成为容器成员，称为 Flex 项目（flex item），简称"项目"

**总结**：就是通过给父盒子添加flex属性，来控制子盒子的位置和排列方式

**传统布局**

+ 兼容性好
+ 布局繁琐
+ 局限性，不能再移动端很好的布局

**flex布局**

+ 操作方便，布局极其简单，移动端使用比较广泛
+ pc端浏览器支持情况比较差
+ IE11或更低版本不支持flex或仅支持部分

**建议**

+  如果是pc端页面布局，还是采用传统方式
+  如果是移动端或者是不考虑兼容的pc则采用flex

##  flex布局父项常见属性

+ `display: flex;`
+ `flex-direction`：设置主轴的方向
  + `row`：默认值从左到右
  + `row-reverse`：从右到左（对称排列）
  + `column`：从上到下
  + `column-reverse`：从下到上（对称排列）
+ `justify-content`：设置主轴上的子元素排列方式
  + **<u>注意：使用这个属性前一定要确认好主轴是哪个</u>**
  + `flex-start`：默认值，从头部开始。（如果主轴是x轴，则从左到右）
  + `flex-end`：从尾部开始排列（和`flex-direction:row-reverse`的区别是`row-reverse`会把元素翻转）
  + `center`：在主轴上居中对齐。（如果主轴是x轴，水平居中）
  + `space-around`：平分剩余空间（每个盒子的`margin-left`和`margin-right`是相等的）
  + `space-between`：先两边贴边，再平分剩余空间
+ `flex-wrap`：设置子元素是否换行（默认不换行）
  + **<u>默认情况下，项目都排在一条线（又称轴线）上，子元素的宽度会随轴线上新元素的增加</u>**
  + `nowrap`不换行
  + `wrap`换行
+ `align-content`：设置侧轴上的子元素的排列方式（多行）**<u>对应`justify-content`</u>**
  + **<u>设置子项在侧轴上的排列方式，并且只能用于子项出现换行的情况（多行），在单行下是没有效果的</u>**
  + `flex-start`：默认值，在侧轴的头部开始排列
  + `flex-end`：侧轴的尾部开始排列
  + `center`：在侧轴中间显示
  + `space-around`：在侧轴平分剩余空间
  + `space-between`：在侧轴先两边贴边，再平分剩余空间
  + `stretch`：设置子项元素高度平分父元素高度
+ `align-items`：设置侧轴上的子元素排列方式（单行）
  + **<u>该属性是控制子项在侧轴（默认是y轴）上的排列方式，在子项为单项（单行）的时候使用</u>**
  + `flex-start`：从头部开始
  + `flex-end`：从尾部开始
  + `center`：居中显示
  + `stretch`：拉伸
+ `flex-flow`：复合属性，相当于同时设置了 flex-direction 和 flex-wrap
  + `flex-flow: row wrap;`

***

### flex-direction设置主轴的方向

+ 在flex布局中，是分为主轴和侧轴两个方向，同样的叫法有 ：行和列、x轴和y轴
+ 默认主轴方向就是x轴方向，水平向右
+ 默认侧轴方向就是y轴方向，水平向下

![](..\图片笔记\前端\mobile web\设置主轴的方向.jpg)

注意：主轴和侧轴是会变化的，就看flex-direction设置谁为主轴，剩下的就是侧轴。而我们的子元素是跟着主轴来排列的

##  flex布局子项常见属性

+ 注意父元素要写`displ`
+ `flex`子项目占的份数
  + 可以是相对父元素的百分比
  + `flex:20%;`表示一行5个元素

+ `align-self`控制子项自己在侧轴的排列方式
+ `order`属性定义子项的排列顺序（前后顺序）

### flex 属性

flex 属性定义子项目分配剩余空间，用flex来表示占多少份数

```css
/* 案例：两侧div是固定宽度，中间的div宽度自适应 */
section {
    display: flex;
    width: 60%;
    height: 150px;
    background-color: pink;
    margin: 0 auto;
}

section div:nth-child(1) {
    width: 100px;
    height: 150px;
    background-color: red;
}

section div:nth-child(2) {
    flex: 1;
    background-color: green;
}

section div:nth-child(3) {
    width: 100px;
    height: 150px;
    background-color: blue;
}
/* 案例：第二个span的宽度是其他span的两倍，调整窗口时宽度自适应 */
p {
    display: flex;
    width: 60%;
    height: 150px;
    background-color: pink;
    margin: 100px auto;
}

p span {
    flex: 1;
}

p span:nth-child(2) {
    flex: 2;
    background-color: purple;
}
```

### align-self控制子项自己在侧轴上的排列方式

`align-self`属性允许单个项目有与其他项目不一样的对齐方式，可覆盖`align-item`属性

默认值为`auto`，表示继承父元素的`align-items`属性，如果没有父元素，则等同于`stretch`

```css
span:nth-child(2) {
      /* 设置第二个span在侧轴的排列方式为flex-end */
      align-self: flex-end;
}
```

### order属性定义项目的排列顺序

数值越小，排列越靠前，默认为0。

注意：和 z-index 不一样。

```css
div span:nth-child(2) {
    /* 设置第二个span在第一个。默认是0，-1比0小所以在前面 */
    order: -1;
}
```

# rem布局

rem (root em)是一个相对单位，类似于em，em是父元素字体大小。不同的是rem的基准是相对于html元素的字体大小。比如，根元素（html）设置`font-size=12px;`非根元素设置`width:2rem;`则换成`px`表示就是`24px`

rem的优势：父元素文字大小可能不一致， 但是整个页面只有一个html，可以很好来控制整个页面的元素大小

## `@media`媒体查询

媒体查询（Media Query）是CSS3新语法。

+ 使用 @media查询，可以针对不同的媒体类型定义不同的样式
+ @media 可以针对不同的屏幕尺寸设置不同的样式
+ 当你重置浏览器大小的过程中，页面也会根据浏览器的宽度和高度重新渲染页面 
+ 目前针对很多苹果手机、Android手机，平板等设备都用得到多媒体查询

**媒体查询语法规范**

+ 用 `@media`开头。注意`@`符号
+ `mediatype`媒体类型
  + `all`：用于所有设备
  + `print`：用于打印机和打印预览
  + `screen`：用于电脑屏幕，平板电脑，智能手机等

+ 关键字
  + `and`：可以将多个媒体特性连接到一起，相当于“且”的意思
  + `not`：排除某个媒体类型，相当于“非”的意思，可以省略
  + `only`：指定某个特定的媒体类型，可以省略

+ `media feature`媒体特性必须有小括号包含。单位不能省略
  + `width`：定义输出设备中页面可见区域的宽度
  + `min-witdh`：定义输出设备中页面最小可见区域的宽度
  + `max-width`：定义输出设备中页面最大可见区域的宽度


```css
@media mediatype and|not|only (media feature) {
    CSS-Code;
}
/* 大于等于320的页面 */
@media screen and (min-width: 320px) {
    html {
        font-size: 50px;
    }
}
/* 大于等于640的页面 */
@media screen and (min-width: 640px) {
    html {
        font-size: 100px;
    }
}

.top {
    height: 1rem;
    font-size: .5rem;
    background-color: green;
    color: #fff;
    text-align: center;
    line-height: 1rem;
}
/* 通过引用资源的方法写 */
/* 引入资源就是针对于不同的屏幕尺寸调用不同的css文件 */
<link rel="stylesheet" href="style320.css" media="screen and (min-width: 320px)">
<link rel="stylesheet" href="style640.css" media="screen and (min-width: 640px)">
```

注意： 为了防止混乱，媒体查询我们要按照从小到大或者从大到小的顺序来写，但是我们最喜欢的还是**从小到大**来写，这样通过后面的样式覆盖，代码更简洁

![](..\图片笔记\前端\mobile web\媒体标签.png)

## rem适配方案

让一些不能等比自适应的元素，达到当设备尺寸发生改变的时候，等比例适配当前设备。使用媒体查询根据不同设备按比例设置html的字体大小，然后页面元素使用rem做尺寸单位，当html字体大小变化元素尺寸也会发生变化，从而达到等比缩放的适配

技术方案：

1. less+rem+媒体查询
   - 假设设计稿是750px，我们把整个屏幕划分为15等份，每一份就是50px；在320px设备的时候，每一份320 / 15=21.33px。
2. flexible.js+rem
   - 手机淘宝团队出的简洁高效移动端适配库。它的原理是把当前设备划分为10等份，但是不同设备下，比例还是一致的。我们要做的，就是确定好我们当前设备的html文字大小就可以了。比如当前设计稿是750px， 那么我们只需要把html文字大小设置为75px(750px / 10) 就可以

### 响应式布局

响应式开发原理就是使用媒体查询针对不同宽度的设备进行布局和样式的设置，从而适配不同设备的目的

响应式需要一个父级做为布局容器，来配合子级元素来实现变化效果。原理就是在不同屏幕下，通过媒体查询来改变这个布局容器的大小，再改变里面子元素的排列方式和大小，从而实现不同屏幕下，看到不同的页面布局和样式变化。

父容器版心的尺寸划分

+ 超小屏幕（手机，小于 768px）：设置宽度为 100%
+ 小屏幕（平板，大于等于 768px）：设置宽度为 750px
+ 中等屏幕（桌面显示器，大于等于 992px）：宽度设置为 970px
+ 大屏幕（大桌面显示器，大于等于 1200px）：宽度设置为 1170px 

# bootstrap

Bootstrap来自Twitter（推特），是目前最受欢迎的前端框架。Bootstrap是基于HTML、CSS和JAVASCRIPT的，它简洁灵活，使得Web开发更加快捷

bootstrap优点

- 标准化的html+css编码规范
- 提供了一套简洁、直观、强悍的组件
- 有自己的生态圈，不断的更新迭代
- 让开发更简单，提高了开发的效率

使用bootstrap的样式库

1. 在官网上下载bootstrap的源码
2. 在html中引入`<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">`
3. 在官网上查找bootstrap定义好的样式，修改时可以利用权重覆盖

## bootstrap布局容器

Bootstrap需要为页面内容和栅格系统包裹一个`.container`或者`.container-fluid`容器，它提供了两个作此用处的类

`.container`

+ 响应式布局的容器 ，固定宽度
+ 大屏 ( >=1200px)-宽度定为 1170px
+ 中屏 ( >=992px)-宽度定为  970px
+ 小屏 ( >=768px)-宽度定为  750px
+ 超小屏  (100%) 

`.container-fluid`

+ 流式布局容器，百分百宽度
+ 占据全部视口（viewport）的容器

## bootstrap栅格系统

Bootstrap提供了一套响应式、移动设备优先的流式栅格系统，随着屏幕或视口（viewport）尺寸的增加，系统会自动分为最多Bootstrap提供了一套响应式、移动设备优先的流式栅格系统，随着屏幕或视口（viewport）尺寸的增加，系统会自动分为最多**12**列

栅格系统用于通过一系列的行（row）与列（column）的组合来创建页面布局，你的内容就可以放入这些创建好的布局中。

+ 按照不同屏幕划分为**1~12等份**
+ 行（row） 可以去除父容器`.container`作用15px的padding。必须先写行再写列。行必须放到`.container`布局容器里面
  + 我们实现列的平均划分，需要给列添加类前缀：`col-xs-`：extra small超小； `col-sm-`：small小；  `col-md-`：medium中等； `col-lg-`：large大
  + 如果一行中列的总份数相加等于12，则这一行能占满整个`.container`的宽度
  + 如果一行中列的总份数相加小于12，则不能占满的地方会留空白
  + 如果一行中列的总份数相加大于12，不能占满的那一列会另起一行
+ 每一列默认有左右15像素的padding
+ 可以同时为一列指定多个设备的类名，以便划分不同份数  例如`class="col-md-4 col-sm-6"`表示在小屏幕占6分在中等屏幕占4分

![](..\图片笔记\前端\mobile web\bootstrap栅格系统类前缀.png)

- 列嵌套：列嵌套加行包裹，这样可以取消父元素的padding值而且高度自动和父级一样高

### 列偏移

使用`.col-md-offset-*`类可以将列向右侧偏移。注意偏移的份数和其他列的份数和为12。本质上是给每个盒子加了margin值。

### 列排序

通过使用`.col-md-push-*`和`.col-md-pull-*`类就可以很容易的改变列（column）的顺序

### 响应式工具

为了加快对移动设备友好的页面开发工作，利用媒体查询功能，并使用这些工具类可以方便的针对不同设备展示或隐藏页面内容

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <!-- 适配低版本IE -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <!-- 一定不要忘记引入bootstrap 的样式文件 -->
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <title>Document</title>
    <style>
        [class^="col"] {
            border: 1px solid #ccc;
        }

        .row:nth-child(1) {
            background-color: pink;
        }

        .row:nth-child(2) .row {
            background-color: green;
        }

        .row:last-child {
            background-color: purple;
        }
    </style>
</head>

<body>
    <div class="container">
        <div class="row">
            <!-- 适配不同大小的屏幕 -->
            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12">1</div>
            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12">2</div>
            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12">3</div>
            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12">4</div>
        </div>

        <!-- 如果一行中列的总份数相加等于12，则这一行能占满整个.container的宽度 -->
        <!-- 列嵌套：列嵌套加行包裹，这样可以取消父元素的padding值而且高度自动和父级一样高 -->
        <div class="row">
            <div class="col-lg-6">
                <div class="row">
                    <div class="col-lg-4">a</div>
                    <div class="col-lg-4">b</div>
                    <div class="col-lg-4">c</div>
                </div>
            </div>
            <div class="col-lg-2">2</div>
            <div class="col-lg-2">3</div>
            <div class="col-lg-2">4</div>
        </div>

        <!-- 列偏移 -->
        <div class="row">
            <div class="col-lg-2">a</div>
            <div class="col-lg-2 col-lg-offset-3">b</div>
            <div class="col-lg-2 col-lg-offset-3">c</div>
        </div>

        <!-- 如果一行中列的总份数相加小于12，则不能占满的地方会留空白 -->
        <!-- 列排序 -->
        <div class="row">
            <div class="col-lg-6">1</div>
            <div class="col-lg-2">2</div>
            <div class="col-lg-2 col-lg-push-2">3</div>
            <div class="col-lg-1 col-lg-pull-2">4</div>
        </div>

        <!-- 如果一行中列的总份数相加大于12，不能占满的那一列会另起一行 -->
        <!-- 隐藏页面内容 -->
        <div class="row">
            <div class="col-lg-6">1</div>
            <div class="col-lg-2 hidden-sm">小屏幕会消失，超小屏幕会出现</div>
            <div class="col-lg-2 hidden-sm">小屏幕会消失，超小屏幕会出现</div>
            <div class="col-lg-3 visible-lg">只在大屏幕显示</div>
        </div>


    </div>
</body>

</html>
```



# Less

**CSS的弊端**

CSS是一门非程序式语言，没有变量、函数、SCOPE（作用域）等概念

+ CSS需要书写大量看似没有逻辑的代码，CSS冗余度是比较高的
+ 不方便维护及扩展，不利于复用
+ CSS没有很好的计算能力
+ 非前端开发工程师来讲，往往会因为缺少CSS编写经验而很难写出组织良好且易于维护的CSS代码项目

**Less介绍**

Less（Leaner Style Sheets的缩写）是一门CSS扩展语言，也称为CSS预处理器

做为CSS的一种形式的扩展，它并没有减少CSS的功能，而是在现有的CSS语法上，为CSS加入程序式语言的特性

它在CSS 的语法基础之上，引入了变量，Mixin（混入），运算以及函数等功能，大大简化了 CSS 的编写，并且降低了 CSS的维护成本，就像它的名称所说的那样，Less可以让我们用更少的代码做更多的事情

常见的CSS预处理器：Sass、Less、Stylus

**Less安装**

安装：`npm install -g less`

查看版本：`lessc -v`

## Less的使用

可以安装VS Code插件Easy LESS，保存后会自动生成.css文件

```less
// 错误的变量名 @1color @color~@#
// 变量名区分大小写 @color 和 @Color 是两个不同的变量
// 定义一个粉色的变量
@color: pink;  
// 定义了一个字体为14像素的变量
@font14: 14px;

// less嵌套：子元素的样式直接写到父元素里面，如果有伪类、交集选择器、伪元素选择器，我们内层选择器的前面需要加 &
.nav {
    .logo {
        color: green;
    }
    &::before {
        content: "";
    }
}

// less运算
// 1. 运算符的左右两侧必须敲一个空格隔开
// 2. 两个数参与运算，如果只有一个数有单位，则最后的结果就以这个单位为准
// 3. 两个数参与运算，如果两个数都有单位，而且不一样的单位，最后的结果以第一个单位为准
@baseFont: 50px;
@border: 5px + 5;
div {
    width: 200px - 50;
    height: (200px + 50px ) * 2;
    border: @border solid red;
    background-color: #666 - #222; // #444
}
img {
    width: 82rem / @baseFont;
    height: 82rem / @baseFont; // 结果为 (82/50)rem
}

```

