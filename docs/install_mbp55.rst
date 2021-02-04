Installation notes for MacBookPro5,5
====================================

This document contains special instructions or issues related to installing Ubuntu 18.04 on a MacBook Pro 13" Mid 2009 (MacBookPro5,5).

**Please read this prior to installing Ubuntu**, because you will want to silence the Mac default boot chime prior to erasing your existing installation of MacOS from the laptop.

.. contents:: Contents
   :local:
   :backlinks: top


Silencing the Mac default boot chime (BEFORE installing Linux)
--------------------------------------------------------------

**WARNING: This step must be taken prior to erasing your existing installation of MacOS from your Apple hardware.**

Macs have a distinctive audible "bong" chime that plays at the start of their boot process, just after powering up the machine. This chime lets you know that your machine has passed all of the pre-boot tests, therefore it can be used as a diagnostic tool similar to the audible beep produced by BIOS during startup on a typical PC.

It was my experience that I had no control over this startup chime once MacOS was removed from and Ubuntu was installed on my MacBookPro5,5. Where I could previously mute this chime as long as my volume was muted prior to shutdown on MacOS, this had no affect on under Ubuntu and the chime would play at full volume upon each machine boot.

**The most definitive fix for this issue is to simply mute this chime directly via MacOS's** ``nvram`` **prior to erasing your existing MacOS installation.** While some online sources appeared to have had success accomplishing this even after installing Linux on their machine, I had no such luck. Instead, I needed to do a complete reinstall of MacOS from the laptops original install media (i.e. an OS X Snow Leopard install DVD from 2009!!!) in order to execute the following fix in the computer's native MacOS environment.

To avoid the heartache and time this will require, I strongly suggest you perform this fix well-before ever wiping MacOS from your machine as a preliminary step prior to installing Ubuntu (or any other Linux distrubution for that matter!). **To permanently silence the boot chime on your machine (effective even after MacOS has been removed from the system)**, open the terminal in MacOS and run the following ``nvram`` command::

   sudo nvram SystemAudioVolume=%01

Now, try rebooting your system, even with the system's volume turned all the way up, to ensure that the boot chime has successfully been silenced.

Apparently, not all Mac models use the same setting to silence the boot chime via ``nvram SystemAudoVolume``. If you find that this is true for you, try some of these other settings to see if any work for silencing your boot chime::

  sudo nvram SystemAudioVolume=%80

  sudo nvram SystemAudioVolume=%00

  sudo nvram SystemAudioVolume=” “

Likewise, if you wish to undo this setting and re-enable your Mac machine's boot chime, you can use this command::

  sudo nvram -d SystemAudioVolume

Once you are done with this step, you are ready `to proceed with your installation of Linux <../README.rst>`_ on your Mac computer.

For further reading, here are some additional resources on this issue:

- https://www.chriswrites.com/how-to-permanently-turn-off-your-macs-startup-sound/
- https://askubuntu.com/questions/711155/silence-system-sound-on-startup-mac
- https://wiki.archlinux.org/index.php/Mac#Mute_startup_chime
- http://atodorov.org/blog/2015/04/27/disabling-macbook-startup-sound-in-linux/
- https://www.howtogeek.com/260693/how-to-disable-the-boot-sound-or-startup-chime-on-a-mac/


Selecting your startup disk on an Apple computer
------------------------------------------------

The ``ALT`` key is the typical Mac startup key used to access the "Startup Manager" at boot time. Holding the ``ALT`` key down while starting your machine allows you to choose other available startup disks or volumes (i.e. a Linux bootable USB drive). If your Mac is using a firmware password, you will be prompted to enter the password. More information on Mac startup key combinations can be found here: https://support.apple.com/en-us/HT201255.


Broadcom proprietary wifi driver
--------------------------------

In order for the wifi card to work under Linux, the proprietary Broadcom drivers must be installed. For that reason, an Ethernet connection will be required during installation. During installation it is highly-recommended that you both connect an Ethernet cable to the laptop and select the option to install 3rd party software during the Ubuntu install process.

If you plan on installing the Broadcom drivers separately after installing the OS, running the ``ubuntu-drivers devices`` command under Ubuntu 18.04 on this machine returns the following output::

  == /sys/devices/pci0000:00/0000:00:15.0/0000:03:00.0 ==
  modalias : pci:v000014E4d0000432Bsv0000106Bsd0000008Dbc02sc80i00
  vendor   : Broadcom Limited
  model    : BCM4322 802.11a/b/g/n Wireless LAN Controller (AirPort Extreme)
  driver   : bcmwl-kernel-source - distro non-free

To install the appropriate driver in Ubuntu 18.04, the ``bcmwl-kernel-source`` driver will most likely be sufficient. For Ubuntu 20.04, errors may arise, requiring a different driver be install. For more information on these potential issues, see the following links:

- https://askubuntu.com/questions/1076964/macbook-can-t-find-wifi-for-ubuntu-18-04
- https://askubuntu.com/questions/1005058/dpkg-error-while-installation-bcmwl-kernel-source-on-ubuntu-16-04
- https://bugs.launchpad.net/ubuntu/+source/bcmwl/+bug/1878045
- https://askubuntu.com/questions/55868/installing-broadcom-wireless-drivers

Nouveau vs. NVIDIA proprietary graphics card driver
---------------------------------------------------

The MacBookPro5,5 uses a NVIDIA GPU, thus you will need to use either the proprietary NVIDIA driver, or the open-source Nouveau driver to utilize the graphics card. Running the ``ubuntu-drivers devices`` command under Ubuntu 18.04 on this machine returns the following output::

  == /sys/devices/pci0000:00/0000:00:10.0/0000:02:00.0 ==
  modalias : pci:v000010DEd00000863sv0000106Bsd000000B9bc03sc00i00
  vendor   : NVIDIA Corporation
  model    : C79 [GeForce 9400M]
  driver   : nvidia-340 - distro non-free recommended
  driver   : xserver-xorg-video-nouveau - distro free builtin


