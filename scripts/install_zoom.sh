#!/bin/bash

# This script installs Zoom from the latest available x64 .deb
# available on their site.

# Sources:
# https://support.zoom.us/hc/en-us/articles/204206269-Installing-Zoom-on-Linux

wget_dir=downloads
install_deb=zoom_amd64.deb
install_file=${wget_dir}/${install_deb}

wget https://zoom.us/client/latest/${install_deb} -O ${install_file} 
sudo apt update -y
(cd ${wget_dir} && sudo apt install ${install_deb})

echo "Zoom has been installed from the latest available .deb"
echo "To uninstall Zoom, run the following command:"
echo ""
echo "    sudo apt remove zoom"
