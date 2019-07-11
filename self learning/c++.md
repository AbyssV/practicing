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

**Example**

- '\0' null character 0

- '\n' newline 10

- '\r' return 13

- '\t' tab 9

- ' ' space 32

- '0' 48

- 'A' 65

- 'a 97'

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

