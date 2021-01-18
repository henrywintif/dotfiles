#!/bin/sh
datetime=$(date +"%Y-%m-%d %l:%M:%S %p")
username=$(whoami)
backlight_percentage=$(xbacklight -get)
battery_status=$(cat /sys/class/power_supply/BAT0/status)
if [ "$battery_status" = "Discharging" ]
then
	battery_status_icon="🔋"
elif [ $battery_status = 'Charging' ]
then
	battery_status_icon='🔌'
else
	battery_status_icon='⚡'
fi
acpi=$(acpi)

# echo $acpi $battery_status_icon $username $datetime

python ~/.config/sway/statusbar.py

