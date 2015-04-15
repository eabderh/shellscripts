#!/bin/bash

# finds and opens the vim session file in the current directory.

# find all files within the current directory, excluding
# subdirectories, with either .vs.vim or .vs as the extension. take
# the first one found from the resulting list and remove the rest.
vsfile="$(find . -maxdepth 1 \-type f \
				-iname ".*.vs.vim" \
				-o \
	 			-iname ".*.vs" \
				| head -n 1)"

# check if a file was found
if [ -z "$vsfile" ]; then
	echo none found
	exit 0
fi

# open file as a vim session
vim -S $vsfile



