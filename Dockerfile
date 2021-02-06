# Reference: https://hub.docker.com/_/ubuntu/
FROM ubuntu:18.04

# OS updates and install
RUN apt-get update && apt-get install -y apt-utils build-essential git sudo

# Create test user
RUN useradd -m -s /bin/bash tester
RUN usermod -aG sudo tester
RUN echo "tester   ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers

# Switch to test user
USER tester
ENV HOME /home/tester
WORKDIR ${HOME}

# Define git branch variable
ARG GIT_BRANCH=master

# run 
RUN git clone --single-branch --branch ${GIT_BRANCH}\
    https://github.com/sedelmeyer/dotfiles.git

CMD ["/bin/bash"]
