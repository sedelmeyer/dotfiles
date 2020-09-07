My personal dotfiles and configuration scripts
==============================================

This repository contains my personal dotfiles and linux configuration scripts.

My decade-old Apple laptop finally died. I suspect it was the motherboard. Regardless, that means I now need to rely more on my Linux machine. This seems like a good time to learn more about Linux, the command line, and all the wonderful Unix tools that exist in the world. It also seems like a good time to automate the build-process for my preferred Linux setup, so I can more easily migrate my development environment among linux machines and more easily wipe and reinstall my desktop OS on a frequent basis.

.. note::

   My old Apple dotfiles have been moved to the ``deprecated/`` subdirectory. Those files are largely out-of-date and haven't been maintained since 2017. It is likely that I will simply remove those files in a future version of this repository. If I ever become a Mac-user again, I'll likely modify this repository to make it compatible with both types of operating systems.

.. contents:: Contents
  :local:
  :depth: 1
  :backlinks: top

Getting started
---------------

About this repository
^^^^^^^^^^^^^^^^^^^^^

These are my personal dotfiles and linux configuration scripts. 

This repository is structured as such:

.. code-block:: bash

   dotfiles/
   ├── deprecated/ >>  No longer used v0.1.0 MacOS install files
   ├── docs/       >>  Documentation detailing configuration  
   ├── dotfiles/   >>  System dotfiles
   ├── Makefile    >>  Make commands providing a simplified CLI
   ├── README.rst  >>  You're reading it, right now!
   └── scripts/    >>  Scripts used to automate setup

Prerequisites
^^^^^^^^^^^^^

The scripts and settings specified in this repository are written specifically for use on Ubuntu 18.04. Feel free to fork, copy, or use them yourself. Just be warned, your mileage may vary depending on your specific linux distribution.

Ubuntu Installation
^^^^^^^^^^^^^^^^^^^

When installing Ubuntu 18.04, here are some reasonable options to select during the installation process:

#. Insert bootable USB with Ubuntu 18.04
#. Restart and press ``F12`` when on startup screen
#. Select language and keyboard layout
#. Connect to WiFi
#. Select "Minimal" installation to prevent default packages from being installed (in favor of selecting our own defaults during configuration)
#. Download updates while installing
#. Select option to install 3rd party software
#. Configure Secure Boot
#. Select "erase disk and install Ubuntu"
#. Encrypt the new Ubuntu installation (must also use LVM by default)
#. Install and restart (monitor restart so that you can enroll MOK)
#. After restart and sign-in, Software Updater will likely appear -- Install new updates

Solving hardware specific issues
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

There are any number of issues that might need fixing, dependent on your specific hardware.

Fix grub suspend loop issue
"""""""""""""""""""""""""""

This may be the issue if, after waking your laptop from suspend mode, it continuously returns you to the lock screen after several seconds of use::

   sudo vi /etc/default/grub

Edit the following line as such::

   GRUB_CMDLINE_LINUX_DEFAULT="quiet splash button.lid_init_state=open"

Save and close the file, then run::

   sudo update-grub
   shutdown -r now

Stick around while it reboots to make certain no additional MOK management is needed.
