#!/bin/bash

_term() {
    for b_file in ${brightness_files[@]}; do
        rm $b_file
    done

    for pipe in ${pipes[@]}; do
        rm $pipe
    done

    for pid in ${pids[@]}; do
	    kill -TERM "$proc" 2>/dev/null
    done

    exit 0
}

# sleeping because wob doesn't work when executed right after sway starts
sleep 1

trap _term SIGHUP SIGINT SIGQUIT SIGTERM

~/.scripts/get_ddc_display_ids.sh > /tmp/display_ids

brightness_files=()
pipes=()
pids=()

init_ddc_display() {
    # takes display ID as parameter. Use ~/.scripts/get_ddc_display_ids to get ids
    brightness_code=10

    brightness_filename="/tmp/d$1_brightness"
    ddcutil -d $1 -t getvcp $brightness_code | cut -d' ' -f4 > $brightness_filename
    brightness_files+=($brightness_filename)

    pipe_filename="$SWAYSOCK.brightness.d$1.wob"
    mkfifo $pipe_filename
    pipes+=($pipe_filename)

    tail -f $pipe_filename | wob -O $1 &
    pids+=($!)
    echo $!
}

while read display_id; do
    init_ddc_display $display_id
done < /tmp/display_ids

for pid in ${pids[@]}; do
    wait $pid
done
