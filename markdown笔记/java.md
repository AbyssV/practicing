# 	JavaSE基础

## 基础类型

![](C:\Users\admin\Desktop\practicing\图片笔记\Java\数据类型.jpg)

### 类型转换

#### 自动类型转化

- 将```byte```类型抓化成```char```类型是不兼容的。

#### 强制类型转换

- typecast: ```int k = (int)88.88```，结果为```88```

- **扩展的赋值运算符(+=, -=, *=, /=, %=)隐含了强制类型转换**

- ```int```类型转化为```long```类型时，加```L```即可，如```20L```

### 运算符

```java
//在println中使用赋值语句
int i = 10;
int j = 20;
System.out.println(i=j); //20. 把j的值赋值给了i，然后输出i的值
```

- 整数相除只能得到整数，要想得到小数，必须有浮点数的参与
- ```^```：逻辑异或。
- ```!```：逻辑非
- 逻辑与```&```，无论左边真假，右边都要执行。短路与```&&```，如果左边为假，右边不执行，如果左边为真，右边执行。
- 逻辑或```|```，无论左边真假，右边都要执行。短路或```||```，如果左边为假，右边执行，如果左边为真，右边不执行。
- 三元运算符：```关系表达式 ? 表达式1 ：表达式2``` e.g ```int max = a > b ? a : b```
- 使用```==```作比较
  - 基本类型：比较的是**数据值**是否相同
  - 引用类型：比较的是**地址值**是否相同

### 字符的```+```操作

拿字符在计算机底层对应的数值来进行计算的

- '\0' null character - 0
- '\n' newline - 10

- '\r' return - 13

- '\t' tab - 9

- ' ' space - 32
- 'A' - 65
- 'a' - 97
- '0' - 48

算术表达式中包含多个基本数据类型的值的时候，整个算术表达式的类型会自动进行提升。

- 提升规则
  - ```byte```类型，```short```类型和```char```类型将被提升到```int```类型
  - 整个表达式的类型自动提升到表达式中最高等级操作数同样的类型
  - 等级顺序：byte,short,char -> int -> long -> float -> double

### 字符串的```+```操作

- 当```+```操作中出现字符串时，这个```+```是字符串连接符，而不是算术运算。
- 在```+```操作中，如果出现了字符串，就是连接运算符，否则就是算术运算。当连续进行```+```操作时，从左到右逐个执行

![](C:\Users\admin\Desktop\practicing\图片笔记\Java\String对象的特点.jpg)

## 方法

- 方法不能嵌套定义

- ```void```表示无返回值，可以省略```return```，也可以单独的书写```return```，后面不加数据

### 方法重载

- 多个方法在**同一个类**中
- 多个方法具有相同的方法名
- 多个方法的参数不相同，类型不同或者数量不同
- 重载仅针对同一个类中方法的名称与参数进行识别，与返回值无关，换句话说不能通过返回值来判定两个方式是否相互构成重载

### 方法的参数传递

- 对于**基本类型**的参数，形式参数的改变，不影响实际参数的值
- 对于**引用类型**的参数，形式参数的改变，影响实际参数的值

## 类

- 权限修饰符：```public```>默认>```protected```>```private```
- ```this```关键字
  - ```this```修饰的变量用于指代成员变量
  - 方法的形参如果与成员变量同名，不带```this```修饰的变量指的是形参，而不是成员变量
  - 方法的形参没有与成员变量同名，不带```this```修饰的变量指的是成员变量
  - 什么时候使用```this```呢？解决局部变量隐藏成员变量
  - 方法被哪个对象调用，```this```就代表哪个对象
- ```final```修饰符

  - 变量是基本类型：```final```修饰符指的是基本类型的数据值不能发生改变
  - 变量是引用类型：```final```修饰符指的是引用类型的地址值不能发生改变，但是地址里面的内容是可以发生改变的
  - 修饰类时表示最终类
- ```static```修饰符

  - 被类的所有对象共享
  - 可以通过类名调用，也可以通过对象名调用。推荐使用类名调用
  - 非静态的成员方法，能访问
    - 静态的成员变量
    - 非静态的成员变量
    - 静态的成员方法
    - 非静态的成员方法
  - 静态的成员方法，能访问
    - 静态的成员变量
    - 静态的成员方法
    - 静态成员方法只能访问静态成员

### 成员变量和局部变量的区别

| 区别           |                  成员变量                  |                    局部变量                    |
| -------------- | :----------------------------------------: | :--------------------------------------------: |
| 类中位置不同   |                 类中方法外                 |              方法内或者方法声明上              |
| 内存中位置不同 |                    heap                    |                     stack                      |
| 生命周期不同   | 随着对象的存在而存在，随着对象的消失而消失 | 随着方法的调用而存在，随着方法的调用完毕而消失 |
| 初始化值不同   |              有默认的初始化值              | 没有默认的初始化值，必须先定义，赋值，才能使用 |

### 内部类

- 内部类就是在一个类中定义一个类。
- 内部类的访问特点
  - 内部类可以直接访问外部类的成员，包括私有
  - 外部类要访问内部类的成员，必须创建对象

#### 内部类的定义格式

```java
public class Outer{
    private int num = 10;
    private class Inner{ //修饰符
        public void show(){
            System.out.println(num);
        }
        
    }
	public void method(){
        Inner i = new Inner();
        i.show();
    }
}
```

#### 成员内部类

```java
Outer o = new Outer();
o.method();
```

#### 局部内部类

- 局部内部类是在方法中定义的类，所以外界是无法直接使用，需要在方法内部创建对象并使用
- 该类可以直接访问外部类的成员，也可以访问方法内的局部变量

````java
public class Outer{
    private int num = 10;    
	public void method(){
        int num2 = 20
        class Inner{ //修饰符
        	public void show(){
            	System.out.println(num); //10
                System.out.println(num2); //20
            }
        }      
        Inner i = new Inner();
        i.show();
    }    
}
````

##### 匿名内部类

前提：存在一个类或者接口，这里的类可以是具体类也可以是抽象类

本质：是一个继承了该类或者实现了该接口的子类匿名对象

```java
public interface Inter{
    public abstract void show();
}
public class Outer{
    public void method(){
        Inter i = new Inter(){
            @Override
            public void show(){
                System.out.println("匿名内部类");
            }
        }; 
        i.show();
    }    
}
```

```java
public static void main(String[] args){
	jo.method(new Jumpping(){
        @Override
        public void jump(){
            System.out.println("猫可以跳高了")
        }
        
    })
}
```


## 抽象类

- 在Java中，一个没有方法体的方法应该定义为抽象方法，**而类中如果有抽象方法，该类必须定义为抽象类**
- 抽象类和抽象方法必须使用```abstract```关键字修饰：```public abstract class 类名{}```，```public abstract void eat();```
- 抽象类不能实例化。参照多态的方式，通过子类对象实例化。这叫抽象多态
- 抽象类的子类
  - 要么重写抽象类中的所有抽象方法
  - 要么是抽象类
- 抽象类的成员特点
  - 成员变量
    - 可以是变量
    - 也可以是常量
  - 构造方法
    - 有构造方法，但是抽象类不能实例化
    - 构造方法用于子类访问父类数据的初始化
  - 成员方法
    - 可以有抽象方法：限定子类必须完成某些动作
    - 也可以有非抽象方法：提高代码复用性
- 抽象类名作为形参和返回值
  - 方法的形参是抽象类名，其实需要的是该抽象类的子类对象
  - 方法的返回值是抽象类名，其实返回的是该抽象类的子类对象



```java
// 抽象类
public abstract class Animal{
    public abstract void eat();
    public void sleep(){...}
}
//子类
public class Cat extends Animal{
    @override
    public void eat(){...}
    
}    
public static void main(String[] args){
	Animal a = new Cat();
}
```

## 继承

- 格式：```public class 子类名 extends 父类名{}```
- 子类可以有父类的内容
- 子类还可以有自己特定的内容
- 在子类方法中访问一个变量 

  - 子类局部范围找

  - 子类成员范围找
  - 父类成员范围找
  - 如果都没有就报错（不考虑父亲的父亲）
- 通过子类对象访问一个方法

  - 子类成员范围找

  - 父类成员范围找
  - 如果都没有就报错（不考虑父亲的父亲）
- ```super```关键字的用法与```this```关键字的用法相似，```this```代表本类对象的引用，```super```代表父类存储空间的标识（可以理解为父类对象引用）。
- 子类中所有的构造方法默认都会访问父类中无参的构造方法

  - 因为子类会继承父类中的数据，可能还会使用父类的数据。所以，子类初始化之前，一定要先完成父类数据的初始化
  - 每一个子类构造方法的第一条语句默认都是：```super()``` 
- 如果父类中没有无参构造方法，只有带参构造方法，该怎么办呢？
  - 通过使用```super```关键字去显示的调用父类的带参构造方法
  - 在父类中自己提供一个无参构造方法
  - 推荐：自己给出无参构造方法

### 继承的好处和弊端

继承好处

- 提高了代码的复用性(多个类相同的成员可以放到同一个类中)

- 提高了代码的维护性(如果方法的代码需要修改，修改一处即可)

继承弊端

- 继承让类与类之间产生了关系，类的耦合性增强了，当父类发生变化时子类实现也不得不跟着变化，削弱了子类的独立性

- 什么时候使用继承？

继承体现的关系：**is a**

- 假设法：我有两个类A和B，如果他们满足A是B的一种，或者B是A的一种，就说明他们存在继承关系，这个时候就可以考虑使用继承来体现，否则就不能滥用继承

- 举例：苹果和水果，猫和动物，猫和狗

### 方法重写

- 子类中出现了和父类中一模一样的方法声明
- 当子类需要父类的功能时，而功能主体子类有自己特有内容时，可以重写父类中的方法，这样，即沿袭了父类的功能，又定义了子类特有的内容 
- ```@Override```
  - 是一个注解。帮助我们检查重写方法的方法声明的正确性
- **```private```方法不能被重写（父类私有成员子类是不能继承的）**
- 子类方法访问权限不能更低（```public```>默认>```private```）

## 多态

- 有继承/实现关系
- 有方法重写
- 有父类引用指向子类对象
- 多态中成员访问特点
  - 成员变量：编译看左边，执行看左边
  - 成员方法：编译看左边，执行看右边
  - 因为成员方法有重写，而成员变量没有
-  多态的好处：提高了程序的扩展性
  - 具体体现：定义方法的时候，使用父类型作为参数，将来在使用的时候，使用具体的子类型参与操作
- 多态的弊端：不能使用子类的特有功能、
- 多态中的转型
  - 向上转型：从子到父，父类引用指向子类对象
  - 向下转型：从父到子，父类引用转为子类对象：```Animal a = new Cat(); Cat c = (Cat)a;```

## 接口

- 接口就是一种公共的规范标准，只要符合规范标准，大家都可以通用
- Java中的接口更多的体现在对行为的抽象
- 接口用关键字```interface```修饰：```public interface 接口名{}```
- 类实现接口用```implements```表示：```public class 类名 implements 接口名{}```
- 接口不能实例化
  - 接口实例化参照多态的方式，通过实现类对象实例化，这叫接口多态
  - 多态的形式：具体类多态，抽象类多态，接口多态
  - 多态的前提，有继承或者实现关系；有方法重写；有父（类/接口）引用指向（子/实现）类对象
- 接口的实现类
  - 要么重写接口中的**所有抽象方法**(如果接口不包含默认方法)
  - 要么是抽象类
- 接口的成员特点
  - 成员变量
    - 只能是常量
    - 默认修饰符：```public static final```
  - 构造方法
    - 接口没有构造方法，因为接口主要是对行为进行抽象，是没有具体存在
    - 一个类如果没有父类，默认继承自```object```类
  - 成员方法
    - 抽象方法 默认修饰符：```public abstract```
    - 默认方法(Java8)
    - 静态方法(Java8)
    - 私有方法(Java9)
- 接口名作为形参和返回值
  - 方法的形参是接口名，其实需要的是该接口的实现类对象
  - 方法的返回值是接口名，其实返回的是该接口的实现类对象

### 接口中默认方法

接口中默认方法的定义格式：

- 格式：```public default 返回值类型 方法名(参数列表){}```

- 范例：```public default void show3(){}```

接口中默认方法的注意事项：

- 默认方法不是抽象方法，所以不强制被重写。但是可以被重写，重写的时候去掉```default```关键字

- ```public```可以省略，```default```不能省略

### 接口中静态方法

接口中静态方法的定义格式：

- 格式：```public static 返回值类型 方法名(参数列表) {}```

- 范例：```public static void show() {}```

接口中静态方法的注意事项：

- 静态方法**只能通过接口名调用**，不能通过实现类名或者对象名调用     

- ```public```可以省略，```static```不能省略 

### 接口中私有方法

Java 9中新增了带方法体的私有方法，这其实在Java 8中就埋下了伏笔：Java 8允许在接口中定义带方法体的默认方法和静态方法。这样可能就会引发一个问题：当两个默认方法或者静态方法中包含一段相同的代码实现时，程序必然考虑将这段实现代码抽取成一个共性方法，而这个共性方法是不需要让别人使用的，因此用私有给隐藏起来，这就是Java 9增加私有方法的必然性

接口中私有方法的定义格式：

- 格式1：```private 返回值类型 方法名(参数列表) {}```

- 范例1：```private void show(){}```

- 格式2：```private static 返回值类型 方法名(参数列表){}```

- 范例2：```private static void method(){}```

接口中私有方法的注意事项：

- 默认方法可以调用私有的静态方法和非静态方法 

- 静态方法只能调用私有的静态方法  

### 实现

```java
//接口
public interface Inter {
    default void show1() {
        System.out.println("show1开始执行");
        method();
        System.out.println("show1结束执行");
    }

    default void show2() {
        System.out.println("show2开始执行");
        method();
        System.out.println("show2结束执行");
    }

    private void show() {
        System.out.println("初级工程师");
        System.out.println("中级工程师");
        System.out.println("高级工程师");
    }

    static void method1() {
        System.out.println("method1开始执行");
        method();
        System.out.println("method1结束执行");
    }

    static void method2() {
        System.out.println("method2开始执行");
        method();
        System.out.println("method2结束执行");
    }

    private static void method() {
        System.out.println("初级工程师");
        System.out.println("中级工程师");
        System.out.println("高级工程师");
    }
}
//实现类
public class InterImpl implements Inter {
}
//主程序
Inter i = new InterImpl();
i.show1();
i.show2();
Inter.method1();
Inter.method2();
```



## 类和接口的关系

- 类和类的关系
  - 继承关系，只能单继承，但是可以多层继承
- 类和接口的关系
  - 实现关系，可以单实现，也可以多实现，还可以在继承一个类的同时实现多个接口
- 接口和接口的关系
  - 继承关系，可以单继承，也可以多继承

```java
public class interImp1 extends Object implements Inter1, Inter2, Inter3{}
public interface Inter3 extends Inter1, Inter2{}
```

## 抽象类和接口的区别

- 成员区别
  - 抽象类：变量，常量；有构造方法；有抽象方法，也有非抽象方法
  - 接口：常量，抽象方法
- 关系区别：同上
- 设计理念区别
  - 抽象类：对类抽象，包括属性，行为
  - 接口：对行为抽象，主要是行为
  - **抽象类是对事物的抽象（is a），而接口是对行为的抽象**

## package

