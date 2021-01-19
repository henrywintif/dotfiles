#!/bin/bash

# This script opens rofi if it isn't open, and closes it if it is.

my_program() {
	dmenu_path | rofi -show run &
}

pid_filename="/tmp/rofi_pid"

if [ -e $pid_filename ]
then
	# if the pid file exists, my_program is running so we'll kill it
	pid=`cat $pid_filename`
	kill $pid
	# and remove the file that indicates its running
	rm $pid_filename
else
	# my_program is not running, so we'll start it
	my_program
	pid=$!
	# save the pid to the file so if this script runs again we can kill it
	echo $pid >> $pid_filename
	# wait until the program closes. this will be triggered both when the
	# program ends normally (e.g. rofi closes), but also when the program
	# is killed by another instance of this script, which will actually
	# run the `rm` command twice, but that shouldn't matter
	wait $pid
	rm $pid_filename
fi
