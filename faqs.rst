.. _faqs:

:tocdepth: 3

Frequently Asked Questions
##########################

Why is the job only allocated ~7 GB?
====================================

The default memory allocation for a job is ~7 GB. Depending on the node type being requested more memory can be allocated for the job.

.. include:: common/slurm_flag_table.rst

How do I change the format of the output of the squeue command?
===============================================================

You can change the output of squeue using the “-o” flag, which can be used to set different fields and their widths (see “man squeue” for all the fields). To use the same configuration repeatedly you can setup an alias such as following in your ``~/.bashrc`` file.

.. code-block:: bash

   alias cq="squeue -u ${USER} -o \"%.20i %.15P %.8T %.12M %.6D %.15j %R\""


