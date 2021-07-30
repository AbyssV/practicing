[TOC]

# prime data type

## integral types

- short: 2 bytes, -32768 through 32768
- int: 4 bytes
- long: 4 bytes
- long long: 8 bytes

## floating point types

- float: 4 bytes
- double: 8 bytes
- long double: 8 bytes

## the character type

char: 1 byte, either -128 through 127 or 0 to 255

represents an ASCII character code

## the character string type

represents a sequence of characters

usually declared as a char *

```const char* s = "Hello";```

## the class string

a standard library class wrapper

also a sequence of characters

may use iterators to traverse

## boolean 

precedence rules

1. ! ++ -- (unary) + -

2. \* / %

3. \+ -

4. < <= > >=

5. == !=

6. &&

7. ||

8. = += -= \*= /= %=

   

# const

**constants may not be assigned, compiler will give a warning message**

```const double PI = 3.141592653;```

```#define BUF_SIZE 100```

# operator precedence

from highest to lowest

-  ++ --
- \* / %

- \+ -
- = += -= *= /= %=

# input and output

## input

- input is done via the ```>>``` operator
- the ```>>``` operator uses references parameter to modify its value
- called an "extractor"
- ```cin``` stands for standard input (defaults to the console)
- it waits for a value to be entered (may require a **return/enter**)

## output

- output is done via ```<<``` operator
- called an "inserter"
- ```cout``` stands for the standard output (defaults to the console)

# files and libraries

- **.h** files include class and function declarations
- **.cpp** files include definitions of functions and class member function
- **.cpp** files typically ```#include``` the **.h** files they use
- a **.h** file must be included where its declarations are used
- ==each **.cpp** file is compiled to object module==
- ==object modules are linked together to form a program==

# templates

- classes and functions may be templates
- templates parameters are types and constants
- allows definition of reusable classes and functions



# exceptions

- useful for making code more rebust
- typically for handling errors and boundary conditions
- exceptions are thrown and must be caught
- exceptions are sent to appropriate catch by type matching



# class

```c++
#include <iostream>
using namespace std;


// you can also use .h file with scope qualifier
class Complex{
public:
    float re, im;
    // define a constructor
    // a constructor must build and initialize our objects
    Complex(float newRe = 0.0, float newIm = 0.0):re(newRe), im(newIm){}


    // member functions
    // members of "this" are directly visible
    // they may access private and public class members
    Complex add(Complex c){
        return Complex(this->re+c.re, im+c.im);

    }

    void print(ostream &out){
        out << "(" << re << "+" << im << "i)";

    }



    ~Complex(){} // it is called just before deallocation of this object

};

// c++ allows us to define a << operator for our new type
// operator << can not be a member function
ostream & operator << (ostream&out, Complex c){
    c.print(out);
    return out;

}

```



# statement

## switch statement

```c++
int main(){
    int i = getIntegerFromUser(); 
    switch(i){
        case 1:
        case 3:
        case 5:
        case 7:    
        case 9:
            cout << i << "is odd\n";
            break;
        case 0:
        case 2:
        case 4:
        case 6:
        case 8:
            cout << i << "is even\n";
            break;
        default:
            cout << i << "isn't in range 0 to 9\n";
            break;
    }
```

## do while statement

while: natural for testing before doing an action that involves repetition

do while: natural for doing an action then testing for completion before repetition

**loop control variable is only in scope over loop body**

**some errors may cause an infinite loop**



# Array

## simple arrays

a fixed size, single-dimensional array of elements of the same type

## character arrays

- also known as character strings
- character strings are arrays of characters terminated by '\0'
- tricky thing is you need an extra element for the terminator

```c++
char s1[4] = {'a', 'b', 'c','\0'};
char s2[4] = "abc";
char s3[] = "abc";
```





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

mingw and cygwin

To compile and run cpp program, run ```gcc hello.cpp -o hello```, then run ```./hello```

You could also ```g++ -Wall -std=c++11 your_file.cpp -o your_program```



# More questions

what is the relationship between gcc, cygwin, mingw, cmake, clang?

[cmake经典教程](https://blog.csdn.net/ruglcc/article/details/7814546/)

[跟我一起写 Makefile](https://blog.csdn.net/haoel/article/details/2886)