- 其实就是文件夹
- 作用：对类进行分类管理
- ```C:\Desktop> set path=%path%;C:\Program Files\Java\jdk1.5.0_09\bin```设置JDK路径
- 格式：```package 包名```（多级包用```.```分开）。e.g.```package com.itheima;```。注意大小写
- 创建包
  - 手动创建包
    - 编译java文件：```javac HelloWorld.java```
    - 建立文件夹```com\itheima\```
    - 将编译生成```HelloWorld.class```文件放到```com\itheima\```下
    - 带包执行```java com.itheima.HelloWorld```
  - 自动创建包
    - 在命令行输入```javac -d . HelloWorld.java```（```.```表示当前文件夹，参考Linux）
    - 执行```java com.itheima.HelloWorld```
  - IDEA会更加方便
- 导入包：在头部```import cn.itcast.Teacher;```或在script里```cn.itcast.Teacher = new cn.itcast.Teacher();```
- 反编译：```javap Hello.class```
- 生成api文档：```javadoc```

### IDEA中的项目结构

1. 创建一个空项目
2. 创建一个空模块
3. 在模块下的```src```下创建一个包
4. 在包下新建一个类
5. 在类中编写代码
6. 在idea中执行程序

![](C:\Users\admin\Desktop\practicing\图片笔记\Java\IDEA中项目结构 (2).jpg)

### 在一个模块内导入另一个模块的包

模块的基本使用步骤

- 创建模块(按照以前的讲解方式创建模块，创建包，创建类，定义方法)
  - 为了体现模块的使用，我们创建2个模块。一个是myOne，一个是myTwo

- 在模块的```src```目录下新建一个名为```module-info.java```的描述性文件，该文件专门定义模块名，访问权限，模块依赖等信息
  - 描述性文件中使用**模块导出**和**模块依赖**来进行配置并使用

- 模块中所有未导出的包都是模块私有的，他们是不能在模块之外被访问的
  - 在myOne这个模块下的描述性文件中配置模块导出
  - 模块导出格式：```exports 包名;```

- 一个模块要访问其他的模块，必须明确指定依赖哪些模块，未明确指定依赖的模块不能访问
  - 在myTwo这个模块下的描述性文件中配置模块依赖
  - 模块依赖格式：```requires 模块名;```
  - 注意：写模块名报错，需要按下```Alt+Enter```提示，然后选择模块依赖

- 在myTwo这个模块的类中使用依赖模块下的内容

### 模块服务的使用

Java 9的模块化系统则进一步的简化了Java的服务机制。Java 9允许将服务接口定义在一个模块中，并使用```uses```语句来声明该服务接口，然后针对该服务接口提供不同的服务实现类，这些服务实现类可以分布在不同的模块中，服务实现模块则使用```provides```语句为服务接口指定实现类

服务使用者只需要面向接口编程即可

模块服务的使用步骤

- 在myOne模块下创建一个包```com.itheima_03```，在该包下提供一个接口```MyService```，接口中定义一个抽象方法```service()```

- 在```com.itheima_03```包下创建一个包```impl```，在该包下提供接口的两个实现类```Itheima```和```Czxy```

- 在myOne这个模块下的描述性文件中添加如下配置
  - 模块导出：```exports com.itheima_03;```服务提供：```provides MyService with Itheima;```指定```MyService```的服务实现类是```Itheima```

- 在myTwo这个模块下的描述性文件中添加如下配置
  - 声明服务接口：```uses MyService;```

- 在myTwo这个模块的类中使用MyService接口提供的服务
  - ServiceLoader：一种加载服务实现的工具

```java
//myOne\src\com\itheima_03\MyService.java
package com.itheima_03;
public interface MyService {
    void service();
}
//myOne\src\com\itheima_03\impl\Czxy.java
package com.itheima_03.impl;
import com.itheima_03.MyService;
public class Czxy implements MyService {
    @Override
    public void service() {
        System.out.println("上大学，来传智学院，一所不一样的大学，收获不一样的你");
    }
}
//myOne\src\com\itheima_03\impl\Itheima.java
package com.itheima_03.impl;
import com.itheima_03.MyService;
public class Itheima implements MyService {
    @Override
    public void service() {
        System.out.println("学IT，来黑马");
    }
}
//myOne\src\module-info.java
import com.itheima_03.MyService;
import com.itheima_03.impl.Czxy;
import com.itheima_03.impl.Itheima;
module myOne {
    exports com.itheima_01;
    exports com.itheima_03;
	provides MyService with Itheima;//with Czxy
}

//myTwo\src\cn\itcast\Test02.java
package cn.itcast;
import com.itheima_03.MyService;
import java.util.ServiceLoader;
public class Test02 {
    public static void main(String[] args) {
        //加载服务
        ServiceLoader<MyService> myServices = ServiceLoader.load(MyService.class);
        //遍历服务
        for(MyService my : myServices) {
            my.service();
        }
    }
}
//myTwo\src\module-info.java
import com.itheima_03.MyService;
module myTwo {
    requires myOne;
    uses MyService;
}
```



## 基本类型包装类

将基本类型封装成对象的好处在于可以在对象中定义更多的功能方法操作该数据

常用的操作之一：用于基本数据类型与字符串之间的转换

| 基本数据类型 |  包装类   |
| :----------: | :-------: |
|     byte     |   Byte    |
|    short     |   Short   |
|     int      |  Integer  |
|     long     |   Long    |
|    float     |   Float   |
|    double    |  Double   |
|     char     | Character |
|   boolean    |  Boolean  |



```java
Integer i1 = Integer.valueOf(100);
Integer i2 = Integer.valueOf("100");
String s1 = String.valueOf(100);
int x = i2.intValue();
int y = Integer.parseInt(s1);
String s2 = "this is a long story";
String[] strArray = s2.split(" ");
```

### 自动装箱和拆箱

装箱：把基本数据类型转化为对应的包装类类型

拆箱：把包装类类型转化为对应的基本数据类型

```java
Integer i = 100; //自动装箱
i+=100; //自动拆箱和自动装箱
```

## 泛型

- 泛型：是JDK5中引入的特性，它提供了编译时类型安全检测机制，该机制允许在编译时检测到非法的类型
  - 它的本质是参数化类型，也就是说所操作的数据类型被指定为一个参数
  - 一提到参数，最熟悉的就是定义方法时有形参，然后调用此方法时传递实参。那么参数化类型怎么理解呢？
  - 顾名思义，就是将类型由原来的具体的类型参数化，然后在使用/调用时传入具体的类型
    这种参数类型可以用在类、方法和接口中，分别被称为泛型类、泛型方法、泛型接口
- 泛型定义格式：
  - <类型>：指定一种类型的格式。这里的类型可以看成是形参
  - <类型1,类型2…>：指定多种类型的格式，多种类型之间用逗号隔开。这里的类型可以看成是形参
  - 将来具体调用时候给定的类型可以看成是实参，**并且实参的类型只能是引用数据类型**
- 泛型的好处：
  - 把运行时期的问题提前到了编译期间
  - 避免了强制类型转换

```java
//泛型类
public class Generic<T> {
   public void show(T t) {
       System.out.println(t);
   }
}
//泛型方法
public class Generic {
    public <T> void show(T t) {
        System.out.println(t);
    }
}
//泛型接口
public interface Generic<T> {
    void show(T t);
}
public class GenericImpl<T> implements Generic<T> {
    @Override
    public void show(T t) {
        System.out.println(t);
    }
}
```

### 类型通配符

- 为了表示各种泛型List的父类，可以使用类型通配符
  - 类型通配符：```<?>```
  - ```List<?>```：表示元素类型未知的List，它的元素可以匹配任何的类型
  - 这种带通配符的List仅表示它是各种泛型List的父类，并不能把元素添加到其中
- 如果说我们不希望```List<?>```是任何泛型List的父类，只希望它代表某一类泛型List的父类，可以使用类型通配符的上限
  - 类型通配符上限：```<? extends 类型>```
  - ```List<? extends Number>```：它表示的类型是Number或者其子类型
- 除了可以指定类型通配符的上限，我们也可以指定类型通配符的下限
  - 类型通配符下限：```<? super 类型>```
  - ```List<? super Number>```：它表示的类型是Number或者其父类型

```java
//类型通配符：<?>
List<?> list1 = new ArrayList<Object>();
List<?> list2 = new ArrayList<Number>();
List<?> list3 = new ArrayList<Integer>();
//类型通配符上限：<? extends 类型>
//        List<? extends Number> list4 = new ArrayList<Object>();
List<? extends Number> list5 = new ArrayList<Number>();
List<? extends Number> list6 = new ArrayList<Integer>();
//类型通配符下限：<? super 类型>
List<? super Number> list7 = new ArrayList<Object>();
List<? super Number> list8 = new ArrayList<Number>();
```

## 可变参数

- 可变参数又称参数个数可变，用作方法的形参出现，那么方法参数个数就是可变的了
  - 格式：```修饰符 返回值类型 方法名(数据类型… 变量名) {  }```
  - 范例：```public static int sum(int… a) {  }```
- 可变参数注意事项
  - 这里的变量其实是一个数组
  - **如果一个方法有多个参数，包含可变参数，可变参数要放在最后**

```java
//    public static int sum(int b,int... a) {
//        return 0;
//    }
public static int sum(int... a) {
    int sum = 0;

    for(int i : a) {
        sum += i;
    }
    return sum;
}
```

### 可变参数的使用

- Arrays工具类中有一个静态方法：
  - ```public static <T> List<T> asList(T... a)```：返回由指定数组支持的固定大小的列表
  - **返回的集合不能做增删操作，可以做修改操作**
- List接口中有一个静态方法：
  - ```public static <E> List<E> of(E... elements)```：返回包含任意数量元素的不可变列表
  - 返回的集合不能做增删改操作，不能做修改操作
- Set接口中有一个静态方法：
  - ```public static <E> Set<E> of(E... elements)``` ：返回一个包含任意数量元素的不可变集合
  - 在给元素的时候，不能给重复的元素
  - 返回的集合不能做增删操作，没有修改的方法

```java
List<String> list = Arrays.asList("hello", "world", "java");
List<String> list = List.of("hello", "world", "java", "world");
Set<String> set = Set.of("hello", "world", "java");
```

## 异常

- ```Error```：严重问题，不需要处理（内存资源不足等）
- ```Exception```：称为异常类，它表示程序本身可以处理的问题
  - ```RuntimeException```：在编译期是不检查的，出现问题后，需要我们回来修改代码
  - 非```RuntimeException```：编译期就必须处理的，否则程序不能通过编译，不能正常运行

### ```try...catch...finally```

```finally```：在异常处理时提供```finally```块来执行所有清除操作。比如说IO流中的释放资源

特点：被```finally```控制的语句一定会执行，除非JVM退出

```java
/*try{
    可能出现异常的代码;
}catch(异常类名 变量名){
	异常的处理代码;
}finally{
    执行所有清除操作;}*/

