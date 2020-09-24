#!/bin/bash

# VSCODE INSTALL
# Sources:
# https://code.visualstudio.com/docs/setup/linux
# https://code.visualstudio.com/docs/editor/extension-gallery#_command-line-extension-management
wget_dir=downloads/

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > ${wget_dir}packages.microsoft.gpg
sudo install -o root -g root -m 644 ${wget_dir}packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

sudo apt-get install apt-transport-https
sudo apt-get update
sudo apt-get install code # or code-insiders

declare -a code_extensions

code_extensions=(
  ms-python.python
  editorconfig.editorconfig
  njpwerner.autodocstring
  lextudio.restructuredtext
  joaompinto.vscode-graphviz
)

for ext in "${code_extensions[@]}"
do
    code --install-extension "$ext"
done

