# VH target plugin

A target plugin to support openmp target offloading from an nec sx-aurora device
to the host processor.
Note that this requires binaries built for sx-aurora and _not_ for the `x86_64`
host.
Please note that this plugin currently only works for `C` and not for `C++`
sources.

## Usage

In order to use this target plugin you have to get hold of a version of clang,
llvm and libopenmp which was built with support for it.
Building those versions can only be done on a machine with a nec sx-aurora
development environment.
In the following paragraphs it is assumed that you have such a version of clang,
llvm and openmp.

### Getting started
You have to build for the sx-aurora target (`--target=ve-linux`), enable openmp
(`-fopenmp`) and enable build for `x86_64` offloading targets
(`-fopenmp-targets=x86_64-pc-linux-gnu`)

The aurora binary has to be able to locate this library and it's call stack as
well as dependencies.
Currently, the following linking arguments are needed for the binary:

TODO: rpath stuff at lib build time?
```
-Wl,-rpath-link /opt/nec/ve/lib/
-Wl,-rpath-link ${path_to_llvm_installation}/lib/clang/11.0.0/lib/linux/ve/
```

Furthermore, the `device-rtl` library must be accessible from the standard search
path on the host, e.g by adding
```LD_LIBRARY_PATH="$LD_LIBRARY_PATH;${path_to_llvm_installation}/lib/"```
to the call of your executable.

### `openmp target` features
Currently only synchronous operations are supported, so the `async` clause is
not supported.
Other clauses or combinations thereof *should* work.

## How to build

First there needs to be a version of clang which can compile the openmp
subproject for the host machine as well as crosscompile for the `ve-linux`
target.
This compiler should then be used to generate a openmp target library for the
host system and a version of the library for the vector engine.
Both libraries must be installed properly and are then ready for use.

## How to add another target plugin

This section is intended for programmers who want to add their own target
library because it was really hard for me to find all the code sections which I
had to change during development of this plugin.

### Copy another plugin
In order to get a skeleton implementation it is recommended to copy another
plugin.
It is recommended to use the one which most closely fits your target and
implementation plan.

### Add the lookup for required libraries
If the new plugin needs additional libraries and headers add them to the
`openmp/libomptarget/cmake/Modules/LibomptargetGetDependencies.cmake`
cmake file.
Then adjust the conditional compile options in the `CMakeLists.txt` of the new
plugin.

### Add it to the global build chain
Add the directory name of your plugin to the list of plugins to scan and build
in `openmp/libomptarget/plugins/CMakeLists.txt`.

### Code the plugin
Change all the needed code in the copied `CMakeLists.txt` and implement the
functions in `src/rtl.cpp`.
Once all is done and compiles it is time to activate the plugin during runtime.

### Activate the plugin in `libomptarget`
In order to make `libomptarget` look for the new plugin it must be added to the
list of target plugins in `openmp/libomptarget/src/rtl.cpp`.
Please note that it must be the name given to the library in the new
`CMakeLists.txt` file, `lib` must be prepended and `.so` appended.

### Test the plugin
It is recommended to test the new plugin with a simple example program while
debugging as well as setting the environment variable `LIBOMPTARGET_DEBUG`.
For final verification of the plugin there is a test suite which can be found
[here](https://crpl.cis.udel.edu/ompvvsollve/).
