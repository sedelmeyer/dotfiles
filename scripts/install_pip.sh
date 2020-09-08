#!/bin/bash

# install python user packages

declare -a python_pkgs

python_pkgs=(
  pipenv
  cookiecutter
  docker-compose
)

for pypkg in "${python_pkgs[@]}"
do
    pip install --user "$pypkg"
done

# add python user package path to .profile
source ~/.profile
# IF THAT DOESN'T WORK
# printf "\n# set PATH so it includes python user packages" >> .profile
# printf "export PATH=\$PATH:\$HOME/.local/bin" >> .profile

# confirm path is set and verify installed versions
for pypkg in "${python_pkgs[@]}"
do
    "$pypkg" --version
done


