# thinkpad_power_adj

A small set of shell scripts to drive `ryzenadj` and `thinkfan` based on the current system power state.
The actual values of max power and temperature are tuned to my specific liking, but can be adjusted to taste if you want.

Garuanteed to work correctly on at least a ThinkPad T14 Gen 1 AMD running Arch Linux, but will likely work on any Ryzen-based ThinkPad.
If you have another model that you can confirm that this program works on, please open an Issue, and I'll add it to the list, or open a PR and do it yourself.

# Install & Running

- Copy all files in the `usr` folder to `/usr`

- Copy all files in the `etc` folder to `/etc`

- If you want the script to start automatically on boot, run `systemctl enable thinkpad_power_adj`

- To start the script without rebooting (or without enabling in the first place), run `systemctl start thinkpad_power_adj`

# Configuration

- Modify `/etc/thinkpad_power_adj/on_bat.sh` to modify the power and temperature settings, or do whatever else you want, it runs in the following conditions:
  - Removing the charger from the laptop
  - Initial script startup, while on battery power
  - Resume from suspend or hibernate, while on battery power

- Modify `/etc/thinkpad_power_adj/on_ac.sh` to modify the power and temperature settings, or do whatever else you want, it runs in the following conditions:
  - Inserting the charger to the laptop
  - Initial script startup, while on AC power
  - Resume from suspend or hibernate, while on AC power

- Modify `/etc/thinkpad_power_adj/thinkfan.ac.yaml` to modify the fan curves for AC power

- Modify `/etc/thinkpad_power_adj/thinkfan.bat.yaml` to modify the fan curves for battery power
