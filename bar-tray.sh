#!/bin/bash
LCK="/tmp/bar-tray.lock"
if [ -f $LCK ] ; then
	killall stalonetray
	rm $LCK
  	exit 0
fi
stalonetray &
echo $! > $LCK
