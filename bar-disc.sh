#!/bin/bash

LCK="/tmp/bar-disc.lock"

if [ -f $LCK ] ; then
	kill -9 "$(<$LCK)"
	rm $LCK
  	exit 0
fi
(\
df -hTx 'tmpfs' -x 'devtmpfs'; echo ""; lsblk -a -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINT \
) \
    | dzen2 -p -x -480 -y 16 -w 480 -l 17 -sa l -ta l  -e "onstart=uncollapse;button1=ungrabkeys,exit;onexit=exec:rm $LCK" &

echo $! > $LCK
