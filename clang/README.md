# SOTOC - Source Transformation for OpenMP Code (suggestions for a better name are greatly appreciated)

Extracts OpenMP target code from a source file and rewrites it into functions


## Building

```
mkdir BUILD && cd BUILD
cmake ../
make
```


## Usage

```
./sotoc input.c -- -fopenmp
```


## What currently worrks

Target code of the form

```c
    #pragma omp target
    {
        // your code here
    }
```


## What currently doesnt work

* Everything else, including but not limited to
    - Correct Function names
    - `#pragma omp target for` construct
    - `#pragma declare target` constructs
    - Global variables
