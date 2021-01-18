#!/bin/bash
ponymix toggle
if ponymix is-muted
then
	echo 0 >> /tmp/xobpipe
else
	echo $(ponymix get-volume) >> /tmp/xobpipe
fi
