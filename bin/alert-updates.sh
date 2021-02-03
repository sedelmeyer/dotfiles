#!/bin/bash

# This script checks Ubuntu's package repository for available
# updates and generates a system message based on the results
# NOTE: This will only work on Ubuntu

# check for updates and store response
apt_check_msg=`/usr/lib/update-notifier/apt-check --human-readable`
n_updates=$(echo "${apt_check_msg}" | awk 'NR==1{print $1;}')

# print message to terminal
echo "${apt_check_msg}"

# generate alert indicating status of available updates
if [ "$n_updates" -gt 0 ] ; then
    update_alert=$(echo "${apt_check_msg}" | awk 'NR==1')
    security_msg=$(echo "${apt_check_msg}" | awk 'NR>=2')
    notify-send -t 10000 --urgency=normal "${update_alert}" "${security_msg}"
else
    notify-send -t 10000 --urgency=low "This system is up-to-date"
fi

