#!/bin/bash

_term() {
	kill -TERM "$proc" 2>/dev/null
	rm /tmp/xobpipe
}

trap _term SIGHUP SIGINT SIGQUIT SIGTERM

mkfifo /tmp/xobpipe
tail -f /tmp/xobpipe | xob &

proc=$!
wait "$proc"
