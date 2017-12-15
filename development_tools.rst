.. _development_tools:

Development Tools
#################

.. toctree::

   Compiling <compiling>
   Debugging and Profiling <debugging_profiling>

Makefiles
---------

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

Version Control Systems
=======================

(adapted from `A visual guide to version
control <http://betterexplained.com/articles/a-visual-guide-to-version-control/>`__)

Version Control (aka *revision control* or *source control*) lets you
track the history of your files over time. Why do you care? So when you
mess up you can easily get back to a previous version that worked.

You've probably invented your own simple version control system in the
past without realizing it. Do you have an directories with files like
this?

-  my_function.c
-  my_function2.c
-  my_function3.c
-  my_function4.c
-  my_function_old.c
-  my_function_older.c
-  my_function_even_older.c

It's why we use "Save As"; you want to save the new file without writing
over the old one. It's a common problem, and solutions are usually like
this:

-  Make a *single backup copy* (e.g. Document.old.txt).
-  If we're clever, we add a *version number* or *date*: e.g.
   Document_V1.txt, DocumentMarch2012.txt.
-  We may even use a *shared folder* so other people can see and edit
   files without sending them by email. Hopefully they rename the file
   after they save it.

Why use a VCS?
--------------

Our shared folder/naming system is fine for class projects or one-time
papers, but is exceptionally bad for software projects. Do you imagine
that the Windows source code sits in a shared folder named something
like "Windows7-Latest-New", for anyone to edit? Or that every programmer
just works on different files in the same folder?

For projects that are large, fast-changing, or have multiple authors, a
Version Control System (VCS) is critical. Think of a VCS as a "file
database", that helps to track changes and avoid general chaos. A good
VCS does the following:

-  *Backup and Restore* -- files are saved as they are edited, and you
   can jump to any moment in time. Need that file as it was on March 8?
   No problem.
-  *Synchronization* -- Allows people to share files and stay up to date
   with the latest version.
-  *Short-term undo* -- Did you try to "fix" a file and just mess it up?
   Throw away your changes and go back to the last "correct" version in
   the database.
-  *Long-term undo* -- Sometimes we mess up bad. Suppose you made a
   change a year ago, and it had a bug that you never caught until now.
   Jump back to the old version, and see what change was made that day.
   Maybe you can fix that one bug and not have to undo your work for the
   whole year?
-  *Track Changes* -- As files are updated, you can leave messages
   explaining why the change happened (these are stored in the VCS, not
   the file). This makes it easy to see how a file is evolving over
   time, and why it was changed.
-  *Track Ownership* -- A VCS tags every change with the name of the
   person who made it, which can be hepful for laying blame *or* giving
   credit.
-  *Sandboxing* (i.e. insurance against yourself) -- Plan to make a big
   change? You can make temporary changes in an isolated area, test and
   work out the kinks before "checking in" your set of changes.
-  *Branching and merging* -- A larger sandbox. You can branch a copy of
   your code into a separate area and modify it in isolation (tracking
   changes separately). Later, you can merge your work back into the
   common area.

Shared folders are quick and simple, but can't provide these critical
features.

General Definitions
-------------------

Most version control systems involve the following concepts, though the
labels may be different.

Basic setup:

-  *Repository (repo)* -- The database storing the files.
-  *Server* -- The computer storing the repo.
-  *Client* -- The computer connecting to the repo.
-  *Working Set/Working Copy* -- Your local directory of files, where
   you make changes.
-  *Trunk/Main* -- The primary location for code in the repo. Think of
   code as a family tree — the trunk is the main line.

Basic actions:

-  *Add* -- Put a file into the repo for the first time, i.e. begin
   tracking it with Version Control.
-  *Revision* -- What version a file is on (v1, v2, v3, etc.).
-  *Head/Tip* -- The latest revision in the repo.
-  *Check out* -- Download a file from the repo.
-  *Check in* -- Upload a file to the repository (if it has changed).
   The file gets a new revision number, and people can "check out" the
   latest one.
-  *Checkin Message* -- A short message describing what was changed.
-  *Changelog/History* -- A list of changes made to a file since it was
   created.
-  *Update/Sync* -- Synchronize your files with the latest from the
   repository. This lets you grab the latest revisions of all files.
-  *Revert* -- Throw away your local changes and reload the latest
   version from the repository.

More advanced actions

-  *Branch* -- Create a separate copy of a file/folder for private use
   (bug fixing, testing, etc). Branch is both a verb ("branch the code")
   and a noun ("Which branch is it in?").
-  *Diff/Change/Delta* -- Finding the differences between two files.
   Useful for seeing what changed between revisions.
