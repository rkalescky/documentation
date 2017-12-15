.. _access:

Access
######

Terminal Access via SSH
=======================

SSH is the only way to access ManeFrame II. There are many SSH clients
available for different operating systems. The details for Linux, macOS,
and Windows are given below. In all cases, ManeFrame II is accesses via
m2.smu.edu using your SMU credentials. 

Linux
-----

Specific instructions will vary by Linux distribution, but generally the
steps are as follows.

#. Open a \ *terminal*
#. Type "ssh -CX yourusername@m2.smu.edu" where "yourusername" with your
   username, which is the first part of your SMU email address.

macOS
-----

macOS requires the one-time
installation \ `XQuartz <https://www.xquartz.org>`__ to provide X11 for
graphical applications. Once XQuartz is installed, steps are generally
as follows.

#. Open the Terminal app at "/Applications/Utilities/Terminal.app"
#. Type "ssh -CX yourusername@m2.smu.edu" where "yourusername" is your
   username, which is the first part of your SMU email address.

Windows
-------

Windows requires the one-time installation of an SSH client and X11.

#. `Putty <http://www.putty.org/>`__ is the most popular (and free) SSH
   client available. Download and install the newest version.
#. In order to view graphics from ManeFrame, you will also need to
   install an X-server. The most popular, again free, X11 implementation
   on Windows is Xming. To install Xming, download and install the
   newest versions of both the \ `Xming X
   server <http://sourceforge.net/projects/xming>`__ and the \ `Xming
   Fonts <http://sourceforge.net/projects/xming/files/Xming-fonts>`__.

Once these two programs are installed, you can then log into ManeFrame
II:

#. Start the Xming program in Start Menu. The Xming program runs from
   the System Tray.
#. Start the Putty program in the Start Menu
#. In the Putty window:

   #. In the “Category:” box:

      #. Scroll to the bottom and select “+” next to “SSH”
      #. Select “X11”

   #. In the “X11 forwarding” section, select “Enable X11 forwarding”.
   #. In the “Category:” box, scroll to the top and select “Session”.
   #. In the “Host Name” field, type “m2.smu.edu”.
   #. In the “Saved Sessions” field, type “ManeFrame II (M2)”.
   #. Press “Save”.
   #. Press “Open”. Select “Yes” if you presented with a “Putty Security
      Alert” window.
   #. At the command prompt, type your username, which is the first part
      of your SMU email address, followed by enter.
   #. At the command prompt, type your SMU password followed by enter.

Accessing Files via SFTP
========================

ManeFrame II has two separate file systems. The first, the "home" file
system, contains user's home directories ("~/", "/users/$USER", "$HOME")
and is what is seen when first logging into the system. The second, the
"scratch" file system, is ManeFrame's high performance parallel file
system ("/scratch/users/$USER" or "$SCRATCH"). The scratch file system
is significantly larger and faster than the home file system and should
be the file system used when running calculations. Files needed for
running calculations or building software must be copied from your local
computer to ManeFrame II. This is generally done using an SFTP client or
the "scp" command where available.

SFTP Clients
------------

There are several popular SFTP clients available and any file transfer
client that supports SFTP will work with ManeFrame II. Several popular
SFTP clients include \ `WinSCP <https://winscp.net/>`__ (Windows)
and \ `CyberDuck <https://cyberduck.io>`__ (Windows, macOS). These
clients generally display two panes with the left side being your local
files and the right side being your ManeFrame II files. When setting up
access in these clients, SFTP must be chosen and your credentials will
be your ManeFrame II credentials.
