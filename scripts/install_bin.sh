#!/bin/bash

# Copies executable bash files to /usr/local/bin
# and makes them executable

declare -a scripts

scripts=(
    alert-battery.sh
    alert-updates.sh
)

printf "\nInstall executable user scripts at /usr/local/bin...\n\n"

for script in "${scripts[@]}"; do
    (cd bin/ && sudo cp ${script} /usr/local/bin/)
    sudo chmod +x /usr/local/bin/${script}
    echo "${script} installed as executable"
done

