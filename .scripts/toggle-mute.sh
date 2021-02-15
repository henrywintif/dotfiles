#!/bin/bash
ponymix toggle
if ponymix is-muted
then
	echo 0 >> /tmp/wobpipe
else
	echo $(ponymix get-volume) >> /tmp/wobpipe
fi
