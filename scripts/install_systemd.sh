#!/bin/bash

# Configure and start systemd user services
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
