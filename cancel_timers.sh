#!/bin/bash

# Get a list of all user timers
timers=$(systemctl --user list-timers --no-legend | awk '{print $NF}')

# For each timer
for timer in $timers; do
    # If the timer was set by the script
    if [[ $timer == smh_* ]]; then
        # Cancel the timer
        systemctl --user stop ${timer%.service}.timer
    fi
done
