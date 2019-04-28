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
- 