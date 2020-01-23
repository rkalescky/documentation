.. _portal:

:tocdepth: 3

HPC OnDemand Web Portal
#######################

Accessing the Portal
====================

Access to the HPC OnDemand web portal requires an existing ManeFrame II
account, which can be requested as documented in :doc:`Accounts <accounts>`.

#. Go to `hpc.smu.edu <https://hpc.smu.edu/>`_.
#. Sign in using your SMU ID and SMU password

Interactive Apps
================

.. _portal_remote_desktop:

Remote Desktop
--------------

#. Select "Remote Desktop" from the "Interactive Apps" drop-down menu.
#. Select options required for your remote desktop instance. These options are the
   same as those requested via a standard Slurm script on M2.
#. Select "Launch"
#. Wait for the job to start on M2. When the job starts a new button "Launch
   noVNC in New Tab" button will appear.
#. Select "Launch noVNC in New Tab"
#. Graphical applications can be run via the Terminal, e.g. ``module load
   comsol && comsol &``.
#. When finished using the remode desktop instance, return to the "My
   Interactive Sessions" tab in your browser and select "Delete" and "Confirm",
   when prompted, to cancel the job on M2.

MATLAB
------

#. Select "MATLAB" from the "Interactive Apps" drop-down menu.   
#. Select options required for your remote desktop instance. These options are the
   same as those requested via a standard Slurm script on M2.
#. Select "Launch"
#. Wait for the job to start on M2. When the job starts a new button "Launch
   noVNC in New Tab" button will appear. 
#. Select "Launch noVNC in New Tab"
#. The MATLAB graphical interface will be presented and running on the M2
   resource requested.
#. When finished using the MATLAB instance, return to the "My
   Interactive Sessions" tab in your browser and select "Delete" and "Confirm", 
   when prompted, to cancel the job on M2.

SAS
---

#. Select "SAS" from the "Interactive Apps" drop-down menu.
#. Select options required for your remote desktop instance. These options are the
   same as those requested via a standard Slurm script on M2.
#. Select "Launch"
#. Wait for the job to start on M2. When the job starts a new button "Launch
   noVNC in New Tab" button will appear.
#. Select "Launch noVNC in New Tab"
#. The SAS graphical interface will be presented and running on the M2 
   resource requested.
#. When finished using the SAS instance, return to the "My
   Interactive Sessions" tab in your browser and select "Delete" and "Confirm",
   when prompted, to cancel the job on M2.

Jupyter Notebook
----------------

#. Select "Jupyter Notebook" from the "Interactive Apps" drop-down menu.
#. Select options required for your remote desktop instance. These options are the
   same as those requested via a standard Slurm script on M2.
#. Select "Launch"
#. Wait for the job to start on M2. When the job starts a new button "Connect
   to Jupyter Notebook" button will appear.
#. Select "Connect to Jupyter Notebook"
#. The Jupyter Notebook graphical interface will be presented and running on the M2   
   resource requested.
#. When finished using the Jupyter Notebook instance, return to the "My
   Interactive Sessions" tab in your browser and select "Delete" and "Confirm",
   when prompted, to cancel the job on M2.

JupyterLab
----------

#. Select "JupyterLab" from the "Interactive Apps" drop-down menu.
#. Select options required for your remote desktop instance. These options are the
   same as those requested via a standard Slurm script on M2.
#. Select "Launch"
#. Wait for the job to start on M2. When the job starts a new button "Connect 
   to JupyterLab" button will appear.
#. Select "Connect to JupyterLab"
#. The Jupyter Notebook graphical interface will be presented and running on the M2
   resource requested.
#. When finished using the JupyterLab instance, return to the "My
   Interactive Sessions" tab in your browser and select "Delete" and "Confirm",
   when prompted, to cancel the job on M2.

RStudio Server
--------------

#. Select "RStudio Server" from the "Interactive Apps" drop-down menu.
#. Select options required for your remote desktop instance. These options are the
   same as those requested via a standard Slurm script on M2.
#. Select "Launch"
#. Wait for the job to start on M2. When the job starts a new button "Connect
   to RStudio Server" button will appear.
#. Select "Connect to RStudio Server"
#. The RStudio graphical interface will be presented and running on the M2
   resource requested.
#. When finished using the RStudio Server instance, return to the "My
   Interactive Sessions" tab in your browser and select "Delete" and "Confirm",
   when prompted, to cancel the job on M2.

Shell Access
============

#. Select "ManeFrame II Shell Access" from the "Clusters" drop-down menu. Note
   that this shell access does not provide access to grpahical applications. If
   needed, please use a :ref:`"Remote Desktop" <portal_remote_desktop>` instance.
#. When finished using the shell, type ``exit`` and close the browser tab.

Monitoring Jobs
===============

#. "Active Jobs" from the "Jobs" drop-down menu.

File Access
===========

#. "Home Directory" from the "Files" drop-down menu.

* You can navigate to specific directories by clicking the directories shown.
* You can go to specific directories using the "Go To..." button.
* You can upload files simply by dragging them to the window or by selecting the "Upload" button.
* You can download files and directories by selecting them and then selecting the "Download" button.

