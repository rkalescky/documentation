.. _makefiles:

:tocdepth: 3

Makefiles
=========

The ``make`` command allows programmers to easily manage programs with
large numbers of files. It aids in developing large programs by encoding
instructions on how to build the program, keeping track of which
portions of the entire program have been changed, and compiling only
those parts of the program which have changed since the last compile.

The ``make`` program gets its set of compile rules from a text file
called ``Makefile`` which resides in the same directory as the source
files. It contains information on how to compile the software, e.g. the
compiler to use, the optimization level, whether to include debugging
info in the executable, etc.. It also contains information on where to
install the finished compiled binaries (executables), manual pages, data
files, dependent library files, configuration files, etc.. For example,
when we built the ``units`` program in the previous tutorial, the
``configure`` program automatically created a ``Makefile`` for building
``units``, so that we did not need to compile everything manually.

Retrieve the set of files for this tutorial either through clicking here
or by copying the relevant files at the command line:

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ cp -R /hpc/examples/workshops/hpc/makefile_tutorial .

.. raw:: html

   </div>

You should now see a new subdirectory entitled ``makefile_tutorial`` in
your current directory. This is where we will work for the rest of this
section. Inside this directory you will see a number of files:

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    driver.cpp      vector_difference.cpp    vector_sum.cpp
    one_norm.cpp    vector_product.cpp

.. raw:: html

   </div>

Here, the main program is held in the file ``driver.cpp``, and
supporting subroutines are held in the remaining files. To compile these
on ManeFrame, it takes a number of steps.

Let's first compile and assemble the auxiliary subroutine
``one_norm.cpp``:

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ g++ -c one_norm.cpp

.. raw:: html

   </div>

This calls the GNU C++ compiler, ``g++``, to create an object file,
named ``one_norm.o``, that contains compiler-generated CPU instructions
on how to execute the function in the file ``one_norm.cpp``.

Use similar instructions to create the object files ``driver.o``,
``vector_difference.o``, ``vector_product.o`` and ``vector_sum.o`` in a
similar fashion.

You should now have the files ``driver.o``, ``one_norm.o``,
``vector_difference.o``, ``vector_product.o`` and ``vector_sum.o`` in
your directory. The final stage in creating the executable is to link
these files together. We may call ``g++`` one more time to do this
(which itself calls the system-dependent linker), supplying all of the
object files as arguments so that ``g++`` knows which files to link
together:

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ g++ driver.o one_norm.o vector_difference.o vector_product.o \
      vector_sum.o -lm

.. raw:: html

   </div>

