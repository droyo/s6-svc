#!/bin/sh

exec s6-setuidgid taplog \
	s6-log -bt n20 s1000000 /var/log/vm/tapsrv
