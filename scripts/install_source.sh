#!/bin/bash

# set boolean to install specific packages from source
install_light=true

# set directory path for downloading source
source_dir=downloads

# install light package from github and install from latest dev
# this package is an alternative to xbacklight and will work
# with non-intel graphics cards. Unfortunately, it isn't
# available through apt pkg repo until ubuntu 20.04
# For more info, see: https://github.com/haikarainen/light
if [ "$install_light" = true ]
then
    repo=light
    repo_path=${source_dir}/${repo}
    (cd ${source_dir} && git clone https://github.com/haikarainen/light.git)
    (cd ${repo_path} && ./autogen.sh && ./configure && make && sudo make install)
fi
