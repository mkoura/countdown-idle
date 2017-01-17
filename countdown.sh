#!/bin/bash

# Martin Kourim <martin@kourim.net>  2016
# Public Domain

help_msg="${0##*/} [hour] [min] sec"

case "$1" in
  -h | *-help ) echo "$help_msg"; exit 0 ;;
esac

case "$#" in
  3 ) hour="${1::5}"; min="${2::10}"; sec="${3::10}" ;;
  2 ) min="${1::10}"; sec="${2::10}" ;;
  1 ) sec="${1::10}" ;;
  * ) echo "$help_msg" >&2; exit 1 ;;
esac

time_uptime() {
  read s _  < /proc/uptime && echo "${s%.*}"
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

now="$($timestamp)"

hsec=0 ; msec=0
[ -n "$hour" ] && hsec="$((hour * 3600))"
[ -n "$min" ] && msec="$((min * 60))"
finish="$((now + hsec + msec + sec))"

while [ "$now" -lt "$finish" ]; do
    togo="$((finish - now))"

    # calculate and print remaining time
    reh="$((togo / 3600))"
    rem="$((togo / 60 % 60))"
    res="$((togo % 60))"
    # always print time on the same line
    printf "\r%02d:%02d:%02d (press ENTER to update)\033[0K" $reh $rem $res

    # wait for ENTER, or until the time is up
    read -s -t "$togo"

    now="$($timestamp)"
done

printf "\rTime's up!\033[0K\n"
