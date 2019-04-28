[TOC]



# To run Java program using command line on windows

```C:\Desktop> set path=%path%;C:\Program Files\Java\jdk1.5.0_09\bin```

This tells the system where to find JDK programs.

```C:\Desktop> javac Hello.java```

This runs javac.exe, the compiler. You should see nothing but the next system prompt...

javac has created the **Hello.class** file. You should see Hello.java and Hello.class among the files.

```C:\Desktop> java Hello```

This runs the Java interpreter. You should then see your program output.

In case your Java class is in some package. Suppose your Java class named ABC.java is present in com.hello.programs, then you need to run it with the package name 

```java com.hello.programs.ABC```

Java is case-sensitive!

## Creation of an executable *.jar file

You've got two options here 

1. With an external manifest file :
   - Create the manifest file say - MANIFEST.mf
   - The MANIFEST file is nothing but an explicit entry of the Main Class
   - ```jar -cvfm TheJavaFile.jar MANIFEST.mf TheJavaFile.class```
2. Executable by Entry Point:
   - ```jar -cvfe TheJavaFile.jar <MainClass> TheJavaFile.class```

To run the Jar File: ```java -jar TheJavaFile.jar```



# what is JVM(Java Virtual Machine)?

The JVM has two primary functions: to allow Java programs to run on any device or operating system (known as the "Write once, run anywhere" principle), and to manage and optimize program memory. When Java was released in 1995, all computer programs were written to a specific operating system, and program memory was managed by the software developer. So the JVM was a revelation.

Let's break those down:

- Technical definition: The JVM is the specification for a software program that executes code and provides the runtime environment for that code.
- Everyday definition: The JVM is how we run our Java programs. We configure the JVM's settings and then rely on it to manage program resources during execution.

> The JVM is widely deployed, heavily used, and maintained by some very bright programmers, both corporate and open source. The OpenJDK project is the offspring of the Sun Microsystems decision to open-source Java. OpenJDK has continued through Oracle's stewardship of Java, with much of the heavy lifting these days done by Oracle engineers.

> **The JVM as a virtual machine**
> The JVM is a virtual machine that runs Java class files in a portable way. Being a virtual machine means the JVM is an abstraction of an underlying, actual machine--such as the server that your program is running on. Regardless of what operating system or hardware is actually present, the JVM creates a predictable environment for programs to run within. Unlike a true virtual machine, however, *the JVM doesn't create a virtual operating system*. It would be more accurate to describe the JVM as a *managed runtime environment*, or a process virtual machine.

## Memory management in the JVM

The most common interaction with a running JVM is to check the memory usage in the **heap** and **stack**. The most common adjustment is tuning the JVM's memory settings.

### Garbage collection

Before Java, all program memory was managed by the programmer. In Java, program memory is managed by the JVM. The JVM manages memory through a process called garbage collection, which continuously identifies and eliminates unused memory in Java programs. Garbage collection happens inside a running JVM.

In the early days, Java came under a lot of criticism for not being as "close to the metal" as C++, and therefore not as fast. The garbage collection process was especially controversial. Since then, a variety of algorithms and approaches have been proposed and used for garbage collection. With consistent development and optimization, garbage collection has vastly improved.

> **What does 'close to the metal' mean?**
> When programmers say a programming language or platform is "close to the metal," we mean the developer is able to programmatically (by writing code) manage an operating system's memory. In theory, programmers can wring more performance out of our programs by stipulating how much is used and when to discard it. In most cases, delegating memory management to a highly refined process like the JVM yields better performance and fewer errors than doing it yourself.

## Loading and executing class files in the JVM

We've talked about the JVM's role in running Java applications, but how does it perform its function? In order to run Java applications, the JVM depends on the **Java class loader** and a **Java execution engine**.

### The Java class loader in the JVM

**Everything in Java is a class, and all Java applications are built from classes.** An application could consist of one class or thousands. In order to run a Java application, a JVM must load compiled .class files into a context, such as a server, where they can be accessed. A JVM depends on its class loader to perform this function.

The Java class loader is the part of the JVM that loads classes into memory and makes them available for execution. Class loaders use techniques like lazy-loading and caching to make class loading as efficient as it can be. That said, class loading isn't the epic brain-teaser that (say) portable runtime memory management is, so the techniques are comparatively simple.

