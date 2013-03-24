#!/bin/sh
# /usr/local/bin/vm-shutdown
powerdown() {
    s6-svc -O "$1" # Keep VM from coming back up
    echo system_powerdown > $1/ctl
    s6-svwait -t 30 -d "$1"
    s6-svc -dx "$1"
}

for vmctl in /service/vm-*/ctl
do
    powerdown `dirname "$vmctl"` &
done

wait
