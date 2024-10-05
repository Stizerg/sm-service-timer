#!/bin/bash

#Removing current all timers
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

# Array of commands
commands=(
    "/bin/bash -c '~/spacemesh/smh12.sh'"
    "/bin/bash -c '~/spacemesh/smh11.sh'"
)

# Array of times
times=("6:00" "7:00")

# Array of dates
dates=("2024-09-30" "2024-10-14" "2024-10-28")

# Get current date and time
current_date=$(date +%s)

# Schedule commands for each date
for date in "${dates[@]}"; do
    next_day=$(date -d "$date +1 day" +%Y-%m-%d)
    for i in "${!times[@]}"; do
        # Determine if the time is for the next day
        if [[ "${times[i]}" < "06:00" ]]; then
            scheduled_date=$(date -d"$next_day ${times[i]}" +%s)
            timer_name="smh_${i}_${next_day//[-]/}"
        else
            scheduled_date=$(date -d"$date ${times[i]}" +%s)
            timer_name="smh_${i}_${date//[-]/}"
        fi

        # Check if the scheduled date is more than 12 hours in the past
        if (( scheduled_date < current_date - 43200 )); then
            echo "Skipping ${commands[i]} scheduled for ${date} ${times[i]} as it is more than 12 hours in the past."
            continue
        fi

        # Check if the scheduled date is within 12 hours in the past
        if (( scheduled_date < current_date )); then
            echo "Starting ${commands[i]} scheduled for ${date} ${times[i]} immediately as it is within 12 hours in the past."
            cmd="systemd-run --user --unit=$timer_name --on-active='1min' -G --no-ask-password ${commands[i]}"
        else
            # Use next_day variable for times scheduled for the next day
            if [[ "${times[i]}" < "06:00" ]]; then
                cmd="systemd-run --user --unit=$timer_name --on-calendar='${next_day} ${times[i]}' -G --no-ask-password ${commands[i]}"
            else
                cmd="systemd-run --user --unit=$timer_name --on-calendar='${date} ${times[i]}' -G --no-ask-password ${commands[i]}"
            fi
        fi

        eval $cmd
    done
done

exit 0

# to see all timers set by the current user
#systemctl --user list-timers --all
