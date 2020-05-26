SOTOC - Source Transformation for OpenMP Code (suggestions for a better name are greatly appreciated)
=====================================================================================================

Extracts OpenMP target code from a source file and rewrites it so it can be
used to compile a target binary. **Only really works for C code**.


Building
--------

You can build sotoc together with the rest of this repository or seperatly:

.. code-block:: console

 $ mkdir BUILD && cd BUILD
 $ cmake ../
 $ make


Usage
-----
.. code-block:: console

 $ sotoc input.c -- -fopenmp

sotoc is a Clang tool and needs compiler options (at least ``-fopenmp``) for
the input file (given after the ``--`` switch on the command line).


What currently works
--------------------

* Target regions.

  * Although unusual indentation is still a problem

* Functions in ``#pragma omp declare target`` constructs.
* Functions which are declared in ``#pragma omp declare target`` constructs and
  have their function bodies outside the construct if the function body comes
  **after** the the ``#pragma declare target`` consturct.
* Usage of some custom types.
* ``#include`` of **system**-headers if types or functions referred to in the
  target code is declared/defined there (for functions you still need to
  ``#include`` the header files within a ``#pragma omp declare target``
  construct.


What currently does not work
----------------------------

* Global variables in ``#pragma omp declare target`` constructs

  * This is partly a Clang problem/bug

* Anything involving macros (with the possible exception of those defined in a
  standard library/system header).
