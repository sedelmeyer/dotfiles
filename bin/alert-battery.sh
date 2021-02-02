#!/bin/bash

# This script generates an alert when the battery is discharging
# and has a current cpacity less than 20%

# For more info, see:
# https://life-prog.com/tech/alert-on-low-battery-in-i3/

bat_files="/sys/class/power_supply/BAT0"
bat_status=$(cat ${bat_files}/status)
capacity=$(cat "${bat_files}/capacity")

if [ ${bat_status} = "Discharging" ]
then
    if [ ${capacity} -le 10 ]; then
        echo "Battery alert - ${capacity}%"
        notify-send --urgency=critical \
            "EXTREMELY LOW battery" \
            "Only ${capacity}% battery remaining"
    elif [ ${capacity} -le 20 ]; then
        echo "Battery alert - ${capacity}%"
        notify-send --urgency=normal \
            "Low battery" \
            "Only ${capacity}% battery remaining"
    fi
fi
