#!/bin/bash

# manually install abcde for cd ripping because
# bionic apt pkg is out of date and musicbrainz api
# interface is broken

wget_dir=downloads
ws_pkg_dir=WebService-MusicBrainz-1.0.4
abcde_pkg_dir=abcde-2.9.3

# first install apt-based install dependencies

declare -a packages

packages=(
    lame # mp3 support
    # vorbis-tools
    # flac
    normalize-audio
    cdparanoia
    cd-discid
    id3
    eyed3
    glycr # not in reqs doc
    libmusicbrainz-discid-perl
    # libwebservice-musicbrainz-perl # requires >=1.0.4, not in bionic repo
    libmojolicious-perl # dependency for libwebservice manual install
)

for pkg in "${packages[@]}"
do
    sudo apt install -y "$pkg"
done


# download and unpack musikbrainz web servces perl script from focal repo

wget http://archive.ubuntu.com/ubuntu/pool/universe/libw/libwebservice-musicbrainz-perl/libwebservice-musicbrainz-perl_1.0.4.orig.tar.gz -P ${wget_dir}/

tar -xvzf ${wget_dir}/libwebservice-musicbrainz-perl_1.0.4.orig.tar.gz -C ${wget_dir}/

(cd ${wget_dir}/${ws_pkg_dir} && perl Makefile.PL && make && make test && make install)


# download latest abcde package from project website

wget https://abcde.einval.com/download/abcde-2.9.3.tar.gz -P ${wget_dir}/

tar -xvzf ${wget_dir}/${abcde_pkg_dir}.tar.gz -C ${wget_dir}/

(cd ${wget_dir}/${abcde_pkg_dir} && make install)
