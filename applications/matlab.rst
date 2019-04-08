.. _matlab:

:tocdepth: 3

Running MATLAB on ManeFrame II
==============================

Types of Nodes on Which MATLAB is to Run
----------------------------------------

First, you must identify the type of compute resource needed to run your
calculation. In the following table the compute resources are delineated
by resource type and the expected duration of the job. The duration and
memory allocations are hard limits. Jobs with calculations that exceed
these limits will fail. Once an appropriate resource has been identified
the partition and Slurm flags from the table can be used in the
following examples.

.. include:: ../common/slurm_flag_table.rst

Running MATLAB Interactively with the Graphical User Interface
--------------------------------------------------------------

The MATLAB graphical user interface can be run directly off of ManeFrame II (M2)
compute nodes using X11 forwarding.

Running MATLAB Graphical User Interface via X11 Forwarding
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Running the MATLAB graphical user interface via X11 requires SSH with X11
forwarding and SFTP access.

1. Log into the cluster using SSH with X11 forwarding enabled and run
   the following commands at the command prompt.
2. ``module load matlab`` to enable access to MATLAB.
3. ``srun -p <partition and options> --x11=first --pty matlab`` where
   ``<partition and options>`` is the partition and associated Slurm
   flags for each partition outlined above.

**Example:**

.. code:: bash

       module load matlab
       srun -p htc --exclusive --mem=6G --x11=first --pty matlab

Running MATLAB Graphical User Interface Locally and Issuing Computations to ManeFrame II
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ManeFrame II (M2) has `MATLAB Distributed Computing Server (DCS) <https://www.mathworks.com/products/distriben.html>`__ installed which enables MATLAB users to issue commands from their local MATLAB installation and have those commands run on M2. However, to be able to do this several criteria first need to be met.

#. The local (your machine) MATLAB installation needs to be MATLAB R2017a.
#. SSH key based authentication to M2 must be set up.
#. The MATLAB DCS integration scripts need to be locally installed.
#. Configuring jobs and computations.

These are discussed each in turn in the following sections.

MATLAB Installation
^^^^^^^^^^^^^^^^^^^

Setting Up SSH Keys for Passwordless Access
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Linux and macOS (and Other UNIX-Like Environments)
""""""""""""""""""""""""""""""""""""""""""""""""""

.. include:: ../common/ssh_key_setup_unix.rst

Windows Using Putty
"""""""""""""""""""

.. include:: ../common/ssh_key_setup_putty.rst

MATLAB DCS Integration Script Installation
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Add the MATLAB integration scripts to your MATLAB Path by placing the integration scripts into ``$MATLAB/toolbox/local``.

Configuring Jobs and Computation
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Prior to submitting the job, we can specify various parameters to pass
to our jobs, such as queue, username, e-mail, etc. Note that any parameters specified using the below workflow will be persistent between MATLAB sessions.

.. code:: matlab

   % Get a handle to the cluster
   c = parcluster;
   % Specify a particular queue to use for MATLAB jobs
   c.AdditionalProperties.QueueName = ‘queue’;
   % Specify e-mail address to receive notifications about your job
   c.AdditionalProperties.EmailAddress = ‘test@foo.com’;
   % Specify the walltime
   c.AdditionalProperties.WallTime = '00:10:00';
   % Request GPUs – this will automatically submit to the GPU queue
   c.AdditionalProperties.UseGpu = true;
   % Specify memory per core/worker to use
   c.AdditionalProperties.MemUsage = ‘4GB’;
   % Specify if your private key/identity file requires a passphrase by default, it is set to false
   c.AdditionalProperties.FileHasPassphrase = true;
   % Save changes after modifying AdditionalProperties fields.
   c.saveProfile

To see the values of the current configuration options, call the
specific AdditionalProperties name.

.. code:: matlab

   % To view current configurations
   c.AdditionalProperties.QueueName

To clear a value, assign the property an empty value (‘’, [], or false).

.. code:: matlab

   % To clear a configuration that takes a string as input
   c.AdditionalProperties.EmailAddress = ‘ ’

**SERIAL JOBS**

Use the batch command to submit asynchronous jobs to the cluster. The
batch command will return a job object which is used to access the
output of the submitted job. See the MATLAB documentation for more help
on batch.

