.. _r:

:tocdepth: 3

Running R on ManeFrame II
=========================

Types of Nodes On Which R Is to Run
-----------------------------------

First, you must identify the type of compute resource needed to run your
calculation. In the following table the compute resources are delineated
by resource type and the expected duration of the job. The duration and
memory allocations are hard limits. Jobs with calculations that exceed
these limits will fail. Once an appropriate resource has been identified
the partition and Slurm flags from the table can be used in the
following examples.

.. include:: ../common/slurm_flag_table.rst

Running R Interactively with RStudio
------------------------------------

The RStudio graphical user interface can be run directly off of
ManeFrame II compute nodes using X11 forwarding.

Running R Graphical User Interface Via X11 Forwarding
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Running RStudio via X11 requires SSH with X11 forwarding and SFTP
access.

1. Log into the cluster using SSH with X11 forwarding enabled and run
   the following commands at the command prompt.
2. ``module load rstudio`` to enable access to R and RStudio.
3. ``srun -p <partition and options> --x11=first --pty rstudio`` where
   ``<partition and options>`` is the partition and associated Slurm
   flags for each partition outlined above.

**Example:**

.. code:: bash

       module load rstudio
       srun -p htc --exclusive --mem=6G --x11=first --pty rstudio

Running R Non-Interactively in Batch Mode
-----------------------------------------

R scripts can be executed non-interactively in batch mode in a myriad
ways depending on the type of compute resource needed for the
calculation, the number of calculations to be submitted, and user
preference. The types of compute resources outlined above. Here, each
partition delineates a specific type of compute resource and the
expected duration of the calculation. Each of the following methods
require SSH access. Examples can be found at ``/hpc/examples/r`` on
ManeFrame II.

Submitting a R Job to a Queue Using Wrap
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A R script can be executed non-interactively in batch mode directly
using sbatch's wrapping function.

1. Log into the cluster using SSH and run the following commands at the
   command prompt.
2. ``module load r`` to enable access to R.
3. ``cd`` to directory with R script.
4. ``sbatch -p <partition and options> --wrap "R --vanilla < <R script file name>"``
   where ``<partition and options>`` is the partition and associated
   Slurm flags for each partition outlined in the table above. and
   ``<R script file name>`` is the R script to be run.
5. ``squeue -u $USER`` to verify that the job has been submitted to the
   queue.

**Example:**

.. code:: bash

       module load r
       sbatch -p standard-mem-s --exclusive --mem=250G --wrap "R --vanilla < example.R"

Submitting a R Job to a Queue Using a Submit Script
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A R script can be executed non-interactively in batch mode by creating
an Sbatch script. The Sbatch script gives the Slurm resource scheduler
information about what compute resources your calculation requires to
run and also how to run the R script when the job is executed by Slurm.

1. Log into the cluster using SSH and run the following commands at the
   command prompt.
2. ``cd`` to directory with R script
3. ``cp /hpc/examples/r/r_example.sbatch <descriptive file name>`` where
   ``<descriptive file name>`` is meaningful for the calculation being
   done. It is suggested to not use spaces in the file name and that it
   end with .sbatch for clarity.
4. Edit the Sbatch file using using preferred text editor. Change the
   partition and flags and R script file name as required for your
   specific calculation.

.. code:: bash

       #!/bin/bash
       #SBATCH -J R_example                   # Job name
       #SBATCH -o example.txt                 # Output file name
       #SBATCH -p standard-mem-s              # Partition (queue)
       #SBATCH --exclusive                    # Exclusivity 
       #SBATCH --mem=250G                     # Total memory required per node
       
       module purge                           # Unload all modules
       module load r                          # Load R, change version as needed
       
       R --vanilla < example.R                # Edit R script name as needed

5. ``sbatch <descriptive file name>`` where ``<descriptive file name>``
   is the Sbatch script name chosen previously.
6. ``squeue -u $USER`` to verify that the job has been submitted to the
   queue.

Submitting Multiple R Jobs to a Queue Using a Single Submit Script
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Multiple R scripts can be executed non-interactively in batch mode by
creating an single Sbatch script. The Sbatch script gives the Slurm
resource scheduler information about what compute resources your
calculations requires to run and also how to run the R script for each
job when the job is executed by Slurm.

1. Log into the cluster using SSH and run the following commands at the
   command prompt.
2. ``cd`` to the directory with the R script or scripts
3. ``cp /hpc/examples/r/r_array_example.sbatch <descriptive file name>``
   where ``<descriptive file name>`` is meaningful for the calculations
   being done. It is suggested to not use spaces in the file name and
   that it end with .sbatch for clarity.
4. Edit the Sbatch file using using preferred text editor. Change the
   partition and flags, R script file name, and number of jobs that will
   be executed as required for your specific calculation.

.. code:: bash

       #!/bin/bash
       #SBATCH -J R_example                   # Job name
       #SBATCH -p standard-mem-s              # Partition (queue)
       #SBATCH --exclusive                    # Exclusivity 
       #SBATCH --mem=250G                     # Total memory required per node
       #SBATCH -o R_example_%A-%a.out         # Job output; %A is job ID and %a is array index
       #SBATCH --array=1-2                    # Range of indices to be executed

       module purge                           # Unload all modules
       module load r                          # Load R, change version as needed

       R --vanilla < array_example_${SLURM_ARRAY_TASK_ID}.R
       # Edit R script name as needed; ${SLURM_ARRAY_TASK_ID} is array index

5. ``sbatch <descriptive file name>`` where ``<descriptive file name>``
   is the Sbatch script name chosen previously.
6. ``squeue -u $USER`` to verify that the job has been submitted to the
   queue.
