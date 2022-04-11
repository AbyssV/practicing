# React介绍

+ React是一个用于构建用户界面（UI，对咱们前端来说，简单理解为：HTML页面）的JavaScript库  
+ 如果从mvc的角度来看，React仅仅是视图层（V）的解决方案。也就是只负责视图的渲染，并非提供了完整了M和C的功能
+ react/react-dom/react-router/redux：框架
+ React起源于Facebook内部项目（News Feed，2011），后又用来架设Instagram的网站（2012），并于2013年5 月开源

+ React是最流行的前端开发框架之一，其他：Vue、Angular等等

## React特点

- 声明式UI - JSX
- 组件化
- 学习一次，随处使用（还有flutter）
  - 使用react/rect-dom可以开发Web应用
  - 使用react/react-native可以开发移动端原生应用（react-native）RN安卓和ios应用
  - 使用react可以开发VR（虚拟现实）应用（react360）

# React 脚手架 - CLI

- 对于前端项目开发来说，脚手架是为了保证前端项目开发过程顺利进行而搭设的开发平台
- 脚手架的意义：
  - 现代的前端开发日趋成熟，需要依赖于各种工具，比如webpack、babel、eslint、sass/less/postcss等
  - 工具配置繁琐、重复，各项目之间的配置大同小异
  - 开发阶段、项目发布，配置不同
    - 项目开始前，帮你搭好架子，省去繁琐的webpack配置
    - 项目开发时，热更新、格式化代码、git提交时自动校验代码格式等
    - 项目发布时，一键自动打包，包括：代码压缩、优化、按需加载等

## 使用 React 脚手架创建项目

- 命令：`npx create-react-app react-basic`
  - `npx create-react-app`是固定命令，`create-react-app`是React脚手架的名称
  - `react-basic`表示项目名称，可以修改
- 启动项目：`yarn start` or `npm start` 
- `npx` 是npm v5.2版本新添加的命令，用来简化npm中工具包的使用
  - 原始：1 全局安装`npm i -g create-react-app` 2 在通过脚手架的命令来创建React项目
    - 更新时不方便
  - 现在：npx调用最新的create-react-app直接创建React项目
    - 直接调用最新的React版本，不用安装
    - 直接运行github gist
    - 运行特定版本

### 项目目录结构说明和调整

- **src**目录是我们写代码进行项目开发的目录、
- 查看**package.json**两个核心库：`react`、`react-dom`（脚手架已经帮我们安装好，我们直接用即可）

- 调整
  1. 删除**src**目录下的所有文件
  2. 创建**index.js**文件作为项目的入口文件，在这个文件中写React代码即可
  3. **public**目录下的**index.html**则是我们需要渲染的页面

# React的基本使用

## 简单的html渲染

```javascript
import React from 'react'
import ReactDOM from 'react-dom'

/* 
  1. 导入react和 eact-dom 
  2. 通过react的api创建react元素（虚拟DOM）
  3. 把react元素渲染到页面中 
*/
// 参数1：标签的名字 h1 p div
// 参数2：标签的属性 对象
// 参数3：标签的内容
const element = React.createElement('ul', { className: 'list' }, [
  React.createElement('li', null, '香蕉'),
  React.createElement('li', null, '橘子'),
  React.createElement('li', null, '苹果'),
])

// 参数1：渲染的react元素
// 参数2：需要渲染到哪个容器中
ReactDOM.render(element, document.getElementById('root'))
```

## 使用JSX

JSX是react的核心内容。JSX是JavaScript XML的简写，表示了在Javascript代码中写XML(HTML)格式的代码

优势：声明式语法更加直观，与HTML结构相同，降低学习成本，提高开发效率。

注意：JSX不是标准的 JS 语法，是JS的语法扩展。脚手架中内置的`@babel/plugin-transform-react-jsx`包，用来解析该语法。

在课上，教授从cdn导入online script，并在`<script>`中标注使用babel解析

**JSX注意点**

+ 只有在脚手架中才能使用jsx语法
  + 因为JSX需要经过babel的编译处理，才能在浏览器中使用。脚手架中已经默认有了这个配置。
+ JSX必须要有一个根节点，不能是平行节点，可以使用空节点或幽灵节点
  +  `<></>`  
  + `<React.Fragment></React.Fragment>`
+ JSX中语法更接近与JavaScript
  + 将`class`替换为js中的`className`
  + 将`<label for="box">are you a human</label><input type="checkbox" id="box" />`中的`for `替换为`htmlFor`
+ 不能出现单行标签，例如`<img src="" alt="">`或是`<br>`，需要改为`<img src="" alt="" />`和`<br />`
+ JSX可以换行，如果JSX有多行，推荐使用`()`包裹JSX，防止自动插入分号的bug，例如

```javascript
function render() {
  return (
    <div>
        123
    </div>
  )
}

ReactDOM.render(render(), document.getElementById('root'))
```

