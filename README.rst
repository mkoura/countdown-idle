==============
countdown-idle
==============
I wanted simple cli countdown timer to use it for Pomodoro and as a tea timer.
All timers I tried were too resource intensive - they were producing lot of CPU
wakeups (on Linux you can check this using ``powertop``).

This countdown timer is very light on resources. The slight disadvantage is
that it prints updated remaining time only when asked (after pressing ENTER),
but that's good enough for my needs.

Example
-------
::

    $ countdown.sh --help
    countdown.sh [hour] [min] sec

    $ countdown.sh 25 0 && espeak "Pomodoro finished"
    00:25:00 (press ENTER to update)

