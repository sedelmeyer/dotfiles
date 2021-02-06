# Reference: https://hub.docker.com/_/ubuntu/
FROM ubuntu:18.04

# OS updates and install
# RUN apt update && apt install -y git
RUN apt-get update && apt-get install -y make git

ARG GIT_BRANCH=master

RUN git clone --single-branch --branch ${GIT_BRANCH}\
    https://github.com/sedelmeyer/dotfiles.git\
    && (cd dotfiles && make dots)\
    && ls -a root > contents.txt

CMD cat contents.txt