Every Java virtual machine includes a class loader. The JVM spec describes standard methods for querying and manipulating the class loader at runtime, but JVM implementations are responsible for fulfilling these capabilities. From the developer's perspective, the underlying class loader mechanisms are typically a black box.

### The execution engine in the JVM

Once the class loader has done its work of loading classes, the JVM begins executing the code in each class. The execution engine is the JVM component that handles this function. The execution engine is essential to the running JVM. In fact, for all practical purposes, it is the JVM instance.

*Executing code involves managing access to system resources. The JVM execution engine stands between the running program--with its demands for file, network and memory resources--and the operating system, which supplies those resources.*

##### How the execution engine manages system resources

System resources can be divided into two broad categories: memory and everything else.

Recall that the JVM is responsible for disposing of unused memory, and that garbage collection is the mechanism that does that disposal. The JVM is also responsible for allocating and maintaining the referential structure that the developer takes for granted. **As an example, the JVM's execution engine is responsible for taking something like the new keyword in Java, and turning it into an OS-specific request for memory allocation.**

Beyond memory, the execution engine manages resources for file system access and network I/O. Since the JVM is interoperable across operating systems, this is no mean task. In addition to each application's resource needs, the execution engine must be responsive to each OS environment. That is how the JVM is able to handle in-the-wild demands.

### Wikipedia

Having a specification ensures interoperability of Java programs across different implementations so that program authors using the Java Development Kit (JDK) need not worry about idiosyncrasies of the underlying hardware platform.

### Class loader

The class loader performs three basic activities in this strict order:

1. Loading: finds and imports the binary data for a type
2. Linking: performs verification, preparation, and (optionally) resolution
   - Verification: ensures the correctness of the imported type
   - Preparation: allocates memory for class variables and initializing the memory to default values
   - Resolution: transforms symbolic references from the type into direct references.
3. Initialization: invokes Java code that initializes class variables to their proper starting values.

In general, there are two types of class loader: bootstrap class loader and user defined class loader.

Every Java virtual machine implementation must have a bootstrap class loader, capable of loading trusted classes. The Java virtual machine specification doesn't specify how a class loader should locate classes.

### JVM languages

A JVM language is any language with functionality that can be expressed in terms of a valid class file which can be hosted by the Java Virtual Machine. A class file contains Java Virtual Machine instructions (Java byte code) and a symbol table, as well as other ancillary information. The class file format is the hardware- and operating system-independent binary format used to represent compiled classes and interfaces.

There are several JVM languages, both old languages ported to JVM and completely new languages. JRuby and Jython are perhaps the most well-known ports of existing languages, i.e. Ruby and Python respectively. Of the new languages that have been created from scratch to compile to Java bytecode, Clojure, Apache Groovy, Scala and Kotlin may be the most popular ones. A notable feature with the JVM languages is that they are compatible with each other, so that, for example, Scala libraries can be used with Java programs and vice versa.

Java 7 JVM implements JSR 292: Supporting Dynamically Typed Languages on the Java Platform, a new feature which supports dynamically typed languages in the JVM. This feature is developed within the Da Vinci Machine project whose mission is to extend the JVM so that it supports languages other than Java.

**More details check [How JVM Works – JVM Architecture?](https://www.geeksforgeeks.org/jvm-works-jvm-architecture/), [Differences between JDK, JRE and JVM](https://www.geeksforgeeks.org/differences-jdk-jre-jvm/)**

# Maven

## From Google

### What it does

Maven is a "build management tool", it is for defining how your ```.java``` files get compiled to ```.class```, packaged into ```.jar``` (or ```.war``` or ```.ear```) files, (pre/post)processed with tools, managing your **CLASSPATH**, and all others sorts of tasks that are required to build your project. It is similar to *Apache Ant* or *Gradle* or *Makefiles* in C/C++, but it attempts to be completely self-contained in it that you shouldn't need any additional tools or scripts by incorporating other common tasks like downloading & installing necessary libraries etc.

It is also designed around the "build portability" theme, so that you don't get issues as having the same code with the same buildscript working on one computer but not on another one (this is a known issue, we have VMs of Windows 98 machines since we couldn't get some of our Delphi applications compiling anywhere else). *Because of this, it is also the best way to work on a project between people who use different IDEs* since IDE-generated Ant scripts are hard to import into other IDEs, but all IDEs nowadays understand and support Maven (IntelliJ, Eclipse, and NetBeans). Even if you don't end up liking Maven, it ends up being the point of reference for all other modern builds tools.