.. code:: matlab

   % Get a handle to the cluster
   c = parcluster;
   % Submit job to query where MATLAB is running on the cluster
   j = c.batch(@pwd, 1, {});
   % Query job for state
   j.State
   % If state is finished, fetch results
   j.fetchOutputs{:}
   % Delete the job after results are no longer needed
   j.delete

To retrieve a list of currently running or completed jobs, call
`parcluster` to retrieve the cluster object. The cluster object stores an
array of jobs that were run, are running, or are queued to run. This
allows us to fetch the results of completed jobs. Retrieve and view the
list of jobs as shown below.

.. code:: matlab

   c = parcluster;
   jobs = c.Jobs

Once we’ve identified the job we want, we can retrieve the results as
we’ve done previously.

fetchOutputs is used to retrieve function output arguments; if using
batch with a script, use load instead. Data that has been written to
files on the cluster needs be retrieved directly from the file system.

To view results of a previously completed job:

.. code:: matlab

   % Get a handle on job with ID 2
   j2 = c.Jobs(2);

NOTE: You can view a list of your jobs, as well as their IDs, using the
above c.Jobs command.

.. code:: matlab

   % Fetch results for job with ID 2
   j2.fetchOutputs{:}
   % If the job produces an error view the error log file
   c.getDebugLog(j.Tasks(1))

NOTE: When submitting independent jobs, with multiple tasks, you will
have to specify the task number.

**PARALLEL JOBS**

Users can also submit parallel workflows with batch. Let’s use the
following example for a parallel job.

We’ll use the batch command again, but since we’re running a parallel
job, we’ll also specify a MATLAB Pool.

.. code:: matlab

   % Get a handle to the cluster
   c = parcluster;
   % Submit a batch pool job using 4 workers for 16 simulations
   j = c.batch(@parallel_example, 1, {}, ‘Pool’, 4);
   % View current job status
   j.State
   % Fetch the results after a finished state is retrieved
   j.fetchOutputs{:}
   
   ans =
   
   8.8872

The job ran in 8.8872 seconds using 4 workers. Note that these jobs will
always request N+1 CPU cores, since one worker is required to manage the
batch job and pool of workers. For example, a job that needs eight
workers will consume nine CPU cores.

We’ll run the same simulation, but increase the Pool size. This time, to
retrieve the results at a later time, we’ll keep track of the job ID.

NOTE: For some applications, there will be a diminishing return when
allocating too many workers, as the overhead may exceed computation
time.

.. code:: matlab

   % Get a handle to the cluster
   c = parcluster;
   % Submit a batch pool job using 8 workers for 16 simulations
   j = c.batch(@parallel_example, 1, {}, ‘Pool’, 8);
   % Get the job ID
   id = j.ID
   Id =
   
   4

   % Clear workspace, as though we quit MATLAB
   clear j

Once we have a handle to the cluster, we’ll call the findJob method to
search for the job with the specified job ID.

.. code:: matlab

   % Get a handle to the cluster
   c = parcluster;
   % Find the old job
   j = c.findJob(‘ID’, 4);
   % Retrieve the state of the job
   j.State
   
   ans
   
   finished
   
   % Fetch the results
   j.fetchOutputs{:};
   
   ans =
   
   4.7270
   
   % If necessary, retrieve output/error log file
   c.getDebugLog(j)

The job now runs 4.7270 seconds using 8 workers. Run code with different
number of workers to determine the ideal number to use.

Alternatively, to retrieve job results via a graphical user interface,
use the Job Monitor (Parallel > Monitor Jobs).

**DEBUGGING**

If a serial job produces an error, we can call the getDebugLog method to
view the error log file.

.. code:: matlab

   j.Parent.getDebugLog(j.Tasks(1))

When submitting independent jobs, with multiple tasks, you will have to
specify the task number. For Pool jobs, do not deference into the job
object.

.. code:: matlab

   j.Parent.getDebugLog(j)

The scheduler ID can be derived by calling schedID

.. code:: matlab

   schedID(j)
   
   ans
   
   25539

**TO LEARN MORE**

To learn more about the MATLAB Parallel Computing Toolbox, check out
these resources:

* `Parallel Computing Coding
  Examples <http://www.mathworks.com/products/parallel-computing/code-examples.html>`__
* `Parallel Computing
  Documentation <http://www.mathworks.com/help/distcomp/index.html>`__
