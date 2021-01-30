Installation notes for MacBookPro5,5
====================================

This document contains special instructions or issues related to installing Ubuntu 18.04 on a MacBook Pro 13" Mid 2009 (MacBookPro5,5).

.. contents:: Contents
   :local:
   :backlinks: top

Silencing the Mac default boot chime
------------------------------------

TODO: Add info about silencing boot chime prior to wiping the MacOS installation

- https://askubuntu.com/questions/711155/silence-system-sound-on-startup-mac
- https://help.ubuntu.com/community/MacBookAir3-2/Narwhal#Disable_the_Mac_Startup_Sound
- https://wiki.archlinux.org/index.php/Mac#Mute_startup_chime
- https://askubuntu.com/questions/711155/silence-system-sound-on-startup-mac
- https://askubuntu.com/questions/564831/mac-nvram-from-ubuntu
- http://atodorov.org/blog/2015/04/27/disabling-macbook-startup-sound-in-linux/
- https://www.howtogeek.com/260693/how-to-disable-the-boot-sound-or-startup-chime-on-a-mac/
- https://www.chriswrites.com/how-to-permanently-turn-off-your-macs-startup-sound/

Broadcom proprietary wifi drivers
---------------------------------

In order for the wifi card to work under Linux, the proprietary Broadcom drivers must be installed. For that reason, an Ethernet connection will be required during installation. During installation it is highly-recommended that you both connect an Ethernet cable to the laptop and select the option to install 3rd party software during the Ubuntu install process.

If you plan on installing the Broadcom drivers separately after installing the OS, running the ``ubuntu-drivers devices`` command under 18.04 on this machine returns the following output::

  == /sys/devices/pci0000:00/0000:00:15.0/0000:03:00.0 ==
  modalias : pci:v000014E4d0000432Bsv0000106Bsd0000008Dbc02sc80i00
  vendor   : Broadcom Limited
  model    : BCM4322 802.11a/b/g/n Wireless LAN Controller (AirPort Extreme)
  driver   : bcmwl-kernel-source - distro non-free

To install the appropriate driver in Ubuntu 18.04, the ``bcmwl-kernel-source`` driver will most likely be sufficient. For Ubuntu 20.04, errors may arise, requiring a different driver be install. For more information on these potential issues, see the following links:

TODO: Finish broadcom driver notes

- https://askubuntu.com/questions/1076964/macbook-can-t-find-wifi-for-ubuntu-18-04
- https://askubuntu.com/questions/1005058/dpkg-error-while-installation-bcmwl-kernel-source-on-ubuntu-16-04
- https://bugs.launchpad.net/ubuntu/+source/bcmwl/+bug/1878045
- https://askubuntu.com/questions/55868/installing-broadcom-wireless-drivers

NVIDIA proprietary graphics card drivers
----------------------------------------

The MacBookPro5,5 uses a NVIDIA GPU, thus you will need to use either the proprietary NVIDIA driver, or the open-source Nouveau driver to utilize the graphics card. Running the ``ubuntu-drivers devices`` command under 18.04 on this machine returns the following output::

  == /sys/devices/pci0000:00/0000:00:10.0/0000:02:00.0 ==
  modalias : pci:v000010DEd00000863sv0000106Bsd000000B9bc03sc00i00
  vendor   : NVIDIA Corporation
  model    : C79 [GeForce 9400M]
  driver   : nvidia-340 - distro non-free recommended
  driver   : xserver-xorg-video-nouveau - distro free builtin

TODO: Finish Nouveau vs. NVIDIA instructions

- https://askubuntu.com/questions/335285/how-to-change-proprietary-video-driver-using-the-command-line
- https://askubuntu.com/questions/1032357/how-to-switch-from-nvidia-to-nouveau-drivers-on-ubuntu-18-04


Changing default ``Fn`` key behavior
------------------------------------

TODO: Add text

Fixing ``Failed to Set MokListRT`` boot warning
-----------------------------------------------

TODO: Add text

Wake from sleep with lid open issues
------------------------------------

TODO: Add text
