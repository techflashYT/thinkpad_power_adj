#!/bin/bash

# Paths to the scripts to run
# If installed and started normally, these should be in CWD
ON_BATTERY_SCRIPT="./on_bat.sh"
ON_AC_SCRIPT="./on_ac.sh"

# File to store the previous power state
STATE_FILE="/var/tmp/previous_power_state"

# Clear old state out
echo "" > "$STATE_FILE"

# Get the current power state from sysfs
# XXX: Probably want to check the appropriate path on startup instead of assuming the `AC` will always be it.
get_power_state() {
	if [ "$(cat /sys/class/power_supply/AC/online)" = "1" ]; then
		echo "AC"
	else
		echo "Battery"
	fi
}

# Attempt to run the script in a loop until it works, or give up
try_run_script() {
	attempt=0
        while ! bash -e $1 && [ "$attempt" != "3" ]; do
		# probably *just* woke up, wait a few seconds and try again
		sleep 5
		attempt=$((attempt + 1))
	done
}

# Execute the appropriate script based on the current power state
execute_script() {
	local current_state="$1"
	if [ "$current_state" = "AC" ]; then
		try_run_script $ON_AC_SCRIPT
	else
		try_run_script $ON_BATTERY_SCRIPT
	fi
}

# Handle power state change by setting it in the state file and executing the appropriate script
handle_power_state_change() {
    current_state=$(get_power_state)
    previous_state=$(cat "$STATE_FILE" 2>/dev/null)

    if [ "$current_state" != "$previous_state" ]; then
        echo "$current_state" > "$STATE_FILE"
        execute_script "$current_state"
    fi
}

# Handle state for the first time
handle_power_state_change

# Monitor for udev events in the background to immediately know if the change states
udevadm monitor --subsystem-match=power_supply | while read -r line; do
    handle_power_state_change
done &

# Fallback loop: Check every 5s, just in case we miss something from udev
while true; do
    handle_power_state_change
    sleep 5
done

