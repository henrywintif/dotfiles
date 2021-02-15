
increase_ddc_brightness() {
    # takes ddc display ID as parameter
    brightness_code=10

    brightness_filename="/tmp/d$1_brightness"
    echo $brightness_filename
    cat $brightness_filename
    current_brightness="$( cat "$brightness_filename" )"
    pipe_filename="$SWAYSOCK.brightness.d$1.wob"

    if ((current_brightness < 100));
    then
        if ((current_brightness < 10));
        then
            echo "lte 10"
            new_val=$((current_brightness + 1))
        else
            echo "gt10"
            new_val=$((current_brightness + 10))
        fi

        echo "cur: $current_brightness ; new_val: $new_val"

        ddcutil -d $1 setvcp $brightness_code $new_val
        echo $new_val >> $pipe_filename
        echo $new_val > $brightness_filename
    fi
}

while read display_id; do
    increase_ddc_brightness $display_id
done < /tmp/display_ids

exit 0
