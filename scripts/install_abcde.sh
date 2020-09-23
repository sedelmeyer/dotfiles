#!/bin/bash

# manually install abcde for cd ripping because
# bionic apt pkg is out of date and musicbrainz api
# interface is broken

# first apt-based install dependencies
# lame
# normalize-audio
# cdparanoia
# cd-discid id3 eyed3
# libmusicbrainz-discid-perl
# glycr # not in reqs doc
# libmojolicious-perl # required for web services

# download and unpack musikbrainz web servces perl script from fosse repo
# libwebservice-musicbrainz-perl
# http://archive.ubuntu.com/ubuntu/pool/universe/libw/libwebservice-musicbrainz-perl/libwebservice-musicbrainz-perl_1.0.4.orig.tar.gz
# perl Makefile.PL
# make
# make test
# make install
# install musicbrainz web services perl script from fosse repo

# download latest abcde package from project website
# make install
