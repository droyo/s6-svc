#!/bin/sh

tunctl -d `cat env/tap`
rm -f env/tap
rm -f ./ctl
