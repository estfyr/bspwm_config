#! /bin/sh

pkill lemonbar
pkill stalonetray

trap 'trap - TERM; kill 0' INT TERM QUIT EXIT

[ -e "$PANEL_FIFO" ] && rm "$PANEL_FIFO"
mkfifo "$PANEL_FIFO"

bspc subscribe > "$PANEL_FIFO" &
xtitle -sf 'T%s' > "$PANEL_FIFO" &
dwmstatus | stdbuf -oL sed 's/^/S/g' > "$PANEL_FIFO" &

. colors

bar_parse.sh < "$PANEL_FIFO" | lemonbar -a 32  -g x$PANEL_HEIGHT -f "$PANEL_FONT" -F "$COLOR_FG" -B "$COLOR_BG" | sh &


wait