//加入finally来实现释放资源
FileOutputStream fos = null;
try {
    fos = new FileOutputStream("myByteStream\\fos.txt");
    fos.write("hello".getBytes());
} catch (IOException e) {
    e.printStackTrace();
} finally {
    if(fos != null) {
        try {
            fos.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
//返回throwable的详细消息字符串
public String getMessages();
//返回此可抛出的简短描述
public String toString(); //包含了getMessages()的内容
//把异常的错误信息输出在控制台
public void printStackTrace(); //最全的
```

### ```throws```

- ```throws 异常类名;```
- 编译时异常必须要进行处理，两种处理方案：```try...catch...```或者```throws```，如果采用```throws```这种方案，将来谁调用谁处理
- 运行时异常可以不处理，出现问题后，需要我们回来修改代码

### ```throws```和```throw```的区别

```throws```

- 用在方法声明后面，跟的是异常类名
- 表示抛出异常，由该方法的调用者来处理
- 表示出现异常的一种可能性，并不一定会发生这些异常

```throw```

- 用在方法体内，跟的是异常对象名
- 表示抛出异常，由方法体内的语句处理
- 执行 throw 一定抛出了某种异常

### 自定义异常

```java
public class ScoreException extends Exception {
    public ScoreException() {}
    public ScoreException(String message) {
        super(message);
    }
}
public class Teacher {
    public void checkScore(int score) throws ScoreException { //不然会报编译期异常，如果继承的是RuntimeException，可以不在这里抛出
        if(score<0 || score>100) {
//            throw new ScoreException();
            throw new ScoreException("你给的分数有误，分数应该在0-100之间");
        } else {
            System.out.println("成绩正常");
        }
    }
}
```

## 递归

- 递归概述：以编程的角度来看，递归指的是方法定义中调用方法本身的现象
- 递归解决问题的思路：
  - 把一个复杂的问题层层转化为一个与原问题相似的规模较小的问题来求解
  - 递归策略只需少量的程序就可描述出解题过程所需要的多次重复计算
- 递归解决问题要找到两个内容：
  - 递归出口：否则会出现内存溢出
  - 递归规则：与原问题相似的规模较小的问题

### 定义一个方法，用于获取给定目录下的所有内容

```java
//定义一个方法，用于获取给定目录下的所有内容，参数为第1步创建的File对象
public static void getAllFilePath(File srcFile) {
    //获取给定的File目录下所有的文件或者目录的File数组
    File[] fileArray = srcFile.listFiles();
    //遍历该File数组，得到每一个File对象
    if(fileArray != null) {
        for(File file : fileArray) {
            //判断该File对象是否是目录
            if(file.isDirectory()) {
                //是：递归调用
                getAllFilePath(file);
            } else {
                //不是：获取绝对路径输出在控制台
                System.out.println(file.getAbsolutePath());
            }
        }
    }
}
```

## 类加载器

当程序要使用某个类时，如果该类还未被加载到内存中，则系统会通过**类的加载**，**类的连接**，**类的初始化**这三个步骤来对类进行初始化。如果不出现意外情况，JVM将会连续完成这三个步骤，所以有时也把这三个步骤统称为类加载或者类初始化

类的加载 

- 就是指将```class```文件读入内存，并为之创建一个```java.lang.Class```对象

- 任何类被使用时，系统都会为之建立一个```java.lang.Class```对象

类的连接

- 验证阶段：用于检验被加载的类是否有正确的内部结构，并和其他类协调一致 

- 准备阶段：负责为类的类变量分配内存，并设置默认初始化值 

- 解析阶段：将类的二进制数据中的符号引用替换为直接引用

类的初始化

- 在该阶段，主要就是对类变量进行初始化 

- 类的初始化步骤
  - 假如类还未被加载和连接，则程序先加载并连接该类
  - 假如该类的直接父类还未被初始化，则先初始化其直接父类
  - 假如类中有初始化语句，则系统依次执行这些初始化语句
  - 注意：在执行第2个步骤的时候，系统对直接父类的初始化步骤也遵循初始化步骤1-3
- 类的初始化时机：
  - 创建类的实例
  - 调用类的类方法
  - 访问类或者接口的类变量，或者为该类变量赋值
  - 使用反射方式来强制创建某个类或接口对应的```java.lang.Class```对象
  - 初始化某个类的子类
  - 直接使用java.exe命令来运行某个主类

类加载器的作用

- 负责将```.class```文件加载到内存中，并为之生成对应的```java.lang.Class```对象
- 虽然我们不用过分关心类加载机制，但是了解这个机制我们就能更好的理解程序的运行

JVM的类加载机制

- 全盘负责：就是当一个类加载器负责加载某个Class时，该Class所依赖的和引用的其他Class也将由该类加载器负责载入，除非显示使用另外一个类加载器来载入
- 父类委托：就是当一个类加载器负责加载某个Class时，先让父类加载器试图加载该Class，只有在父类加载器无法加载该类时才尝试从自己的类路径中加载该类
- 缓存机制：保证所有加载过的Class都会被缓存，当程序需要使用某个Class对象时，类加载器先从缓存区中搜索该Class，只有当缓存区中不存在该Class对象时，系统才会读取该类对应的二进制数据，并将其转换成Class对象，存储到缓存区

### ```ClassLoader```

是负责加载类的对象

Java运行时具有以下内置类加载器

- ```Bootstrap class loader```：它是虚拟机的内置类加载器，通常表示为null ，并且没有父null
- ```Platform class loader```：平台类加载器可以看到所有平台类 ，平台类包括由平台类加载器或其祖先定义的Java SE平台API，其实现类和JDK特定的运行时类
- ```System class loader```：它也被称为应用程序类加载器 ，与平台类加载器不同。 系统类加载器通常用于定义应用程序类路径，模块路径和JDK特定工具上的类
- 类加载器的继承关系：System的父加载器为Platform，而Platform的父加载器为Bootstrap

```ClassLoader```中的两个方法

- ```static ClassLoader getSystemClassLoader()```：返回用于委派的系统类加载器
- ```ClassLoader getParent()```：返回父类加载器进行委派
- ```getResourceAsStream()```：返回用于读取指定资源的输入流

```java
//static ClassLoader getSystemClassLoader()：返回用于委派的系统类加载器
ClassLoader c = ClassLoader.getSystemClassLoader();
System.out.println(c); //AppClassLoader
//ClassLoader getParent()：返回父类加载器进行委派
ClassLoader c2 = c.getParent();
System.out.println(c2); //PlatformClassLoader
ClassLoader c3 = c2.getParent();
System.out.println(c3); //null
```

## 反射

框架：半成品软件。可以在框架的基础上进行软件开发，简化编码

反射：是指在运行时去获取一个类的变量和方法信息。然后通过获取到的信息来创建对象，调用方法的一种机制。
- 好处：
  1. 可以在程序运行过程中，操作这些对象。
  2. 可以解耦，提高程序的可扩展性。

![](C:\Users\admin\Desktop\practicing\图片笔记\Java\反射概述.bmp)

### 获取```Class```类的对象

我们要想通过反射去使用一个类，首先我们要获取到该类的字节码文件对象，也就是类型为```Class```类型的对象

这里我们提供三种方式获取```Class```类型的对象

- 使用类的```class```属性来获取该类对应的```Class```对象。举例：```Student.class```将会返回```Student```类对应的```Class```对象
  - 多用于参数的传递
- 调用对象的```getClass()```方法，返回该对象所属类对应的```Class```对象
  - 该方法是```Object```类中的方法，所有的Java对象都可以调用该方法
  - 多用于对象的获取字节码的方式
- 使用```Class```类中的静态方法```forName(String className)```，该方法需要传入字符串参数，该字符串参数的值是某个类的全路径，也就是完整包名的路径
  - 将字节码文件加载进内存，返回Class对象
  - 多用于**配置文件**```Properties```，更方便。将类名定义在配置文件中。读取文件，加载类

结论：同一个字节码文件(```*.class```)在一次程序运行过程中，只会被加载一次，不论通过哪一种方式获取的Class对象都是同一个。

```java
//使用类的class属性来获取该类对应的Class对象
Class<Student> c1 = Student.class;
System.out.println(c1);
//调用对象的getClass()方法，返回该对象所属类对应的Class对象
Student s = new Student();
Class<? extends Student> c3 = s.getClass();
//使用Class类中的静态方法forName(String className)
Class<?> c4 = Class.forName("com.itheima_02.Student");
System.out.println(c1== c4);
```

### 反射获取构造方法并使用

```Class```类中用于获取构造方法的方法

- ```Constructor<?>[] getConstructors()```：返回所有公共构造方法对象的数组
- ```Constructor<?>[] getDeclaredConstructors()```：返回所有构造方法对象的数组
- ```Constructor<T> getConstructor(Class<?>... parameterTypes)```：返回一个```Constructor```对象，该对象反映由该```Class```对象表示的类的指定公共构造函数。参数：你要获取的构造方法的参数的个数和数据类型对应的字节码文件对象
- ```Constructor<T> getDeclaredConstructor(Class<?>... parameterTypes)```：返回一个```Constructor```对象，该对象反映由此```Class```对象表示的类或接口的指定构造函数

```Constructor```类中用于创建对象的方法

- ```T newInstance(Object... initargs)```：使用由此```Constructor```对象表示的构造函数，使用指定的初始化参数来创建和初始化构造函数的声明类的新实例

基本数据类型也可以通过```.class```得到对应的```Class```类型。e.g.```int.class```

```public void setAccessible(boolean flag)```：值为```true```，取消访问检查

### 反射获取成员变量并使用

```Class```类中用于获取成员变量的方法

- ```Field[] getFields()```：返回所有公共成员变量对象的数组
- ```Field[] getDeclaredFields()```：返回所有成员变量对象的数组
- ```Field getField(String name)```：返回一个```Field```对象，该对象反映由该```Class```对象表示的类或接口的指定公共成员字段
- ```Field getDeclaredField(String name)```：返回一个```Field```对象，该对象反映由该```Class```对象表示的类或接口的指定声明字段

```Field```类中用于给成员变量赋值的方法

- ```void set(Object obj, Object value)```：给```obj```对象的成员变量赋值为```value```。哪个成员变量调用这个方法就是给哪个成员变量赋值

### 反射获取成员方法并使用

```Class```类中用于获取成员方法的方法

- ```Method[] getMethods()```：返回一个包含方法对象的数组， 方法对象反映由该```Class```对象表示的类或接口的所有公共方法，包括由类或接口声明的对象以及从超类和超级接口**继承的类**
- ```Method[] getDeclaredMethods()```：返回一个包含方法对象的数组，方法对象反映由```Class```对象表示的类或接口的所有声明方法，包括```public```，```protected```，```default（package）```访问和私有方法，但**不包括继承方法**
- ```Method getMethod(String name, Class<?>... parameterTypes)```：返回一个方法对象，该对象反映由该```Class```对象表示的类或接口的指定公共成员方法
- ```Method getDeclaredMethod(String name, Class<?>... parameterTypes)```：返回一个方法对象，它反映此表示的类或接口的指定声明的方法```Class```对象

```Method```类中用于调用成员方法的方法

- ```Object invoke(Object obj, Object... args)```：调用```obj```对象的成员方法，参数是```args```,返回值是```Object```类型

```java
//获取Class对象
Class<?> c = Class.forName("com.itheima_02.Student");
System.out.println(c.getName());//获取类名
//private Student(String name)
Constructor<?> con = c.getDeclaredConstructor(String.class);
//暴力反射
con.setAccessible(true);
//空参构造创建的快捷方法
//Object obj = c.newInstance();
Object obj = con.newInstance("林青霞"); 
Field nameField = c.getDeclaredField("name");
nameField.setAccessible(true);//公共的也可以用
nameField.set(obj, "张曼玉");
Object value = nameField.get(obj);
System.out.println(obj);
Method m = c.getDeclaredMethod("method3", String.class, int.class);
m.setAccessible(true);
Object o = m.invoke(obj, "林青霞", 30);
System.out.println(m.getName());//获取方法名
System.out.println(o);
```





## Lambda表达式

Lambda表达式的使用前提

- 函数式接口


Lambda表达式的格式

- 格式：```(形式参数) -> {代码块} ```

- 形式参数：如果有多个参数，参数之间用逗号隔开；如果没有参数，留空即可 

- ```->```：由英文中画线和大于符号组成，固定写法。代表指向动作 

- 代码块：是我们具体要做的事情，也就是以前我们写的方法体内容 

注意事项：

- 使用Lambda必须要有接口，并且要求接口中有且仅有一个抽象方法

- 必须有上下文环境，才能推导出Lambda对应的接口
  - 根据局部变量的赋值得知Lambda对应的接口：```Runnable r = () -> System.out.println("Lambda表达式");new Thread(r).start();```
  - 根据调用方法的参数得知Lambda对应的接口：```new Thread(() -> System.out.println("Lambda表达式")).start();```

```java
//有且仅有一个抽象方法的接口
public interface Addable {
    int add(int x,int y);
}

public static void main(String[] args) {
    //匿名内部类，对比看
    useAddable(new Addable(){
        @Override
        public int add(int x, int y){
            return x + y;
        }
    });        

    //在主方法中调用useAddable方法
    //参数的类型可以省略。但是有多个参数的情况下，不能只省略一个。如果参数有且仅有一个，那么小括号可以省略。如果代码块的语句只有一条，可以省略大括号和分号，如果有return，return也要省略
    /*
    useAddable((x, y) -> {
        return x + y;

    });*/
    useAddable((x, y) -> x + y);
}

private static void useAddable(Addable a) {
    int sum = a.add(10, 20);
    System.out.println(sum);
}
```

### 函数式接口

有且仅有一个抽象方法的接口

Java中的函数式编程体现就是Lambda表达式，所以函数式接口就是可以适用于Lambda使用的接口

只有确保接口中有且仅有一个抽象方法，Java中的Lambda才能顺利地进行推导

如何检测一个接口是不是函数式接口呢？

- ```@FunctionalInterface```：放在接口定义的上方：如果接口是函数式接口，编译通过；如果不是，编译失败

我们自己定义函数式接口的时候，```@FunctionalInterface```是可选的，就算我不写这个注解，只要保证满足函数式接口定义的条件，也照样是函数式接口。但是，建议加上该注解

我的理解：Lambda表达式返回一个函数式接口

Java8在```java.util.function```包下预定义了大量的函数式接口供我们使用

- Supplier接口
  - ```T get()```：获得结果 
  - 该方法不需要参数，它会按照某种实现逻辑(由Lambda表达式实现)返回一个数据
  - ```Supplier<T>```接口也被称为生产型接口，如果我们指定了接口的泛型是什么类型，那么接口中的```get```方法就会生产什么类型的数据供我们使用
- Consumer接口
  - ```void accept(T t)```：对给定的参数执行此操作
  - ```default Consumer<T> andThen(Consumer after)```：返回一个组合的```Consumer```，依次执行此操作，然后执行```after```操作
  - ```Consumer<T>```接口也被称为消费型接口，它消费的数据的数据类型由泛型指定
- Predicate接口
  - ```boolean test(T t)```：对给定的参数进行判断(判断逻辑由Lambda表达式实现)，返回一个布尔值 
  - ```default Predicate<T> negate()```：返回一个逻辑的否定，对应逻辑非
  - ```default Predicate<T> and(Predicate other)```：返回一个组合判断，对应短路与
  - ```default Predicate<T> or(Predicate other)```：返回一个组合判断，对应短路或
  - ```Predicate<T>```接口通常用于判断参数是否满足指定的条件
- Function接口
  - ```R apply(T t)```：将此函数应用于给定的参数 
  - ```default <V> Function andThen(Function after)```：返回一个组合函数，首先将该函数应用于输入，然后将after函数应用于结果 
  - ```Function<T,R>```接口通常用于对参数进行处理，转换(处理逻辑由Lambda表达式实现)，然后返回一个新的值



```java
//Supplier
public static void main(String[] args) {
    String s = getString(() -> "林青霞");
    System.out.println(s);

    Integer i = getInteger(() -> 30);
    System.out.println(i);
}
//定义一个方法，返回一个整数数据
private static Integer getInteger(Supplier<Integer> sup) {
    return sup.get();
}
//定义一个方法，返回一个字符串数据
private static String getString(Supplier<String> sup) {
    return sup.get();
}

//Consumer
public static void main(String[] args) {
    String[] strArray = {"林青霞,30", "张曼玉,35", "王祖贤,33"};
    printInfo(strArray, str -> System.out.print("姓名：" + str.split(",")[0]),
            str -> System.out.println(",年龄：" + Integer.parseInt(str.split(",")[1])));
}

private static void printInfo(String[] strArray, Consumer<String> con1, Consumer<String> con2) {
    for (String str : strArray) {
        con1.andThen(con2).accept(str);
    }
}

//Predicate
public static void main(String[] args) {
    String[] strArray = {"林青霞,30", "柳岩,34", "张曼玉,35", "貂蝉,31", "王祖贤,33"};
    ArrayList<String> array = myFilter(strArray, s -> s.split(",")[0].length() > 2,
            s -> Integer.parseInt(s.split(",")[1]) > 33);

    for (String str : array) {
        System.out.println(str);
    }
}
private static ArrayList<String> myFilter(String[] strArray, Predicate<String> pre1, Predicate<String> pre2) {
    //定义一个集合
    ArrayList<String> array = new ArrayList<String>();
    //遍历数组
    for (String str : strArray) {
        if (pre1.and(pre2).test(str)) {
            array.add(str);
        }
    }
    return array;
}

//Function
public static void main(String[] args) {
    String s = "林青霞,30";
    convert(s, ss -> ss.split(",")[1], Integer::parseInt, i -> i + 70);
}
private static void convert(String s, Function<String, String> fun1, Function<String, Integer> fun2, Function<Integer, Integer> fun3) {
    int i = fun1.andThen(fun2).andThen(fun3).apply(s);
    System.out.println(i);
}
```



### Lambda表达式和匿名内部类的区别

所需类型不同

- 匿名内部类：可以是接口，也可以是抽象类，还可以是具体类

- Lambda表达式：只能是接口

使用限制不同

- 如果接口中有且仅有一个抽象方法，可以使用Lambda表达式，也可以使用匿名内部类

- 如果接口中多于一个抽象方法，只能使用匿名内部类，而不能使用Lambda表达式

实现原理不同

- 匿名内部类：编译之后，产生一个单独的```.class```字节码文件
- Lambda表达式：编译之后，没有一个单独的```.class```字节码文件。对应的字节码会在运行的时候动态生成

### 方法引用

Lambda表达式支持的方法引用

常见的引用方式：

- 引用类方法

- 引用对象的实例方法

- 引用类的实例方法

- 引用构造器

#### 方法引用符

```::```该符号为引用运算符，而它所在的表达式被称为方法引用

回顾一下我们在体验方法引用中的代码

- Lambda表达式：```usePrintable(s -> System.out.println(s));```
  - 分析：拿到参数```s```之后通过Lambda表达式，传递给```System.out.println```方法去处理

- 方法引用：```usePrintable(System.out::println);```
  - 分析：直接使用```System.out```中的```println```方法来取代Lambda，代码更加的简洁

推导与省略

- 如果使用Lambda，那么根据“可推导就是可省略”的原则，无需指定参数类型，也无需指定的重载形式，它们都将被自动推导

- 如果使用方法引用，也是同样可以根据上下文进行推导

- **方法引用是Lambda的孪生兄弟**

#### 引用类方法

引用类方法，**其实就是引用类的静态方法**

- 格式：```类名::静态方法```
- 范例：```Integer::parseInt```
- Lambda表达式被类方法替代的时候，它的形式参数全部传递给静态方法作为参数

- Integer类的方法：```public static int parseInt(String s)```将此String转换为int类型数据

#### 引用对象的实例方法

引用对象的实例方法，**其实就引用类中的成员方法**

- 格式：对象::成员方法

- 范例： ```"HelloWorld"::toUpperCase```
- Lambda表达式被对象的实例方法替代的时候，它的形式参数全部传递给该方法作为参数

- String类中的方法：```public String toUpperCase()```将此String所有字符转换为大写

#### 引用类的实例方法

引用类的实例方法，**其实就是引用类中的成员方法**

- 格式：```类名::成员方法```

- 范例：```String::substring```
- Lambda表达式被类的实例方法替代的时候，第一个参数作为调用者，后面的参数全部传递给该方法作为参数

- String类中的方法： ```public String substring(int beginIndex,int endIndex)```从beginIndex开始到endIndex结束，截取字符串。返回一个子串，子串的长度为endIndex-beginIndex 

#### 引用构造器

引用构造器，**其实就是引用构造方法**

- 格式：```类名::new```
- 范例：```Student::new```
- Lambda表达式被构造器替代的时候，它的形式参数全部传递给构造器作为参数



```java
 //引用类方法
useConverter(Integer::parseInt);
private static void useConverter(Converter c) {
    int number = c.convert("666");
    System.out.println(number);
}

//引用对象的实例方法
//定义一个类
public class PrintString {
    //把字符串参数变成大写的数据，然后在控制台输出
    public void printUpper(String s) {
        String result = s.toUpperCase();
        System.out.println(result);
    }
}
PrintString ps = new PrintString();
usePrinter(ps::printUpper);
private static void usePrinter(Printer p) {
	p.printUpperCase("HelloWorld");
}

//引用类的实例方法
useMyString(String::substring);
private static void useMyString(MyString my) {
	String s = my.mySubString("HelloWorld", 2, 5);
	System.out.println(s);
}

//引用构造器
//定义一个类
public class Student {
    ...
}
useStudentBuilder(Student::new);
private static void useStudentBuilder(StudentBuilder sb) {
	Student s = sb.build("林青霞", 30);
	System.out.println(s.getName() + "," + s.getAge());
}
```

## Stream流

Stream流的使用

- 生成流 
  - 通过数据源(集合,数组等)生成流
    - ```list.stream()```

- 中间操作
  - 一个流后面可以跟随零个或多个中间操作，其目的主要是打开流，做出某种程度的数据过滤/映射，然后返回一个新的流，交给下一个操作使用
    - ```filter()```

- 终结操作
  - 一个流只能有一个终结操作，当这个操作执行后，流就被使用“光”了，无法再被操作。所以这必定是流的最后一个操作
    - ```forEach```

### Stream流的常见生成方式

- Collection体系的集合可以使用默认方法stream()生成流
  - ```default Stream<E> stream() ```
- Map体系的集合间接的生成流
- 数组可以通过Stream接口的静态方法```of(T... values)```生成流

```java
public static void main(String[] args) {
    //Collection体系的集合可以使用默认方法stream()生成流
    List<String> list = new ArrayList<String>();
    Stream<String> listStream = list.stream();

    Set<String> set = new HashSet<String>();
    Stream<String> setStream = set.stream();

    //Map体系的集合间接的生成流
    Map<String,Integer> map = new HashMap<String, Integer>();
    Stream<String> keyStream = map.keySet().stream();
    Stream<Integer> valueStream = map.values().stream();
    Stream<Map.Entry<String, Integer>> entryStream = map.entrySet().stream();

    //数组可以通过Stream接口的静态方法of(T... values)生成流
    String[] strArray = {"hello","world","java"};
    Stream<String> strArrayStream = Stream.of(strArray);
    Stream<String> strArrayStream2 = Stream.of("hello", "world", "java");
    Stream<Integer> intStream = Stream.of(10, 20, 30);
}
```

### Stream流的常见中间操作方法

- ```Stream<T> filter(Predicate predicate)```：用于对流中的数据进行过滤
  - ```Predicate```接口中的方法```boolean test(T t)```：对给定的参数进行判断，返回一个布尔值 
- ```Stream<T> limit(long maxSize)```：返回此流中的元素组成的流，截取前指定参数个数的数据
- ```Stream<T> skip(long n)```：跳过指定参数个数的数据，返回由该流的剩余元素组成的流
- ```static <T> Stream<T> concat(Stream a, Stream b)```：合并a和b两个流为一个流
- ```Stream<T> distinct()```：返回由该流的不同元素（根据```Object.equals(Object)```）组成的流
- ```Stream<T> sorted()```：返回由此流的元素组成的流，根据**自然顺序**排序
- ```Stream<T> sorted(Comparator comparator)```：返回由该流的元素组成的流，根据提供的```Comparator```进行排序
- ```<R> Stream<R> map(Function mapper)```：返回由给定函数应用于此流的元素的结果组成的流
  - ```Function```接口中的方法```R apply(T t)```
- ```IntStream mapToInt(ToIntFunction mapper)```：返回一个```IntStream```其中包含将给定函数应用于此流的元素的结果
  - ```IntStream```：表示原始int流
  - ```ToIntFunction```接口中的方法```int applyAsInt(T value)```

### Stream流的常见终结操作方法

- ```void forEach(Consumer action)```：对此流的每个元素执行操作
  - ```Consumer```接口中的方法```void accept(T t)```：对给定的参数执行此操作
- ```long count()```：返回此流中的元素数

```java
//创建一个集合，存储多个字符串元素
ArrayList<String> list = new ArrayList<String>();
list.add("林青霞");
list.add("张曼玉");
list.add("王祖贤");
list.add("柳岩");
list.add("张敏");
list.add("张无忌");

///需求：把list集合中以张开头的，长度为3的元素的个数在控制台输出
System.out.println(list.stream().filter(s -> s.startsWith("张")).filter(s -> s.length() == 3).count());
///需求：跳过2个元素，把剩下的元素中前2个在控制台输出
list.stream().skip(2).limit(2).forEach(System.out::println);
///需求：合并两个流，并把结果在控制台输出，要求字符串元素不能重复
Stream<String> s1 = list.stream().limit(4);
Stream<String> s2 = list.stream().skip(2);
Stream.concat(s1,s2).distinct().forEach(System.out::println);
//需求：按照字符串长度把数据在控制台输出，长度相同时按照字母顺序输出
list.stream().sorted((s1,s2) -> {
    int num = s1.length()-s2.length();
    int num2 = num==0?s1.compareTo(s2):num;
    return num2;
}).forEach(System.out::println);
//需求：将集合中的字符串数据转换为整数之后求和
list.add("10");
list.add("20");
list.add("30");
list.add("40");
list.add("50");
//list.stream().map(Integer::parseInt).forEach(System.out::println);
//list.stream().mapToInt(Integer::parseInt).forEach(System.out::println);
//int sum() 返回此流中元素的总和
int result = list.stream().mapToInt(Integer::parseInt).sum();
System.out.println(result);
```

### Stream流的收集操作

对数据使用Stream流的方式操作完毕后，我想把流中的数据收集到集合中，该怎么办呢？

- Stream流的收集方法
  - ```R collect(Collector collector)```

但是这个收集方法的参数是一个```Collector```接口

工具类```Collectors```提供了具体的收集方式

- ```public static <T> Collector toList()```：把元素收集到List集合中
  - ```List<String> names = listStream.collect(Collectors.toList());```
- ```public static <T> Collector toSet()```：把元素收集到Set集合中
  - ```Set<Integer> ages = setStream.collect(Collectors.toSet());```
- ```public static  Collector toMap(Function keyMapper,Function valueMapper)```：把元素收集到Map集合中
  - ```Map<String, Integer> map = arrayStream.collect(Collectors.toMap(s -> s.split(",")[0], s -> Integer.parseInt(s.split(",")[1])));```

## 多线程

进程：是正在运行的程序

- 是系统进行资源分配和调用的独立单位
- 每一个进程都有它自己的内存空间和系统资源

线程：是进程中的单个顺序控制流，是一条执行路径

- 单线程：一个进程如果只有一条执行路径，则称为单线程程序
- 多线程：一个进程如果有多条执行路径，则称为多线程程序

线程有两种调度模型

- 分时调度模型：所有线程轮流使用 CPU 的使用权，平均分配每个线程占用 CPU 的时间片
- 抢占式调度模型：优先让优先级高的线程使用 CPU，如果线程的优先级相同，那么会随机选择一个，优先级高的线程获取的 CPU 时间片相对多一些 - Java使用的是抢占式调度模型
  - 线程默认优先级是5；线程优先级的范围是：1-10
  - 线程优先级高仅仅表示线程获取的CPU时间片的几率高，但是要在次数比较多，或者多次运行的时候才能看到你想要的效果
- 假如计算机只有一个 CPU，那么 CPU 在某一个时刻只能执行一条指令，线程只有得到CPU时间片，也就是使用权，才可以执行指令。所以说多线程程序的执行是有随机性，因为谁抢到CPU的使用权是不一定的

![](C:\Users\admin\Desktop\practicing\图片笔记\Java\线程的生命周期.jpg)

### 多线程的实现方案

#### 继承```Thread```类

- 定义一个类```MyThread```继承T```hread```类
- 在```MyThread```类中重写```run()方```法
- 创建```MyThread```类的对象
- 启动线程

为什么要重写```run()```方法？

- 因为```run()```是用来封装被线程执行的代码

```run()```方法和```start()```方法的区别？

- ```run()```：封装线程执行的代码，直接调用，相当于普通方法的调用
- ```start()```：启动线程；然后由JVM调用此线程的```run()```方

```java
public class MyThread extends Thread {
    public MyThread() {}
    public MyThread(String name) {
        super(name);
    }
    @Override
    public void run() {
        for (int i = 0; i < 100; i++) {
            System.out.println(getName() + ":" + i);
            try {
                //static void sleep(long millis)：使当前正在执行的线程停留（暂停执行）指定的毫秒数
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}

//Thread(String name)
MyThread my1 = new MyThread("关羽");
MyThread my2 = new MyThread("张飞");
//void setName(String name)：将此线程的名称更改为等于参数 name
//my1.setName("刘备");

/*
//设置主线程为刘备
//static Thread currentThread() 返回对当前正在执行的线程对象的引用
Thread.currentThread().setName("刘备");
//void setDaemon(boolean on)：将此线程标记为守护线程，当运行的线程都是守护线程时，Java虚拟机将退出
//设置守护线程
my1.setDaemon(true);
my2.setDaemon(true);
//------------------------------------------------------------------------------------
//void join()：等待这个线程死亡
my1.start();
try {
	my1.join();
} catch (InterruptedException e) {
	e.printStackTrace();
}
	my2.strat();
*/

my1.start();
my2.start();
//public final int getPriority()：返回此线程的优先级
System.out.println(my1.getPriority()); //5
//System.out.println(Thread.MAX_PRIORITY); //10
//System.out.println(Thread.MIN_PRIORITY); //1
//System.out.println(Thread.NORM_PRIORITY); //5
//设置正确的优先级
my1.setPriority(5);
```

#### 实现```Runnable```接口

- 定义一个类```MyRunnable```实现```Runnable```接口
- 在```MyRunnable```类中重写```run()```方法
- 创建```MyRunnable```类的对象
- 创建```Thread```类的对象，把```MyRunnable```对象作为构造方法的参数
- 启动线程

相比继承Thread类，实现Runnable接口的好处
- 避免了Java单继承的局限性
- 适合多个相同程序的代码去处理同一个资源的情况，把线程和程序的代码、数据有效分离，较好的体现了面向对象的设计思想

```java
public class MyRunnable implements Runnable {
    @Override
    public void run() {
        for(int i=0; i<100; i++) {
            System.out.println(Thread.currentThread().getName()+":"+i);
        }
    }
}

//创建MyRunnable类的对象
MyRunnable my = new MyRunnable();
//创建Thread类的对象，把MyRunnable对象作为构造方法的参数
//Thread(Runnable target)
//Thread t1 = new Thread(my);
//Thread t2 = new Thread(my);
//Thread(Runnable target, String name)
Thread t1 = new Thread(my,"高铁");
Thread t2 = new Thread(my,"飞机");
//启动线程
t1.start();
t2.start();
```

### 线程同步

锁多条语句操作共享数据，可以使用同步代码块实现

```synchronized(任意对象)```：就相当于给代码加锁了，任意对象就可以看成是一把锁

同步方法

- 就是把```synchronized```关键字加到方法上

- 格式：```修饰符 synchronized 返回值类型 方法名(方法参数) {    }```

- 同步方法的锁对象是什么呢? 
  - ```this```
- 同步静态方法：就是把synchronized关键字加到静态方法上
  - 格式：```修饰符 static synchronized 返回值类型 方法名(方法参数) {    }```
- 同步静态方法的锁对象是什么呢?
  - ```类名.class```

同步的好处和弊端	

- 好处：解决了多线程的数据安全问题
- 弊端：当线程很多时，因为每个线程都会去判断同步上的锁，这是很耗费资源的，无形中会降低程序的运行效率

```java
//卖票案例
public class SellTicket implements Runnable {
    private static int tickets = 100;
    private int x = 0;

    @Override
    public void run() {
        while (true) {
            if (x % 2 == 0) {
                //同步代码块
                synchronized (SellTicket.class) {
                    if (tickets > 0) {
                        try {
                            Thread.sleep(100);
                        } catch (InterruptedException e) {
                            e.printStackTrace();
                        }
                        System.out.println(Thread.currentThread().getName() + "正在出售第" + tickets + "张票");
                        tickets--;
                    }
                }
            } else {

                sellTicket();
            }
            x++;
        }
    }
	//同步方法
    private static synchronized void sellTicket() {
        if (tickets > 0) {
            try {
                Thread.sleep(100);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            System.out.println(Thread.currentThread().getName() + "正在出售第" + tickets + "张票");
            tickets--;
        }
    }
}
public class Main {
    public static void main(String[] args) {
        SellTicket st = new SellTicket();

        Thread t1 = new Thread(st, "窗口1");
        Thread t2 = new Thread(st, "窗口2");
        Thread t3 = new Thread(st, "窗口3");

        t1.start();
        t2.start();
        t3.start();
    }
}
```

### 线程安全的类

```StringBuffer```/```StringBuilder```

- 线程安全，可变的字符序列 

- 从版本JDK5开始，被```StringBuilder```替代。通常应该使用```StringBuilder```类，因为它支持所有相同的操作，但它更快，因为它不执行同步

```Vector```/```ArrayList```

- 从Java2平台v1.2开始，该类改进了```List```接口，使其成为Java Collections Framework的成员。与新的集合实现不同，Vector被同步。如果不需要线程安全的实现，建议使用```ArrayList```代替```Vector ```

```Hashtable```/```HashMap```

- 该类实现了一个哈希表，它将键映射到值。任何非```null```对象都可以用作键或者值  

- 从Java2平台v1.2开始，该类进行了改进，实现了```Map```接口，使其成为Java Collections Framework的成员。与新的集合实现不同，```Hashtable```被同步。如果不需要线程安全的实现，建议使用```HashMap```代替```Hashtable```

也可以使用```static <T> List<T> synchronizedList(List<T> list) 返回由指定列表支持的同步（线程安全）列表```

- ```List<String> list = Collections.synchronizedList(new ArrayList<String>());```

### Lock锁

Lock实现提供比使用```synchronized```方法和语句可以获得更广泛的锁定操作

Lock中提供了获得锁和释放锁的方法

- ```void lock()```：获得锁
- ```void unlock()```：释放锁

Lock是接口不能直接实例化，这里采用它的实现类```ReentrantLock```来实例化

- ```ReentrantLock```的构造方法 
  - ```ReentrantLock()```：创建一个```ReentrantLock```的实例

```java
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class SellTicket implements Runnable {
    private int tickets = 100;
    private Lock lock = new ReentrantLock();

    @Override
    public void run() {
        while (true) {
            try {
                lock.lock();
                if (tickets > 0) {
                    try {
                        Thread.sleep(100);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                    System.out.println(Thread.currentThread().getName() + "正在出售第" + tickets + "张票");
                    tickets--;
                }
            } finally {
                lock.unlock();
            }
        }
    }
}
```

### 生产者消费者案例

```java
void wait()//导致当前线程等待，直到另一个线程调用该对象的 notify()方法或 notifyAll()方法
void notify()//唤醒正在等待对象监视器的单个线程
void notifyAll()//唤醒正在等待对象监视器的所有线程 
```



## 常用API 

- ```java.lang.*```是不用导包的
- 工具类的设计思想
  - 构造方法用```private```修饰
  - 成员用```public static```修饰

### ```Scanner```

```java
import java.util.Random;
import java.util.Scanner;
Scanner in = new Scanner(System.in);
//不推荐使用
while (in.hasNext()){
    float f = in.nextFloat();
}
double d = in.nextDouble();
int i = in.nextInt();
String line = in.nextLine();
Random r = new Random();
int r_number = r.nextInt(10); // [0, 10)范围的随机数
```

### ```String```

- Java程序中所有的双引号字符串，都是```String```类的对象
- 字符串不可变，它们的值在创建后不能被更改。```StringBuilder```内容是可变的
- 虽然String的值时不可变的，但是它们可以被共享
- 字符串效果上相当于字符数组(```char[]```)，但是底层原理是字节数组(```byte[]```)

```java
//public String()：创建一个空白字符串对象，不含有任何内容
//public String (char[] chs)：根据字符数组的内容，来创建字符串对象
char[] chs = {'a', 'b', 'c'};
String s1 = new String(chs); //"abc"
//public String (char[] chs)：根据字节数组的内容，来创建字符串对象
byte[] bys = {97, 98, 99};
String s2 = new String(bys); //"abc"
//直接赋值的方式创建字符串对象
String s3 = "abc";
boolean flag = s1.equals(s2);
char last = s1.charAt(s1.length-1);

//StringBuilder
StringBuilder sb = new StringBuilder("Hello");
sb.append(" World ").append(sb.length()).reverse();
System.out.println(sb);

//StringBuilder转化为String
String s4 = sb.toString();
//String转化为StringBuilder
StringBuilder sb2 = new StringBuilder(s1);
```

### ```Math```

```java
public static int abs(int a)：返回参数的绝对值
public static double ceil(double a)：返回大于或等于参数的最小double值，等于一个整数
public static double floor(double a)：返回小于或等于参数的最大double值，等于一个整数
public static int round(float a)：按照四舍五入返回最接近参数的int
public static int max(int a,int b)：返回两个int值中的较大值
public static int min(int a,int b)：返回两个int值中的较小值
public static double pow(double a,double b)：返回a的b次幂的值
public static double random()：返回值为double的正值，[0.0,1.0)
```

### ```Array```

```java
//动态初始化
int[] a = new int[3];
//静态初始化
int[] a = {1, 2, 3} //int[] arr = new int[]{1, 2, 3}的简化格式，仍然有开辟内存的操作
Array.toString(int[] a);
//我写的
public static String arrayToString(int arr[]) {
    StringBuilder sb = new StringBuilder();
    sb.append("[");
    for (int i = 0; i < arr.length - 1; i++) {
        sb.append(arr[i]);
        sb.append(",");
    }
    sb.append(arr[arr.length - 1]);
    sb.append("]");
    return sb.toString();
}
Arrar.sort(int[] a);
//我写的冒泡排序
int[] arr = {3242, 345, 564, 66, 34, 2, 423243, 3422, 2, 4243, 423424};
int times = arr.length-1;
int temp = arr[0];
for (int i = 1; i <= times; i++) {
    for (int j = 0; j<times-i;j++){
        if (arr[j]>arr[j+1]){
            temp = arr[j+1];
            arr[j+1] = arr[j];
            arr[j] = temp;
        }
    }
}
```



### ```ArrayList```

```java
import java.util.ArrayList;
ArrayList<String> arr = new ArrayList<String>();
arr.add("Hello ");
arr.add(" java");
arr.add(1, "World"); //index must within bound
System.out.println(arr);
System.out.println(arr.remove(" java")); //返回是否删除成功
System.out.println(arr.remove(arr.size()-1));//返回被删除的元素.index must within bound
System.out.println(arr.set(0, "hello"));//返回被修改的元素.index must within bound
System.out.println(arr.get(0));//返回指定索引处的元素.index must within bound
```

### ```File```

- File：它是文件和目录路径名的抽象表示
- 文件和目录是可以通过File封装成对象的
- 对于File而言，其封装的并不是一个真正存在的文件，仅仅是一个路径名而已。它可以是存在的，也可以是不存在的。将来是要通过具体的操作把这个路径的内容转换为具体存在的
- 绝对路径和相对路径的区别
  - 绝对路径：完整的路径名，不需要任何其他信息就可以定位它所表示的文件。例如：```E:\itcast\java.txt```
  - 相对路径：必须使用取自其他路径名的信息进行解释。例如：```myFile\\java.txt```
- 删除目录时的注意事项：
  - **如果一个目录中有内容(目录，文件)，不能直接删除。应该先删除目录中的内容，最后才能删除目录**

```java
import java.io.File;
import java.io.IOException;

//构造函数
//File(String pathname)：通过将给定的路径名字符串转换为抽象路径名来创建新的 File实例。
File f1 = new File("E:\\itcast\\java.txt");
//File(String parent, String child)：从父路径名字符串和子路径名字符串创建新的 File实例。
File f2 = new File("E:\\itcast","java.txt");
//File(File parent, String child)：从父抽象路径名和子路径名字符串创建新的 File实例。
File f3 = new File("E:\\itcast");
File f4 = new File(f3,"java.txt");

///File类创建功能：
/*public boolean createNewFile()：当具有该名称的文件不存在时，创建一个由该抽象路径名命名的新空文件
如果文件不存在，就创建文件，并返回true
如果文件存在，就不创建文件，并返回false
创建时不能出现名字相同的元素，即使一个是目录，一个是文件*/
File f1 = new File("E:\\itcast\\java.txt");
System.out.println(f1.createNewFile());
/* public boolean mkdir()：创建由此抽象路径名命名的目录
如果目录不存在，就创建目录，并返回true
如果目录存在，就不创建目录，并返回false*/
File f2 = new File("E:\\itcast\\JavaSE");
System.out.println(f2.mkdir());
/*public boolean mkdirs()：创建由此抽象路径名命名的目录，包括任何必需但不存在的父目录
如果目录不存在，就创建目录，并返回true
如果目录存在，就不创建目录，并返回false*/
File f3 = new File("E:\\itcast\\JavaWEB\\HTML");
System.out.println(f3.mkdirs());

//File类删除功能
File f3 = new File("myFile\\itcast");
System.out.println(f3.mkdir());
File f4 = new File("myFile\\itcast\\java.txt");
System.out.println(f4.createNewFile());
//需求6：删除当前模块下的目录itcast，必须先删除目录下的文件，再删除目录
System.out.println(f4.delete());
System.out.println(f3.delete());
//File类判断和获取功能
File f = new File("myFile\\java.txt");
//public boolean isDirectory()：测试此抽象路径名表示的File是否为目录
//public boolean isFile()：测试此抽象路径名表示的File是否为文件
//public boolean exists()：测试此抽象路径名表示的File是否存在
System.out.println(f.isDirectory());
System.out.println(f.isFile());
System.out.println(f.exists());
//public String getAbsolutePath()：返回此抽象路径名的绝对路径名字符串
//public String getPath()：将此抽象路径名转换为路径名字符串
//public String getName()：返回由此抽象路径名表示的文件或目录的名称
System.out.println(f.getAbsolutePath());
System.out.println(f.getPath());
System.out.println(f.getName());
//public String[] list()：返回此抽象路径名表示的目录中的文件和目录的名称字符串数组
//Public File[] listFiles()：返回此抽象路径名表示的目录中的文件和目录的File对象数组
File f2 = new File("E:\\itcast");
String[] strArray = f2.list();
for(String str : strArray) {
    System.out.println(str);
}
File[] fileArray = f2.listFiles();
for(File file : fileArray) {
    if(file.isFile()) {
        System.out.println(file.getName());
    }
}
```

### ```InputStream/OutputStream```

- IO流概述：
  - IO：输入/输出(Input/Output)
  - 流：是一种抽象概念，是对数据传输的总称。也就是说数据在设备间的传输称为流，流的本质是数据传输
  - IO流就是用来处理设备间数据传输问题的
  - 常见的应用：文件复制；文件上传；文件下载
- IO流分类：
  - 按照数据的流向
    - 输入流：读数据
    - 输出流：写(write)数据
  - 按照数据类型来分
    - 字节流-字节输入流；字节输出流
    - 字符流-字符输入流；字符输出流
  - 一般来说，我们说IO流的分类是按照数据类型来分的。那么这两种流都在什么情况下使用呢？
    - 如果数据通过Window自带的记事本软件打开，我们还可以读懂里面的内容，就使用字符流，否则使用字节流。**如果你不知道该使用哪种类型的流，就使用字节流**

![](C:\Users\admin\Desktop\practicing\图片笔记\Java\IO流小结.jpg)

![](C:\Users\admin\Desktop\practicing\图片笔记\Java\IO流小结 (2).jpg)

#### 字节流```FileInputStream```/```FileOutputStream```

- 字节流抽象基类
  - ```InputStream```：这个抽象类是表示字节输入流的所有类的超类
  - ```OutputStream```：这个抽象类是表示字节输出流的所有类的超类
  - 子类名特点：子类名称都是以其父类名作为子类名的后缀
- ```FileOutputStream```：文件输出流用于将数据写入File
  - ```FileOutputStream(String name)```：创建文件输出流以指定的名称写入文件
- 使用字节输出流写数据的步骤：
  - 创建字节输出流对象(调用系统功能创建了文件，创建字节输出流对象，让字节输出流对象指向文件)
  - 调用字节输出流对象的写数据方法
  - 释放资源(关闭此文件输出流并释放与此流相关联的任何系统资源)
- ```FileInputStream```：从文件系统中的文件获取输入字节
  - ```FileInputStream(String name)```：通过打开与实际文件的连接来创建一个```FileInputStream```，该文件由文件系统中的路径名```name```命名
- 使用字节输入流读数据的步骤
  - 创建字节输入流对象
  - 调用字节输入流对象的读数据方法
  - 释放资源
- **字节流写数据如何实现换行呢？**
  - window:```\r\n```
  - linux:```\n```
  - mac:```\r```       

```java
/*public FileOutputStream(String name,boolean append)
创建文件输出流以指定的名称写入文件。
如果第二个参数为true ，则字节将写入文件的末尾而不是开头*/
FileOutputStream fos = new FileOutputStream("idea_test\\test.txt", true);
/*
    做了三件事情：
        A:调用系统功能创建了文件
        B:创建了字节输出流对象
        C:让字节输出流对象指向创建好的文件
 */
//void write(int b)：将指定的字节写入此文件输出流
fos.write(97);
//void write(byte[] b)：将 b.length字节从指定的字节数组写入此文件输出流
//byte[] bys = {97, 98, 99, 100, 101};
//byte[] getBytes()：返回字符串对应的字节数组
byte[] bys = "abcde".getBytes();
//void write(byte[] b, int off, int len)：将 len字节从指定的字节数组开始，从偏移量off开始写入此文件输出流
 fos.write(bys,1,3);
//最后都要释放资源
//void close()：关闭此文件输出流并释放与此流相关联的任何系统资源。
fos.close();
FileInputStream fis = new FileInputStream("idea_test\\test.txt");
byte[] bys2 = new byte[1024]; //1024及其整数倍
int len;
while ((len=fis.read(bys2))!=-1) {
    System.out.println(len);
    System.out.print(new String(bys2,0,len));
}
//释放资源
fis.close();
```

#### 字节缓冲流```BufferedOutputStream```/```BufferedInputStream```

- 字节缓冲流：
  - ```BufferedOutputStream```：该类实现缓冲输出流。 通过设置这样的输出流，应用程序可以向底层输出流写入字节，而不必为写入的每个字节导致底层系统的调用
  - ```BufferedInputStream```：创建```BufferedInputStream```将创建一个内部缓冲区数组。 当从流中读取或跳过字节时，内部缓冲区将根据需要从所包含的输入流中重新填充，一次很多字节
- 构造方法：
  - 字节缓冲输出流：```BufferedOutputStream(OutputStream out)```
  - 字节缓冲输入流：```BufferedInputStream(InputStream in)```
- 为什么构造方法需要的是字节流，而不是具体的文件或者路径呢？
  - 字节缓冲流**仅仅提供缓冲区**，而真正的读写数据还得依靠基本的字节流对象进行操作

```java
//字节缓冲输出流：BufferedOutputStream(OutputStream out)
BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream("myByteStream\\bos.txt"));
bos.write("hello\r\n".getBytes());
bos.write("world\r\n".getBytes());
//释放资源
bos.close();
//字节缓冲输入流：BufferedInputStream(InputStream in)
BufferedInputStream bis = new BufferedInputStream(new FileInputStream("myByteStream\\bos.txt"));
//一次读取一个字节数据
int by;
while ((by=bis.read())!=-1) {
	System.out.print((char)by);
}
//一次读取一个字节数组数据
 byte[] bys = new byte[1024];
int len;
while ((len=bis.read(bys))!=-1) {
	System.out.print(new String(bys,0,len));
}
//释放资源
bis.close();
```

#### 字符流```InputStreamReader```/```FileWriter```/```OutputStreamWriter```/```FileReader```

- 为什么会出现字符流？
  - 由于字节流操作中文不是特别的方便，所以Java就提供字符流
    - 字符流 = 字节流 + 编码表
  - 用字节流复制文本文件时，文本文件也会有中文，但是没有问题，原因是最终底层操作会自动进行字节拼接成中文，如何识别是中文的呢？
    - 汉字在存储的时候，无论选择哪种编码存储，第一个字节都是负数
- 小结：采用何种规则编码，就要采用对应规则解码，否则就会出现乱码
- 编码表
  - 计算机中储存的信息都是用二进制数表示的；我们在屏幕上看到的英文、汉字等字符是二进制数转换之后的结果
  - 按照某种规则，将字符存储到计算机中，称为编码。反之，将存储在计算机中的二进制数按照某种规则解析显示出来，称为解码 。这里强调一下：按照A编码存储，必须按照A编码解析，这样才能显示正确的文本符号。否则就会导致乱码现象
    - 字符编码：就是一套自然语言的字符与二进制数之间的对应规则(A,65)
- 字符集
  - 是一个系统支持的所有字符的集合，包括各国家文字、标点符号、图形符号、数字等
  - 计算机要准确的存储和识别各种字符集符号，就需要进行字符编码，一套字符集必然至少有一套字符编码。常见字符集有ASCII字符集、GBXXX字符集、Unicode字符集等
- ASCII字符集：
  - ASCII(American Standard Code for Information Interchange，美国信息交换标准代码)：是基于拉丁字母的一套电脑编码系统，用于显示现代英语，主要包括控制字符(回车键、退格、换行键等)和可显示字符(英文大小写字符、阿拉伯数字和西文符号) 
  - 基本的ASCII字符集，使用7位表示一个字符，共128字符。ASCII的扩展字符集使用8位表示一个字符，共256字符，方便支持欧洲常用字符。是一个系统支持的所有字符的集合，包括各国家文字、标点符号、图形符号、数字等
- GBXXX字符集
  - GB2312：简体中文码表。一个小于127的字符的意义与原来相同，但两个大于127的字符连在一起时， 就表示一个汉字，这样大约可以组合了包含7000多个简体汉字，此外数学符号、罗马希腊的字母、日文的假名等都编进去了，连在ASCII里本来就有的数字、标点、字母都统统重新编了两个字节长的编码，这就是常说的"全角"字符，而原来在127号以下的那些就叫"半角"字符了（GuoBiao）
  - GBK：最常用的中文码表。是在GB2312标准基础上的扩展规范，使用了双字节编码方案，共收录了21003个汉字，完全兼容GB2312标准，同时支持繁体汉字以及日韩汉字等
  - GB18030：最新的中文码表。收录汉字70244个，采用多字节编码，每个字可以由1个、2个或4个字节组成。支持中国国内少数民族的文字，同时支持繁体汉字以及日韩汉字等
- BIG5：繁体中文 港澳台等用
- Unicode字符集
  - 为表达任意语言的任意字符而设计，是业界的一种标准，也称为统一码、标准万国码。它最多使用4个字节的数字来表达每个字母、符号，或者文字。有三种编码方案，UTF-8、UTF-16和UTF32。最为常用的UTF-8编码
  - UTF-8编码：可以用来表示Unicode标准中任意字符，它是电子邮件、网页及其他存储或传送文字的应用中，优先采用的编码。互联网工程工作小组（IETF）要求所有互联网协议都必须支持UTF-8编码。它使用一至四个字节为每个字符编码
  - 编码规则：
    - 128个US-ASCII字符，只需一个字节编码
    - 拉丁文等字符，需要二个字节编码
    - 大部分常用字（含中文），使用三个字节编码
    - 其他极少使用的Unicode辅助字符，使用四字节编码
- 一个汉字存储：
  - 如果是**GBK**编码，占用2个字节
  - 如果是**UTF-8**编码，占用3个字节
- 字符流抽象基类
  - ```Reader```：字符输入流的抽象类
  - ```Writer```：字符输出流的抽象类
- 字符流中和编码解码问题相关的两个类：
  - ```InputStreamReader```
    - ```FileReader(String fileName)```：用于读取字符文件的便捷类
  - ```OutputStreamWriter```
    - ```FileWriter(String fileName)```：用于写入字符文件的便捷类



```java
//编码和解码
String s = "中国";
byte[] bys = s.getBytes("GBK");
String ss = new String(bys,"GBK");
System.out.println(ss);

OutputStreamWriter osw = new OutputStreamWriter(new FileOutputStream("myCharStream\\osw.txt"),"UTF-8");
//void write(int c)：写一个字符
osw.write(97);
osw.write(98);
//void flush()：刷新流，还可以继续写数据
//void write(char[] cbuf)：写入一个字符数组
//void write(char[] cbuf, int off, int len)：写入字符数组的一部分
char[] chs = {'a', 'b', 'c', 'd', 'e'};
osw.write(chs, 0, chs.length);
//void write(String str)：写一个字符串
//void write(String str, int off, int len)：写一个字符串的一部分
osw.write("abcde", 0, "abcde".length());
osw.close();

InputStreamReader isr = new InputStreamReader(new FileInputStream("myCharStream\\osw.txt"),"UTF-8");
//一次读取一个字符数据
int ch;
while ((ch=isr.read())!=-1) {
    System.out.print((char)ch);
}
//int read(char[] cbuf)：一次读一个字符数组数据
char[] chs = new char[1024];
int len;
while ((len = isr.read(chs)) != -1) {
    System.out.print(new String(chs, 0, len));
}
isr.close();//关闭流，释放资源，但是在关闭之前会先刷新流。一旦关闭，就不能再写数据

//更简洁，但是需要转换字符编码时，还是需要InputStreamReader和OutStreamWriter
FileReader fr = new FileReader("myCharStream\\ConversionStreamDemo.java");
//根据目的地创建字符输出流对象
FileWriter fw = new FileWriter("myCharStream\\Copy.java");

//读写数据，复制文件
//int ch;
//while ((ch=fr.read())!=-1) {
//    fw.write(ch);
//}
char[] chs = new char[1024];
int len;
while ((len=fr.read(chs))!=-1) {
    fw.write(chs,0,len);
}
//释放资源
fw.close();
fr.close();
```

#### 字符缓冲流```BufferedReader```/```BufferedWriter```

- ```BufferedWriter```：将文本写入字符输出流，缓冲字符，以提供单个字符，数组和字符串的高效写入，可以指定缓冲区大小，或者可以接受默认大小。默认值足够大，可用于大多数用途
  - ```BufferedWriter(Writer out)```
  - ```void newLine()```：写一行行分隔符，行分隔符字符串由系统属性定义
- ```BufferedReader```：从字符输入流读取文本，缓冲字符，以提供字符，数组和行的高效读取，可以指定缓冲区大小，或者可以使用默认大小。 默认值足够大，可用于大多数用途
  - ```BufferedReader(Reader in)```
  - ```public String readLine()``` ：读一行文字。 结果包含行的内容的字符串，**不包括任何行终止字符**，如果流的结尾已经到达，则为```null ```

```java
//BufferedWriter(Writer out)
BufferedWriter bw = new BufferedWriter(new FileWriter("myCharStream\\bw.txt"));
bw.write("hello\r\n");
bw.write("world\r\n");
//BufferedReader(Reader in)
BufferedReader br = new BufferedReader(new FileReader("myCharStream\\bw.txt"));
//一次读取一个字符数据
//int ch;
//hile ((ch=br.read())!=-1) {
//    System.out.print((char)ch);
//}
//一次读取一个字符数组数据
//char[] chs = new char[1024];
//int len;
//while ((len=br.read(chs))!=-1) {
//	System.out.print(new String(chs,0,len));
//}
/*String line;
while ((line=br.readLine())!=null) {
    bw.write(line);
    bw.newLine();
    bw.flush();
}*/
//做题常用

BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
String input;
while ((input = br.readLine())!=null){
    ...
    
}
br.close();
bw.close();
```

#### ```IOException```异常处理

```java
//JDK9的改进方案
private static void method4() throws IOException {
    FileReader fr = new FileReader("fr.txt");
    FileWriter fw = new FileWriter("fw.txt");
    try(fr;fw){
        char[] chs = new char[1024];
        int len;
        while ((len = fr.read()) != -1) {
            fw.write(chs, 0, len);
        }
    } catch (IOException e) {
        e.printStackTrace();
    }
}
//JDK7的改进方案
private static void method3() {
    try(FileReader fr = new FileReader("fr.txt");
        FileWriter fw = new FileWriter("fw.txt");){
        char[] chs = new char[1024];
        int len;
        while ((len = fr.read()) != -1) {
            fw.write(chs, 0, len);
        }
    } catch (IOException e) {
        e.printStackTrace();
    }    
```

#### 标准输入输出流```InputStream in```/```PrintStream out```

- System类中有两个静态的成员变量：
  - ```public static final InputStream in```：标准输入流。通常该流对应于键盘输入或由主机环境或用户指定的另一个输入源
  - ```public static final PrintStream out```：标准输出流。通常该流对应于显示输出或由主机环境或用户指定的另一个输出目标

- 自己实现键盘录入数据：
  - ```BufferedReader br = new BufferedReader(new InputStreamReader(System.in));```

- 写起来太麻烦，Java就提供了一个类实现键盘录入
  - ```Scanner sc = new Scanner(System.in);```

```java
BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
System.out.println("请输入一个整数：");
int i = Integer.parseInt(br.readLine());
System.out.println("你输入的整数是：" + i);
//自己实现键盘录入数据太麻烦了，所以Java就提供了一个类供我们使用
Scanner sc = new Scanner(System.in);
//PrintStream类有的方法，System.out都可以使用
PrintStream ps = System.out;
```

#### 字节打印流```PrintStream```/字符打印流```PrintWriter```

- 打印流分类：
  - 字节打印流：```PrintStream```
  - 字符打印流：```PrintWriter```
- 打印流的特点：
  - 只负责输出数据，不负责读取数据
  - 永远不会抛出```IOException```
  - 有自己的特有方法
- 字节打印流
  - ```PrintStream(String fileName)```：使用指定的文件名创建新的打印流
  - 使用继承父类的方法写数据，查看的时候会转码；使用自己的特有方法写数据，查看的数据原样输出
  - 可以改变输出语句的目的地 ```public static void setOut(PrintStream out)```：重新分配“标准”输出流

```java
PrintStream ps = new PrintStream("myOtherStream\\ps.txt");
ps.println(97); //不是'a'
ps.println(98); //不是'b'
ps.close();
//PrintWriter(String fileName) ：使用指定的文件名创建一个新的PrintWriter，而不需要自动执行行刷新
//PrintWriter(Writer out, boolean autoFlush)：创建一个新的PrintWriter
PrintWriter pw = new PrintWriter(new FileWriter("myOtherStream\\pw.txt"),true);
pw.println("hello");
/*
pw.write("hello");
pw.write("\r\n");
pw.flush();
 */
pw.println("world");
pw.close();
```

#### 对象序列化流```ObjectOutputStream```/对象反序列化流```ObjectInputStream```

对象序列化：就是将对象保存到磁盘中，或者在网络中传输对象

这种机制就是使用一个字节序列表示一个对象，该字节序列包含：对象的类型、对象的数据和对象中存储的属性等信息

字节序列写到文件之后，相当于文件中持久保存了一个对象的信息

反之，该字节序列还可以从文件中读取回来，重构对象，对它进行反序列化

要实现序列化和反序列化就要使用对象序列化流和对象反序列化流：

- 对象序列化流：```ObjectOutputStream```
- 对象反序列化流：```ObjectInputStream```

对象序列化流```ObjectOutputStream```

- 将Java对象的原始数据类型和图形写入```OutputStream```。 可以使用```ObjectInputStream```读取（重构）对象。 可以通过使用流的文件来实现对象的持久存储。 如果流是网络套接字流，则可以在另一个主机上或另一个进程中重构对象 

- 构造方法：
  - ```ObjectOutputStream(OutputStream out)```：创建一个写入指定的```OutputStream```的O```bjectOutputStream```

- 序列化对象的方法：
  - ```void writeObject(Object obj```)：将指定的对象写入```ObjectOutputStream```

- 注意：
  - 一个对象要想被序列化，该对象所属的类必须必须实现```Serializable```接口
  - ```Serializable```是一个标记接口，实现该接口，不需要重写任何方法

对象反序列化流```ObjectInputStream```

- ```ObjectInputStream```反序列化先前使用```ObjectOutputStream```编写的原始数据和对象

- 构造方法：
  - ```ObjectInputStream(InputStream in)```：创建从指定的```InputStream```读取的```ObjectInputStream```

- 反序列化对象的方法：
  - ```Object readObject()```：```从ObjectInputStream```读取一个对象

用对象序列化流序列化了一个对象后，假如我们修改了对象所属的类文件，读取数据会不会出问题呢？

- 会出问题，会抛出```InvalidClassException```异常

如果出问题了，如何解决呢？

- 重新序列化

- 给对象所属的类加一个```serialVersionUID ````
  - ```private static final long serialVersionUID = 42L;```

如果一个对象中的某个成员变量的值不想被序列化，又该如何实现呢？

- 给该成员变量加```transient```关键字修饰，该关键字标记的成员变量不参与序列化过程

```java
public class Student implements Serializable {
    private static final long serialVersionUID = 42L;
    private String name;
    private transient int age;
    ...
}
public static void main(String[] args) throws IOException, ClassNotFoundException {
    write();
    read();
}
//反序列化
private static void read() throws IOException, ClassNotFoundException {
    ObjectInputStream ois = new ObjectInputStream(new FileInputStream("myOtherStream\\oos.txt"));
    Object obj = ois.readObject();
    Student s = (Student) obj;
    System.out.println(s.getName() + "," + s.getAge());
    ois.close();
}
//序列化
private static void write() throws IOException {
    ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream("myOtherStream\\oos.txt"));
    Student s = new Student("林青霞", 30);
    oos.writeObject(s);
    oos.close();
}
```

### ```Object```

```object```是类层次结构的根，每个类都可以将```object```作为超类。所有类都直接或者间接的继承自该类

回想面向对象中，为什么说子类的构造方法默认访问的是父类的无参构造方法？因为它们的顶级父类只有无参构造方法

在子类重写```toString```，```equals```，可以按```Alt+Insert```自动生成

### ```Date```/```System.currentTimeMillis```/```SimpleDateFormat```

```java
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
Date d = new Date();
long time = System.currentTimeMillis();
d.setTime(time);
//y M d H m s 年月日时分秒
SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss");
String s = sdf.format(d);
System.out.println(s);

String ss = "2048-08-09 11:11:11";
SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
Date dd = sdf2.parse(ss); //这是编译时异常，可能出问题，所以throws ParseException，用try...catch...处理
System.out.println(dd);
```

### ```Calendar```

```java
import java.util.Calendar;
Calendar c = Calendar.getInstance(); //多态的形式
// 10年后的5天前
c.add(Calendar.YEAR, 10);
c.add(Calendar.DATE, -5);

//c.set(2014,10,11);
int year = c.get(Calendar.YEAR);
int month = c.get(Calendar.MONTH) + 1; //从0开始
int date = c.get(Calendar.DATE);
System.out.printf("%d年%d月%d日", year, month, date);
```

### ```InetAddress```

常用命令：

- ```ipconfig```：查看本机IP地址
- ```ping IP```地址：检查网络是否连通

特殊IP地址：

- ```127.0.0.1```：是回送地址，可以代表本机地址，一般用来测试使用

端口：设备上应用程序的唯一标识

- 端口号：用两个字节表示的整数，它的取值范围是0-65535。其中，0-1023之间的端口号用于一些知名的网络服务和应用，普通的应用程序需要使用1024以上的端口号。如果端口号被另外一个服务或应用所占用，会导致当前程序启动失败

```java
//public static InetAddress getByName(String host)：确定主机名称的IP地址。主机名称可以是机器名称，也可以是IP地址
//InetAddress address = InetAddress.getByName("itheima");
InetAddress address = InetAddress.getByName("192.168.1.8");
//public String getHostName()：获取此IP地址的主机名
String name = address.getHostName();
//public String getHostAddress()：返回文本显示中的IP地址字符串
String ip = address.getHostAddress();
```

#### UDP通信原理

- UDP协议是一种不可靠的网络协议，它在通信的两端各建立一个```Socket```对象，但是这两个```Socket```只是发送，接收数据的对象
- 因此对于基于UDP协议的通信双方而言，没有所谓的客户端和服务器的概念
- Java提供了```DatagramSocket```类作为基于UDP协议的Socket

UDP发送数据

1. 创建发送端的```Socket```对象(```DatagramSocket```)

2. 创建数据，并把数据打包
3. 调用```DatagramSocket```对象的方法发送数据
4. 关闭发送端

UDP接收数据

1. 创建接收端的```Socket```对象(```DatagramSocket```)

2. 创建一个数据包，用于接收数据

3. 调用```DatagramSocket```对象的方法接收数据

4. 解析数据包，并把数据在控制台显示

5. 关闭接收端

```java
//创建发送端的Socket对象(DatagramSocket)
//DatagramSocket() 构造数据报套接字并将其绑定到本地主机上的任何可用端口
DatagramSocket ds = new DatagramSocket();
//创建数据，并把数据打包
//DatagramPacket(byte[] buf, int length, InetAddress address, int port)
//构造一个数据包，发送长度为 length的数据包到指定主机上的指定端口号。
byte[] bys = "hello,udp,我来了".getBytes();
DatagramPacket dp = new DatagramPacket(bys,bys.length,InetAddress.getByName("192.168.1.8"),5001);
//调用DatagramSocket对象的方法发送数据
//void send(DatagramPacket p) 从此套接字发送数据报包
ds.send(dp);
//关闭发送端
//void close() 关闭此数据报套接字
ds.close();

//创建接收端的Socket对象(DatagramSocket)
//DatagramSocket(int port) 构造数据报套接字并将其绑定到本地主机上的指定端口
DatagramSocket ds = new DatagramSocket(5001);
//创建一个数据包，用于接收数据
//DatagramPacket(byte[] buf, int length) 构造一个 DatagramPacket用于接收长度为 length数据包
byte[] bys = new byte[1024];
DatagramPacket dp = new DatagramPacket(bys,bys.length);
//调用DatagramSocket对象的方法接收数据
ds.receive(dp);
//解析数据包，并把数据在控制台显示
//byte[] getData() 返回数据缓冲区
//int getLength() 返回要发送的数据的长度或接收到的数据的长度
System.out.println("数据是：" + new String(dp.getData(),0,dp.getLength()));
//关闭接收端
ds.close();
```

#### TCP通讯原理

TCP通信协议是一种可靠的网络协议，它在通信的两端各建立一个```Socket```对象，从而在通信的两端形成网络虚拟链路，

- 一旦建立了虚拟的网络链路，两端的程序就可以通过虚拟链路进行通信

- Java对基于TCP协议的的网络提供了良好的封装，使用```Socket```对象来代表两端的通信端口，并通过```Socket```产生IO流来进行网络通信

- Java为客户端提供了```Socket```类，为服务器端提供了```ServerSocket```类

TCP发送数据

1. 创建客户端的```Socket```对象(```Socket```)
2. 获取输出流，写数据
3. 释放资源

TCP接收数据

1. 创建服务器端的```Socket```对象(```ServerSocket```)
2. 监听客户端连接，返回一个```Socket```对象
3. 获取输入流，读数据，并把数据显示在控制台
4. 释放资源

```java
//案例：客户端读取文件并向服务器端上传文件，服务器端接受文件并读取到本地，给出反馈
//Client
public static void main(String[] args) throws IOException {
    //Socket(InetAddress address, int port) 创建流套接字并将其连接到指定IP地址的指定端口号
	//Socket s = new Socket(InetAddress.getByName("192.168.1.66"),10000);
    //Socket(String host, int port) 创建流套接字并将其连接到指定主机上的指定端口号
    //创建客户端Socket对象
    Socket s = new Socket("192.168.1.66",10000);
    //封装文本文件的数据
    BufferedReader br = new BufferedReader(new FileReader("myNet\\InetAddressDemo.java"));
    //OutputStream getOutputStream() 返回此套接字的输出流
    //封装输出流写数据
    BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(s.getOutputStream()));

    String line;
    while ((line=br.readLine())!=null) {
        bw.write(line);
        bw.newLine();
        bw.flush();
    }

    //自定义结束标记
//        bw.write("886");
//        bw.newLine();
//        bw.flush();

    //public void shutdownOutput()
    s.shutdownOutput();

    //接收反馈
    BufferedReader brClient = new BufferedReader(new InputStreamReader(s.getInputStream()));
    String data = brClient.readLine(); //等待读取数据
    System.out.println("服务器的反馈：" + data);

    //释放资源
    br.close();
    s.close();
}

//Server
public static void main(String[] args) throws IOException {
    //ServerSocket(int port) 创建绑定到指定端口的服务器套接字
    //创建服务器Socket对象
	ServerSocket ss = new ServerSocket(10000);
    //Socket accept() 侦听要连接到此套接字并接受它
    //监听客户端连接，返回一个对应的Socket对象
    Socket s = ss.accept();
    //接收数据
    BufferedReader br = new BufferedReader(new InputStreamReader(s.getInputStream()));
    //把数据写入文本文件
    BufferedWriter bw = new BufferedWriter(new FileWriter("myNet\\Copy.java"));

    String line;
    while ((line=br.readLine())!=null) { //等待读取数据
//            if("886".equals(line)) {
//                break;
//            }
        bw.write(line);
        bw.newLine();
        bw.flush();
    }

    //给出反馈
    BufferedWriter bwServer = new BufferedWriter(new OutputStreamWriter(s.getOutputStream()));
    bwServer.write("文件上传成功");
    bwServer.newLine();
    bwServer.flush();

    //释放资源
    bw.close();
    ss.close();
}
```



## ```Collection```集合

- ```Collection```集合概述
  - 是单例集合的顶层接口，它表示一组对象，这些对象也称为```Collection```的元素
  - JDK 不提供此接口的任何直接实现，它提供更具体的子接口（如```Set```和```List```）实现
- 创建```Collection```集合的对象
  - 多态的方式
  - 具体的实现类```ArrayList```
- **集合存储的是引用类类型，所以要使用基本类型的包装类类型**，比如```TreeSet<Integer> ts = new TreeSet<Integer>();```

![](C:\Users\admin\Desktop\practicing\图片笔记\Java\集合体系结构.jpg)

```stack```栈：FILO

```queue```队列：FIFO

```ArrayList```数组：查询快，增删慢

```LinkedList```链表：相比数组，增删快，查询慢 

### ```Iterator()```迭代器/```ListIterator```列表迭代器/增强```for```循环

```java
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
//创建集合对象
Collection<String> c = new ArrayList<String>();
//boolean add(E e)：添加元素
c.add("hello");
c.add("world");
//boolean remove(Object o)：从集合中移除指定的元素
System.out.println(c.remove("world"));
System.out.println(c.remove("javaee"));
//void clear()：清空集合中的元素
c.clear();
//boolean contains(Object o)：判断集合中是否存在指定的元素
System.out.println(c.contains("world"));
System.out.println(c.contains("javaee"));
//boolean isEmpty()：判断集合是否为空
System.out.println(c.isEmpty());
//int size()：集合的长度，也就是集合中元素的个数
System.out.println(c.size());
//Iterator<E> iterator()：返回此集合中元素的迭代器，通过集合的iterator()方法得到
//迭代器是通过集合的iterator()方法得到的，所以我们说它是依赖于集合而存在的
Iterator<String> it = c.iterator();
//boolean hasNext()：如果迭代具有更多元素，则返回true
while (it.hasNext()) {
    //E next()：返回迭代的下一个元素
	String s = it.next();
	System.out.println(s);
}

List<String> list = new ArrayList<String>();

//添加元素
list.add("hello");
list.add("world");
list.add("java");

//从后往前显示
ListIterator<String> lit = list.listIterator();
while (lit.hasPrevious()) {
    String s = lit.previous();
    System.out.println(s);
}

//不会引发并发修改异常，因为会把预期修改值赋值给实际修改值
while (lit.hasNext()) {
    String s = lit.next();
    if(s.equals("world")) {
        lit.add("javaee");
    }
}


//增强for循环
for(String s : list) {
    System.out.println(s);
}
//内部原理是一个Iterator迭代器
/*
for(String s : list) {
    if(s.equals("world")) {
        list.add("javaee"); //ConcurrentModificationException
    }
}
*/

```

#### 运行时异常```ConcurrentModificationException```并发修改异常

- 产生原因：迭代器遍历的过程中，通过集合对象修改了集合中的元素，造成了迭代器获取元素中判断预期修改值(```expectedModCount```)和实际修改值(```modCount```)不一致，但是```ListIterator```列表迭代器不会显示异常

- 解决方案：用for循环遍历，然后用集合对象做对应的操作即可

### ```LinkedList```链表

```java
import java.util.*;
LinkedList<String> ll = new LinkedList<String>();
ll.add("Hello");
ll.add("World");
ll.add("Java");
//public void addFirst(E e)：在该列表开头插入指定的元素
ll.addFirst("Begin");
//public void addLast(E e)：将指定的元素追加到此列表的末尾
ll.addLast("End");
//public E getFirst()：返回此列表中的第一个元素
System.out.println(ll.getFirst());
//public E getLast()：返回此列表中的最后一个元素
System.out.println(ll.getLast());
//public E removeFirst()：从此列表删除并返回第一个元素
System.out.println(ll.removeFirst());
//public E removeLast()：从此列表删除并返回最后一个元素
System.out.println(ll.removeLast());
for (String s: ll) System.out.println(s);
```

### ```Set```集合

```java
import java.util.*;
Set<String> set = new HashSet<String>();
HashSet<String> hs = new HashSet<String>();
LinkedHashSet<String> linkedHashSet = new LinkedHashSet<String>();
linkedHashSet.add("Hello");
linkedHashSet.add("World");
linkedHashSet.add("Java");
linkedHashSet.add("World");
for (String s: linkedHashSet) System.out.println(s);
TreeSet<Integer> ts = new TreeSet<Integer>();
ts.add(10);
ts.add(5);
ts.add(90);
ts.add(60);
ts.add(30);
ts.add(30);
for (Integer i: ts) System.out.println(i);
```

#### 哈希值

- 哈希值：是JDK根据对象的**地址**或者**字符串**或者**数字**算出来的int类型的数值

- Object类中有一个方法可以获取对象的哈希值
  - ```public int hashCode()```：返回对象的哈希码值
- 对象的哈希值特点
  - 同一个对象多次调用```hashCode()```方法返回的哈希值是相同的
  - **默认情况下**，不同对象的哈希值是不同的。而重写```hashCode()```方法，可以实现让不同对象的哈希值相同

![](C:\Users\admin\Desktop\practicing\图片笔记\Java\常见数据结构之哈希表.jpg)

![](C:\Users\admin\Desktop\practicing\图片笔记\Java\HashSet集合保证元素唯一性源码分析.jpg)

#### ```HashSet```

- 底层数据结构是哈希表
- 对集合的迭代顺序不作任何保证，也就是说不保证存储和取出的元素顺序一致
- **没有带索引的方法，所以不能使用普通```for```循环遍历。可以使用迭代器或增强```for```遍历**
- 由于是Set集合，所以是不包含重复元素的集合

#### ```LinkedHashSet```

- 哈希表和链表实现的Set接口，具有可预测的迭代次序
- 由链表保证元素有序，也就是说元素的存储和取出顺序是一致的
- 由哈希表保证元素唯一，也就是说没有重复的元素

#### ```TreeSet```

- 元素有序，这里的顺序不是指存储和取出的顺序，而是按照一定的规则进行排序，具体排序方式取决于构造方法
  - ```TreeSet()```：根据其元素的自然排序进行排序
  - ```TreeSet(Comparator comparator)``` ：根据指定的比较器进行排序
- **没有带索引的方法，所以不能使用普通```for```循环遍历。可以使用迭代器或增强```for```遍历**
- 由于是Set集合，所以不包含重复元素的集合

### 自然排序```Comparable```

- 用```TreeSet```集合存储自定义对象，无参构造方法使用的是自然排序对元素进行排序的
- 自然排序，就是让元素所属的类实现Comparable接口，重写```compareTo(T o)```方法
- 重写方法时，一定要注意排序规则必须按照要求的主要条件和次要条件来写

```java
public class Student implements Comparable<Student> {
//...

    @Override
    public int compareTo(Student s) {
//        return 0; 相同
//        return 1; 大于
//        return -1; 小于
        //按照年龄从小到大排序
       int num = this.age - s.age;
//        int num = s.age - this.age;
        //年龄相同时，按照姓名的字母顺序排序
       int num2 = num==0?this.name.compareTo(s.name):num;
        return num2;
    }
}
```

### 比较器排序```Comparator```

- 用```TreeSet```集合存储自定义对象，带参构造方法使用的是比较器排序对元素进行排序的
- 比较器排序，就是让集合构造方法接收```Comparator```的实现类对象，重写```compare(T o1,T o2)```方法
- 重写方法时，一定要注意排序规则必须按照要求的主要条件和次要条件来写

```java
//匿名内部类
TreeSet<Student> ts = new TreeSet<Student>(new Comparator<Student>() {
    @Override
    public int compare(Student s1, Student s2) {
        //this.age - s.age
        //s1,s2
        int num = s1.getAge() - s2.getAge(); //不能直接访问
        int num2 = num == 0 ? s1.getName().compareTo(s2.getName()) : num;
        return num2;
    }
});
```

## ```Map```集合

- Map集合概述
  - ```Interface Map<K,V>```	K：键的类型；V：值的类型
    将键映射到值的对象；不能包含重复的键；每个键可以映射到最多一个值。同一个键第二次出现时，```put```会修改值
  - 举例：学生的学号和姓名
- 创建Map集合的对象
  - 多态的方式
  - 具体的实现类```HashMap```

```java
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

Map<String,String> map = new HashMap<String,String>();

//V put(K key,V value)：添加元素
map.put("张无忌","赵敏");
map.put("郭靖","黄蓉");
map.put("杨过","小龙女");

//V remove(Object key)：根据键删除键值对元素
System.out.println(map.remove("郭襄"));
//void clear()：移除所有的键值对元素
map.clear();
//boolean containsKey(Object key)：判断集合是否包含指定的键
//boolean containsValue(Object value)：判断集合是否包含指定的值
System.out.println(map.containsKey("郭襄"));
//boolean isEmpty()：判断集合是否为空
ystem.out.println(map.isEmpty());
//int size()：集合的长度，也就是集合中键值对的个数
System.out.println(map.size());

//V get(Object key):根据键获取值
System.out.println(map.get("张无忌"));


//Set<K> keySet():获取所有键的集合
Set<String> keySet = map.keySet();
for(String key : keySet) {
	System.out.println(key);
}

//Collection<V> values():获取所有值的集合
Collection<String> values = map.values();
for(String value : values) {
	System.out.println(value);
}
//Set<Map.Entry<k,v>> entrySet()：获取所有键值对对象的集合
//遍历map中的对象
Set<Map.Entry<String, String>> entrySet = map.entrySet();
//遍历键值对对象的集合，得到每一个键值对对象
for (Map.Entry<String, String> me : entrySet) {
	//根据键值对对象获取键和值
	String key = me.getKey();
	String value = me.getValue();
	System.out.println(key + "," + value);
}
//TreeMap是可以排序的
//example
ArrayList<HashMap<String, String>> array = new ArrayList<HashMap<String, String>>();

//创建HashMap集合，并添加键值对元素
HashMap<String, String> hm1 = new HashMap<String, String>();
hm1.put("孙策", "大乔");
hm1.put("周瑜", "小乔");
//把HashMap作为元素添加到ArrayList集合
array.add(hm1);
// ...
for (HashMap<String, String> hm : array) {
    Set<String> keySet = hm.keySet();
    for (String key : keySet) {
        String value = hm.get(key);
        System.out.println(key + "," + value);
    }
}
```

### ```Properties```

```Properties```概述：

- 是一个**Map体系**的集合类
- ```Properties```可以保存到流中或从流中加载
- 属性列表中的每个键及其对应的值都是一个字符串

```java
//创建集合对象
Properties prop = new Properties();
//Object setProperty(String key, String value)：设置集合的键和值，都是String类型，底层调用Hashtable方法put
prop.setProperty("itheima001", "林青霞");
//String getProperty(String key)：使用此属性列表中指定的键搜索属性
System.out.println(prop.getProperty("itheima001"));
//Set<String> stringPropertyNames()：从该属性列表中返回一个不可修改的键集，其中键及其对应的值是字符串
Set<String> names = prop.stringPropertyNames();
for (String key : names) {
    String value = prop.getProperty(key);
    System.out.println(key + "," + value);
}

//把集合中的数据保存到文件
private static void myLoad() throws IOException {
    Properties prop = new Properties();
	//void load(InputStream inStream):从输入字节流读取属性列表（键和元素对）
    //void load(Reader reader):从输入字符流读取属性列表（键和元素对）
    FileReader fr = new FileReader("myOtherStream\\fw.txt");
    prop.load(fr);
    fr.close();
    System.out.println(prop);
}
//把文件中的数据加载到集合
private static void myStore() throws IOException {
    Properties prop = new Properties();
    prop.setProperty("itheima001","林青霞");
    //void store(OutputStream out, String comments):将此属性列表（键和元素对）写入此 Properties表中，以适合于使用 load(InputStream)方法的格式写入输出字节流
    //void store(Writer writer, String comments):将此属性列表（键和元素对）写入此 Properties表中，以适合使用 load(Reader)方法的格式写入输出字符流
    FileWriter fw = new FileWriter("myOtherStream\\fw.txt");
    prop.store(fw,null);
    fw.close();
}
```

## ```Collections```

- Collections类的概述
  - **由静态方法组成**
  - 是针对集合操作的工具类
- Collections类的常用方法
  - ```public static <T extends Comparable<? super T>> void sort(List<T> list)```：将指定的列表按升序排序
  - ```public static void reverse(List<?> list)```：反转指定列表中元素的顺序
  - ```public static void shuffle(List<?> list)```：使用默认的随机源随机排列指定的列表

```java
List<Integer> list = new ArrayList<Integer>();
list.add(10);
list.add(20);
list.add(30);
list.add(40);

Collections.sort(list);
Collections.reverse(list);
Collections.shuffle(list);
```

# Junit单元测试

测试分类：
1. 黑盒测试：不需要写代码，给输入值，看程序是否能够输出期望的值。
2. 白盒测试：需要写代码的。关注程序具体的执行流程。

Junit使用：白盒测试

步骤：

1. 定义一个测试类(测试用例)
	* 建议：
		* 测试类名：```被测试的类名Test```		```CalculatorTest```
		* 包名：```xxx.xxx.xx.test```		```cn.itcast.test```

2. 定义测试方法：可以独立运行
	* 建议：
		* 方法名：```test测试的方法名```		```testAdd()```
		* 返回值：```void```
		* 参数列表：空参

3. 给方法加```@Test```
4. 导入junit依赖环境

判定结果：
* 红色：失败
* 绿色：成功
* 一般我们会使用断言操作来处理结果：```Assert.assertEquals(期望的结果,运算的结果);```

补充：
* ```@Before```：修饰的方法会在测试方法之前被自动执行
* ```@After```：修饰的方法会在测试方法执行之后自动被执行

```java
public class CalculatorTest {
	//初始化方法：用于资源申请，所有测试方法在执行之前都会先执行该方法
    @Before
    public void init(){
        System.out.println("init...");
    }
    //释放资源方法：在所有测试方法执行完后，都会自动执行该方法
    @After
    public void close(){
        System.out.println("close...");
    }
    //测试add方法
    @Test
    public void testAdd(){
        System.out.println("testAdd...");
        Calculator c  = new Calculator();
        int result = c.add(1, 2);
        //3.断言  我断言这个结果是3
        Assert.assertEquals(3,result);
    }
    //测试sub方法
    @Test
    public void testSub(){
        System.out.println("testSub....");
        Calculator c  = new Calculator();
        int result = c.sub(1, 2);
        Assert.assertEquals(-1,result);
    }
}
```



# 注解

说明程序的。给计算机看的。

作用：

- 编写文档：通过代码里标识的注解生成文档【生成文档doc文档】
- 代码分析：通过代码里标识的注解对代码进行分析【使用反射】
- 编译检查：通过代码里标识的注解让编译器能够实现基本的编译检查【Override】

JDK中预定义的一些注解

- ```@Override```：检测被该注解标注的方法是否是继承自父类(接口)的
- ```@Deprecated```：该注解标注的内容，表示已过时。但需要兼容低版本，所以不删除。
- ```@SuppressWarnings```：压制警告
  - 一般传递参数```all``` - ```@SuppressWarnings("all")```

写的时候可以用的

- ```@param```
- ```@return```
- ```@throws```
- ```@since```
- ```@link```
- ```@exception```
- ```@see```

## 自定义注解

格式：

- 元注解
  - ```public @interface 注解名称{属性列表;}```

本质：注解本质上就是一个接口，该接口默认继承```Annotation```接口

- ```public interface MyAnno extends java.lang.annotation.Annotation {}```

属性：接口中的抽象方法

- 要求：
  - 属性的返回值类型有下列取值
    - 基本数据类型
    - String
    - 枚举(```public enum Persion{P1, p2;}```)
    - 注解(```public @interface Anno{}```)
    - 以上类型的数组
  - 定义了属性，在使用时需要给属性赋值
    - ```@Anno(value=12, per = Person.p1, anno = @Anno, strs ={"aaa", "bbb"} )```
    - 如果只有一个属性需要赋值，并且属性的名称是```value```，则```value```可以省略，直接定义值即可。```@Anno(12)```
    - 如果定义属性时，使用default关键字给属性默认初始化值，则使用注解时，可以不进行属性的赋值。：```String name() default "zhangsan";```
    - 数组赋值时，值使用```{}```包裹。如果数组中只有一个值，则```{}```可以省略

## 元注解

用于描述注解的注解

- ```@Target```：描述注解能够作用的位置(```@Target({ElementType.METHOD, ElementType.FIELD})```)
  - ```ElementType```（枚举类）取值：
    - ```TYPE```：可以作用于类上
    - ```METHOD```：可以作用于方法上
    - ```FIELD```：可以作用于成员变量上

- ```@Retention```：描述注解被保留的阶段。```@Retention(RetentionPolicy.RUNTIME)```：当前被描述的注解，会保留到class字节码文件中，并被JVM读取到
  - ```RetionPolicy```
    - ```SOURCE```
    - ```CLASS```
    - ```RUNTIME```

- ```@Documented```：描述注解是否被抽取到api文档中

- ```@Inherited```：描述注解是否被子类继承

## 注解的解析

在程序使用(解析)注解：获取注解中定义的属性值

- 获取注解定义的位置的对象：```Class```, ```Method```, ```Field```
- 获取指定的注解
  - ```getAnnotation(Class)```
  - ```method.isAnnotationPresent(Pro.class)```：当前方法上有没有指定的注解被
- 调用注解类中的抽象方法获取配置的属性值

```java
/**
 * 描述需要执行的类名，和方法名
 */

@Target({ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
public @interface Pro {

    String className();//代表了一套规范
    String methodName();
}

//反射读取配置文件的案例，自定义包名和方法名并使用反射运行
@Pro(className = "cn.itcast.annotation.Demo1",methodName = "show")
public class ReflectTest {
    public static void main(String[] args) throws Exception {
        Class<ReflectTest> reflectTestClass = ReflectTest.class;
        //2.获取上边的注解对象
        //其实就是在内存中生成了一个该注解接口的子类实现对象，实现类重写了以下两个方法          
        /*
            public class ProImpl implements Pro{
                public String className(){
                    return "cn.itcast.annotation.Demo1";
                }
                public String methodName(){
                    return "show";
                }

            }
 */
        Pro an = reflectTestClass.getAnnotation(Pro.class);
        //3.调用注解对象中定义的抽象方法，获取返回值
        String className = an.className();
        String methodName = an.methodName();
        //3.加载该类进内存
        Class cls = Class.forName(className);
        //4.创建对象
        Object obj = cls.newInstance();
        //5.获取方法对象
        Method method = cls.getMethod(methodName);
        //6.执行方法
        method.invoke(obj);       
    }
}

```

小结：

- 以后大多数时候，我们会使用注解，而不是自定义注解

- 注解给谁用？
  - 编译器
  - 给解析程序用
  
- 注解不是程序的一部分，可以理解为注解就是一个标签

  # IDEA

- 生成```main()```: ``` psvm + Enter```

- 生成```System.out.println```语句: ```sout + Enter```

- 生成iterator遍历：```iter + Enter```

- ```Alt+Insert```：在类中自动生成常用方法

- ```Ctrl+Alt+V```：自动生成变量接受

- ```Alt+Enter```：提供解决办法

- 

# My Note

stack：栈内存。存储局部变量，定义在方法中的变量。使用完毕，立即消失。

heap：堆内存。存储```new```出来的内容（实体，对象）。数组在初始化时，会为存储空间添加默认值(0,0.0,false,空字符,null)。每一个```new```出来的东西都有一个地址值。使用完毕，会在垃圾回收器空闲时被回收。

接口中的抽象方法不能有主体（没有```{}```及内容），抽象类中的抽象方法也不能有主体

常见的命名约定

- 小驼峰命名法：方法、变量
  - 约定1：标识符是一个单词的时候，首字母小写。```name```
  - 约定2：标识符由多个单词组成的时候，第一个单词首字母小写，其他单词首字母大写。```firstName```

- 大驼峰命名法：类
  - 约定1：标识符是一个单词的时候，首字母大写。```Student```

- 约定2：标识符由多个单词组成的时候，每个单词的首字母大写。```GoodStudent```


## ```static``` 

static修饰的变量我们称之为静态变量，没有用static修饰的变量称之为实例变量，他们两者的区别是：

静态变量是随着类加载时被完成初始化的，它在内存中仅有一个，且JVM也只会为它分配一次内存，同时类所有的实例都共享静态变量，可以直接通过类名来访问它，任何一个实例对其的修改都会导致其他实例的变化。

但是实例变量则不同，它是伴随着实例的，每创建一个实例就会产生一个实例变量，它与该实例同生共死。

所以我们一般在这两种情况下使用静态变量：对象之间共享数据、访问方便。

- 不能以任何形式引用this、super。

- static变量在定义时必须要进行初始化，且初始化时间要早于非静态变量。

## Creation of an executable *.jar file

You've got two options here 

1. With an external manifest file :
   - Create the manifest file say - MANIFEST.mf
   - The MANIFEST file is nothing but an explicit entry of the Main Class
   - ```jar -cvfm TheJavaFile.jar MANIFEST.mf TheJavaFile.class```
2. Executable by Entry Point:
   - ```jar -cvfe TheJavaFile.jar <MainClass> TheJavaFile.class```

To run the Jar File: ```java -jar TheJavaFile.jar```



# Reference

## what is JVM(Java Virtual Machine)?

The JVM has two primary functions: **to allow Java programs to run on any device or operating system (known as the "Write once, run anywhere" principle), and to manage and optimize program memory**. When Java was released in 1995, all computer programs were written to a specific operating system, and program memory was managed by the software developer. So the JVM was a revelation.

Let's break those down:

- Technical definition: The JVM is the specification for a software program that executes code and provides the runtime environment for that code.
- Everyday definition: The JVM is how we run our Java programs. We configure the JVM's settings and then rely on it to manage program resources during execution.

> The JVM is a virtual machine that runs Java class files in a portable way. Being a virtual machine means the JVM is an abstraction of an underlying, actual machine--such as the server that your program is running on. Regardless of what operating system or hardware is actually present, the JVM creates a predictable environment for programs to run within. Unlike a true virtual machine, however, *the JVM doesn't create a virtual operating system*. It would be more accurate to describe the JVM as a *managed runtime environment*, or a process virtual machine.

### Memory management in the JVM

The most common interaction with a running JVM is to check the memory usage in the **heap** and **stack**. The most common adjustment is tuning the JVM's memory settings.

### Garbage collection

Before Java, all program memory was managed by the programmer. In Java, program memory is managed by the JVM. The JVM manages memory through a process called garbage collection, which continuously identifies and eliminates unused memory in Java programs. Garbage collection happens inside a running JVM.

In the early days, Java came under a lot of criticism for not being as "close to the metal" as C++, and therefore not as fast. The garbage collection process was especially controversial. Since then, a variety of algorithms and approaches have been proposed and used for garbage collection. With consistent development and optimization, garbage collection has vastly improved.

> **What does 'close to the metal' mean?**
> When programmers say a programming language or platform is "close to the metal," we mean the developer is able to programmatically (by writing code) manage an operating system's memory. In theory, programmers can wring more performance out of our programs by stipulating how much is used and when to discard it. **In most cases, delegating memory management to a highly refined process like the JVM yields better performance and fewer errors than doing it yourself**.

### Loading and executing class files in the JVM

We've talked about the JVM's role in running Java applications, but how does it perform its function? In order to run Java applications, the JVM depends on the **Java class loader** and a **Java execution engine**.

#### The Java class loader in the JVM

**Everything in Java is a class, and all Java applications are built from classes.** An application could consist of one class or thousands. In order to run a Java application, a JVM must load compiled ```.class``` files into a context, such as a server, where they can be accessed. A JVM depends on its class loader to perform this function.

The Java class loader is the part of the JVM that loads classes into memory and makes them available for execution. Class loaders use techniques like lazy-loading and caching to make class loading as efficient as it can be. That said, class loading isn't the epic brain-teaser that (say) portable runtime memory management is, so the techniques are comparatively simple.

Every Java virtual machine includes a class loader. The JVM spec describes standard methods for querying and manipulating the class loader at runtime, but JVM implementations are responsible for fulfilling these capabilities. **From the developer's perspective, the underlying class loader mechanisms are typically a black box**.

#### The execution engine in the JVM

Once the class loader has done its work of loading classes, the JVM begins executing the code in each class. The execution engine is the JVM component that handles this function. The execution engine is essential to the running JVM. In fact, for all practical purposes, it is the JVM instance.

Executing code involves managing access to system resources. The JVM execution engine stands between the running program--with its demands for file, network and memory resources--and the operating system, which supplies those resources.

##### How the execution engine manages system resources

System resources can be divided into two broad categories: memory and everything else.

Recall that the JVM is responsible for disposing of unused memory, and that garbage collection is the mechanism that does that disposal. The JVM is also responsible for allocating and maintaining the referential structure that the developer takes for granted. **As an example, the JVM's execution engine is responsible for taking something like the new keyword in Java, and turning it into an OS-specific request for memory allocation.**

Beyond memory, the execution engine manages resources for file system access and network I/O. Since the JVM is interoperable across operating systems, this is no mean task. In addition to each application's resource needs, the execution engine must be responsive to each OS environment. That is how the JVM is able to handle in-the-wild demands.

Having a specification ensures interoperability of Java programs across different implementations so that program authors using the Java Development Kit (JDK) need not worry about idiosyncrasies of the underlying hardware platform.

### Class loader

The class loader performs three basic activities in this strict order:

1. **Loading**: finds and imports the binary data for a type
2. **Linking**: performs verification, preparation, and (optionally) resolution
   - Verification: ensures the correctness of the imported type
   - Preparation: allocates memory for class variables and initializing the memory to default values
   - Resolution: transforms symbolic references from the type into direct references.
3. **Initialization**: invokes Java code that initializes class variables to their proper starting values.

In general, there are two types of class loader: bootstrap class loader and user defined class loader.

Every Java virtual machine implementation must have a bootstrap class loader, capable of loading trusted classes. The Java virtual machine specification doesn't specify how a class loader should locate classes.

### JVM languages

A JVM language is any language with functionality that can be expressed in terms of a valid class file which can be hosted by the Java Virtual Machine. A class file contains Java Virtual Machine instructions (Java byte code) and a symbol table, as well as other ancillary information. The class file format is the hardware- and operating system-independent binary format used to represent compiled classes and interfaces.

There are several JVM languages, both old languages ported to JVM and completely new languages. JRuby and Jython are perhaps the most well-known ports of existing languages, i.e. Ruby and Python respectively. Of the new languages that have been created from scratch to compile to Java bytecode, Clojure, Apache Groovy, Scala and Kotlin may be the most popular ones. A notable feature with the JVM languages is that they are compatible with each other, so that, for example, Scala libraries can be used with Java programs and vice versa.

Java 7 JVM implements JSR 292: Supporting Dynamically Typed Languages on the Java Platform, a new feature which supports dynamically typed languages in the JVM. This feature is developed within the Da Vinci Machine project whose mission is to extend the JVM so that it supports languages other than Java.

**More details check [How JVM Works – JVM Architecture?](https://www.geeksforgeeks.org/jvm-works-jvm-architecture/), [Differences between JDK, JRE and JVM](https://www.geeksforgeeks.org/differences-jdk-jre-jvm/)**

## Maven

### From Google

#### What it does

Maven is a "build management tool", it is for defining how your ```.java``` files get compiled to ```.class```, packaged into ```.jar``` (or ```.war``` or ```.ear```) files, (pre/post)processed with tools, managing your **CLASSPATH**, and all others sorts of tasks that are required to build your project. It is similar to *Apache Ant* or *Gradle* or , <u>Makefiles in C/C++</u>, but it attempts to be completely self-contained in it that you shouldn't need any additional tools or scripts by incorporating other common tasks like downloading & installing necessary libraries etc.

It is also designed around the "build portability" theme, so that you don't get issues as having the same code with the same buildscript working on one computer but not on another one (this is a known issue, we have VMs of Windows 98 machines since we couldn't get some of our Delphi applications compiling anywhere else). *Because of this, it is also the best way to work on a project between people who use different IDEs* since IDE-generated Ant scripts are hard to import into other IDEs, but all IDEs nowadays understand and support Maven (IntelliJ, Eclipse, and NetBeans). Even if you don't end up liking Maven, it ends up being the point of reference for all other modern builds tools.

#### Why you should use it

There are three things about Maven that are very nice.

1. Maven will (after you declare which ones you are using) download all the libraries that you use and the libraries that they use for you automatically. This is very nice, and makes dealing with lots of libraries ridiculously easy. This lets you avoid "dependency hell". It is similar to Apache Ant's Ivy.

2. It uses "Convention over Configuration" so that by default you don't need to define the tasks you want to do. You don't need to write a "compile", "test", "package", or "clean" step like you would have to do in Ant or a Makefile. Just put the files in the places in which Maven expects them and it should work off of the bat.

3. Maven also has lots of nice plug-ins that you can install that will handle many routine tasks from generating Java classes from an XSD schema using JAXB to measuring test coverage with Cobertura. Just add them to your ```pom.xml``` and they will integrate with everything else you want to do.

The initial learning curve is steep, but (nearly) every professional Java developer uses Maven or wishes they did. You should use Maven on every project although don't be surprised if it takes you a while to get used to it and that sometimes you wish you could just do things manually, since learning something new sometimes hurts. However, once you truly get used to Maven you will find that build management takes almost no time at all.

#### How to Start

The best place to start is [Maven in 5 Minutes](http://maven.apache.org/guides/getting-started/maven-in-five-minutes.html). It will get you start with a project ready for you to code in with all the necessary files and folders set-up (yes, I recommend using the quickstart archetype, at least at first).

After you get started you'll want a better understanding over how the tool is intended to be used. For that [Better Builds with Maven](https://web.archive.org/web/20130903151814/http://www.maestrodev.com/wp-content/uploads/2012/03/betterbuildswithmaven-2008.pdf) is the most thorough place to understand the guts of how it works, however, [Maven: The Complete Reference](https://www.sonatype.com/ebooks) is more up-to-date. Read the first one for understanding, but then use the second one for reference.

