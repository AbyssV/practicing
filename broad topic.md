# 解决问题

1. 阅读官方文档。学习新技术，要看他的官方文档，最佳实践
2. 查询github或提交issue
   1. 提交issue，一般是bug fix或feature request，要说清楚问题和环境，并给出code example
   2. 如果功能可以自己解决，可以发起pull request

3. google
4. chatgpt



# 工程文件命名

在大型工程项目中，标准的文件夹命名有助于维护项目的组织和清晰度。以下是一些常见的文件夹命名及其用途：

1. **src (Source)**
   - 包含项目的源代码。
   - 这是开发者直接工作的主要目录。
2. **dist (Distribution)**
   - 存放经过编译、构建或压缩后的代码，用于部署或发布。
   - 包含最终可交付或可执行的项目版本。
3. **lib (Library)**
   - 存放项目依赖的第三方库或自定义库。
4. **bin (Binary)**
   - 包含编译后的二进制文件，如可执行文件。
5. **test**
   - 存放项目的测试代码，包括单元测试、集成测试等。
6. **docs (Documentation)**
   - 包含项目文档，如 API 文档、用户手册等。
7. **assets**
   - 用于存储静态资源，如图片、样式表、脚本文件等。
8. **config (Configuration)**
   - 存放配置文件，如数据库配置、环境变量等。
9. **build**
   - 用于存储构建脚本和与构建过程相关的文件。
10. **vendor**
    - 存放未通过包管理器安装的第三方代码。
11. **public**
    - 存放对外部可见的文件，如 HTML、CSS、客户端 JavaScript。
12. **logs**
    - 存放日志文件。

这些命名惯例有助于团队成员快速理解项目结构，并有效地协作。不过，根据不同的项目类型和技术栈，具体的目录结构和命名可能会有所变化。



# github action

GitHub Actions 是 GitHub 提供的一个自动化平台，允许用户在 GitHub 仓库中自动执行软件开发工作流程。通过 GitHub Actions，你可以自动化、定制和执行你的软件开发工作流程，直接在你的 GitHub 仓库中。

GitHub Actions 的主要用途包括：

1. **持续集成 (CI)**:
   - 自动执行代码构建、测试，确保代码更改不会破坏现有功能。
   - 在每次提交或拉取请求时触发，以保持代码质量。
2. **持续部署 (CD)**:
   - 自动化部署过程，将代码更改部署到生产环境或其他阶段环境（如开发、测试环境）。
   - 确保快速、一致的部署流程。
3. **自动化脚本执行**:
   - 自动执行脚本，如数据库迁移、脚本测试、依赖性安装等。
4. **自动响应仓库事件**:
   - 对于 GitHub 仓库中的特定事件（如推送、合并请求、发布、Issue 和评论等）自动执行动作。
5. **构建工件**:
   - 自动构建和上传二进制文件或其他工件，供后续使用或发布。
6. **通知和报告**:
   - 在工作流程的某个阶段发送通知，例如构建失败、测试覆盖率变化等。

GitHub Actions 的特点是高度定制化和灵活性，它允许开发者编写自定义工作流程文件（通常是 YAML 格式），定义运行环境、需要执行的命令和步骤。此外，GitHub 提供了市场（GitHub Marketplace），在其中可以找到大量现成的 Actions，以实现常见任务和集成。





# 一些概念

## 钩子 (Hooks)

- **定义**：钩子是一种特定的回调机制，允许用户在特定的时刻或事件发生时插入或修改代码的执行。它们是预先定义的函数或方法，可以由开发者扩展或重写以执行特定的任务。
- **用途**：钩子常用于插件架构，允许第三方开发者插入自己的代码，而不需要修改主程序。例如，版本控制系统如 Git 提供了 pre-commit、post-commit 等钩子，允许在提交之前或之后运行特定的脚本。
- **示例**：在许多 web 框架中，当请求到达或响应被发送时，可以定义钩子来执行任务，如日志记录、数据验证或其他任何操作。

## 脚手架 (Scaffolding)

- **定义**：脚手架是一种代码生成工具，用于快速创建项目的基本结构。它提供了一个基本的框架，开发者可以基于此框架进行进一步的开发和定制。
- **用途**：脚手架帮助开发者快速启动新项目，确保项目结构的一致性和最佳实践。它可以生成目录结构、基本的文件和代码模板。
- **示例**：许多 web 开发框架提供脚手架工具。例如，Ruby on Rails 的 `rails generate` 命令可以生成 MVC 结构的基本组件；Angular CLI 提供了 `ng generate` 命令来快速生成组件、服务和其他项目结构。

## IDE相关

### IDE

 an integrated development environment - a suped-up text editor with additional support for developing (such as forms designers, resource editors, etc), compiling and debugging applications. e.g Eclipse, Visual Studio.

### Library

a chunk of code that you can call from your own code, to help you do things more quickly/easily. For example, a Bitmap Processing library will provide facilities for loading and manipulating bitmap images, saving you having to write all that code for yourself. Typically a library will only offer one area of functionality (processing images or operating on zip files)

### API(application programming interface) 

a term meaning the functions/methods in a library that you can call to ask it to do things for you - the interface to the library.

### SDK(software development kit)

a library or group of libraries (often with extra tool applications, data files and sample code) that aid you in developing code that uses a particular system (e.g. extension code for using features of an operating system (Windows SDK), drawing 3D graphics via a particular system (DirectX SDK), writing add-ins to extend other applications (Office SDK), or writing code to make a device like an Arduino or a mobile phone do what you want). An SDK will still usually have a single focus.

### toolkit

is like an SDK - it's a group of tools (and often code libraries) that you can use to make it easier to access a device or system... Though perhaps with more focus on providing tools and applications than on just code libraries.

### framework

a big library or group of libraries that provides many services (rather than perhaps only one focussed ability as most libraries/SDKs do). For example, .NET provides an application framework - it makes it easier to use most (if not all) of the disparate services you need (e.g. Windows, graphics, printing, communications, etc) to write a vast range of applications - so one "library" provides support for pretty much everything you need to do. Often a framework supplies a complete base on which you build your own code, rather than you building an application that consumes library code to do parts of its work.

There are of course many examples in the wild that won't exactly match these descriptions though.