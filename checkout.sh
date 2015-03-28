#!/bin/bash



if [ $# -ne 1 ]; then
	echo No file
	exit 1
fi

if [ -d $1 ]; then
	files="$(find $1 -maxdepth 1 -type f)"
	echo $files
fi

if [ -f $1 ]; then
	echo $1
fi
