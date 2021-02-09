Recovering data from a LUKS encrypted LVM drive
===============================================

After having the motherboard die on one of my laptops, I found myself needing to recover the contents of that laptop's LUKS encrypted drive. The process for doing this is not entirely intuitive, and I needed to consult several sources to get all of the steps correct.

Required software
-----------------

The first thing to do is ensure you have the correct software installed. Both ``cryptsetup`` and ``lvm2`` need to be installed. The good news is, these packages might already be part of your current system install. For instance, to check whether they are already installed in Ubuntu, using the ``apt`` package manager, type the following two commands::

   sudo apt list --installed | grep cryptsetup-bin
   sudo apt list --installed | grep lvm2

If either or neither of these are installed, you would want to install them using a command such as::

  sudo apt-get install cryptsetup-bin lvm2

Once you have them installed, it's time to decrypt and mount your drive.

Decrypting and mounting your drive
----------------------------------



Additional Resources
--------------------

Here are some additional resources used to develop the above listed directions:

* https://askubuntu.com/questions/862358/how-to-recover-data-from-an-encrypted-hard-drive-on-a-dead-laptop#
* https://askubuntu.com/questions/63594/mount-encrypted-volumes-from-command-line
* https://www.systutorials.com/docs/linux/man/8-vgrename/
* https://sleeplessbeastie.eu/2015/11/16/how-to-mount-encrypted-lvm-logical-volume/
