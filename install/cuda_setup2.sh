#!/bin/bash

# RUN ONLY AFTER SUCCESSFULL COMPLETION OF cuda_setup1.sh

# Install development and runtime libraries (~4GB)
sudo apt-get install -y --no-install-recommends \
    cuda-10-1 \
    libcudnn7=7.6.5.32-1+cuda10.1  \
    libcudnn7-dev=7.6.5.32-1+cuda10.1


# Install TensorRT. Requires that libcudnn7 is installed above.
sudo apt-get install -y --no-install-recommends libnvinfer6=6.0.1-1+cuda10.1 \
    libnvinfer-dev=6.0.1-1+cuda10.1 \
    libnvinfer-plugin6=6.0.1-1+cuda10.1

# NOTE 1: After installation, the desktop background may be distorted due to
# a known rendering issue with NVIDIA on Gnome.
# Whenever this occurs, it can be fixed by pressing:
# Alt + F2, then enter r and hit Enter
# This will restart the Gnome, and should restore the background image.

# Source:
# https://askubuntu.com/questions/1043398/broken-desktop-background-on-ubuntu-18-04-under-gnome-after-waking-up-from-suspe

# NOTE 2: Alteratively, NVIDIA can be disabled for energy savings by switching
# to the Intel graphics card using the prime-select command and specifying which
# card to use:
# sudo prime-select intel
# sudo prime-select nvidia
# A reboot will be required for the change to take effect
# To identify which card is currently being used:
# prime-select query

# Source:
# https://www.linuxbabe.com/desktop-linux/switch-intel-nvidia-graphics-card-ubuntu

