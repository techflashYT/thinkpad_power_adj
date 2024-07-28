# thinkpad_power_adj

A small set of shell scripts to drive `ryzenadj` and `thinkfan` based on the current system power state.
The actual values of max power and temperature are tuned to my specific liking, but can be adjusted to taste if you want.

Garuanteed to work correctly on at least a ThinkPad T14 Gen 1 AMD running Arch Linux, but will likely work on any Ryzen-based ThinkPad.
If you have another model that you can confirm that this program works on, please open an Issue, and I'll add it to the list, or open a PR and do it yourself.

# Install

- Copy all files in `thinkpad_power_adj` to wherever you want, I would recommend `/usr/bin/thinkpad_power_adj`, as it's what the systemd unit assumes by default.

- Copy all files in the `systemd` folder to `/etc/systemd/system/` or `/usr/lib/systemd/system/`

- If you want the script to start automatically on boot, run `systemctl enable thinkpad_power_adj`

- To start the script without rebooting (or without enabling in the first place), run `systemctl start thinkpad_power_adj`
