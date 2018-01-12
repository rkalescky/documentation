Using Remote Virtual Desktops
=============================

DCV Setup
---------

Download NICE DCV Endstation client application for your operating system from `NICE  <https://www.nice-software.com/download/nice-dcv-2016>`_ and install.

.. note::

   If using the DCV client on a Mac with macOS 10.12 or later operating system, the file "libz.1.dylib" must be deleted from the application bundle for the application to work properly. First open the application and it will crash. Then to remove the file, open Terminal and run the command ``rm /Applications/DCV\ Endstation.app/Contents/Frameworks/libz.1.dylib``.

Connecting to a DCV Desktop Instance
------------------------------------

Once the local DCV client application is installed you can launch a desktop instance on one of M2’s DCV nodes via the `portal website <https://portal.m2.smu.edu:18443/ef/>`_. You can log into the portal using your SMU credentials (SMU/M2 username and password). Once logged in, select "DCV XFCE Linux Desktop" at the bottom of the panel on the left side of the page to start a new desktop instance. You may be prompted to download a DCV connection file. Once the file is downloaded you can open it via the NICE DCV Endstation client application already installed on your machine, which will connect you to your desktop instance. If you are prompted with a signature warning dialog box, select yes. Depending on the application running, selecting "Scale to window size" in the Preferences may be beneficial.

Running Graphical Applications in the DCV Desktop Instance
----------------------------------------------------------

Once you are connected to your DCV node you can running applications directly on the node. For example to start RStudio you would open a terminal (right-click on the desktop and select "Open Terminal Here"). From the terminal you can load the RStudio model and then launch RStudio via ``module load rstudio && rstudio &``. The node that you are using is allocated exclusively to you and gives you access to 36 cores, 256 GB of memory, and a NVIDIA M5000 GPU. As you are connected to a node that is part of M2 you can browse your M2 files via your application or via the terminal as usual. Additionally, the node will remain allocated to you even if you disconnect from it via the DCV client. You can simply reconnect using the connection file and continue your work where you left off. Currently the DCV node allocation time limit is one day. The desktop instance can be terminated from he portal website, however there is no need to remain logged into the portal website while using your allocated DCV instance.
