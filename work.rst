.. _work:

:tocdepth: 3

Work Storage Migration and New Scratch Workflow
===============================================

We have now enabled general access to a new storage location at ``$WORK``,
which is ``/work/users/$USER`` where ``$USER`` is your ManeFrame II (M2)
username. This storage space is designed to be used for long term data storage
on M2 in lieu of ``$SCRATCH`` (``/scratch/users/$USER``), which is now commonly
being used as a long term storage location. Your $WORK space has an 8 TB quota
with no time limits.

In the near term we encourage you to move general data storage from
``$SCRATCH`` to ``$WORK`` and then use ``$SCRATCH`` just for scratch space
during calculations. Below are some helpful commands for determining what to
move to ``$WORK``.

.. raw:: html

   <div class="alert alert-info" style="text-align: justify;">

.. Note::

   * ``$SCRATCH`` is a temporary storage space for the duration of a job or a
     set of jobs.
   * ``$WORK`` is storage for the duration of a project or critical research
     output that would be difficult to reproduce. Files needed after a job
     completes should be moved from $SCRATCH to $WORK.
   * Neither ``$SCRATCH`` nor ``$WORK`` are backed up. Both have built in
     redundancies, but are otherwise not protected.

.. raw:: html

   </div>

As noted above, your ``$SCRATCH`` space should be used as scratch space for
running jobs. Files that are not needed after the job has completed should be
removed and those files that are needed should be moved to your ``$HOME`` or
``$WORK`` spaces. Examples of this workflow are given below.

Migrating Data from ``$SCRATCH`` to ``$WORK``
---------------------------------------------
.. raw:: html

   <iframe src="https://smu.hosted.panopto.com/Panopto/Pages/Embed.aspx?id=74fd2e9f-931e-44cb-a6ea-ac68011b9c59&autoplay=false&offerviewer=false&showtitle=false&showbrand=false&start=0&interactivity=all"
   width=600 height=338 style="border: 1px solid #464646;" allowfullscreen allow="autoplay">
   </iframe>

The commands given must be run through shell access to M2, which can be the
:ref:`HPC OnDemand Web Portal <portal>` or :ref:`any SSH-capable client
<access>`.

In each of the commands where a job is submited to the queue, the job may take
a while to complete. You can view the status of the job via ``squeue -u $USER |
grep wrap``.

Before the following commands can be run, the migration assistant module must
be loaded into your environment.

.. code:: bash

       module load migration

The migration assistant's help can be found by running
``work_migration_assistant``.

Determine the Size of Files in Your ``$SCRATCH`` Space
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: bash

       sbatch -p htc -c 1 --mem=6G -o "$HOME/scratch_usage_%j.out" --wrap 'work_migration_assistant report_scratch_size'

This will submit a job that will show the sizes of the directories ``$SCRATCH``
and the total. The output for the job will be in ``"$HOME/scratch_usage_%j.out"``
where ``%j`` is a job ID number.

Determine the Number of Files in Your ``$SCRATCH`` Space
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: bash

       sbatch -p htc -c 1 --mem=6G -o "$HOME/scratch_file_count_%j.out" --wrap 'work_migration_assistant report_scratch_number_files'

This will submit a job that will show the number of files for each directory in
``$SCRATCH``. The output for the job will be in
``$HOME/scratch_file_count_%j.out`` where ``%j`` is a job ID number.

Move All Data from ``$SCRATCH`` to ``$WORK`` if the Total Size is Less than 8 TB
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. raw:: html

   <div class="alert alert-info" style="text-align: justify;">

.. warning::
   These commands will copy all data from ``$SCRATCH`` and then delete the data
   in ``$SCRATCH``. Also, this is best done while you have no other jobs running
   on M2.

.. raw:: html

   </div>

.. code:: bash

       sbatch -p htc -c 1 --mem=6G -o "$HOME/scratch_work_migration_%j.out" --wrap 'work_migration_assistant migrate'

This will submit a job that will copy data from ``$SCRATCH`` to ``$WORK``. The
output of the transfer will be in file ``$HOME/scratch_work_migration_%j.out``,
where ``%j`` is a job ID number.

Verify that all the data has been tranferred from ``$SCRATCH`` to ``$WORK``.

