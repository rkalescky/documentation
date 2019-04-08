.. _compiling:

:tocdepth: 3

Compiling Programs
==================

All high-level language code must be converted into a form the computer
understands. In the above shell scripts, this translation is handled by
the shell itself. Unfortunately, such *interpreted* languages that must
act on each command one-at-a-time typically run much slower than a
computer processor is able.

Alternately, a *compiled program* is one in which a separate program is
used to translate the full set of human-readable commands into an
executable, and in so doing is able to optimize how these commands are
performed. This translation process is handled by a *compiler*, which
will typically perform a suite of optimizations including grouping
repeated calculations together into vector operations, pre-fetching data
from main memory before it is required by the program, or even
re-ordering commands to maximize data reuse within fast cache memory.

For example, C++ language source code is converted into an executable
through the following process. The human-readable source code is
translated into a lower-level *assembly language*. This assembly
language code is then converted into object files which are fragments of
code which the computer processor understands directly. The final stage
the compiler performs involves linking the object code to code libraries
which contain built-in system functions. After this linking stage, the
compiler outputs an executable program.

To do all these steps by hand is complicated and beyond the capability
of the ordinary user. A number of utilities and tools have been
developed for programmers and end-users to simplify these steps.

A single session of a week-long workshop is an insufficient amount of
time to teach any compiled programming languages, so we'll primarily
discuss how to use codes that you've written within a Linux environment,
and provide some links on tutorial pages for two of most
popular/advanced languages (C++ and Fortran90) for modern high performance computing (HPC).

Compiling Programs
------------------

First copy the shared example code to your own directory:

.. code:: bash

    cp -R /hpc/examples/workshops/hpc/compiling_tutorial .

In the ``compiling_tutorial`` directory, you will notice a number of
files:

.. code:: bash

    $ cd compiling_tutorial
    $ ls
    Makefile         hello.c    hello.f    python_example.py
    bash_example.sh  hello.cpp  hello.f90

These implement the archetypal "Hello world" program in a variety of
languages prevalent within HPC:

-  ``hello.c`` -- written in the C programming language
-  ``hello.cpp`` -- written in the C++ programming language
-  ``hello.f`` -- written in the Fortran-77 programming language
-  ``hello.f90`` -- written in the Fortran-90 programming language

Open the file written in your preferred programming language. If you
have no preference among these, open the C++ version:

.. code:: bash

    $ gedit hello.cpp &

Depending on your language of choice, you should see something similar
to the following:

.. code:: c

    // Inclusions
    #include <iostream>

    // Example "hello world" routine
    int main() {

      // print message to stdout
      std::cout << "Hello World!\n";

      return 0;
    }

