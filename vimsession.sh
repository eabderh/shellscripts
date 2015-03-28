#!/bin/bash

vsfile="$(find . -maxdepth 1 -type f -iname ".*.vs.vim" | head -n 1)"

if [ -z "$vsfile" ]; then
	echo none found;
	exit 0;
fi

#read -n 1 -s
vim -S $vsfile