-  *Merge/Patch* -- Apply the changes from one file to another, to bring
   it up-to-date. For example, you can merge features from one branch
   into another.
-  *Conflict* -- When pending changes to a file contradict each other
   (both changes cannot be applied automatically).
-  *Resolve* -- Fixing the changes that contradict each other and
   checking in the final version.
-  *Locking* -- Taking control of a file so nobody else can edit it
   until you unlock it. Some version control systems use this to avoid
   conflicts.
-  *Breaking the lock* -- Forcibly unlocking a file so you can edit it.
   It may be needed if someone locks a file and goes on vacation.
-  *Check out for edit* -- Checking out an "editable" version of a file.
   Some VCSes have editable files by default, others require an explicit
   command.

A typical scenario goes like this:

-  Alice adds a file (ShoppingList.txt) to the repository.
-  Alice checks out the file, makes a change (puts "milk" on the list),
   and checks it back in with a checkin message ("Added delicious
   beverage.").
-  The next morning, Bob updates his local working set and sees the
   latest revision of ShoppingList.txt, which contains "milk".
-  Bob adds "donuts" to the list, while Alice also adds "eggs" to the
   list.
-  Bob checks the list in, with a checking message `"Mmmmm,
   donuts" <https://www.youtube.com/watch?v=8-4P1WPE-Qg>`__.
-  Alice updates her copy of the list before checking it in, and notices
   that there is a conflict. Realizing that the order of items doesn't
   matter, she merges the changes by putting both "donuts" and "eggs" on
   the list, and checks in the final version.

Standard VCS Programs
---------------------

ManeFrame has a number of programs installed to enable version control
over your codes. The most popular of these systems are listed below (in
chronological order, from oldest to youngest) -- all of these are
installed on ManeFrame and are in your ``$PATH`` by default.

CVS
~~~

Originally developed in 1990,
`CVS <https://en.wikipedia.org/wiki/Concurrent_Versions_System>`__ is
one of the oldest version systems still in use today. It follows a
client-server approach, in which all repository duties are handled by a
server, to which clients connect to "check out" and "check in" files.

The primary CVS commands are:

-  ``cvs add`` -- adds a new file/directory to the repository
-  ``cvs admin`` -- administration front end for the underlying revision
   control system
-  ``cvs checkout`` -- checkout sources for editing
-  ``cvs commit`` -- checks files into the repository
-  ``cvs diff`` -- checks for differences between revisions
-  ``cvs history`` -- shows status of files and users
-  ``cvs import`` -- import sources into CVS
-  ``cvs remove`` -- removes an entry from the repository
-  ``cvs status`` -- status info on the revisions
-  ``cvs tag`` -- add a tag to checked out version
-  ``cvs update`` -- brings work tree in sync with repository

While there are many `criticisms of
CVS <https://en.wikipedia.org/wiki/Concurrent_Versions_System#Criticism>`__,
it's longevity has resulted in `CVS support by a large number of
*Integrated Desktop Environments*
(IDEs) <https://en.wikipedia.org/wiki/Concurrent_Versions_System#IDEs_with_support_for_CVS>`__
on all major operating systems with native support for CVS-hosted
projects.

CVS resources:

-  `Main CVS site <http://cvs.nongnu.org/>`__
-  `CVS tutorial <http://www-mrsrl.stanford.edu/~brian/cvstutorial/>`__

SVN
~~~

`Apache Subversion <https://en.wikipedia.org/wiki/Apache_Subversion>`__
(SVN) was initially released in 2000, as an effort to write an
open-source version control system that behaved similarly to CVS, but
with a variety of bug fixes and feature improvements. Resultingly, SVN
similarly relies on a client-server approach, and it's commands are
quite similar to those for CVS.

The primary SVN commands include:

-  ``svn help`` -- provides a summary of the available commands.
-  ``svn checkout`` or ``svn co`` -- pulls an SVN tree from the server
   (you should only need to do this once).
-  ``svn add`` -- adds a newly-created file or directory to the
   repository.
-  ``svn delete`` or ``svn del`` or ``svn remove`` or ``svn rm``
   --deletes the local file immediately, and notifies the repository
   that on the next commit, the file should be deleted from there as
   well.
-  ``svn status`` or ``svn stat`` -- displays the status of working
   directories and files.
-  ``svn update`` or ``svn up`` -- synchronizes your local version of
   the code with the server. If you have made local changes, it will try
   and merge any changes on the server with your changes on your
   machine.
-  ``svn commit`` or ``svn ci`` -- recursively sends your changes to the
   SVN server.

   -  If called with specific files/directories as arguments, it will
      send only those.
   -  If given no arguments it will send all changes.
   -  The ``-m`` option should always be used to pass a log message to
      the command.

-  ``svn diff`` -- shows all changes between the local version of a file
   and the version in the repository. May also be used to see changes
   between specific versions of the file with the syntax
   ``svn diff -r revision1:revision2 FILENAME``
-  ``svn move SRC DEST`` or ``svn mv SRC DEST`` or
   ``svn rename SRC DEST`` or ``svn ren SRC DEST`` -- moves a file from
   one directory to another or renames a file in your local directory
   immediately, and performs the same changes on the server upon
   committing.
-  ``svn revert`` -- replaces a local file(s) with the one in the
   repository.
-  ``svn log`` –- displays the log messages from checkins to to the
   repository.
-  ``svn resolve`` -- if an update showed a conflict (a file marked with
   a "C"), then once you have manually merged the two versions of file,
   this command will set the file's status to "resolved".

As with any project, SVN also has a number of
`criticisms <https://en.wikipedia.org/wiki/Apache_Subversion#Limitations_and_problems>`__,
but again since it has been widely used for over a decade, subversion
support has been integrated into a variety of `GUI front-ends and
IDEs <https://en.wikipedia.org/wiki/List_of_software_that_uses_Subversion>`__.

In addition, there are a number of web sites that will host open-source
SVN-based software projects free of charge, including:

-  `Google code <http://code.google.com/hosting/>`__
-  `SourceForge <http://sourceforge.net/>`__
-  `CloudForge <http://info.cloudforge.com/freeplan.html>`__
-  `Bounty Source <http://www.bountysource.com/>`__
-  `Assembla <http://offers.assembla.com/free-subversion-hosting/?affiliate=ianterrell>`__
-  `BerliOS Developer <http://developer.berlios.de/>`__

SVN resources:

-  `Main SVN site <https://subversion.apache.org/>`__
-  `SVN tutorial <http://svnbook.red-bean.com/en/1.7/index.html>`__

Git
~~~

Originally released in 2005 (by `Linus
Torvalds <https://en.wikipedia.org/wiki/Linus_Torvalds>`__ himself!),
`Git <https://en.wikipedia.org/wiki/Git_(software)>`__ was one of the
first version control systems that followed a *distributed revision
control* model (DRCS), in which it is no longer required to have a
single server that all clients connect with. Instead, DRCS follows a
peer-to-peer approach. in which each peer's working copy of the codebase
is a fully-functional repository. These work by exchanging patches (sets
of changes) between peers, resulting in some `key benefits over previous
centralized
systems <https://en.wikipedia.org/wiki/Distributed_revision_control#Distributed_vs._centralized>`__

The
`commands <https://confluence.atlassian.com/display/STASH/Basic+Git+commands>`__
used for interacting with Git are nearly identical to those for SVN,
with a few additions/exceptions:

-  ``git clone`` -- this is the primary mechanism for retrieving a local
   copy of a Git repository. Unlike the CVS and SVN ``checkout``
   commands, the result is a full repository that may act as a server
   for other client repositories.
-  ``git pull`` -- this fetches and merges changes on the remote server
   to your working repository.
-  ``git push`` -- the opposite of ``pull``, this sends all changes in
   your local repository to a remote repository.

However, *unlike SVN*, Git does not allow you to use the shortcut names
for standard commands; for example ``git ci`` is an illegal command, but
``git commit`` is allowed.

While distributed version control systems no longer require a main
server, it is often useful to have a centralized, "agreed-upon" main
repository that all users can access. As with subversion, there are a
number of web sites that will host open-source Git-based software
projects free of charge, including:

-  `Bitbucket <https://bitbucket.org/dashboard/overview>`__
-  `GitHub <https://github.com/>`__
-  `Gitorious <https://gitorious.org/>`__
-  `CloudForge <http://www.cloudforge.com/>`__
-  `ProjectLocker <http://projectlocker.com/>`__
-  `Assembla <http://offers.assembla.com/free-git-hosting/>`__

Git resources:

-  `Main Git site <http://git-scm.com/>`__
-  `Git tutorials <http://www.atlassian.com/git/tutorial>`__
-  `Git book chapters <http://git-scm.com/book>`__

Mercurial
~~~~~~~~~

Like Git,
`Mercurial <https://en.wikipedia.org/wiki/Mercurial_(software)>`__ was
first released in 2005, and is a widely-used distributed revision
control system. It is primarily implemented using Python, and is
available on all major operating systems.

Again, like Git, Mercurial commands are similar to CVS and SVN, with a
few notable exceptions (note that ``hg`` is the chemical symbol for
mercury):

-  ``hg clone`` -- the primary mechanism for retrieving a local copy of
   a mercurial repository; the result of which is a full repository that
   may act as a server for other client repositories.
-  ``hg pull`` -- this fetches all changes on the remote server and adds
   them to your working repository, but *unlike Git it does not merge
   them in*, allowing you control over which remote changesets are
   incorporated into your local sandbox, and which are not.
-  ``hg up`` -- this is the command that updates your local sandbox with
   changes that have been pulled into your working repository.
-  ``hg push`` -- like Git, this command sends all changes in your local
   repository to a remote repository.

Unlike Git, but as with SVN, Mercurial allows use of popular command
shortcuts like ``ci``, ``stat`` and ``up`` instead of their longer
alternatives (``commit``, ``status`` and ``update``).

As with Git and Subversion, there are a variety of web sites that will
host open-source Mercurial repositories free of charge, including:

-  `Bitbucket <https://bitbucket.org/dashboard/overview>`__
-  `Assembla <http://www.assembla.com/>`__
-  `Google code <http://code.google.com/projecthosting/>`__
-  `SourceForge <http://sourceforge.net/>`__
-  `CodePlex <http://www.codeplex.com/>`__
-  `Pikacode <http://pikacode.com/>`__
-  `Beanstalk <http://beanstalkapp.com/>`__
-  `Kiln <http://www.fogcreek.com/kiln/>`__

Mercurial resources:

-  `Main mercurial site <http://mercurial.selenic.com/>`__
-  `TortoiseHG -- multi-platform, graphical mercurial
   client <http://tortoisehg.bitbucket.org/>`__
-  `Mercurial guide <http://hgbook.red-bean.com/>`__
-  `Mercurial tutorial <http://mercurial.selenic.com/wiki/Tutorial>`__

Mercurial Example
~~~~~~~~~~~~~~~~~

We'll get a little experience with using Mercurial to "collaborate" on a
shared project.

The first step in using a version control system on an existing
repository is to do the initial download of the code from the main
repository. This repository can often be on a standalone server, on a
public a web site, or it can even reside in someone else's home
directory. Here, we'll use one that I've set up for this class on the
public web server `bitbucket.org <http://bitbucket.org>`__. In
Mercurial, the initial download of the code uses the ``clone`` command:

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ hg clone https://drreynolds@bitbucket.org/drreynolds/smuhpc-workshop-example

.. raw:: html

   </div>

When the command completes, you should have a new directory named
``smuhpc-workshop-example``. Enter that directory,

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ cd smuhpc-workshop-example
    $ ls
    driver.cpp     vector_difference.cpp   vector_sum.cpp
    one_norm.cpp   vector_product.cpp 

.. raw:: html

   </div>

You should notice the files we used earlier in this tutorial. Since
Mercurial is a *distributed* version control system, this directory is
now a new repository of your own.

In this directory, add a new file of the form *lastname.txt* containing
your first name, e.g.

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ echo "Rob" > Kalescky.txt

.. raw:: html

   </div>

To see which files have changed in comparison with the last saved state
of the repository, you can use the ``status`` command:

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ hg status
    ? Kalescky.txt

.. raw:: html

   </div>

The "?" indicates that there is a new file in the directory that the
repository does not yet know about. We can add these files to the
repository with the ``add`` command:

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ hg add Kalescky.txt

.. raw:: html

   </div>

Re-running ``status``, we see that the repository now knows about the
file:

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ hg status
    A Kalescky.txt

.. raw:: html

   </div>

where, the "A" denotes that the file has been added to the repository.
Other keys include:

-  ``M`` -- the file has been modified
-  ``!`` -- the file has been deleted
-  ``R`` -- the file has been removed from the repository

If you want to see the specific changes that have been made to all of
the Mercurial-tracked files, you can use the ``diff`` command:

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ hg diff
    diff -r ad44a3024020 Kalescky.txt
    --- /dev/null    Thu Jan 01 00:00:00 1970 +0000
    +++ b/Kalescky.txt   Fri May 31 13:46:17 2013 -0500
    @@ -0,0 +1,1 @@
    +Daniel

.. raw:: html

   </div>

where we see that there is a new line "Rob" (denoted by the ``+``) that
has been added.

To save this change into the repository, we must ``commit`` the changes.
To do so, we must supply both a log message using the ``-m`` flag, and
our name (in order to give credit and/or lay blame) with the ``-u``
flag. For example, my commit message could be something like this:

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ hg commit -u rkalescky -m "added a file with my name" Kalescky.txt

.. raw:: html

   </div>

Once this command has completed, we see that the local directory is
current with our local repository:

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ hg status

.. raw:: html

   </div>

(note that nothing is listed).

When working on a project with others, you will eventually wish to share
your code by "pushing" it back up to a shared repository. This can also
be quite helpful if you develop your project on different computers, so
that instead of copying the files manually by email, ``rsync`` or
``scp``, you can just push your changes up to the repository from one
computer, and clone/pull them down to another.

The command to push files back to the main repository is ``push``. We
will not do so here, since in order to push to
`bitbucket.org <http://bitbucket.org>`__ you must first set up a
Bitbucket account.

However, if you did have a Bitbucket account, prior to pushing your
code, you should always retrieve any changes that your collaborators
have made to the repository by using a "pull" and an "update" (and
possibly a "merge" if necessary). To retrieve these changes:

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ hg pull
    $ hg update

.. raw:: html

   </div>

If the ``update`` command returns successfully, then you can push your
changes back to my example repository with the command

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ hg push

.. raw:: html

   </div>

However, if the ``update`` command complained about changes needing to
be merged (meaning that someone else checked things in, so your changes
need to be merged with his/hers), then you can ``merge`` via

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ hg merge

.. raw:: html

   </div>

Assuming that your modifications do not collide with anyone else's, this
should be successful, in which case you need to check in the merge

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ hg commit -u rkalescky -m "merged to tip"

.. raw:: html

   </div>

Once you're certain that you have finished retrieving and merging all
changes from the shared repository, you ``push`` via

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ hg push

.. raw:: html

   </div>

Typically this process is not difficult, since you will usually be
editing different files than your collaborators.

Comparison with Dropbox/Google Drive/OneDrive/etc.
--------------------------------------------------

With the advent of "the cloud", we are inundated with options for
storing files and sharing them with others. As a result, many of us have
come up with preferred strategies for working with our files, such as
with `Dropbox <http://dropbox.com>`__, `Google
Drive <http://drive.google.com>`__,
`OneDrive <https://onedrive.live.com>`__,
`Box <https://www.box.com/>`__, ...

Unfortunately, while these cloud storage options are great solutions for
sharing files with others, they are *poor* choices for typical software
projects:

1. It is typically very difficult (or impossible) to retrieve old
   versions of a file, and even when possible, it may only be done based
   on date/time, and does not include "checkin" messages describing the
   differences between files.

   VCS systems store specific "versions" of each file, with checkins
   labeled using (hopefully descriptive) messages. Better yet, VCS
   systems allow you to "tag" a specific state of the repository (e.g.
   to mark it for release as version "2.0"). The repository may be
   "reverted" to its status at any tag or after any checkin with only
   one (or a few) simple commands.

2. Unless all authors *never* edit the same file, merging changes
   between multiple authors becomes difficult, if not impossible. VCS
   systems allow multiple users to edit the same file, merging changes
   automatically (if made to separate parts of the file), or requesting
   the newest checkin to manually merge portions of the code that
   overlap.

3. No "sandboxing" of code -- the moment that you edit the file it is
   changed in the cloud, making it impossible for one user to compile
   while another is actively editing and saving files (since they
   typically will not compile at every save).

   VCS systems allow you to save files to disk for compilation and
   testing, and only share the changes with others *when you decide that
   the changes should be shared*.

4. No simple "diff" capabilities, to see *exactly* what has changed in
   each file at any point in time.

   VCS systems all supply some kind of "diff" to allow quick comparison
   between versions of a code.

All of that said, some people use a combination of a VCS and a cloud
storage solution to get the benefits of both. For example, many smaller
groups will set up a distributed version control system (Git or
Mercurial) *inside* a Dropbox folder, that they can then share with
other developers (for example, see `this blog
post <http://rogerstringer.com/2012/04/16/using-dropbox-as-a-git-repository/>`__).
In this way, you can benefit from using the cloud to share files with
others (Dropbox, Google Drive, etc.), while also benefiting from a VCS
system for all of the options discussed above.

However, a big problem with the above cloud-based approach is that the
client software needs to be installed on all machines where you plan to
access the in-cloud repository. While you can certainly install these
programs on your own computers, in general *you cannot install them on
shared clusters* (like ManeFrame). So if you do decide to use a
customized cloud+VCS system, you'll still need to manually copy your
codes to/from ManeFrame (or other shared clusters), and ensure that any
updates to the repository and/or to files on ManeFrame are manually
merged back-and-forth.

In my experience, it's much simpler (and just as free) to use a
professional repository hosting service like
`Bitbucket <http://bitbucket.org>`__.
