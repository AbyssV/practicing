# 解决问题

1. 阅读官方文档
2. 查询github或提交issue
3. google
4. chatgpt



# 一些概念

钩子 (Hooks)

- **定义**：钩子是一种特定的回调机制，允许用户在特定的时刻或事件发生时插入或修改代码的执行。它们是预先定义的函数或方法，可以由开发者扩展或重写以执行特定的任务。
- **用途**：钩子常用于插件架构，允许第三方开发者插入自己的代码，而不需要修改主程序。例如，版本控制系统如 Git 提供了 pre-commit、post-commit 等钩子，允许在提交之前或之后运行特定的脚本。
- **示例**：在许多 web 框架中，当请求到达或响应被发送时，可以定义钩子来执行任务，如日志记录、数据验证或其他任何操作。

脚手架 (Scaffolding)
- **定义**：脚手架是一种代码生成工具，用于快速创建项目的基本结构。它提供了一个基本的框架，开发者可以基于此框架进行进一步的开发和定制。
- **用途**：脚手架帮助开发者快速启动新项目，确保项目结构的一致性和最佳实践。它可以生成目录结构、基本的文件和代码模板。
- **示例**：许多 web 开发框架提供脚手架工具。例如，Ruby on Rails 的 `rails generate` 命令可以生成 MVC 结构的基本组件；Angular CLI 提供了 `ng generate` 命令来快速生成组件、服务和其他项目结构。

IDE

 an integrated development environment - a suped-up text editor with additional support for developing (such as forms designers, resource editors, etc), compiling and debugging applications. e.g Eclipse, Visual Studio.

Library

a chunk of code that you can call from your own code, to help you do things more quickly/easily. For example, a Bitmap Processing library will provide facilities for loading and manipulating bitmap images, saving you having to write all that code for yourself. Typically a library will only offer one area of functionality (processing images or operating on zip files)

API(application programming interface) 

a term meaning the functions/methods in a library that you can call to ask it to do things for you - the interface to the library.

SDK(software development kit)

a library or group of libraries (often with extra tool applications, data files and sample code) that aid you in developing code that uses a particular system (e.g. extension code for using features of an operating system (Windows SDK), drawing 3D graphics via a particular system (DirectX SDK), writing add-ins to extend other applications (Office SDK), or writing code to make a device like an Arduino or a mobile phone do what you want). An SDK will still usually have a single focus.

toolkit

is like an SDK - it's a group of tools (and often code libraries) that you can use to make it easier to access a device or system... Though perhaps with more focus on providing tools and applications than on just code libraries.

framework

a big library or group of libraries that provides many services (rather than perhaps only one focussed ability as most libraries/SDKs do). For example, .NET provides an application framework - it makes it easier to use most (if not all) of the disparate services you need (e.g. Windows, graphics, printing, communications, etc) to write a vast range of applications - so one "library" provides support for pretty much everything you need to do. Often a framework supplies a complete base on which you build your own code, rather than you building an application that consumes library code to do parts of its work.

There are of course many examples in the wild that won't exactly match these descriptions though.