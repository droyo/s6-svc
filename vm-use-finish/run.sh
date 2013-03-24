#!/bin/sh

tunctl -b -u qemu > env/tap || exit 1
mkfifo -m 660 ./ctl
chown qemu: ./ctl

exec s6-setuidgid qemu /bin/sh -c "
	exec 0<./ctl
	exec 8>./ctl
	
	exec s6-envdir ./env /bin/sh -c '
		exec qemu-system-x86_64 -enable-kvm
			-nographic \\
			-net nic,macaddr=\$MAC \\
			-net tap,ifname=\$tap \\
			-hda \$DISK \\
			-monitor stdio
	'
"
