if [ "$watt_limit" = "" ] || [ "$temp_limit" = "" ]; then
	echo "you didn't set the vars" >&2
	exit 1
fi

# shorthands for setting all of the values
l=${watt_limit}000
t=$temp_limit

# go
ryzenadj --power-saving --fast-limit=$l --slow-limit=$l --stapm-limit=$l --vrmsocmax-current=$l --vrmsoc-current=$l --apu-slow-limit=$l --slow-time=$l --vrm-current=$l --apu-skin-temp=$t --vrmmax-current=100000 --stapm-time=100000 --tctl-temp=$t

exit $?
