#!/bin/bash

# see instructions here:
# https://www.dropbox.com/install?os=lnx

read -p "Do you currently have access to a browser for linking your account (y/n)?" choice
case "$choice" in 
  y|Y ) echo "yes";;
  n|N ) echo "no... the script will not be run at this time"; exit;;
  * ) echo "invalid entry"; exit;;
esac

# download the daemon
(cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -)

# running it for the first time will start the server
# it is best to hold off on this until after script is run
# ~/.dropbox-dist/dropboxd

# now download dropbox cli script
# see notes here:
# https://ostechnix.com/install-dropbox-in-ubuntu-18-04-lts-server/
sudo wget -O /usr/local/bin/dropbox "https://www.dropbox.com/download?dl=packages/dropbox.py"

# make that script executable
sudo chmod +x /usr/local/bin/dropbox

# run to see all options
dropbox

printf "\nRun this command to start daemon for the first time:"
printf "\n\n    dropbox start"
printf "\n\nA browser sign-in window will open to link your account\n\n"
