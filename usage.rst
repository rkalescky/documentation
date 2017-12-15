.. _usage:

:tocdepth: 3

Usage
#####

.. toctree::

   UNIX and Linux <unix>
   Scripting <scripting>
   Modules <modules>
   Slurm <slurm>

Here you can can fine information on how to effectively use ManeFrame
II. For questions about using SMU's HPC resources or setting up
`accounts <~/link.aspx?_id=0897B41E31514946ABE677FE00FAF843&_z=z>`__
please email the `SMU HPC Admins <mailto:smuhpc-admins@smu.edu>`__.

.. raw:: html

   <div class="alert">

For a quick reference page of ManeFrame II specific information please
see the \ `ManeFrame II
Cheatsheet <https://smu.box.com/s/ml22oudkmqz89df2opxdgw5219wv5tnx>`__.

.. raw:: html

   </div>

Accessing Applications via Modules
==================================

The module system is a command-line tool to help users manage their
Linux environment variables (e.g. PATH, LD_LIBRARY_PATH). It works by
grouping related environment variable settings together based on various
usage scenarios, such as

-  Adding executables to a user's PATH
-  Adding the location of specific software libraries to a user's
   LD_LIBRARY_PATH
-  Adding documentation manual pages "man pages" to a user's MANPATH
-  Creating custom environment variables to define the global path where
   a specific package is installed.

| These modules may be added/removed dynamically, allowing a user to
  have a great amount of control over her/his environment.
| Possibly one of the greatest assets of the module system is that it
  provides a simple user interface, and can be queried to learn all of
  the available modules on a system, making it easier to know which
  packages are or aren't already installed on a system.
| The module system operates through the Linux executable, module,
  followed by the desired command. The primary module commands are as
  follows:

-  "module avail" -- displays a list of all available modules on the
   system.
-  "module list" -- lists all currently loaded modules in your working
   environment.
-  "module add" and "module load" -- loads a module into your working
   environment.
-  "module rm" and "module unload" -- undoes a previous "add" or "load"
   command, removing the module from your working environment.
-  "module switch" and "module swap" -- this does a combination
   unload/load, swapping out one module for another.
-  "module display" and "module show" -- this shows detaled information
   about how a specific module affects your environment.
-  "module help" -- This displays a set of descriptive information about
   the module (what it does, the version number of the software, etc.).

.. raw:: html

   <div class="alert">

**Request Software Installation**

A software installation request can be made by sending an email
`help@smu.edu <mailto:help@smu.edu?subject=HPC%20Software%20Installation%20Request>`__
with "HPC" in the subject line.

.. raw:: html

   </div>

Submitting Jobs via Slurm
=========================

Slurm set of programs that manage unattended background program
execution (a.k.a. *batch processing*). The basic features of any job
scheduler include:

-  Interfaces which help to define workflows and/or job dependencies.
-  Automatic submission of executions.
-  Interfaces to monitor the executions.
-  Priorities and/or queues to control the execution order of unrelated
   jobs.

In the context of high-throughput and high-performance computing, the
primary role of a job scheduler is to manage the job queue for all of
the compute nodes of the cluster. It's goal is typically to schedule
queued jobs so that all of the compute nodes are utilized to their
capacity, yet doing so in a fair manner that gives priority to users who
have used less resources and/or contributed more to the acquisition of
the system.

.. maneframes-slurm-partitionsqueues:

ManeFrame II's Queues (Partitions)
----------------------------------

