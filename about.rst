.. _about:

About
#####

SMU’s new high-performance compute cluster will dramatically increase
the computational capacity and performance that SMU provides to its
researchers. The new cluster features state of the art CPUs,
accelerators, and networking technologies, significantly more memory per
node, and advanced interactive GPU-accelerated remote desktop
experiences. Also, the cluster is much more energy efficient making it
more economical to run and more environmentally friendly!

The new cluster will provide a similar interactive experience for
researchers currently using ManeFrame. Similarities include the CentOS 7
operating system (replacing Scientific Linux 6; both are Red Hat
Enterprise Linux derivatives), the SLURM resource scheduler, and the
Lmod environment module system. Additionally, updated, but familiar,
development tool chains will be available including the GCC, Intel, and
PGI compiler suites. Optimized high-level programming environments such
as MATLAB, Python, and R will also be installed in addition to the
domain specific software packages that SMU researchers depend on for
their work.

+-----------------------------+---------------------+-----------------------+
|                             | ManeFrame I         | ManeFrame II          |
+=============================+=====================+=======================+
| Computational Ability       | 104 TFLOPS          | 630 TFLOPS            |
+-----------------------------+---------------------+-----------------------+
| Number of Nodes             | 1,104               | 306                   |
+-----------------------------+---------------------+-----------------------+
| Total CPU Cores             | 8,832               | 11,088                |
+-----------------------------+---------------------+-----------------------+
| Total Memory                | 29.2 TB (29,856 GB) | 116.5 TB (119,336 GB) |
+-----------------------------+---------------------+-----------------------+
| Total Accelerator Cores     | 0                   | 132,608               |
+-----------------------------+---------------------+-----------------------+
| Node Interconnect Bandwidth | 20 Gb/s             | 100 Gb/s              |
+-----------------------------+---------------------+-----------------------+
| Scratch Space.              | 1.4 PB (1,229 TB)   | 2.8 PB (2,867 TB)     |
+-----------------------------+---------------------+-----------------------+
| Archive Capabilities        | No                  | Yes                   |
+-----------------------------+---------------------+-----------------------+
| Operating System            | Scientific Linux 6  | CentOS 7              |
+-----------------------------+---------------------+-----------------------+

Standard-, Medium-, and High- Memory Compute Nodes
--------------------------------------------------

Each of the 176 standard compute nodes has 36 cores, 256 GB of memory,
and 100 Gb/s networking. Specifically, these nodes contain dual Intel
Xeon E5-2695v4 2.1 GHz 18-core “Broadwell” processors with 45 MB of
cache each and 256 GB of DDR4-2400 memory. The “Broadwell”
microarchitecture of these processors is four generations newer than the
“Nehalem”-based Xeon processors in ManeFrame. This translates to more
efficient execution per processor cycle and significantly improved
vectorization via the second-generation Advanced Vector Extensions
(AVX2). In addition, there are 35 medium- and five high-memory compute
nodes which have the same processors, but feature 768 GB and 1,536 GB
(1.5 TB) of DDR4-2400 memory respectively and ManeFrame’s new four 768
GB and six 1,536 GB (1.5 TB) nodes also will be added to the new
cluster. The new and more efficient architecture, high core count, and
high memory capacities of these nodes will provide significant
improvements to existing computationally or memory intensive workflows.

Accelerator Nodes with NVIDIA GPUs
----------------------------------

The 36 accelerator nodes with NVIDIA GPUs are configured with dual Intel
Xeon E5-2695v4 2.1 GHz 18-core “Broadwell” processors, 256 GB of
DDR4-2400 memory, and one NVIDIA P100 GPU accelerator. Each NVIDIA P100
GPU has 3584 CUDA cores and 16 GB CoWoS HBM2 memory. The P100 GPU is the
based on the new Pascal architecture and an extremely high bandwidth
(732 GB/s) stacked memory architecture. These GPUs, combined with an
ever-broadening set of drop-in replacement libraries and ever easier to
implement CUDA-based programming environments, make GPU-based
acceleration significantly more approachable for many computationally
intensive applications.

Many-Core Nodes with Intel Xeon Phi Processors
----------------------------------------------

The 36 many-core nodes are configured with Intel Xeon Phi 7230 (also
known as Knights Landing or KNL) processors and 385 GB of DDR4-2400
memory. Each Xeon Phi has 64 1.30 GHz cores and 16 GB of high bandwidth
(400 GB/s) stacked memory. KNL processors are based on the Intel’s
“Silvermont” Atom processor cores and have hardware-based support for up
to four concurrent threads. A principal benefit of the KNL processors is
that they are based on and binary compatible with x86 architectures and
therefore do not require specialized programming languages or
directives/pragmas.

Virtual Desktop Nodes
---------------------

The five virtual desktop nodes will allow researchers remote desktop
access to high-performance compute capability. These nodes can be used
for applications that have demanding remote visualization and/or
rendering requirements. In addition, these virtual desktops can be
configured as either Linux or Windows for a handful of compatible
applications. Each node has dual Intel Xeon E5-2695v4 2.1 GHz 18-core
“Broadwell” processors, 256 GB of DDR4-2400 memory, and one NVIDIA
Quadro M5000 GPU.

High-Performance Network
------------------------

The cluster provides high-speed and low-latency EDR InfiniBand
networking. Every node is equipped with a Mellanox ConnectX-5 InfiniBand
adaptor and all nodes are connected via Mellanox Switch-IB 2 switches.
The InfiniBand network provides 100 Gb/s and less than 600 nanosecond
latency. Additionally, the combination of ConnectX-5 and Switch-IB 2
provides network acceleration for applications by off-loading some MPI
calls, thereby reducing the load on the processors, freeing them to work
on other computations.

High-Performance and Archival Storage
-------------------------------------

The cluster has three new storage systems. The first storage system will
be an NFS based storage providing space for home directories,
applications, libraries, and compilers, etc. This storage system
provides 11.4 TB of sold state drive based usable space and 38.4 TB of
usable 7200 RPM SAS storage space. This storage space will have an
automatic retention of 30 days’ worth of changes. The second storage
system will provide the high-performance Lustre file system for
calculation scratch space. This storage system provides 2.8 PB of usable
space with a write performance of 56.4 GB/s and read performance of 70.8
GB/s, when used in parallel. The third storage system is 110 TB of
usable disk based archive space that includes off-site backup for
disaster recovery.