* `Parallel Computing
  Overview <http://www.mathworks.com/products/parallel-computing/index.html>`__
* `Parallel Computing
  Tutorials <http://www.mathworks.com/products/parallel-computing/tutorials.html>`__
* `Parallel Computing
  Videos <http://www.mathworks.com/products/parallel-computing/videos.html>`__
* `Parallel Computing
  Webinars <http://www.mathworks.com/products/parallel-computing/webinars.html>`__

Running MATLAB Non-Interactively in Batch Mode
----------------------------------------------

MATLAB scripts can be executed non-interactively in batch mode in a myriad
ways depending on the type of compute resource needed for the
calculation, the number of calculations to be submitted, and user
preference. The types of compute resources outlined above. Here, each
partition delineates a specific type of compute resource and the
expected duration of the calculation. Each of the following methods
require SSH access. Examples can be found at ``/hpc/examples/matlab`` on M2.

Submitting a MATLAB Job to a Queue Using Wrap
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A MATLAB script can be executed non-interactively in batch mode directly
using sbatch's wrapping function.

1. Log into the cluster using SSH and run the following commands at the
   command prompt.
2. ``module load matlab`` to enable access to MATLAB.
3. ``cd`` to the directory with MATLAB script.
4. ``sbatch -p <partition and options> --wrap "matlab <matlab script file name>"``
   where ``<partition and options>`` is the partition and associated
   Slurm flags for each partition outlined in the table above. and
   ``<matlab script file name>`` is the MATLAB script to be run.
5. ``squeue -u $USER`` to verify that the job has been submitted to the
   queue.

**Example:**

.. code:: bash

       module load matlab
       sbatch -p standard-mem-s --exclusive --mem=250G --wrap "matlab example.do"

Submitting a MATLAB Job to a Queue Using an sbatch Script
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A MATLAB script can be executed non-interactively in batch mode by creating
an sbatch script. The sbatch script gives the Slurm resource scheduler
information about what compute resources your calculation requires to
run and also how to run the MATLAB script when the job is executed by
Slurm.

1. Log into the cluster using SSH and run the following commands at the
   command prompt.
2. ``cd`` to the directory with MATLAB script.
3. ``cp /hpc/examples/matlab/matlab_example_htc.sbatch <descriptive file name>``
   where ``<descriptive file name>`` is meaningful for the calculation
   being done. It is suggested to not use spaces in the file name and
   that it end with *.sbatch* for clarity.
4. Edit the sbatch file using using preferred text editor. Change the
   partition and flags and MATLAB script file name as required for your
   specific calculation.

.. literalinclude:: ../examples/matlab/matlab_example_htc.sbatch
   :language: bash

5. ``sbatch <descriptive file name>`` where ``<descriptive file name>``
   is the sbatch script name chosen previously.
6. ``squeue -u $USER`` to verify that the job has been submitted to the
   queue.

Submitting Multiple MATLAB Jobs to a Queue Using a Single sbatch Script
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Multiple MATLAB scripts can be executed non-interactively in batch mode by
creating a single sbatch script. The sbatch script gives the Slurm
resource scheduler information about what compute resources your
calculations requires to run and also how to run the MATLAB script for each
job when the job is executed by Slurm.

1. Log into the cluster using SSH and run the following commands at the
   command prompt.
2. ``cd`` to the directory with the MATLAB script or scripts.
3. ``cp /hpc/examples/matlab/matlab_array_example.sbatch <descriptive file name>``
   where ``<descriptive file name>`` is meaningful for the calculations
   being done. It is suggested to not use spaces in the file name and
   that it end with *.sbatch* for clarity. Additionally, to run this specific
   example you will also need additional files that can be copied with the
   command ``cp /hpc/examples/matlab/{array_example_1.do,array_example_2.do,example.dta} .``.
4. Edit the sbatch file using using preferred text editor. Change the
   partition and flags, MATLAB script file name, and number of jobs that
   will be executed as required for your specific calculation.

.. literalinclude:: ../examples/matlab/matlab_example_array.sbatch
   :language: bash

5. ``sbatch <descriptive file name>`` where ``<descriptive file name>``
   is the sbatch script name chosen previously.
6. ``squeue -u $USER`` to verify that the job has been submitted to the
   queue.
