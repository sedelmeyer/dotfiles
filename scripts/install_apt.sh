#!/bin/bash

ufw_enable=true
borg_ppa=true
podman_ppa=true

dvd_support=true

# Update Ubuntu and get standard repository programs
sudo apt update && sudo apt full-upgrade -y

# common apt packages

declare -a packages

packages=(
  ## BASICS
  git
  vim
  make
  tree
  file
  htop
  ufw
  curl
  wget
  xsel
  xclip
  tmux
  rsync
  borgbackup
  i3
  # xbacklight # only works with intel graphic 
  # light # altern to xbacklight, only avail 20.04
  redshift
  vifm
  ## MEDIA
  cmus
  eject
  mpv
  # ABCDE installed using install_abcde.sh
  # for that reason, rhythmbox is not used
  # rhythmbox
  # gstreamer1.0-plugins-bad
  # smplayer
  # ABCDE CD ENCODER PKGS
  # Only 20.04 version works, see install_abcde.sh
  # eyed3
  # lame
  # flac
  # abcde
  # IMAGES
  gimp
  scrot
  inkscape
  imagemagick
  fim
  ## DEV HEADERS REQUIRED FOR SUCKLESS TOOLS
  libx11-dev
  libxft-dev
  ## DOCUMENTS
  texlive
  pandoc
  graphviz
  libreoffice
  ## OTHER TOOLS
  # python3-gpg
  # nautilus-dropbox
  ## OTHERS TO CONSIDER
  gnome-sushi
  # add libreoffice sushi support
  unoconv
  # p7zip
  # p7zip-full
  # clamav
  # nmap
  # jpegoptim
  # optipng
  # gnome-tweak-tool
  # shunit2
  # chromium-browser
  # mutt
  # notmuch-mutt
  # adb
  # duplicity
  exfat-fuse
  exfat-utils
  # calcurse
  # khal
  # lynx
  # w3m
  # w3m-img
)

for pkg in "${packages[@]}"
do
    sudo apt-get install -y "$pkg"
done

# enable firewall
# will still require policies to modify behavior
if [ "$ufw_enable" = true ]
then
    sudo ufw enable
fi

# install borgbackup from ppa for more recent version
if [ "$borg_ppa" = true ]
then
    sudo add-apt-repository ppa:costamagnagianfranco/borgbackup
    sudo apt-get update
    sudo apt install -y borgbackup
fi

# install podman from Kubic project. It is not in pkg repo for 18.04
# Read more here:
# https://podman.io/getting-started/installation.html#linux-distributions
if [ "$podman_ppa" = true ]
then
    . /etc/os-release
    echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /" | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
    curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/Release.key | sudo apt-key add -
    sudo apt-get update
    sudo apt-get -y upgrade
    sudo apt-get -y install podman
fi

# DVD Support
if [ "$dvd_support" = true ]
then
    sudo apt-get install -y libdvd-pkg
    sudo dpkg-reconfigure libdvd-pkg
fi

sudo apt-get upgrade -y
sudo apt-get autoremove -y
