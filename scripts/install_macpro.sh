#!/bin/bash

# Install special steps required for MBP 2009

change_fnmode=true
fix_moklistrt=true

# fnmode=2 makes the function keys primary, and special keys
# require that fn be held down
# See more here:
# https://help.ubuntu.com/community/AppleKeyboard#Change_Function_Key_behavior
# Other keyboard mods here too:
# https://wiki.archlinux.org/index.php/Apple_Keyboard#hid_apple_module_options
if [ "$change_fnmode" = true ]
then
    echo options hid_apple fnmode=2 | sudo tee -a /etc/modprobe.d/hid_apple.conf

    echo "Trigger copying the configuration into the initramfs bootfile."
    echo "This may take a little bit of time to complete..."

    sudo update-initramfs -u -k all

    printf "\nFn default key behavior changed to set F* keys as primary.\n"
fi

# MacBookPro hardware typically generates the following warning
# during boot: "Failed to Set MokListRT"
# This fixes that warning. However, it may need to be re-run
# if the warning shows up again after later system updates
# See more here:
# https://askubuntu.com/questions/1279602/ubuntu-20-04-failed-to-set-moklistrt-invalid-parameter/1279764#1279764
if [ "$fix_moklistrt" = true ]
then
    sudo cp /boot/efi/EFI/ubuntu/grubx64.efi /boot/efi/EFI/ubuntu/shimx64.efi 
fi

printf "\nReboot for changes to take effect:\n"
printf "\n    shutdown now -r\n\n"

