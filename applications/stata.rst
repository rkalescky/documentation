.. _stata:

:tocdepth: 3

Running STATA on ManeFrame II
=============================

Types of Nodes On Which STATA Is to Run
---------------------------------------

First, you must identify the type of compute resource needed to run your
calculation. In the following table the compute resources are delineated
by resource type and the expected duration of the job. The duration and
memory allocations are hard limits. Jobs with calculations that exceed
these limits will fail. Once an appropriate resource has been identified
the partition and Slurm flags from the table can be used in the
following examples.

.. include:: ../common/slurm_flag_table.rst

.. note::

   The STATA installation on ManeFrame II provides serial and parallel
   versions. The commands to run the parallel versions are same as the
   serial version, but with "-mp" appended, i.e. ``xstata-mp`` instead of
   ``xstata``. Please do not run the parallel version via the "htc" queue
   (see the table above). The examples below all serial versions of STATA
   can be substituted with the parallel version provided an appropriate
   queue is used.

Running STATA Interactively with the Graphical User Interface
-------------------------------------------------------------

The STATA graphical user interface can be run directly off of ManeFrame II
compute nodes using X11 forwarding.

Running STATA Graphical User Interface Via X11 Forwarding
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Running the STATA graphical user interface via X11 requires SSH with X11
forwarding and SFTP access.

1. Log into the cluster using SSH with X11 forwarding enabled and run
   the following commands at the command prompt.
2. ``module load stata`` to enable access to STATA
3. ``srun -p <partition and options> --x11=first --pty $SHELL`` where
   ``<partition and options>`` is the partition and associated Slurm
   flags for each partition outlined above.
4. ``xstata &`` to launch STATA on the Slurm allocated resource.

**Example:**

.. code:: bash

       module load stata
       srun -p htc --exclusive --mem=6G --x11=first --pty $SHELL
       xstata &

Running STATA Non-Interactively in Batch Mode
---------------------------------------------

STATA scripts can be executed non-interactively in batch mode in a myriad
ways depending on the type of compute resource needed for the
calculation, the number of calculations to be submitted, and user
preference. The types of compute resources outlined above. Here, each
partition delineates a specific type of compute resource and the
expected duration of the calculation. Each of the following methods
require SSH access. Examples can be found at ``/hpc/examples/stata`` on
ManeFrame II.

Submitting a STATA Job to a Queue Using Wrap
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A STATA script can be executed non-interactively in batch mode directly
using sbatch's wrapping function.

1. Log into the cluster using SSH and run the following commands at the
   command prompt.
2. ``module load stata`` to enable access to STATA
3. ``cd`` to directory with STATA script
4. ``sbatch -p <partition and options> --wrap "stata <stata script file name>"``
   where ``<partition and options>`` is the partition and associated
   Slurm flags for each partition outlined in the table above. and
   ``<stata script file name>`` is the STATA script to be run.
5. ``squeue -u $USER`` to verify that the job has been submitted to the
   queue

**Example:**

.. code:: bash

       module load stata
       sbatch -p standard-mem-s --exclusive --mem=250G --wrap "stata example.do"

Submitting a STATA Job to a Queue Using a Submit Script
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A STATA script can be executed non-interactively in batch mode by creating
an sbatch script. The sbatch script gives the Slurm resource scheduler
information about what compute resources your calculation requires to
run and also how to run the STATA script when the job is executed by
Slurm.

1. Log into the cluster using SSH and run the following commands at the
   command prompt.
2. ``cd`` to directory with STATA script
3. ``cp /hpc/examples/stata/stata_example_htc.sbatch <descriptive file name>``
   where ``<descriptive file name>`` is meaningful for the calculation
   being done. It is suggested to not use spaces in the file name and
   that it end with .sbatch for clarity.
4. Edit the sbatch file using using preferred text editor. Change the
   partition and flags and STATA script file name as required for your
   specific calculation.

.. literalinclude:: ../examples/stata/stata_example_htc.sbatch
   :language: bash

5. ``sbatch <descriptive file name>`` where ``<descriptive file name>``
   is the sbatch script name chosen previously.
6. ``squeue -u $USER`` to verify that the job has been submitted to the
   queue.

Submitting Multiple STATA Jobs to a Queue Using a Single Submit Script
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Multiple STATA scripts can be executed non-interactively in batch mode by
creating an single sbatch script. The sbatch script gives the Slurm
resource scheduler information about what compute resources your
calculations requires to run and also how to run the STATA script for each
job when the job is executed by Slurm.

1. Log into the cluster using SSH and run the following commands at the
   command prompt.
2. ``cd`` to the directory with the STATA script or scripts
3. ``cp /hpc/examples/stata/stata_array_example.sbatch <descriptive file name>``
   where ``<descriptive file name>`` is meaningful for the calculations
   being done. It is suggested to not use spaces in the file name and
   that it end with .sbatch for clarity. Additionally, to run this specific
   example you will also need additional files that can be copied with the
   command ``cp /hpc/examples/stata/{array_example_1.do,array_example_2.do,example.dta} .``.
4. Edit the sbatch file using using preferred text editor. Change the
   partition and flags, STATA script file name, and number of jobs that
   will be executed as required for your specific calculation.

.. literalinclude:: ../examples/stata/stata_array_example.sbatch
   :language: bash

5. ``sbatch <descriptive file name>`` where ``<descriptive file name>``
   is the Sbatch script name chosen previously.
6. ``squeue -u $USER`` to verify that the job has been submitted to the
   queue.
