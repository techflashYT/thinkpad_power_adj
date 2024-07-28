# thinkpad_power_adj

A small set of shell scripts to drive `ryzenadj` and `thinkfan` based on the current system power state.
The actual values of max power and temperature are tuned to my specific liking, but can be adjusted to taste if you want.

Garuanteed to work correctly on at least a ThinkPad T14 Gen 1 AMD running Arch Linux, but will likely work on any Ryzen-based ThinkPad.
If you have another model that you can confirm that this program works on, please open an Issue, and I'll add it to the list, or open a PR and do it yourself.

# Install & Running

- Copy all files in `thinkpad_power_adj` to wherever you want, I would recommend `/usr/bin/thinkpad_power_adj`, as it's what the systemd unit assumes by default.

- Copy all files in the `systemd` folder to `/etc/systemd/system/` or `/usr/lib/systemd/system/`

- If you want the script to start automatically on boot, run `systemctl enable thinkpad_power_adj`

- To start the script without rebooting (or without enabling in the first place), run `systemctl start thinkpad_power_adj`

# Configuration

- Modify `[install root]/on_bat.sh` to modify the power and temperature settings, or do whatever else you want, it runs in the following conditions:
  - Removing the charger from the laptop
  - Initial script startup, while on battery power
  - Resume from suspend or hibernate, while on battery power

- Modify `[install root]/on_ac.sh` to modify the power and temperature settings, or do whatever else you want, it runs in the following conditions:
  - Inserting the charger to the laptop
  - Initial script startup, while on AC power
  - Resume from suspend or hibernate, while on AC power

- Modify `[install root]/thinkfan.ac.yaml` to modify the fan curves for AC power

- Modify `[install root]/thinkfan.bat.yaml` to modify the fan curves for battery power
