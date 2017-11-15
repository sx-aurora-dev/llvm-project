# SOTOC - Source Transformation for OpenMP Code (suggestions for a better name are greatly appreciated)

Extracts OpenMP target code from a source file and rewrites it into functions. _Only really works for C code_


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

Most code with target regions.

## What currently doesnt work

* Everything else, including but not limited to
    - `#pragma declare target` constructs
    - Global variables
