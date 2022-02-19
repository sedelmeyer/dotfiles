#!/bin/bash

# MINICONDA INSTALL
# Sources:
# var
# https://conda.io/projects/conda/en/latest/user-guide/install/linux.html

remove_download=true
wget_dir=downloads
conda_install_script=Miniconda3-latest-Linux-x86_64.sh
install_location=${HOME}/miniconda3

# download and install script
wget https://repo.anaconda.com/miniconda/$conda_install_script -P ${wget_dir}/
(cd ${wget_dir} && bash $conda_install_script -b -u -p ${install_location})

# removed conda install script
if [ "$remove_download" = true ]
then
    (cd ${wget_dir} && rm $conda_install_script)
    echo "$conda_install_script has been removed"
fi

# add conda binaries to path
echo 'export PATH="~/miniconda3/bin:$PATH"' >> ~/.bashrc

# Reload default profile
# Here we source new .bashrc ommitting initial lines
# Why do we do this? See here: https://askubuntu.com/a/1041348
eval "$(cat ~/.bashrc | tail -n +10)"

# initialize conda
conda init

# update to latest version of conda
conda update -y conda

# install pip inside base conda environment so that
# the separate install_pip.sh script runs as expected
conda install pip

# install python 3.7 environment for specific projects
conda create -y --name py37 python=3.7 pip

# print final summary of results
conda_ver=`conda --version`
printf "\nMiniconda3 is installed and ${conda_ver} is on PATH\n\n"
printf "A Python 3.7 conda env named py37 has also been installed\n\n"

# execute bash so that bashrc does not need to be sourced
exec bash