.. code:: bash

       sbatch -p htc -c 1 --mem=6G -o "$HOME/scratch_work_migration_%j.out" --wrap 'work_migration_assistant verify'

After you have verified that the transfer has been completed you may delete the
data from ``$SCRATCH``. In order to use the migration assistant to remove the
data, the following conditions must be met:

#. The path must exist.
#. An absolute (full, not relative) path path must be given.
#. The path must be the real path, e.g. ``/scratch/users/$USER`` and not ``~/scratch\``.
#. The path must be ``/scratch/users/$USER`` or a directory within ``/scratch/users/$USER``.

The migration assistant will verify with you if you really want to remove the 
specified directory.

.. code:: bash

       work_migration_assistant remove $SCRATCH

Move Select Directory from ``$SCRATCH`` to ``$WORK`` if the Total Size is Less than 8 TB
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. raw:: html

   <div class="alert alert-info" style="text-align: justify;">

.. warning::
   These commands will copy a specific directory from ``$SCRATCH`` and then
   delete that directory from ``$SCRATCH``. Also, this is best done while you
   have no other jobs reading or writing data to this directory.

.. raw:: html

   </div>

.. code:: bash

       sbatch -p htc -c 1 --mem=6G "$HOME/scratch_work_migration_%j.out" --wrap 'work_migration_assistant migrate <directory_to_move>'

Here, ``<directory_to_move>`` is the directory that you would like to move. The
command will submit a job that will copy data from ``$SCRATCH`` to ``$WORK``.
The output of the transfer will be in file ``$HOME/scratch_work_migration_%j.out``,
where ``%j`` is a job ID number.

Verify that all the data has been tranferred from ``$SCRATCH`` to ``$WORK``.

.. code:: bash

       sbatch -p htc -c 1 --mem=6G -o "$HOME/scratch_work_migration_%j.out" --wrap 'work_migration_assistant verify <directory_to_move>'

If verification reports that the transfer has not completed, run the migration
command above again and then re-verify.

After you have verified that the transfer has been completed you may delete the
data from ``$SCRATCH``. In order to use the migration assistant to remove the 
data, the following conditions must be met:

#. The path must exist.
#. An absolute (full, not relative) path path must be given.
#. The path must be the real path, e.g. ``/scratch/users/$USER`` and not ``~/scratch\``.
#. The path must be ``/scratch/users/$USER`` or a directory within ``/scratch/users/$USER``.

The migration assistant will verify with you if you really want to remove the
specified directory.

.. code:: bash

       work_migration_assistant remove $SCRATCH/<directory_to_move>

..

Using ``$SCRATCH`` as Scratch, a Workflow for ``$WORK``
-------------------------------------------------------

The general workflow should be:

#. Prepare job files and associated scripts in ``$HOME`` or ``$WORK``.
#. During the job, `i.e.` in the job script itself, copy needed files from
   ``$HOME`` or ``$WORK`` to a temporary directory in ``$SCRATCH``.
#. Once the calculations in the job have finished, copy the needed files back
   from ``$SCRATCH``.
#. Lastly, clean up your temporary directory in ``$SCRATCH`` by deleting it.

Example Workflow When Using ``sbatch``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In the following example job script, the work flow of copying data to
``$SCRATCH``, running the job, and then copying needed data back from
``SCRATCH`` is demonstrated. The files for this example can be found on M2 in
``/hpc/examples/workflow``.

In this example:

#. One file, ``water.dat``, is defined to be copied to the temporary scratch
   directory.
#. Two files, ``water.out`` and ``water.fchk``, are defined to be copied back
   from the temporary scratch directory after the calculation has completed.
#. A temporary scratch directory is made.
#. This example is using Psi4, which has a special variable to point the
   calculation a scratch space. Thus, we set that variable to point to the
   temporary scratch directory as well.
#. The all of files initially defined to be copied to the temporary scratch
   directory are then copied there.
#. The script then goes to the temporary scratch directory.
#. The calculation is run.
#. Once the calculation has finished, all the files defined to be copied back
   to the directory from which the job was submitted are then copied to a job
   specific directory there.
#. The temporary scratch directory is the deleted thereby cleaning up all other
   files produced by the calculation that are no longer needed.

.. literalinclude:: examples/workflow/water.sbatch

