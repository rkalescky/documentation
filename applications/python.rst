.. _python:

:tocdepth: 3

Running Python on ManeFrame II
==============================

Types of Nodes on Which Python is to Run
----------------------------------------

First, you must identify the type of compute resource needed to run your
calculation. In the following table the compute resources on ManeFrame II (M2) are delineated
by resource type and the expected duration of the job. The duration and
memory allocations are hard limits. Jobs with calculations that exceed
these limits will fail. Once an appropriate resource has been identified
the partition and Slurm flags from the table can be used in the
following examples.

.. include:: ../common/slurm_flag_table.rst

Python Versions
---------------

There are several Python versions installed on M2. By default, the CentOS
system Python is available. Additional high performance implementations of
Python are available via ``module load python/2`` or ``module load python/3``
for Python 2.7 and Python 3.6 respectively. These Anaconda-based
implementations also support conda environments, which allow for specific
Python and package versions to be installed as needed.

Running Python Interactively with Jupyter Notebooks
---------------------------------------------------

Jupyter Notebooks can be run directly off of M2 compute nodes using the :doc:`HPC
OnDemand Web Portal <../portal>`.

Running Python Non-Interactively in Batch Mode
----------------------------------------------

Python scripts can be executed non-interactively in batch mode in a myriad
ways depending on the type of compute resource needed for the
calculation, the number of calculations to be submitted, and user
preference. The types of compute resources outlined above. Here, each
partition delineates a specific type of compute resource and the
expected duration of the calculation. Each of the following methods
require SSH access. Examples can be found at ``/hpc/examples/python`` and ``/hpc/examples/jupyter`` on M2.

Submitting a Python Job to a Queue Using Wrap
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A Python script can be executed non-interactively in batch mode directly
using sbatch's wrapping function.

1. Log into the cluster using SSH and run the following commands at the
   command prompt.
2. ``module load python`` to enable access to Python.
3. ``cd`` to the directory with Python script.
4. ``sbatch -p <partition and options> --wrap "python <Python script file name>"``
   where ``<partition and options>`` is the partition and associated
   Slurm flags for each partition outlined in the table above. and
   ``<Python script file name>`` is the Python script to be run.
5. ``squeue -u $USER`` to verify that the job has been submitted to the
   queue.

**Example:**

.. code:: bash

       module load python
       sbatch -p standard-mem-s --exclusive --mem=250G --wrap "python example.py"

Submitting a Python Job to a Queue Using an sbatch Script
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A Python script can be executed non-interactively in batch mode by creating
an sbatch script. The sbatch script gives the Slurm resource scheduler
information about what compute resources your calculation requires to
run and also how to run the Python script when the job is executed by Slurm.

1. Log into the cluster using SSH and run the following commands at the
   command prompt.
2. ``cd`` to the directory with the Python script.
3. ``cp /hpc/examples/python/python_example.sbatch <descriptive file name>`` where
   ``<descriptive file name>`` is meaningful for the calculation being
   done. It is suggested to not use spaces in the file name and that it
   end with *.sbatch* for clarity.
4. Edit the sbatch file using using preferred text editor. Change the
   partition and flags and Python script file name as required for your
   specific calculation.

.. code:: bash

       #!/bin/bash
       #SBATCH -J python_example              # Job name
       #SBATCH -o example.txt                 # Output file name
       #SBATCH -p standard-mem-s              # Partition (queue)
       #SBATCH --exclusive                    # Exclusivity 
       #SBATCH --mem=250G                     # Total memory required per node
       
       module purge                           # Unload all modules
       module load python                     # Load R, change version as needed
       
       python example.py                      # Edit Python script name as needed

5. ``sbatch <descriptive file name>`` where ``<descriptive file name>``
   is the sbatch script name chosen previously.
6. ``squeue -u $USER`` to verify that the job has been submitted to the
   queue.

Submitting Multiple Python Jobs to a Queue Using a Single sbatch Script
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Multiple Python scripts can be executed non-interactively in batch mode by
creating a single sbatch script. The sbatch script gives the Slurm
resource scheduler information about what compute resources your
calculations requires to run and also how to run the Python script for each
job when the job is executed by Slurm.

1. Log into the cluster using SSH and run the following commands at the
   command prompt.
2. ``cd`` to the directory with the Python script or scripts.
3. ``cp -R /hpc/examples/python/python_array_example ~/``.
4. ``cd python_array_example``.
5. Edit the sbatch file using using preferred text editor. Change the
   partition and flags, Python script file name, and number of jobs that will
   be executed as required for your specific calculation.

.. code:: bash

       #!/bin/bash
       #SBATCH -J python_example              # Job name
       #SBATCH -p standard-mem-s              # Partition (queue)
       #SBATCH --exclusive                    # Exclusivity 
       #SBATCH --mem=250G                     # Total memory required per node
       #SBATCH -o python_example_%A-%a.out    # Job output; %A is job ID and %a is array index
       #SBATCH --array=1-2                    # Range of indices to be executed

       module purge                           # Unload all modules
       module load python                     # Load R, change version as needed

       python array_example_${SLURM_ARRAY_TASK_ID}.py
       # Edit Python script name as needed; ${SLURM_ARRAY_TASK_ID} is array index

6. ``sbatch python_array.sbatch``.
7. ``squeue -u $USER`` to verify that the job has been submitted to the
   queue.
