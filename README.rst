My personal dotfiles and configuration scripts
==============================================

This repository contains my personal dotfiles and linux configuration scripts.

My decade-old Apple laptop finally died. I suspect it was the motherboard. Regardless, that means I now need to rely more on my Linux machine. This seems like a good time to learn more about Linux, the command line, and all the wonderful Unix tools that exist in the world. It also seems like a good time to automate the build-process for my preferred Linux setup, so I can more easily migrate my development environment among linux machines and more easily wipe and reinstall my desktop OS on a frequent basis.

.. note::

   My old Apple dotfiles have been moved to the ``deprecated/`` subdirectory. Those files are largely out-of-date and haven't been maintained since 2017. It is likely that I will simply remove those files in a future version of this repository. If I ever become a Mac-user again, I'll likely modify this repository to make it compatible with both types of operating systems.

.. contents:: Contents
  :local:
  :backlinks: top


About this repository
---------------------

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
-------------

The scripts and settings specified in this repository are written specifically for use on Ubuntu 18.04. Feel free to fork, copy, or use them yourself. Just be warned, your mileage may vary depending on your specific linux distribution.

Ubuntu Installation
-------------------

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

There are any number of issues that might need fixing, dependent on your specific hardware. Below are some I've encountered.

Fix grub suspend loop issue
^^^^^^^^^^^^^^^^^^^^^^^^^^^

This may be the issue if, after waking your laptop from suspend mode, it continuously returns you to the lock screen after several seconds of use. Try this for a possible solution::

   sudo vi /etc/default/grub

Edit the following line as such::

   GRUB_CMDLINE_LINUX_DEFAULT="quiet splash button.lid_init_state=open"

Save and close the file, then run::

   sudo update-grub
   shutdown -r now

Stick around while it reboots to make certain no additional MOK management is needed.

Configure new installation using this repository
------------------------------------------------

In order to use the configuration scripts in this repository, either download the entire repository to the newly install Ubuntu machine or clone it like so with HTTPS::

   sudo apt install git
   git clone https://github.com/sedelmeyer/dotfiles.git

After cloning the repository ``cd`` into it (i.e. ``cd dotfiles/``) and use the ``make`` commands to run the appropriate bash installation scripts. If for some reason your Linux installation did not include ``make``, you can run ``sudo apt install make`` prior to running the install scripts.

Please note, a future version of this repository will include a better ``make`` workflow for configuring a newly installed system. But, until then, a new system can best be configured by running each make command in the following order.

``make apt``
   This command runs the ``install_apt.sh`` script in order to install packages available in Ubuntu's package directory. Prior to running this command, please review the packages specified in the ``install_apt.sh`` script and modify that list to include only the packages you wish to have installed.

``make conda``
   This command runs the ``install_conda.sh`` script in order to install the latest version of Anaconda, Inc's (prev. Continuum Analytics) Miniconda distribution, providing both the latest vesion of Python and the ``conda`` package manager.

``make docker``
   This command runs the ``install_docker.sh`` script to install the latest version of Docker CE on your system.

``make pip``
   This command runs the ``install_pip.sh`` script and ``--user`` installs desired Python packages such as ``pipenv``, ``cookiecutter``, and ``docker-compose``.

``make settings``
   This command runs the ``install_settings.sh`` script and sets Ubuntu ``gsettings`` for various attributes of the operating system.

``make vscode``
   This command runs the ``install_vscode.sh`` script and installs the VSCode IDE and desired extensions.

Configure user dotfiles
-----------------------

Please inspect the dotfiles contained in this repository's ``dotfiles/`` subdirectory. These include very Vim-centric settings for various applications. If you are not a Vim user, you will likely dislike much of the configuration outlined in these dotfiles.

``make dots``
   This command runs the ``install_dots.sh`` script and generates matching symlinks in your HOME (i.e. ``~/``) directory for each specified dotfile. If your HOME directory already contains one of these dotfiles, your existing dotfile will be dated and renamed rather than overwriting it. In its place, a new symlink will be generated.


Configure TensorFlow NVIDIA GPU support for CUDA-enabled cards
--------------------------------------------------------------

If your machine has a CUDA-enabled NVIDIA graphics card and you are a TensorFlow user, you may want to enable that card for your deep learning algorithms. Note however, that this is a 2-part script and a restart of your system is required between the first and second script.

``make cuda1``
   This command runs the ``install_cuda1.sh`` script and adds the required NVIDIA package repositories and installs a compatible NVIDIA driver.

After running ``make cuda1`` and restarting your system, you should now run ``nvidia-smi`` to check that your GPU(s) are visible to your system and that you are running the appropriate version NVIDIA driver (currently version 450). If all looks good, run the second Cuda script ``make`` command.

``make_cuda2``
    This command runs the ``install_cuda1.sh`` script and installs the development and runtime libraries (~4GB) and TensorRT.


