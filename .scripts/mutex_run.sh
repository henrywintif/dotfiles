#!/bin/bash

# This script evaluates the parameter passed once. If this script is run again with the same 
# parameter, it closes the first instance.
#
# Example usage with rofi: `./.scripts/mutex_run.sh "dmenu_path | rofi -show run"`

my_command=$1

# where the pid_file will go
pid_file_directory="/tmp/"
# we'll replace a bunch of possible characters in the command to make the filename safe
# WARNING: I haven't done extensive testing on this, and I don't guarantee filenames to be safe
pid_filename=$(echo $my_command | sed -r 's/[][}{|/\!"#$&()*;<=>?^`~\ ]/_/g' | sed -r "s/[']/_/g")
# the full filepath is the directory+filename
pid_filepath=$pid_file_directory$pid_filename".lock"

if [ -e $pid_filepath ]
then
	# if the pid file exists, my_program is running so we'll kill it
	pid=`cat $pid_filepath`
	kill $pid
	# and remove the file that indicates its running
	rm $pid_filepath
else
	# my_program is not running, so we'll start it
	eval $my_command" &"
	pid=$!
	# save the pid to the file so if this script runs again we can kill it
	echo $pid >> $pid_filepath
	# wait until the program closes. this will be triggered both when the
	# program ends normally (e.g. rofi closes), but also when the program
	# is killed by another instance of this script, which will actually
	# run the `rm` command twice, but that shouldn't matter
	wait $pid
	rm $pid_filepath
fi
