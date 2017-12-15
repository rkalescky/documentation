.. _sas:

Running SAS on ManeFrame II
===========================

Types of Nodes On Which SAS Is to Run
-------------------------------------

First, you must identify the type of compute resource needed to run your
calculation. In the following table the compute resources are delineated
by resource type and the expected duration of the job. The duration and
memory allocations are hard limits. Jobs with calculations that exceed
these limits will fail. Once an appropriate resource has been identified
the partition and Slurm flags from the table can be used in the
following examples.

+-------------+-------------+-------------+-------------+-------------+
| Partition   | Duration    | Cores       | Memory [GB] | Slurm Flags |
+=============+=============+=============+=============+=============+
| development | 2 hours     | 36          | 256         | ``-p develo |
|             |             |             |             | pment``     |
+-------------+-------------+-------------+-------------+-------------+
| htc         | 1 day.      | 1           | 6           | ``-p htc -- |
|             |             |             |             | mem=6G``    |
+-------------+-------------+-------------+-------------+-------------+
| standard-me | 1 day       | 36          | 256         | ``-p standa |
| m-s         |             |             |             | rd-mem-s -- |
|             |             |             |             | exclusive - |
|             |             |             |             | -mem=250G`` |
+-------------+-------------+-------------+-------------+-------------+
| standard-me | 1 week      | 36          | 256         | ``-p standa |
| m-m         |             |             |             | rd-mem-m -- |
|             |             |             |             | exclusive - |
|             |             |             |             | -mem=250G`` |
+-------------+-------------+-------------+-------------+-------------+
| standard-me | 1 month     | 36          | 256         | ``-p standa |
| m-l         |             |             |             | rd-mem-l -- |
|             |             |             |             | exclusive - |
|             |             |             |             | -mem=250G`` |
+-------------+-------------+-------------+-------------+-------------+
| medium-mem- | 1 day       | 36          | 768         | ``-p medium |
| 1-s         |             |             |             | -mem-1-s -- |
|             |             |             |             | exclusive - |
|             |             |             |             | -mem=750G`` |
+-------------+-------------+-------------+-------------+-------------+
| medium-mem- | 1 week      | 36          | 768         | ``-p medium |
| 1-m         |             |             |             | -mem-1-m -- |
|             |             |             |             | exclusive - |
|             |             |             |             | -mem=750G`` |
+-------------+-------------+-------------+-------------+-------------+
| medium-mem- | 1 month     | 36          | 768         | ``-p medium |
| 1-l         |             |             |             | -mem-1-l -- |
|             |             |             |             | exclusive - |
|             |             |             |             | -mem=750G`` |
+-------------+-------------+-------------+-------------+-------------+
| medium-mem- | 2 weeks     | 24          | 768         | ``-p medium |
| 2           |             |             |             | -mem-2 --ex |
|             |             |             |             | clusive --m |
|             |             |             |             | em=750G``   |
+-------------+-------------+-------------+-------------+-------------+
| high-mem-1  | 2 weeks     | 36          | 1538        | ``-p high-m |
|             |             |             |             | em-1 --excl |
|             |             |             |             | usive --mem |
|             |             |             |             | =1500G``    |
+-------------+-------------+-------------+-------------+-------------+
| high-mem-2  | 2 weeks     | 40          | 1538        | ``-p high-m |
|             |             |             |             | em-2 --excl |
|             |             |             |             | usive --mem |
|             |             |             |             | =1500G``    |
+-------------+-------------+-------------+-------------+-------------+
| mic         | 1 week      | 64          | 384         | ``-p mic -- |
|             |             |             |             | exclusive - |
|             |             |             |             | -mem=374G`` |
+-------------+-------------+-------------+-------------+-------------+
| gpgpu-1     | 1 week      | 36          | 256         | ``-p gpgpu- |
|             |             |             |             | 1 --exclusi |
|             |             |             |             | ve --gres=g |
|             |             |             |             | pu:1 --mem= |
|             |             |             |             | 250G``      |
+-------------+-------------+-------------+-------------+-------------+
| dcv         | 1 day       | 36          | 256         | ``-p dcv -- |
|             |             |             |             | exclusive - |
|             |             |             |             | -mem=250G`` |
+-------------+-------------+-------------+-------------+-------------+

Running SAS Interactively with the Graphical User Interface
-----------------------------------------------------------

The SAS graphical user interface can be run directly off of ManeFrame II
compute nodes using X11 forwarding.

Running SAS Graphical User Interface Via X11 Forwarding
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Running the SAS graphical user interface via X11 requires SSH with X11
forwarding and SFTP access.

1. Log into the cluster using SSH with X11 forwarding enabled and run
   the following commands at the command prompt.
2. ``module load sas`` to enable access to SAS
3. ``srun -p <partition and options> --x11=first --pty sas`` where
   ``<partition and options>`` is the partition and associated Slurm
   flags for each partition outlined above.

**Example:**

