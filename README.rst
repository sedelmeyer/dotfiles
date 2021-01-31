My personal dotfiles and configuration scripts
==============================================

This repository contains my personal dotfiles and Linux configuration scripts.

These were created so I can more easily migrate my development environment among Linux machines and easily wipe and reinstall my desktop operating system on a more frequent basis.

.. image:: https://github.com/sedelmeyer/dotfiles/workflows/build/badge.svg?branch=master
   :target: https://github.com/sedelmeyer/dotfiles/actions

.. contents:: Contents
   :local:
   :backlinks: top

About this repository
---------------------

These are my personal dotfiles and linux configuration scripts. 

This repository is structured as such::

   dotfiles/
   ├── deprecated/ <-  No longer used v0.1.0 MacOS install files
   ├── docs/       <-  Configuration details and notes (future release)  
   ├── dotfiles/   <-  System dotfiles
   ├── Makefile    <-  Make commands providing a simplified CLI
   ├── README.rst  <-  You're reading it, right now!
   └── scripts/    <-  Scripts used to automate setup

0. Prerequisites
----------------

The scripts and settings specified in this repository are written specifically for use on Ubuntu 18.04. Feel free to fork, copy, or use them yourself. Just be warned, your mileage may vary depending on your specific Linux distribution and your specified configuration preferences.

**If you are installing Linux on an Apple manufactured laptop or desktop,** `please read about the Apple-specific issue fixes outlined on this page <docs/install_mbp55.rst>`_ **prior to installing Ubuntu (or any Linux distribution) on your machine.** In particular, you will want to take the required steps to permanently silence the Mac boot chime prior to erasing MacOS from your machine. 

1. Ubuntu Installation
----------------------

When installing Ubuntu 18.04, here are the general steps along with some reasonable options to select during the installation process:

#. Insert bootable USB with Ubuntu 18.04
#. Restart and press ``F12`` when on startup screen
#. Select language and keyboard layout
#. Connect to WiFi
#. Select "Minimal" installation to prevent default packages from being installed (in favor of selecting our own defaults during later configuration)
#. Choose to download updates while installing
#. Select the option to install 3rd party software
#. Configure Secure Boot
#. Select "erase disk and install Ubuntu"
#. Encrypt the new Ubuntu installation (the installer will requires you to also use LVM)
#. Install and restart (monitor your machine while it restarts so that you can enroll MOK when the option appears)
#. After restart and sign-in, the Software Updater will likely appear asking if you'd like to install new updates. Do it!

1.1. Solving hardware-specific issues
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

There are any number of issues that might need fixing, dependent on your specific hardware. Below are some I've encountered.

