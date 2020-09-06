#!/bin/bash

# DOCKER INSTALL

# Source:
# https://docs.docker.com/engine/install/ubuntu/

sudo apt update

sudo apt install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg-agent \
  software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

# confirm that install worked
sudo docker run hello-world

# docker-compose shall be installed separately using a pip --user install

