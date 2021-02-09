Recovering data from a LUKS encrypted LVM drive
===============================================

After having the motherboard die on one of my laptops, I found myself needing to recover the contents of that laptop's LUKS encrypted drive. The process for doing this is not entirely intuitive, and I needed to consult several sources to get all of the steps correct.

.. contents:: Contents
  :local:
  :depth: 1
  :backlinks: top

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

.. contents:: In this section
  :local:
  :backlinks: top

The first thing you will want to do is remove the drive you are attempting to recover from your machine, place it in an external disk enclosure, and attach it via USB to a working machine.

1. Identify your encrypted drive partition
""""""""""""""""""""""""""""""""""""""""""

Using the command line in that working machine, once the external encrypted drive is connected, you need to identify the encrypted drive by running ``sudo lsblk``. Once you have the external drive name identified (for the sake of simplicity, we will call that drive ``/dev/sdx``, although in reality it will likely be something like ``/dev/sdb`` or ``/dev/sdc``), you can drill down for a bit more information on each partition of that drive::

   sudo lsblk -f /dev/sdx

Then, let's say that the ``/dev/sdx3`` partition is the ``crypto_LUKS`` filesystem::

  sudo file -s /dev/sdx3

2. Open your LUKS device using ``cryptsetup``
"""""""""""""""""""""""""""""""""""""""""""""

Before you can mount your encrypted disk, you will need to first decrypt it (i.e. open your LUKS device) and then (in step 3 below), activate your logical volume(s).

To open your LUKS device and set up a mapping for that device, run the following command (and substitute the ``encrypted_device`` name for any name you like). Please note, **upon running this command, you will be prompted for the passphrase used to originally encrypt your external drive.** If you do not have that passphrase, you will not be able to open the LUKS device::

   sudo cryptsetup luksOpen /dev/sdx3 encrypted_device

3. Activate your LVM logical volumns
""""""""""""""""""""""""""""""""""""

Prior to mountig this decrypted LUKS device, if your encrypted drive was set up using LVM logical volumes, you will first need to identify and activate those logical volumes. To do this, identify the volume group you need to activate::

   sudo vgdisplay --short

If you see that more than one volume group has the same name (e.g. ``ubuntu-vg``), as will be likely if your other machine was had the same operating system installed on it, **you MUST first change the volume group name of your external LUKS device before proceeding on with these instructions.** Please see the instruction outlining how to accomplish this below in `the section on dealing with duplicate volume group names <#dealing-with-duplicate-volume-group-names>`_.

If your LUKS device volume group name is already different, or you have already taken the steps needed to change that volume group name, you can proceed. For the sake of simplicity, let's assume our identified volume group is named ``external-vg``. Now, we will inspect the logical volumes contained in this logical group::

   sudo lvs -o lv_name,lv_size -S vg_name=external-vg

Most likely you will see a ``root`` volume and a ``swap`` volume. The ``root`` volume should be nearly the full size of your external drive, while the ``swap`` will likely be much smaller (e.g. 470 GiB vs. 8GiB). You now need to activate the desire ``root`` volume of your decrypted volume group::

  sudo lvchange -ay external-vg/root

4. Mount and access your decrypted file system
""""""""""""""""""""""""""""""""""""""""""""""

Now that your logical volume is activate, it can be counted to your system. You can do this, just as you would to mount any other external drive partition. First, create a mount directory::

   sudo mkdir /mnt/new_mount_point

Then, mount your decrypted file system::

   sudo mount /dev/external-vg/root /mnt/new_mount_point/

Now, you can freely access the data on that mounted file system.

5. Unmounting your file system, deactivating your volume, and closing your LUKS device
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Once you are done working with your mounted filesystem, there are 3 steps you need to first take prior to detaching the external drive from your machine. First, you should unmount your decrypted file system::

   sudo umount /dev/external-vg

Next, you must deactivate your active volume group(s). It is wise to first check to see what logical volumes of a volume group are active::

   sudo lvs -S "lvs_active=active && vg_name=external-vg"

Then, you can deactivate the desired volume group(s)::

   sudo lvchange -an external-vg/root

Or, the entire logical volume, rather than running the command separately for each active volume in that group::

   sudo lvchange -an external-vg

Finally, you will need to remove the ``encrupted_device`` LUKS device mapping and wipe the key from the kernel memory::

   sudo cryptsetup luksClose encrypted_device

**Congratulations! You can now disconnect your external drive.**

Dealing with duplicate volume group names
-----------------------------------------

If both your old system (from which the external drive was taken) and new system (i.e. the one on your current machine) are the same Linux distributions, then it is very likely that both will have identical volume group names. This MUST be dealt with prior to trying to activate the volume group contained on your external drive. Active volume groups with duplicate name are not allowed!

After completing `Step 2 above <#open-your-luks-device-using-cryptsetup>`_, once you identify that your have a duplicate volume group name on your external drive, you will want to change the name of that volume group. Just note that you will no longer be able to boot from that external drive once you have changed its volume group name. But this should not be too big of an issue, because you can always change the volume group back to its original name by repeating the commands below, substituting the new name with its original name.

First, run the following command to identify external drive volume group's UUID::

   sudo vgdisplay

Next, using that UUID (let's pretend it is ``UUID: a123-y321z``), you can rename that volume group to ``new-external-vg`` with this command::

   sudo vgrename a123-y321z new-external-vg

Now, if you rerun ``sudo vgdisplay``, you should see the external volume group listed by its new name. Once this is complete, you can proceed on with `Step 3 above <#activate-your-lvm-logical-volumns>`_.


Additional Resources
--------------------

Here are some additional resources used to develop the above listed directions:

* https://askubuntu.com/questions/862358/how-to-recover-data-from-an-encrypted-hard-drive-on-a-dead-laptop#
* https://askubuntu.com/questions/63594/mount-encrypted-volumes-from-command-line
* https://www.systutorials.com/docs/linux/man/8-vgrename/
* https://sleeplessbeastie.eu/2015/11/16/how-to-mount-encrypted-lvm-logical-volume/
