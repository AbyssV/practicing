[TOC]

# Namespace

Namespaces allow us to group named entities that otherwise would have global scope into narrower scopes, giving them namespace scope. This allows organizing the elements of programs into different logical scopes referred to by names.

- A namespace is a declarative region that provides a scope to the identifiers (names of the types, function, variables etc) inside it.
- Multiple namespace blocks with the same name are allowed. All declarations within those blocks are declared in the named scope.

- Namespace declarations appear only at global scope.
- Namespace declarations can be nested within another namespace.
- Namespace declarations don’t have access specifiers. (Public or private)
- No need to give semicolon after the closing brace of definition of namespace.
- We can split the definition of namespace over several units.

## simple example

```c++
// Creating namespaces 
#include <iostream> 
using namespace std; 
namespace ns1 
{ 
	int value() { return 5; } 
} 
namespace ns2 
{ 
	const double x = 100; 
	double value() { return 2*x; } 
} 

int main() 
{ 
	// Access value function within ns1 
	cout << ns1::value() << '\n'; 

	// Access value function within ns2 
	cout << ns2::value() << '\n'; 

	// Access variable x directly 
	cout << ns2::x << '\n';	 

	return 0; 
} 
```

### output

```
5
200
100
```



## namespace with class

- Class can also be declared inside namespace and defined outside namespace

- We can define methods also outside the namespace

```c++
// A C++ code to demonstrate that we can define 
// methods outside namespace. 
#include <iostream> 
using namespace std; 

// Creating a namespace 
namespace ns 
{ 
	void display(); 
	class geek 
	{ 
	public: 
	void display(); 
	}; 
} 

// Defining methods of namespace 
void ns::geek::display() 
{ 
	cout << "ns::geek::display()\n"; 
} 
void ns::display() 
{ 
	cout << "ns::display()\n"; 
} 

// Driver code 
int main() 
{ 
	ns::geek obj; 
	ns::display(); 
	obj.display(); 
	return 0; 
} 
```

### output

```
ns::display()
ns::geek::display()
```



#  #define, #ifndef, #else and #endif

Those are called [#include guards](https://en.wikipedia.org/wiki/Include_guard)(check the example).

In the C and C++ programming languages, an #include guard, sometimes called a macro guard or header guard, is a particular construct used to avoid the problem of double inclusion when dealing with the include directive.

The C preprocessor processes directives of the form #include <file> in a source file by locating the associated file on disk and transcluding ("including") its contents into a copy of the source file known as the translation unit, replacing the include directive in the process. The files included in this regard are generally header files, which typically contain declarations of functions and classes or structs. If certain C or C++ language constructs are defined twice, the resulting translation unit is invalid. #include guards prevent this erroneous construct from arising by the double inclusion mechanism.

The addition of #include guards to a header file is one way to make that file idempotent.[citation needed] Another construct to combat double inclusion is #pragma once, which is non-standard but nearly universally supported among C and C++ compilers.

```c++
#ifndef <token>
/* code */
#else
/* code to include if the token is defined */
#endif
```

```#ifndef``` checks whether the given token has been ```#defined``` earlier in the file or in an included file; if not, it includes the code between it and the closing ```#else``` or, if no ```#else``` is present, ```#endif``` statement. ```#ifndef``` is often used to make header files idempotent by defining a token once the file has been included and checking that the token was not set at the top of that file.

```c++
#ifndef _INCL_GUARD
#define _INCL_GUARD
#endif
```



# compile cpp file with clang

```clang++ -Wall -std=c++11 your_file.cpp -o your_program```

```g++ -Wall -std=c++11 your_file.cpp -o your_program```

For short, run ```g++ hello.cpp -o hello```, then run ```./hello```

```-Wall``` means to enable all compiler warnings. And ```-Werror``` means treat all warnings as errors. In other words, any possible warning that the compiler has determined will be shown to you if your code meets it, and it will be treated as a compile error that must be fixed.



# More questions

what is the relationship between gcc, cygwin, mingw, cmake, clang?

[cmake经典教程](https://blog.csdn.net/ruglcc/article/details/7814546/)

[跟我一起写 Makefile](https://blog.csdn.net/haoel/article/details/2886)