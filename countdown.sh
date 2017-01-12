#!/bin/bash

# Martin Kourim <martin@kourim.net>  2016
# Public Domain

help_msg="${0##*/} [hour] [min] sec"

case "$1" in
  -h | *-help ) echo "$help_msg"; exit 0 ;;
esac

case "$#" in
  3 ) hour="$1"; min="$2"; sec="$3" ;;
  2 ) min="$1"; sec="$2" ;;
  1 ) sec="$1" ;;
  * ) echo "$help_msg" >&2; exit 1 ;;
esac

time_uptime() {
  read sec _  < /proc/uptime && echo "${sec%.*}"
}

time_date() {
  date +%s
}

# avoid fork/exec alltogether if possible
if [ -e /proc/uptime ]; then
  timestamp="time_uptime"
else
  timestamp="time_date"
fi


hsec=0 ; msec=0
[ -n "$hour" ] && hsec="$((hour * 3600))"
[ -n "$min" ] && msec="$((min * 60))"
sec="$((hsec + msec + sec))"

now="$($timestamp)"
finish="$((now + sec))"

# Print newline and return to previous line.
# This way the newline won't be displayed only
# after ENTER is pressed for the first time.
printf "\n\033[1A\033[2K"

while [ "$now" -lt "$finish" ]; do
    togo="$((finish - now))"

    # calculate and print remaining time
    reh="$((togo / 3600 % 100))"
    rem="$((togo / 60 % 60))"
    res="$((togo % 60))"
    # always print time on the same line
    printf "\r%02d:%02d:%02d (press ENTER to update)\033[0K" $reh $rem $res

    # wait for ENTER, or until the time is up
    if read -t "$togo"; then
      # ENTER was pressed, return to previous line
      printf "\033[1A\033[2K"
    fi

    now="$($timestamp)"
done

printf "\rTime's up!\033[0K\n"
