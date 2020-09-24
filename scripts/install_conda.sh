#!/bin/bash

# MINICONDA INSTALL
# Sources:
# var
# https://conda.io/projects/conda/en/latest/user-guide/install/linux.html

wget_dir=../downloads/
conda_install_script=Miniconda3-latest-Linux-x86_64.sh

wget https://repo.anaconda.com/miniconda/$conda_install_script -P ${wget_dir}
(cd ${wget_dir} && bash $conda_install_script)

# echo 'export PATH="~/anaconda/bin:$PATH"' >> ~/.bashrc

# Reload default profile
source ~/.bashrc

conda update -y conda

# removed conda install script
# rm $conda_install_script

# install python 3.7 environment for specific projects
conda create --name py37 python=3.7 pip
