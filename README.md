# SM-service-timer for Ubuntu
<br />
This script for Ubuntu is used to start services at specific time
<br />
Set the dates of beginning of cycle gaps
You need to set the time for each service to start, the number of records in "commands" and "times" variables must be the same
For example if you need to set the timer only for one service, the starting time should be the only one":

commands=(
    "/bin/bash -c '~/spacemesh/smh21-service.sh'"
)

times=("6:00")

If you late to execute this script and the starting time is behind of current time, the service will be started within 1 minute.

Fill free to change this script as you like.