This creates an executable file named ``a.out``, which is the default
(entirely non-descriptive) name given by most compilers to the resulting
executable. The additional argument ``-lm`` is used to tell ``g++`` to
link these functions against the built-in math library (so that we can
use the absolute value function, ``fabs()``, that is called inside the
``one_norm.cpp`` file.

You can instead give your executable a more descriptive name with the
``-o`` option:

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ g++ driver.o one_norm.o vector_difference.o vector_product.o \
      vector_sum.o -lm -o driver.exe 

.. raw:: html

   </div>

This will create the same executable, but with the more descriptive name
``driver.exe``.

How can a Makefile help?
~~~~~~~~~~~~~~~~~~~~~~~~

While you may find it to be quite enjoyable to compile every source file
by hand, and then manually link them together into an executable, the
process can be completely automated by using a ``Makefile``.

A few rules about ``Makefiles``:

-  The ``make`` program will look for any of the files: ``GNUmakefile``,
   ``makefile``, and ``Makefile`` (in that order) for build
   instructions. Most people consider the name ``Makefile`` as best
   practice, though any are acceptable.
-  Inside the ``Makefile``, lines beginning with the ``#`` character are
   treated as comments, and are ignored.
-  Blank lines are ignored.
-  You specify a *target* for ``make`` to build using the syntax,

   .. raw:: html

      <div class="sourceCode">

   .. code:: makefile

       target : dependencies
             build command 1
             build command 2
             build command 3

   .. raw:: html

      </div>

   where each of the lines following the ``target :`` line must begin
   with a ``[Tab]`` character. Each of these lines are executed when
   ``make`` is called. These lines are executed as if they were typed
   directly at the command line (as with a shell script).

-  More than one *target* may be included in any ``Makefile``.
-  If you just type ``make`` at the command line, only the first
   *target* is run.

As an example, examine the Makefile from the previous tutorial. Here,
all of the lines are either blank or are comment lines except for the
four sets:

.. raw:: html

   <div class="sourceCode">

.. code:: makefile

    hello_cpp.exe : hello.cpp
            g++ hello.cpp -o hello_cpp.exe

    hello_c.exe : hello.c
            gcc hello.c -o hello_c.exe

    hello_f90.exe : hello.f90
            gfortran hello.f90 -o hello_f90.exe

    hello_f77.exe : hello.f
            gfortran hello.f -o hello_f77.exe

.. raw:: html

   </div>

Here, we have four build targets, ``hello_cpp.exe``, ``hello_c.exe``,
``hello_f90.exe`` and ``hello_f77.exe`` (it is traditional to give the
target the same name as the output of the build commands).

Each of these targets depend a source code file listed to the right of
the colon; here these are ``hello.cpp``, ``hello.c``, ``hello.f90`` and
``hello.f``, respectively.

The indented lines (each require a single [Tab] character) under each
target contain the instructions on how to build that executable. For
example, ``make`` will build ``hello_cpp.exe`` by issuing the command
``g++ hello.cpp -o hello_cpp.exe``, which does the compilation, assembly
and linking all in one step (since there is only one source code file).

Alternatively, this Makefile could have been written:

.. raw:: html

   <div class="sourceCode">

.. code:: makefile

    hello_cpp.exe : hello.cpp
            g++ -c hello.cpp
            g++ hello.o -o hello_cpp.exe

    hello_c.exe : hello.c
            gcc -c hello.c
            gcc hello.o -o hello_c.exe

    hello_f90.exe : hello.f90
            gfortran -c hello.f90
            gfortran hello.o -o hello_f90.exe

    hello_f77.exe : hello.f
            gfortran -c hello.f
            gfortran hello.o -o hello_f77.exe

.. raw:: html

   </div>

or even as

.. raw:: html

   <div class="sourceCode">

.. code:: makefile

    hello_cpp.exe : 
            g++ hello.cpp -o hello_cpp.exe

    hello_c.exe : 
            gcc hello.c -o hello_c.exe

    hello_f90.exe : 
            gfortran hello.f90 -o hello_f90.exe

    hello_f77.exe : 
            gfortran hello.f -o hello_f77.exe

.. raw:: html

   </div>

(which ignores the dependency on the source code files ``hello.cpp``,
``hello.c``, ``hello.f90`` and ``hello.f``, respectively).

Makefile Variables
~~~~~~~~~~~~~~~~~~

As you likely noticed, many of the above commands seemed very repetitive
(e.g. continually calling ``gfortran``, or repeating the dependencies
and target name in the compile line).

As with anything in Linux, we'd prefer to do things as easily as
possible, which is where Makefile variables come into the picture. We
can define our own variable in a ``Makefile`` by placing the variable to
the left of an equal sign, with the value to the right (as with Bash):

.. raw:: html

   <div class="sourceCode">

.. code:: makefile

    VAR = value

.. raw:: html

   </div>

The main difference with Bash comes in how we use these variables.
Again, it requires a ``$``, but we also need to use parentheses or
braces, ``$(VAR)`` or ``${VAR}``. In addition, there are a few built-in
variables within ``Makefile`` commands that can be quite handy:

-  ``$^`` -- in a compilation recipe, this references all of the
   *dependencies* for the target
-  ``$<`` -- in a compilation recipe, this references the *first
   dependency* for the target
-  ``$@`` -- in a compilation recipe, this references the *target name*

With these, we can streamline our previous ``Makefile`` example
considerably:

.. raw:: html

   <div class="sourceCode">

.. code:: makefile

    CC=gcc
    CXX=g++
    FC=gfortran 

    hello_cpp.exe : hello.cpp
            $(CXX) $^ -o $@

    hello_c.exe : hello.c
            $(CC) $^ -o $@

    hello_f90.exe : hello.f90
            $(FC) $^ -o $@

    hello_f77.exe : hello.f
            $(FC) $^ -o $@

.. raw:: html

   </div>

Advanced Usage
~~~~~~~~~~~~~~

If we have one main routine in the file ``driver.c`` that uses functions
residing in multiple input files, e.g. ``func1.c``, ``func2.c``,
``func3.c`` and ``func4.c``, it is standard to compile each of the input
functions into ``.o`` files separately, and then to link them together
with the driver at the last stage. This can be very helpful when
developing/debugging code, since if you only change one line in
``file2.c``, you do not need to re-compile *all* of your input
functions, just the one that you changed. By setting up your
``Makefile`` so that the targets are the ``.o`` files, and if the
Makefile knows how to build each ``.o`` file so that it depends on the
respective ``.c`` file, recompilation of your project can be very
efficient. For example,

.. raw:: html

   <div class="sourceCode">

.. code:: makefile

    CC=gcc

    driver.exe : driver.o func1.o func2.o func3.o func4.o 
            $(CC) $^ -o $@

    driver.o : driver.c
            $(CC) -c $^ -o $@

    func1.o : func1.c
            $(CC) -c $^ -o $@

    func2.o : func2.c
            $(CC) -c $^ -o $@

    func3.o : func3.c
            $(CC) -c $^ -o $@

    func4.o : func4.c
            $(CC) -c $^ -o $@

.. raw:: html

   </div>

However, if this actually depends on a *large number* of input
functions, the Makefile can become very long if you have to specify the
recipe for compiling each ``.c`` file into a ``.o`` file. To this end,
we can supply an *explicit rule* for how to perform this conversion,
e.g.

.. raw:: html

   <div class="sourceCode">

.. code:: makefile

    CC=gcc
    OBJS=driver.o func1.o func2.o func3.o func4.o func5.o \
         func6.o func7.o func8.o func9.o func10.o func11.o \
         func12.o func13.o func14.o func15.o

    driver.exe : $(OBJS)
            $(CC) $^ -o $@

    %.o : %.c 
            $(CC) -c $^ -o $@

.. raw:: html

   </div>

Here, the last block specifies the rule for how to convert *any* ``.c``
file into a ``.o`` file. Similarly, we have defined the ``OBJS``
variable to list out all of the ``.o`` files that we need to generate
our executable. Notice that the line continuation character is ``\``:

-  The ``\`` must be the *last character* on the line (no trailing
   spaces)
-  Continued lines must use *spaces* to start the line (no "Tab"),
   though they aren't required to line up as pretty as in this example.

As a final example, let's now suppose that all of the files in our
project ``#include`` the same header file, ``head.h``. Of course, if we
change even a single line in this header file, we'll need to recompile
all of our ``.c`` files, so we need to add ``head.h`` as a dependency
for processing our ``.c`` files into ``.o`` files:

.. raw:: html

   <div class="sourceCode">

.. code:: makefile

    CC=gcc
    OBJS=driver.o func1.o func2.o func3.o func4.o func5.o \
         func6.o func7.o func8.o func9.o func10.o func11.o \
         func12.o func13.o func14.o func15.o

    driver.exe : $(OBJS)
            $(CC) $^ -o $@

    %.o : %.c head.h
            $(CC) -c $< -o $@

.. raw:: html

   </div>

Note that to the right of the colon in our explicit rule we have now
listed the header file, ``head.h``. Also notice that within the explicit
rule, we now use the ``$<`` instead of the ``$^``, this is because we
want the compilation line to be, e.g.

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    gcc -c func3.c -o func3.o

.. raw:: html

   </div>

and **not**

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    gcc -c func3.c head.h -o func3.o

.. raw:: html

   </div>

so we only wanted to automatically list the *first* dependency from the
list, and not *all* dependencies.

Makefile Exercise
~~~~~~~~~~~~~~~~~

Create a ``Makefile`` to compile the executable ``driver.exe`` for this
workshop tutorial, out of the files ``driver.cpp``, ``one_norm.cpp``,
``vector_difference.cpp``, ``vector_product.cpp`` and
``vector_sum.cpp``. This should encode all of the commands that we
earlier needed to do by hand. Start out with the command

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ gedit Makefile &

.. raw:: html

   </div>

to have ``gedit`` create the file ``Makefile`` in the background, so
that while you edit the ``Makefile`` you can still use the terminal
window to try out ``make`` as you add commands.

You can incorporate more than one target into your ``Makefile``. The
first target in the file will be executed by a ``make`` command without
any arguments. All other targets may be executed through the command
``make target``, where ``target`` is the name you have specified for a
target in the ``Makefile``.

For example, a standard ``Makefile`` target is to clean up the temporary
files created during compilation of the executable, typically entitled
``clean``. In our compilation process, we created the temporary files
``driver.o``, ``one_norm.o``, ``vector_product.o``, ``vector_sum.o`` and
``vector_difference.o``. These could be cleaned up with the single
command ``make clean`` if we add the following lines to the
``Makefile``, after your commands to create ``driver.exe``:

.. raw:: html

   <div class="sourceCode">

.. code:: makefile

    clean :
          rm -f *.o

.. raw:: html

   </div>

Now type ``make clean`` in the terminal -- all of the temporary build
files have been removed.

``Makefiles`` can be much more complicated than those outlined here, but
for our needs in this tutorial these commands should suffice. For
additional information on the ``make`` system, see the PDF manual listed
below.

Make resources:

-  `GNU Make
   manual <http://runge.math.smu.edu/Courses/Math6370_Spring13/make.pdf>`__

