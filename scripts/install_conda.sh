#!/bin/bash

# MINICONDA INSTALL
# Sources:
# var
# https://conda.io/projects/conda/en/latest/user-guide/install/linux.html

remove_download=true
wget_dir=downloads
conda_install_script=Miniconda3-latest-Linux-x86_64.sh

# download and install script
wget https://repo.anaconda.com/miniconda/$conda_install_script -P ${wget_dir}/
(cd ${wget_dir} && bash $conda_install_script)

# removed conda install script
if [ "$remove_download" = true ]
then
    (cd ${wget_dir} && rm $conda_install_script)
    echo "$conda_install_script has been removed"
fi

# add conda binaries to path
echo 'export PATH="~/miniconda3/bin:$PATH"' >> ~/.bashrc

# Reload default profile
# Set PS1 so that .bashrc can be sourced in script
# Why do we do this? See here: https://askubuntu.com/a/896723
PS1=true
source ~/.bashrc

# update to latest version of conda
conda update -y conda

# install python 3.7 environment for specific projects
conda create --name py37 python=3.7 pip

printf "\nRun this command to finish your conda setup:"
printf "\n\n    source ~/.bashrc\n\n"
