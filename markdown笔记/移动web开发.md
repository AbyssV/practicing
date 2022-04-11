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
