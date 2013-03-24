#!/bin/sh

rm -f ./ctl
tunctl -d `cat env/tap`
rm -f env/tap
