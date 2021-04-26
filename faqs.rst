.. _faqs:

:tocdepth: 3

Frequently Asked Questions
##########################

.. include:: common/acknowledgement.rst

Why is the job only allocated ~7 GB?
====================================

The default memory allocation for a job is ~7 GB. Depending on the node type being requested more memory can be allocated for the job.

.. include:: common/slurm_flag_table.rst

How do I change the format of the output of the squeue command?
===============================================================

You can change the output of squeue using the “-o” flag, which can be used to set different fields and their widths (see “man squeue” for all the fields). To use the same configuration repeatedly you can setup an alias such as following in your ``~/.bashrc`` file.

.. code-block:: bash

   alias cq="squeue -u ${USER} -o \"%.20i %.15P %.8T %.12M %.6D %.15j %R\""

How can load all dependency packages of a package built via Spack?
==================================================================

Many packages on M2 have been built using the Spack package manager. This system allows for the complete dependency chain of packages to be built as needed for the specific package being installed. When using an application that was built via Spack only the package module needs to loaded as it will automatically find its own dependencies as needed. However, when building an application outside of Spack, but using Spack-built packages, it is useful to be able to have all dependency packages loaded into the build environment. This can be accomplished via:

.. code-block:: bash

   module load spack <compiler>
   source <(spack module loads --dependencies <package_name>)

Here `<compiler>` and `<package_name>` are the module names for your chosen compiler and the package needed, respectively.
