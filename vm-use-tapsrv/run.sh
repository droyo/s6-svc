#!/bin/sh

mkfifo -m 660 ./ctl
chown qemu: ./ctl
	
s6-svwait ../tapsrv
exec aq-ipcrun -d 8 ../tapsrv/ctl /bin/sh -c '
	echo $$ >&8
	tap=`sed 1q <&8`
	echo -n $tap > env/tap
	exec 0<ctl
	exec 9>ctl
	
	exec s6-envdir /bin/sh -c "
		exec qemu-system-x86_64 -enable_kvm \
			-net nic,macaddr=\$MAC \
			-net tap,ifname=\$tap \
			-hda \$DISK \
			-monitor stdio
	"
'
