#!/bin/bash

# Note that this script fails with error code 2 on gh-actions
# test matrix. Therefore, this script is not tested during CI. 
# Use and modify with caution.

# set boolean to install specific packages from source
install_light=true
install_st=true

# set directory path for downloading source
source_dir=$HOME/Code/source
# make directory path if it does not already exist
mkdir -p ${source_dir}

# install light package from github and install from latest dev
# this package is an alternative to xbacklight and will work
# with non-intel graphics cards. Unfortunately, it isn't
# available through apt pkg repo until ubuntu 20.04
# For more info, see: https://github.com/haikarainen/light
if [ "$install_light" = true ]
then
    sudo apt install -y gcc automake autoconf
    repo=light
    repo_path=${source_dir}/${repo}
    (cd ${source_dir} && git clone https://github.com/haikarainen/light.git)
    (cd ${repo_path} && ./autogen.sh && ./configure && make && sudo make install)
    light -h # show help to ensure install worked
fi

# install personal forked version of suckless.org simple
# terminal (st) from GitHub and install
if [ "$install_st" = true ]
then
    sudo apt install -y libx11-dev libxft-dev
    repo=st
    repo_path=${source_dir}/${repo}
    (cd ${source_dir} && git clone https://github.com/sedelmeyer/st.git)
    (cd ${repo_path} && sudo make clean install)
    st -v # show version to ensure install worked
fi

