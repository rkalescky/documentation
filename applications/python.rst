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
Python and package versions to be installed as needed. Additional, Python
versions can be use via Anaconda and Spack.

Custom Python Evironments and Package Installations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Python environments allow users to use specific versions of Python with the
packages of their choice. The packages can be installed via `conda` or `pip`,
depending on the type of environment being used.

Anaconda Environments
`````````````````````
Anaconda environments are managed using `conda`, which is available via
Anaconda installations such as `python/2` and `python/3` on ManeFrame II.

The the example below a specific version of Python is installed along with the
JupyterLab package and it's dependencies. The new environment is then loaded
and then unloaded.

.. code:: bash

  module purge
  module load python/3
  conda create -y -n jupyter_37 -c conda-forge jupyterlab python=3.7
  source activate ~/.conda/envs/jupyter_37
  deactivate

For more information on managing Python environments with `conda` see `here
<https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html>`_.

.. raw:: html

    <iframe
    src="https://smu.hosted.panopto.com/Panopto/Pages/Embed.aspx?id=b687e8ad-f4c6-4330-b356-ace701266b3f&autoplay=false&offerviewer=false&showtitle=false&showbrand=false&start=0&interactivity=all"
    width=600 height=338 style="border: 1px solid #464646;" allowfullscreen allow="autoplay">
    </iframe>

Python Virtual Environments
```````````````````````````

Python 3 has native support for managing environments, which can be used with
any Python 3 installation on ManeFrame II.

In the example below a specific installation of Python, in this case from
Spack, is used and then JupyterLab and it's dependencies are installed. The new
environment is then loaded and then unloaded.

.. code:: bash

  module purge
  module load spack gcc-9.2
  source <(spack module tcl loads --dependencies python@3.7%gcc@9.2)
  python3 -m venv ~/.venv/jupyter_37
  source ~/.venv/jupyter_37/bin/activate
  pip3 install --upgrade pip
  pip3 install --upgrade jupyterlab
  deactivate

For more information on managing Python environments with Python virtual
environments and `pip` see `here
<https://docs.python.org/3/tutorial/venv.html>`_.

.. raw:: html

    <iframe
    src="https://smu.hosted.panopto.com/Panopto/Pages/Embed.aspx?id=1f2662a9-e56e-43af-8159-ace701266b15&autoplay=false&offerviewer=false&showtitle=false&showbrand=false&start=0&interactivity=all"
    width=600 height=338 style="border: 1px solid #464646;" allowfullscreen allow="autoplay">
    </iframe>

Running Python Interactively with Jupyter Notebooks
---------------------------------------------------

Jupyter Notebooks can be run directly off of M2 compute nodes using the :doc:`HPC
OnDemand Web Portal <../portal>`.

Anaconda environments and Python virtual environments can be used via the
Portal provided that the installation includes JupyterLab as demonstrated
above. In either case, the specific modules and then environment activatation
can be done in the Portal's JupyterLab's "Additional environment modules to
load" and "Custom environment settings" text fields respectively.

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
