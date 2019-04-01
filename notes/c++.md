### compile cpp file with clang

```clang++ -Wall -std=c++11 test.cc -o test```

```-Wall``` means to enable all compiler warnings. And ```-Werror``` means treat all warnings as errors. In other words, any possible warning that the compiler has determined will be shown to you if your code meets it, and it will be treated as a compile error that must be fixed.

