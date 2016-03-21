#!/bin/bash

LCK="/tmp/bar-calendar.lock"

if [ -f $LCK ] ; then
	kill -9 "$(<$LCK)"
	rm $LCK
  	exit 0
fi

TODAY=$(expr `date +'%d'` + 0)
MONTH=`date +'%m'`
YEAR=`date +'%Y'`

(
echo ''`date +'%A %d %B %Y %n'`;  echo
\
# current month, hilight header and today
cal \
    | sed -re "s/^(.*[A-Za-z][A-Za-z]*.*)$/\1/;s/(^|[ ])($TODAY)($|[ ])/\1^fg(#ffffff)^bg(#4f3d52)\2\3/"

# next month, hilight header
[ $MONTH -eq 12 ] && YEAR=`expr $YEAR + 1`
cal `expr \( $MONTH + 1 \) % 12` $YEAR \
    | sed -e 's/^\(.*[A-Za-z][A-Za-z]*.*\)$/\1/'

) \
    | dzen2 -p -x -160 -y 16 -w 160 -l 14 -sa c -ta c  -e "onstart=uncollapse;button1=ungrabkeys,exit;onexit=exec:rm $LCK" &

echo $! > $LCK
