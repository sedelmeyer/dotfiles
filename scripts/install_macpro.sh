#!/bin/bash

# Install special steps required for MBP 2009

# fnmode=2 makes the function keys primary, and special keys
# require that fn be held down
# See more here:
# https://help.ubuntu.com/community/AppleKeyboard#Change_Function_Key_behavior
# Other keyboard mods here too:
# https://wiki.archlinux.org/index.php/Apple_Keyboard#hid_apple_module_options
echo options hid_apple fnmode=2 | sudo tee -a /etc/modprobe.d/hid_apple.conf

echo "Trigger copying the configuration into the initramfs bootfile."
echo "This may take a little bit of time to complete..."

sudo update-initramfs -u -k all

printf "\nFn default key behavior changed to set F* keys as primary.\n"
printf "\nReboot when convenient for changes to take effect:\n"
printf "\n    shutdown now -r\n\n"
