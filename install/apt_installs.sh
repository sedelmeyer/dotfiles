#!/bin/bash

# Update Ubuntu and get standard repository programs
sudo apt update && sudo apt full-upgrade -y

# common apt packages

declare -a packages

packages=(
  ## BASICS
  git
  vim
  tree
  file
  htop
  ufw
  curl
  wget
  ## MEDIA
  cmus
  rhythmbox
  gstreamer1.0-plugins-bad
  # smplayer
  mpv
  # ABCDE CD ENCODER PKGS
  # Only 20.04 version works
  # eyed3
  # lame
  # flac
  # abcde
  # IMAGES
  gimp
  inkscape
  imagemagick
  fim
  ## DOCUMENTS
  texlive
  pandoc
  graphviz
  libreoffice
  ## OTHER TOOLS
  python3-gpg
  nautilus-dropbox
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
  exfat-fuse
  exfat-utils
  # calcurse
  # khal
  # lynx
  # w3m
  # w3m-img
  vifm
  # ranger
)

for pkg in "${packages[@]}"
do
    sudo apt install -y "$pkg"
done

# enable firewall
sudo ufw enable
# will still require policies to modify behavior

# DVD Support
sudo apt install -y libdvd-pkg
sudo dpkg-reconfigure libdvd-pkg

sudo apt upgrade -y
sudo apt autoremove -y