### Why you should use it

There are three things about Maven that are very nice.

1. Maven will (after you declare which ones you are using) download all the libraries that you use and the libraries that they use for you automatically. This is very nice, and makes dealing with lots of libraries ridiculously easy. This lets you avoid "dependency hell". It is similar to Apache Ant's Ivy.

2. It uses "Convention over Configuration" so that by default you don't need to define the tasks you want to do. You don't need to write a "compile", "test", "package", or "clean" step like you would have to do in Ant or a Makefile. Just put the files in the places in which Maven expects them and it should work off of the bat.

3. Maven also has lots of nice plug-ins that you can install that will handle many routine tasks from generating Java classes from an XSD schema using JAXB to measuring test coverage with Cobertura. Just add them to your ```pom.xml``` and they will integrate with everything else you want to do.

The initial learning curve is steep, but (nearly) every professional Java developer uses Maven or wishes they did. You should use Maven on every project although don't be surprised if it takes you a while to get used to it and that sometimes you wish you could just do things manually, since learning something new sometimes hurts. However, once you truly get used to Maven you will find that build management takes almost no time at all.

### How to Start

The best place to start is [Maven in 5 Minutes](http://maven.apache.org/guides/getting-started/maven-in-five-minutes.html). It will get you start with a project ready for you to code in with all the necessary files and folders set-up (yes, I recommend using the quickstart archetype, at least at first).

After you get started you'll want a better understanding over how the tool is intended to be used. For that [Better Builds with Maven](https://web.archive.org/web/20130903151814/http://www.maestrodev.com/wp-content/uploads/2012/03/betterbuildswithmaven-2008.pdf) is the most thorough place to understand the guts of how it works, however, [Maven: The Complete Reference](https://www.sonatype.com/ebooks) is more up-to-date. Read the first one for understanding, but then use the second one for reference.

## 来自百度

c/c++软件自动编译有makefile,
程序源码管理有cvs,subverion,
linux应用程序管理yum,yast(它们自动管理程序版本和依赖)
windows程序管理有360软件管理
java源码编译有ant，
那么java项目工程里在有没有jar包管理和源码管理，程序编译三合一的优秀工具？
它就是伟大的maven！！！!
随着近两年Maven在国内的普及,越来越多的公司与项目开始接受并使用其作为项目构建与依赖管理工具,
Java开发人员用Maven来管理和维护java软件项目就越来越方便！
Apache Maven是一个基于java的apache ant的构建工具的替代者。
Maven这个单词来自于意第绪语，意为知识的积累，
最早在Jakata Turbine项目中它开始被用来试图简化构建过程。
当时有很多项目，它们的Ant build文件仅有细微的差别，而JAR文件都由CVS来维护。
于是Maven创始者开始了Maven这个项目，该项目的清晰定义包括，
一种很方便的发布项目信息的方式，以及一种在多个项目中共享JAR的方式。
作为Apache组织中的一个颇为成功的开源项目，Maven主要服务于基于Java平 台的项目构建、依赖管理和项目信息管理。
无论是小型的开源类库项目，还是大型的企业级应用；无论是传统的瀑布式开发，还是流行的敏捷模式，Maven都能大显身手。

我们知道，开发java系统，下载一堆jar包依赖是很正常的事情。有了maven，你不用去各个网站下载各种版本的jar包，也不用考虑这些jar包的依赖关系。Maven会给你搞定，就是超市的配菜师傅会帮你把红烧小排的配料配齐一样。

通俗点讲，就是通过pom.xml文件的配置获取jar包，而不用手动去添加jar包，而这里pom.xml文件对于学了一点maven的人来说，就有些熟悉了，怎么通过pom.xml的配置就可以获取到jar包呢？pom.xml配置文件从何而来？等等类似问题我们需要搞清楚，如果需要使用pom.xml来获取jar包，那么首先该项目就必须为maven项目，maven项目可以这样去想，就是在java项目和web项目的上面包裹了一层maven，本质上java项目还是java项目，web项目还是web项目，但是包裹了maven之后，就可以使用maven提供的一些功能了(通过pom.xml添加jar包)。