.. code:: bash

       module load sas
       srun -p htc --exclusive --mem=6G --x11=first --pty sas

Running SAS Non-Interactively in Batch Mode
-------------------------------------------

SAS scripts can be executed non-interactively in batch mode in a myriad
ways depending on the type of compute resource needed for the
calculation, the number of calculations to be submitted, and user
preference. The types of compute resources outlined above. Here, each
partition delineates a specific type of compute resource and the
expected duration of the calculation. Each of the following methods
require SSH access. Examples can be found at ``/hpc/examples/sas`` on
ManeFrame II.

Submitting a SAS Job to a Queue Using Wrap
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A SAS script can be executed non-interactively in batch mode directly
using sbatch's wrapping function.

1. Log into the cluster using SSH and run the following commands at the
   command prompt.
2. ``module load sas`` to enable access to SAS
3. ``cd`` to directory with SAS script
4. ``sbatch -p <partition and options> --wrap "sas <sas script file name>"``
   where ``<partition and options>`` is the partition and associated
   Slurm flags for each partition outlined in the table above. and
   ``<sas script file name>`` is the SAS script to be run.
5. ``squeue -u $USER`` to verify that the job has been submitted to the
   queue

**Example:**

.. code:: bash

       module load sas
       sbatch -p standard-mem-s --exclusive --mem=250G --wrap "sas example.sas"

Submitting a SAS Job to a Queue Using a Submit Script
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A SAS script can be executed non-interactively in batch mode by creating
an Sbatch script. The Sbatch script gives the Slurm resource scheduler
information about what compute resources your calculation requires to
run and also how to run the SAS script when the job is executed by
Slurm.

1. Log into the cluster using SSH and run the following commands at the
   command prompt.
2. ``cd`` to directory with SAS script
3. ``cp /hpc/examples/sas/sas_example.sbatch <descriptive file name>``
   where ``<descriptive file name>`` is meaningful for the calculation
   being done. It is suggested to not use spaces in the file name and
   that it end with .sbatch for clarity.
4. Edit the Sbatch file using using preferred text editor. Change the
   partition and flags and SAS script file name as required for your
   specific calculation.

.. code:: bash

       #!/bin/bash
       #SBATCH -J sas_example                 # Job name
       #SBATCH -o example.txt                 # Output file name
       #SBATCH -p standard-mem-s              # Partition (queue)
       #SBATCH --exclusive                    # Exclusivity 
       #SBATCH --mem=250G                     # Total memory required per node
       
       module purge                           # Unload all modules
       module load sas/9.4                    # Load SAS, change version as needed
       
       sas_tmp=${SCRATCH}/tmp/sas             # Setup directory for scratch files
       mkdir -p ${sas_tmp}
       
       sas example.sas -work ${sas_tmp}       # Edit SAS script name as needed

5. ``sbatch <descriptive file name>`` where ``<descriptive file name>``
   is the Sbatch script name chosen previously.
6. ``squeue -u $USER`` to verify that the job has been submitted to the
   queue.

Submitting Multiple SAS Jobs to a Queue Using a Single Submit Script
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Multiple SAS scripts can be executed non-interactively in batch mode by
creating an single Sbatch script. The Sbatch script gives the Slurm
resource scheduler information about what compute resources your
calculations requires to run and also how to run the SAS script for each
job when the job is executed by Slurm.

1. Log into the cluster using SSH and run the following commands at the
   command prompt.
2. ``cd`` to the directory with the SAS script or scripts
3. ``cp /hpc/examples/sas/sas_array_example.sbatch <descriptive file name>``
   where ``<descriptive file name>`` is meaningful for the calculations
   being done. It is suggested to not use spaces in the file name and
   that it end with .sbatch for clarity.
4. Edit the Sbatch file using using preferred text editor. Change the
   partition and flags, SAS script file name, and number of jobs that
   will be executed as required for your specific calculation.

.. code:: bash

       #!/bin/bash
       #SBATCH -J sas_example                 # Job name
       #SBATCH -p standard-mem-s              # Partition (queue)
       #SBATCH --exclusive                    # Exclusivity 
       #SBATCH --mem=250G                     # Total memory required per node
       #SBATCH -o sas_example_%A-%a.out       # Job output; %A is job ID and %a is array index
       #SBATCH --array=1-2                    # Range of indices to be executed

       module purge                           # Unload all modules
       module load sas/9.4                    # Load SAS, change version as needed

       sas_tmp=${SCRATCH}/tmp/sas             # Setup directory for scratch files
       mkdir -p ${sas_tmp}

       sas array_example_${SLURM_ARRAY_TASK_ID}.sas -work ${sas_tmp} 
       # Edit SAS script name as needed; ${SLURM_ARRAY_TASK_ID} is array index

5. ``sbatch <descriptive file name>`` where ``<descriptive file name>``
   is the Sbatch script name chosen previously.
6. ``squeue -u $USER`` to verify that the job has been submitted to the
   queue.