NVIDIA is the preferred driver for this machine
"""""""""""""""""""""""""""""""""""""""""""""""

It has been my experience that the Nouveau driver performs well on this machine, with only some minor pixel distortions during the boot process, but appears to be linked to `an unresolvable wake from sleep issue <#wake-from-sleep-with-lid-open-issues>`_. Therefore, it is advisable to install the ``nvidia-340`` driver as is shown in the output above. The NVIDIA driver appears to have the benefit of running your GPU at lower temperatures than the Nouveau driver and it also appears to resolve the wake from sleep issue.

NVIDIA issues and fixes
"""""""""""""""""""""""

Just be aware to a couple of issues that do arise as a result of the NVIDIA driver, both of which are easily resolved.

**Screen brightness adjustment fix**

Out of the box, you will likely not have control over your screen brightness. To resolve this issue, you will want to edit your ``/usr/share/X11/xorg.conf.d/nvidia-drm-outputclass-ubuntu.conf`` to include the ``"NoLogo"`` and ``"RegistryDwords"`` options shown in the file text shown below::

   Section "OutputClass"
       Identifier "nvidia"
       MatchDriver "nvidia-drm"
       Driver "nvidia"
       ModulePath "/usr/lib/nvidia-340/xorg"
       Option "NoLogo" "True"
       Option "RegistryDwords" "EnableBrightnessControl=1"
   EndSection

By setting the ``"NoLogo"`` option to ``"True"``, the garish NVIDIA splash screen, which typically appears while logging in will no longer appear. By setting ``"RegistryDwords"`` to ``"EnableBrightnessControl=1"``, saving your changes, and rebooting your system, you should now be able to control your LCD screen brightness using either your screen brightness keys or a command line utility such as ``xbacklight``.

If your screen brightness controls still do not work, you will likely also need to edit your ``grub`` file located at ``/etc/default/grub``, and change the line::
  
   GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"

to this::

   GRUB_CMDLINE_LINUX_DEFAULT="quiet splash acpi_backlight=vendor"

Next, update grub with the command: ``sudo update-grub``

Now, reboot and your screen brightness controls should work.

For more information on screen brightness control with the NVIDIA driver installed, please see:

- https://help.ubuntu.com/community/MacBookPro5-5/Precise#Video
- https://www.fosslinux.com/41008/install-nvidia-driver-on-ubuntu-command-line-and-gui-ways.htm
- https://askubuntu.com/questions/335285/how-to-change-proprietary-video-driver-using-the-command-line
- https://askubuntu.com/questions/1032357/how-to-switch-from-nvidia-to-nouveau-drivers-on-ubuntu-18-04


Changing the default ``Fn`` key behavior
----------------------------------------

By default, after installing Linux, your Mac machine's F* keys will act as special keys (e.g. brightness controls, volume controls, etc.). If you prefer that the F* keys themselves be primary and that you press the ``Fn`` key to trigger the use of each corresponding special key instead, you will need to update your ``hid_apple.conf`` to reflect the ``fnmode=2`` option.

This fix will be run as part of `the "install_macpro.sh" script <../scripts/install_macpro.sh>`_ executed using the ``make macpro`` command described in this repo's `README.rst <../README.rst/#install-all-required-packages>`_ file. For more information on this keyboard functionality modification and others available for Apple keyboards, please see:

- https://help.ubuntu.com/community/AppleKeyboard#Change_Function_Key_behavior
- https://wiki.archlinux.org/index.php/Apple_Keyboard#hid_apple_module_options


Fixing ``Failed to Set MokListRT`` boot warning
-----------------------------------------------

After installing Linux on your Mac machine, you will likely be presented with a ``Failed to Set MokListRT`` warning while booting your system. This is non-fatal and the system will proceed to finish booting after a short delay. In order to fix this warning, you must ``sudo cp`` your ``/boot/efi/EFI/ubuntu/grubx64.efi`` file to overwrite ``/boot/efi/EFI/ubuntu/shimx64.efi``. Upon reboot, the warning should no longer appear.

This fix will be run as part of `the "install_macpro.sh" script <../scripts/install_macpro.sh>`_ executed using the ``make macpro`` command described in this repo's `README.rst <../README.rst/#install-all-required-packages>`_ file. For more information on this, please see:

- https://askubuntu.com/questions/1279602/ubuntu-20-04-failed-to-set-moklistrt-invalid-parameter/1279764#1279764

.. _wake:

Wake from sleep with lid open issues
------------------------------------

Another issue identified running Ubuntu 18.04 on a MacBookPro5,5, is that the machine can fail to wake from suspend mode. This issue is most frequently experienced if the laptop lid is closed without logging out of my user profile, or if I explicilty invoke ``systemctl suspend`` from the command line. In both those cases, the laptop will not wake up. If the lid is closed, the LED indicator light is steadily lit rather than undulating as a Mac laptop typically does while sleeping. Upon opening the laptop lid, the LED light turns off, but the screen never turns on. The only way to resolve this issue when it happens is to force shutdown the machine by holding down the power button for several seconds. Pressing the power button a second time reboots the machine and everything then works again as expected. 

Thus far, the issue appears to be tied to the Nouveau open-source driver for this machine's NVIDIA GPU. I have been unable to find any fixes that work under use of this driver and have only been able to resolve this wake from sleep issue by installing the NVIDIA proprietary driver. I have yet to experience this issue while using the NVIDIA driver, so this issue seems resolved as of now.
