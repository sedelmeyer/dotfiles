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

# Configure and start services which require the
# newly installed executables
declare -a services

services=(
    alert-battery
)

printf "\nConfigure and enable systemctl user services...\n\n"

# copy service files to ~/.config/systemd/user/ dir
for service in "${services[@]}"; do
    # copy services to systemd/user/ dir
    (cd systemd/user/ && cp ${service}.* ~/.config/systemd/user/)
done

# reload the systemctl daemon to pick up new services
systemctl --user daemon-reload

# start new service and enable so it will also run after reboot
for service in "${services[@]}"; do
    systemctl --user start ${service}.timer
    systemctl --user enable ${service}.timer
    echo "${service} service configured, started, and enabled with systemctl"
done

# print summary of newly configured user timers
printf "\nPrint summary of all systemctl user timers...\n\n"
systemctl --user list-timers

