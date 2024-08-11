#!/bin/bash

# clear out old state
STATE_DIR="/var/tmp/thinkpad_power_adj"

fifo="$STATE_DIR/fifo"
rm -rf $STATE_DIR
mkdir $STATE_DIR

# Functions to get/set state variables for the frontend
get_state() {
	cat "$STATE_DIR/$1"
}

set_state() {
	echo "$2" > "$STATE_DIR/$1"
}


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
	echo "Trying to run $1"
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
	local mode="$2"
	if [ "$current_state" = "AC" ]; then
		try_run_script "./on_ac_$mode.sh"
	elif [ "$current_state" = "Battery" ]; then
		try_run_script "./on_bat_$mode.sh"
	else
		echo "wtf - $current_state"
	fi
}

# Handle power state change by setting it in the state file and executing the appropriate script
handle_power_state_change() {
	current_state=$(get_power_state)
	previous_state=$(get_state pwr_state 2>/dev/null)

	if [ "$current_state" != "$previous_state" ]; then
		set_state pwr_state "$current_state"
		execute_script "$current_state" "$(get_state mode)"
	fi
}

handle_perf_mode_change() {
	execute_script "$current_state" "$(get_state mode)"
}


# Handle state for the first time
set_state mode "balanced"
handle_power_state_change
handle_perf_mode_change

mkfifo "$fifo"

# Monitor for udev events in the background to immediately know if the change states
udevadm monitor --subsystem-match=power_supply | while read -r line; do
	handle_power_state_change
done &

while true; do
	if ! read request < "$fifo"; then
		continue
	fi
	# TODO: handle it
		
	handle_power_state_change
	handle_perf_mode_change
done

