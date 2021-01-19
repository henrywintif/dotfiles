#!/bin/bash

# This script opens rofi if it isn't open, and closes it if it is.

my_rofi() {
	dmenu_path | rofi -show run &
}

if [ -e /tmp/rofi_pid ]
then
	# if the rofi_pid file exists, rofi is open so we'll close it
	rofi_pid=`cat /tmp/rofi_pid`
	kill $rofi_pid
	rm /tmp/rofi_pid
else
	my_rofi
	rofi_pid=$!
	echo $rofi_pid >> /tmp/rofi_pid
	wait $rofi_pid
	rm /tmp/rofi_pid
fi