1.1.1 Fix grub suspend loop issue
"""""""""""""""""""""""""""""""""

This may be the issue if, after waking your laptop from suspend mode, it continuously returns you to the lock screen after several seconds of use. Try this for a possible solution::

   sudo vi /etc/default/grub

Edit the following line as such::

   GRUB_CMDLINE_LINUX_DEFAULT="quiet splash button.lid_init_state=open"

Save and close the file, then run::

   sudo update-grub
   shutdown -r now

Stick around while it reboots to make certain no additional MOK management is needed.

2. Configure new installation using this repository
---------------------------------------------------

In order to use the configuration scripts in this repository, either download the entire repository to the newly install Ubuntu machine or ``git clone`` it like so with HTTPS::

   sudo apt install git
   git clone https://github.com/sedelmeyer/dotfiles.git

After cloning the repository ``cd`` into it (i.e. ``cd dotfiles/``) and use the ``make`` commands to run the appropriate bash installation scripts. If for some reason your Linux installation does not include the ``make`` application, you can run ``sudo apt install make`` prior to running the install scripts.

**Please note**: A future version of this repository will include a better ``make`` workflow for configuring a newly installed system. But, until then, a new system can best be configured by running each ``make`` command outlined below in the following order:

2.1. Install all required packages
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The following ``make`` commands install all desired packages. The scripts associated with each ``make`` command are separated based on the installation sources for each set of packages.

``make apt``
   This command runs the ``install_apt.sh`` script in order to install packages available in Ubuntu's package directory. Prior to running this command, please review the packages specified in the ``install_apt.sh`` script and modify that list to include only the packages you wish to have installed.

``make conda``
   This command runs the ``install_conda.sh`` script in order to install the latest version of Anaconda, Inc's (prev. Continuum Analytics) Miniconda distribution, providing both the latest vesion of Python and the ``conda`` package manager.

``make docker``
   This command runs the ``install_docker.sh`` script to install the latest version of Docker CE on your system.

``make pip``
   This command runs the ``install_pip.sh`` script and ``--user`` installs desired Python packages such as ``pipenv``, ``cookiecutter``, and ``docker-compose``.

``make vscode``
   This command runs the ``install_vscode.sh`` script and installs the Visual Studio Code IDE and all desired extensions.

``make abcde``
   This command runs the ``install_abcde.sh`` script and installs the ABCDE (A Better CD Encoder) package for ripping music CDs. While this package is available in the Ubuntu package repository, the version available for Bionic (i.e. Ubuntu 18.04) is outdated and incompatible with the current MusicBrainz web API. Therefore, this script manually installs the latest version of ``abcde`` along with its dependencies. For more info on this package, please see: https://abcde.einval.com/wiki/

``make dropbox``
   This command runs the ``install_dropbox.sh`` script and installs the official Dropbox daemon and command line application. For more information on Dropbox setup on Linux, please see https://www.dropbox.com/install?os=lnx and https://ostechnix.com/install-dropbox-in-ubuntu-18-04-lts-server/. You will want to have access to a web browser to complete Dropbox set-up on your machine. 

``make zoom``
   This command runs the ``install_zoom.sh`` script to download and install the latest version Zoom .deb package from the official Zoom website. Additional information on this install process can be found here: https://support.zoom.us/hc/en-us/articles/204206269-Installing-Zoom-on-Linux

``make source``
   This command runs the ``install_source.sh`` script and installs, by default, the packages ``light`` from https://github.com/haikarainen/light and ``st`` from https://github.com/sedelmeyer/st. Source code for these packages are downloaded to ``~/Code/source/`` and the packages are then installed directly from that source.

``make macpro``
   This command runs the ``install_macpro.sh`` script and executes system fixes required for a MacBook Pro 13" Mid 2009 (i.e. MacBookPro5,5) to function as desired while running Ubuntu 18.04. This includes setting the ``hid_apple.conf`` with ``fnmode=2`` so that F* keys require the use of the Fn key to use special keys (i.e. brightness, volume, etc.). It also includes an EFI fix to resolve the ``Failed to Set MokListRT`` warning at when the system boots. A reboot is required after running ``make macpro``.

2.2. Configure system settings
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Most system settings in Ubuntu 18.04 can be configured via the Gnome settings (i.e. ``gsettings``) command. The following ``make`` command sets all of those settings based on what is specified in the corresponding script.

``make settings``
   This command runs the ``install_settings.sh`` script and sets Ubuntu ``gsettings`` for various attributes of the operating system.

2.3. Configure user dotfiles
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Please inspect the dotfiles contained in this repository's ``dotfiles/`` subdirectory. These include very Vim-centric settings for various applications. If you are not a Vim user, you will likely dislike much of the configuration outlined in these dotfiles.

``make dots``
   This command runs the ``install_dots.sh`` script and generates matching symlinks in your HOME (i.e. ``~/``) directory for each specified dotfile. If your HOME directory already contains one of these dotfiles, your existing dotfile will be dated and renamed rather than overwriting it. In its place, a new symlink will be generated.

2.3.1. Install Vim plugins
""""""""""""""""""""""""""

After running ``make dots``, you will want to make certain that all Vim plugins specified in ``.vimrc`` get installed. To accomplish this, open ``vim`` and run the follow command from within Vim::

   :PlugInstall

2.4. Configure TensorFlow NVIDIA GPU support
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If your machine has a CUDA-enabled NVIDIA graphics card and you are a TensorFlow user, you may want to enable that card to speed up processing for your deep learning algorithms. Note however, that this is a 2-part script and a restart of your system is required between the first and second script.

``make cuda1``
   This command runs the ``install_cuda1.sh`` script and adds the required NVIDIA package repositories and installs a compatible NVIDIA driver.

After running ``make cuda1`` and restarting your system, you should now run ``nvidia-smi`` to check that your GPU(s) are visible to your system and that you are running the appropriate version NVIDIA driver (currently version 450). If all looks good, run the second Cuda script ``make`` command.

``make cuda2``
    This command runs the ``install_cuda2.sh`` script and installs the development and runtime libraries (~4GB) and TensorRT.

2.4.1 Switch between NVIDIA and Intel graphics
""""""""""""""""""""""""""""""""""""""""""""""

Once the ``cuda1`` and ``cuda2`` scripts have been run, feel free to turn off the NVIDIA graphic card when it is not in use for more efficient battery use. This can be accomplished by using the ``prime-select`` command as follows...

To see whether NVIDIA or Intel graphics are in use::
   
   prime-select query

To turn off NVIDIA in favor of Intel (more efficient power use)::
   
   prime-select intel

To turn NVIDIA back on::

   prime-select nvidia

**Note:** You will need to restart your system in order for any graphics card changes to take effect.

Useful resources
----------------

* The Ubuntu package repository search: https://packages.ubuntu.com/
* The TensorFlow GPU support documentation: https://www.tensorflow.org/install/gpu
* The ``vim-plug`` plugin manager documentation: https://github.com/junegunn/vim-plug/wiki
* Docker installation instructions for Linux: https://docs.docker.com/engine/install/ubuntu/
