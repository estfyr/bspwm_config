#! /bin/sh
#
# Example panel for lemonbar

. colors

num_mon=$(bspc query -M | wc -l)

while read -r line ; do
	case $line in
		S*)
			sys="${line#?} %{B-}%{F-}"
			;;
		T*)
			# xtitle output
			title="${line#?} %{B-}%{F-}"
			;;
		W*)
			# bspwm's state
			wm=""
			IFS=':'
			set -- ${line#?}
			while [ $# -gt 0 ] ; do
				item=$1
				name=${item#?}
				case $item in
					[mM]*)
						[ $num_mon -lt 2 ] && shift && continue
						case $item in
							m*)
								# monitor
								FG=$COLOR_FG
								BG=$COLOR_BG
								;;
							M*)
								# focused monitor
								FG=$COLOR_FG
								BG=$COLOR_FOCUSED_MONITOR_BG
								;;
						esac
						wm="${wm}%{F${FG}}%{B${BG}}%{A:bspc monitor -f ${name}:} ${name} %{A}%{B-}%{F-}"
						;;
					[fFoOuU]*)
						case $item in
							f*)
								# free desktop
								FG=$COLOR_FREE_FG
								BG=$COLOR_BG
								;;
							F*)
								# focused free desktop
								FG=$COLOR_FREE_FG
								BG=$COLOR_FOCUSED_BG
								;;
							o*)
								# occupied desktop
								FG=$COLOR_OCCUPIED_FG
								BG=$COLOR_BG
								;;
							O*)
								# focused occupied desktop
								FG=$COLOR_OCCUPIED_FG
								BG=$COLOR_FOCUSED_BG
								;;
							u*)
								# urgent desktop
								FG=$COLOR_URGENT_FG
								BG=$COLOR_BG
								;;
							U*)
								# focused urgent desktop
								FG=$COLOR_URGENT_FG
								BG=$COLOR_FOCUSED_BG
								;;
						esac
						wm="${wm}%{F${FG}}%{B${BG}}%{A:bspc desktop -f ${name}:} ${name} %{A}%{B-}%{F-}"
						;;
					L*)
						# layout, state and flags
                        #WMLVDS1:OQ:oW:oE:fA:fS:fD:LT:TF:G
                        case $name in
                            T*)
                                symbol="#"
                                ;;
                            M*)
                                symbol="[]"
                                ;;
                        esac
						wm="${wm}%{F${COLOR_FREE_FG}} %{A:bspc desktop -l next:}${symbol}%{A}%{B-}%{F-}"
						;;
					[TG]*)
						# layout, state and flags
						;;
				esac
				shift
			done
			;;
	esac
	printf "%s\n" "%{l}${wm}    ${title}%{r}${sys}"
done
