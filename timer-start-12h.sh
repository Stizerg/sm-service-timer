#!/bin/bash

# Array of services
commands=(
    "/bin/bash -c '~/spacemesh/smh23-service.sh'"
    "/bin/bash -c '~/spacemesh/smh22-service.sh'"
    "/bin/bash -c '~/spacemesh/smh21-service.sh'"
)

# Array of times
times=("6:00" "7:00" "8:00")

# Array of dates
dates=("2024-07-22" "2024-08-05")

# Get current date and time
current_date=$(date +%Y-%m-%d)
current_time=$(date +%H:%M)

# For each date
for date in "${dates[@]}"; do
    # For each service
    for i in "${!commands[@]}"; do
        # Define a name for the timer
        timer_name="smh_${i}_${date//[-]/}"
        # If the date is today and the time is in the past, schedule the service to run within 1 minute
        if [[ "$date" == "$current_date" && "${times[i]}" < "$current_time" ]]; then
            cmd="systemd-run --user --unit=$timer_name --on-active='1min' -G --no-ask-password ${commands[i]}"
        else
            cmd="systemd-run --user --unit=$timer_name --on-calendar='${date} ${times[i]}' -G --no-ask-password ${commands[i]}"
        fi
        eval $cmd
    done
done

exit 0

# to see all timers set by the current user
# systemctl --user list-timers --all






