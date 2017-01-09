==============
countdown-idle
==============
I wanted simple cli countdown timer to use it for Pomodoro and as a tea timer.
All timers I found were too resource intensive - they were producing lot of CPU
wakeups (launch ``powertop`` and see for yourself).

This timer is very light on resources, the disadvantage is that it prints
updated remaining time only when asked (pressing ENTER), but that's enough for
my needs.

Example
-------
::

    $ countdown.sh --help
    countdown.sh [hour] [min] sec

    $ countdown.sh 25 0 && notify-send "Pomodoro finished"
    00:25:00 (press ENTER to update)