For those of you familiar to the "Windows" (and even OS X's "Xcode")
approach to programming, you're probably more used to seeing this within
an *Integrated Desktop Environment* (IDE), where you enter your code and
click icons that will handle compilation and execution of your program
for you. While IDEs exist in the Linux world, they are rarely used in
HPC since the compilation approach on your laptop typically cannot create
code that will execute on the worker nodes of a cluster.

So with *portability* in mind, let's investigate the (rather simple)
world of command-line compilation in Linux.

The first step in compilation is knowing which compiler to use. Nearly
every Linux system is installed with the GNU compiler collection,
`GCC <http://gcc.gnu.org/>`__:

-  ``gcc`` -- the GNU C compiler
-  ``g++`` -- the GNU C++ compiler
-  ``gfortran`` -- the GNU Fortran compiler (handles F77/F90/F95/F2003)

However, if you have a very old version of the GNU compiler suite,
instead of ``gfortran`` you may have ``g77``, that only works with F77
code (not F90 or newer).

The GNU compiler suite is open-source (i.e., you can modify it if you
want), free, and is available for all major computer architectures (even
Windows); however, it does not always produce the most efficient code.
As a result, the `SMU Center for Scientific
Computation <http://www.smu.edu/Academics/CSC>`__ has purchased the
`PGI <http://www.pgroup.com/>`__ compiler suite:

-  ``pgcc`` - the PGI C compiler
-  ``pgc++`` - the PGI C++ compiler
-  ``pgfortran`` - the PGI Fortran compiler (handles F77/F90/F95/F2003)

To compile an executable, we merely call the relevant compiler, followed
by the files we wish to compile, e.g., for the C code we'd use

.. code:: bash

    $ gcc hello.c

or for the F77 code we'd use

.. code:: bash

    $ gfortran hello.f

Either of these commands will produce a new file named ``a.out``. This
is the standard output name for executables produced by compilers.
However, since a computer where every program was named "a.out" would be
unusable, it is typical to give your your program a somewhat more
descriptive name. This is handled with the command line option ``-o``,
e.g.,

.. code:: bash

    $ g++ hello.cpp -o hello.exe

Compile the program in the language of your choice, naming the
executable ``hello.exe``. Once this has been compiled, you can run it
just like any other Linux program, via

.. code:: bash

    $ ./hello.exe

The extension on executable files in Linux can be anything; I just
choose ".exe" to provide a sense of familiarity for those coming from
the Windows world. In fact, all that actually matters for a Linux
program is that it has "execute" permissions (and that it was compiled
correctly). You can verify that the files generated by the compiler have
the correct permissions via

.. code:: bash

    $ ls -l hello.exe
    -rwxr-xr-x 1 rkalescky math 8166 May 29 12:26 hello.exe

The three "x" characters in the string at the left of the line states
state that the program may be executed by the owner (rkalescky), the
group (math), and others (anyone on the system), respectively. If you
recall changing the permissions of ``bash_example.sh`` and
``python_example.py``, you used ``chmod`` to set these same "x"es
manually; the compiler automatically does this for you in the
compilation stage.

Alternately, you can inquire about any file's properties with the
``file`` command:

.. code:: bash

    $ file hello.exe
    hello.exe: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 2.6.18, not stripped

Note the 'executable' property listed above.

For those who would like additional information on learning computing
languages, I'd recommend that you pursue some of the following links,
and look through some of the provided code for this workshop (especially
in some of the following sessions). The best ways to learn a new
language are through following examples and practicing; if you'd like
some programming "homework" for practice, ask me after class. Also,
`Google <http://google.com>`__ is a great resource if you're ever in
trouble when programming, since the odds are good that someone else has
had the same questions as you, which have been answered on public
forums. Just describe your question and do a web search.

Fortran resources:

-  `Fortran
   short-course <http://faculty.washington.edu/rjl/classes/am583s2013/notes/index.html#fortran>`__
-  `Interactive Fortran 90 Programming
   Course <http://www.liv.ac.uk/HPC/HTMLFrontPageF90.html>`__
-  `Fortran 90
   Tutorial <http://www.cs.mtu.edu/~shene/COURSES/cs201/NOTES/fortran.html>`__

C++ resources:

-  `C++ By Example: A Hands-On Course in
   C++ <http://www.programmr.com/practice/>`__
-  `C++ Language Tutorial <http://www.cplusplus.com/doc/tutorial/>`__
-  `Interactive C++ Tutorial (focuses on object-oriented
   programming) <http://www.learncpp.com/>`__

Compiling "typical" Linux Packages
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

As the number of UNIX variants increased, it became harder to write
programs which would be portable to all variants. Developers frequently
did not have access to every system, and the characteristics of some
systems changed from version to version. The GNU configure and build
system simplifies the building of programs distributed as source code.
All programs are built using a simple, standardized, two step process.
The program builder need not install any special tools in order to build
the program.

The configure shell script attempts to guess correct values for various
system-dependent variables used during compilation. It uses those values
to create a Makefile in each directory of the package.

For packages that use this approach, the simplest way to compile a
package is:

1. ``cd`` to the directory containing the package's source code.
2. Type ``./configure`` to configure the package for your system.
3. Type ``make`` to compile the package.
4. Optionally, type ``make check`` to run any self-tests that come with
   the package.
5. Type ``make install`` to install the programs and any data files and
   documentation.
6. Optionally, type ``make clean`` to remove the program binaries and
   object files from the source code directory.

The configure utility supports a wide variety of options. You can
usually use the ``--help`` option to get a list of interesting options
for a particular configure script.

The only generic option you are likely to use at first is the
``--prefix`` option. The directory named by this option will hold
machine independent files such as documentation, data and configuration
files.

Example: Compiling the Program "units"
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

For this example, we will download and compile a piece of free software
that converts between different units of measurements.

Downloading Source Code
'''''''''''''''''''''''

First create a download directory:

.. code:: bash

    $ mkdir download

Download the software using ``wget`` into your new download directory
(``wget`` stands for "World Wide Web Get", though apparently they
thought that ``wwwget`` was too long to use):

.. code:: bash

    $ cd download
    $ wget http://faculty.smu.edu/reynolds/unixtut/units-1.74.tar.gz

Extracting the Source Code
''''''''''''''''''''''''''

List the contents of your download directory:

.. code:: bash

    $ ls

As you can see, the filename ends in tar.gz. The ``tar`` command turns
several files and directories into one single ".tar" file. This is then
compressed using the ``gzip`` command (to create a ".tar.gz" file).

First unzip the file using the ``gunzip`` command. This will create a
.tar file:

.. code:: bash

    $ gunzip units-1.74.tar.gz

Then extract the contents of the tar file:

.. code:: bash

    $ tar -xvf units-1.74.tar

Alternatively, since tarred-and-zipped files are so prevalent (often
called "tarballs"), these two commands may be combined together via

.. code:: bash

    $ tar -zxvf units-1.74.tar.gz

All of us have unzipped a file, only to discover that whoever put it
together zipped the files themselves instead of a folder of files. As a
result, when we unzipped the files, they "exploded" into the current
directory, hiding or even overwriting our existing files. This is
colloquially referred to as a "tarbomb". **Do not do this**. When making
a zip file or tar file, be considerate of others and always put your
files in a folder, then zip that new folder so that when unpacked, all
contents are contained nicely in the sub-folder.

Again, list the contents of the directory, then go to the ``units-1.74``
sub-directory:

.. code:: bash

    $ ls -l 
    $ cd units-1.74

Configuring and Creating the Makefile
'''''''''''''''''''''''''''''''''''''

The first thing to do is carefully read the ``README`` and ``INSTALL``
text files (use the ``less`` command below). If the package author is doing
her job correctly, this these files will contain important information
on how to compile and run the software (if not, they may contain useless
or outdated information). *This* package was put together by a
responsible author.

.. code:: bash

    $ less README

(use the arrow keys to scroll up/down; hit ``q`` to exit).

The ``units`` package uses the GNU configure system to compile the
source code. We will need to specify the installation directory, since
the default will be the main system area which you do not have write
permissions for. We'll plan on installing this into a new subdirectory
in your home directory, ``$HOME/units-1.7.4``. This is typically handled
by passing the ``--prefix`` option to ``configure``:

.. code:: bash

    $ ./configure --prefix=$HOME/units-1.7.4

NOTE: The ``$HOME`` variable is an example of an environment variable.
The value of ``$HOME`` is the path to your home directory. Type

.. code:: bash

    $ echo $HOME 

to show the value of this variable.

If ``configure`` has run correctly, it will have created a ``Makefile``
with all necessary options to compile the program. You can view the
``Makefile`` if you wish (use the ``less`` command), but do not edit the
contents of this file unless you know what you are doing.

Building the Package
''''''''''''''''''''

Now you can go ahead and build the package by running the ``make``
command:

.. code:: bash

    $ make

After a short while (depending on the speed of the computer), the
executable(s) and/or libraries will be created. For many packages, you
can check to see whether everything compiled successfully by typing

.. code:: bash

    $ make check

If everything is okay, you can now install the package:

.. code:: bash

    $ make install

This will install the files into the ``~/units-1.7.4`` directory you
created earlier.

Running the Software
''''''''''''''''''''

Go back to the top of your home directory:

.. code:: bash

    $ cd

You are now ready to run the software (assuming everything worked).
Unlike most of the commands you have used so far, the new ``units``
executable is not in your ``PATH``, so you cannot run it from your
current directory like this (the following command will fail to run):

.. code:: bash

    $ units

Instead, you must run executables that are not in your ``PATH`` by providing
the pathname to the executable. One option for this is to provide the
path name from your current location, e.g.,

.. code:: bash

    $ ./units-1.7.4/bin/units

Alternately, you can navigate through the directory structure until you
are in the same directory as the executable:

.. code:: bash

    $ cd ~/units-1.7.4

If you list the contents of the units directory, you will see a number
of subdirectories:

+-----------+----------------------------------+
| Directory | Contents                         |
+===========+==================================+
| bin       | The binary executables           |
+-----------+----------------------------------+
| info      | GNU info formatted documentation |
+-----------+----------------------------------+
| man       | Man pages                        |
+-----------+----------------------------------+
| share     | Shared data files                |
+-----------+----------------------------------+

To run the program, change into the ``bin`` directory:

.. code:: bash

    $ cd bin

and type

.. code:: bash

    $ ./units

As an example, convert 6 feet to meters:

.. code:: bash

    You have: 6 feet
    You want: meters 

            * 1.8288
            / 0.54680665

If you get the answer 1.8288, congratulations, it worked. Type ``^c`` to
exit the program.

To view what units the program can convert between, view the data file
in the ``share`` directory (the list is quite comprehensive).

To read the full documentation, change into the ``info`` directory and
type

.. code:: bash

    $ info --file=units.info

Here, you can scroll around the page using the arrow keys, use [enter]
to select a topic, or [n] to go to the next topic, [p] to go back to the
previous topic, or [u] to go back to the main menu.

Once you're finished reading up on the ``units`` command, press [q] to
exit back to the command prompt.

If for some reason you don't actually want such a critically important
program installed in your home directory, you can delete it with the
command:

.. code:: bash

    $ rm -rf ~/units-1.7.4
