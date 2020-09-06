#!/bin/bash

# MINICONDA INSTALL
# Sources:
# var
# https://conda.io/projects/conda/en/latest/user-guide/install/linux.html

conda_install_script=Miniconda3-latest-Linux-x86_64.sh

wget https://repo.anaconda.com/miniconda/$conda_install_script
bash $conda_install_script

# echo 'export PATH="~/anaconda/bin:$PATH"' >> ~/.bashrc

# Reload default profile
source ~/.bashrc

conda update -y conda

rm $conda_install_script