+---------+---------+---------+---------+---------+---------+---------+
| Queue   | Quantit | Exclusi | Duratio | Cores   | Memory  | Additio |
|         | y       | vity    | n       |         | [GB]    | nal     |
|         | [Nodes] |         |         |         |         | Notes   |
+=========+=========+=========+=========+=========+=========+=========+
| develop | 2       | Partial | 2 hours | 36      | 256     | 2 Intel |
| ment    |         |         |         |         |         | Xeon    |
|         |         |         |         |         |         | E5-2695 |
|         |         |         |         |         |         | v4      |
|         |         |         |         |         |         | CPUs    |
+---------+---------+---------+---------+---------+---------+---------+
| htc     | 52      | Shared  | 1 day   | 1       | 8       | 2 Intel |
|         |         |         |         |         |         | Xeon    |
|         |         |         |         |         |         | E5-2695 |
|         |         |         |         |         |         | v4      |
|         |         |         |         |         |         | CPUs    |
+---------+---------+---------+---------+---------+---------+---------+
| standar | 80      | Exclusi | 1 day   | 36      | 256     | 2 Intel |
| d-mem-s |         | ve      |         |         |         | Xeon    |
|         |         |         |         |         |         | E5-2695 |
|         |         |         |         |         |         | v4      |
|         |         |         |         |         |         | CPUs    |
+---------+---------+---------+---------+---------+---------+---------+
| standar | 24      | Exclusi | 1 week  | 36      | 256     | 2 Intel |
| d-mem-m |         | ve      |         |         |         | Xeon    |
|         |         |         |         |         |         | E5-2695 |
|         |         |         |         |         |         | v4      |
|         |         |         |         |         |         | CPUs    |
+---------+---------+---------+---------+---------+---------+---------+
| standar | 18      | Exclusi | 1 month | 36      | 256     | 2 Intel |
| d-mem-l |         | ve      |         |         |         | Xeon    |
|         |         |         |         |         |         | E5-2695 |
|         |         |         |         |         |         | v4      |
|         |         |         |         |         |         | CPUs    |
+---------+---------+---------+---------+---------+---------+---------+
| medium- | 20      | Exclusi | 1 day   | 36      | 768     | 2 Intel |
| mem-1-s |         | ve      |         |         |         | Xeon    |
|         |         |         |         |         |         | E5-2695 |
|         |         |         |         |         |         | v4      |
|         |         |         |         |         |         | CPUs    |
+---------+---------+---------+---------+---------+---------+---------+
| medium- | 10      | Exclusi | 1 week  | 36      | 768     | 2 Intel |
| mem-1-m |         | ve      |         |         |         | Xeon    |
|         |         |         |         |         |         | E5-2695 |
|         |         |         |         |         |         | v4      |
|         |         |         |         |         |         | CPUs    |
+---------+---------+---------+---------+---------+---------+---------+
| medium- | 5       | Exclusi | 1 month | 36      | 768     | 2 Intel |
| mem-1-l |         | ve      |         |         |         | Xeon    |
|         |         |         |         |         |         | E5-2695 |
|         |         |         |         |         |         | v4      |
|         |         |         |         |         |         | CPUs    |
+---------+---------+---------+---------+---------+---------+---------+
| medium- | 4       | Exclusi | 2 weeks | 24      | 768     | 2 Intel |
| mem-2   |         | ve      |         |         |         | Xeon    |
|         |         |         |         |         |         | E5-2680 |
|         |         |         |         |         |         | v3      |
|         |         |         |         |         |         | CPUs    |
+---------+---------+---------+---------+---------+---------+---------+
| high-me | 5       | Exclusi | 2 weeks | 36      | 1,538   | 2 Intel |
| m-1     |         | ve      |         |         |         | Xeon    |
|         |         |         |         |         |         | E5-2695 |
|         |         |         |         |         |         | v4      |
|         |         |         |         |         |         | CPUs    |
+---------+---------+---------+---------+---------+---------+---------+
| high-me | 6       | Exclusi | 2 weeks | 40      | 1,538   | 4 Intel |
| m-2     |         | ve      |         |         |         | Xeon    |
|         |         |         |         |         |         | E7-8891 |
|         |         |         |         |         |         | CPUs    |
+---------+---------+---------+---------+---------+---------+---------+
| mic     | 36      | Exclusi | 1 week  | 64      | 384     | 1 Intel |
|         |         | ve      |         |         |         | Xeon    |
|         |         |         |         |         |         | Phi     |
|         |         |         |         |         |         | 7230    |
|         |         |         |         |         |         | CPU     |
+---------+---------+---------+---------+---------+---------+---------+
| gpgpu-1 | 36      | Exclusi | 1 week  | 36      | 256     | 1       |
|         |         | ve      |         |         |         | NVIDIA  |
|         |         |         |         |         |         | P100    |
|         |         |         |         |         |         | GPU     |
+---------+---------+---------+---------+---------+---------+---------+
| gpgpu-2 | 1       | Exclusi | 1 week  | 12      | 31      | 4       |
|         |         | ve      |         |         |         | NVIDIA  |
|         |         |         |         |         |         | K80     |
|         |         |         |         |         |         | GPUs    |
+---------+---------+---------+---------+---------+---------+---------+
| dcv     | 5       | Exclusi | 1 day   | 36      | 256     | 1       |
|         |         | ve      |         |         |         | NVIDIA  |
|         |         |         |         |         |         | M5000   |
|         |         |         |         |         |         | GPU     |
+---------+---------+---------+---------+---------+---------+---------+

development
    The development queue is primarily used for software development and
    testing.

htc
    The high-throughput computing (HTC) queue is exclusively for
    single-threaded and relatively low memory jobs.

standard-mem
    The standard memory queue is for base compute nodes. These nodes are
    allocated on a whole-node basis (exclusive access per job).

medium-mem-1
    The first medium memory queue if for the new medium memory compute
    nodes. These nodes are allocated on a whole-node basis (exclusive
    access per job).

medium-mem-2
    The second medium memory queue is for the the existing dense-memory1
    nodes that will be moved forward to ManeFrame II.

high-mem-1
    The first high memory queue is for the new high memory compute
    nodes.

high-mem-2
    The second high memory queue is for the existing dense-memory2 nodes
    that will will be moved forward to ManeFrame II.

mic
    The many integrated core (MIC) queue is for the Intel KNL nodes.

gpgpu-1
    The first general-purpose computing on graphics processing units
    (GPGPU) is for the new NVIDIA P100 GPU nodes.

gpgpu-2
    The second general-purpose computing on graphics processing units
    (GPGPU) is for the existing gpu4 node that will be moved forward to
    ManeFrame II.

dvc
    The desktop cloud visualization (DVC) queue is for the NVIDIA M5000
    nodes primarily used for remote desktop computing.

 

.. slurm-commands:

Basic Slurm Commands
--------------------

-  sinfo -- displays information about SLURM nodes and partitions (queue
   types).
-  squeue -- views information about jobs located in the SLURM
   scheduling queue.
-  sbatch -- submits a batch script to SLURM.
-  srun -- runs a parallel or interactive job on the worker nodes.
-  salloc -- obtains a SLURM job allocation (a set of nodes), executes a
   command, and then releases the allocation when the command is
   finished.
-  scancel -- kills jobs or job steps that are under the control of
   SLURM and listed by squeue.
