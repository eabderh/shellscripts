#!/bin/bash

set -e

if [ -z "$1" ]; then
	exit 0
fi

file_encrypted=$1
file_archived=$(expr match "$file_encrypted" '\(.*\)\..*')
file_target=$(expr match "$file_archived" '\(.*\)\..*')

if [ -f "$file_archived" ] || [ -d "$file_target" ]; then
	exit 1
fi

gpg --output $file_archived --decrypt $file_encrypted
7z x $file_archived

ln -s $file_target open_enarc

#if [ -d "$file_target" ]; then
#	cd $file_target
#fi

