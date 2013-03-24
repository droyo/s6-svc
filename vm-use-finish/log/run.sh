#!/bin/sh

logdir="/var/log/vm/$(dirname $(pwd) | sed 's;^.*/vm-;;')"
exec s6-setuidgid qemulog \
	s6-log -bt n20 s1000000 "$logdir"
