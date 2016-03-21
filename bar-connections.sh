#!/bin/bash

LCK="/tmp/bar-connections.lock"

if [ -f $LCK ] ; then
	kill -9 "$(<$LCK)"
	rm $LCK
	exit 0
fi


#(ip route | cut -d ' ' -f 1,2,3
#,

#wicd-cli -ly | cut -f 1,3,4 
#) \
    (
wicd-cli -dy
echo ""
echo "eth in/out: "$(($(ifdata -sib eth0)/1024/1024))"/"$(($(ifdata -sob eth0)/1024/1024))"(MB)"
echo "wlan in/out: "$(($(ifdata -sib wlan0)/1024/1024))"/"$(($(ifdata -sob wlan0)/1024/1024))"(MB)"
echo ""
route)  | dzen2 -p -x -500 -y 16 -w 500 -l 20 -sa l -ta l  -e "onstart=uncollapse;button1=ungrabkeys,exit;onexit=exec:rm $LCK" &

echo $! > $LCK

