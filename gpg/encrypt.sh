#!/bin/bash

set -e

if [ -z "$1" ]; then
	echo wrong arguments
	exit 0
fi

file_archived_temp=temp.7z
file_encrypted_temp=temp.pgp
file_target=$1
file_archived=${file_target}.7z
file_encrypted=${file_archived}.gpg

7z a $file_archived_temp $file_target

gpg --output $file_encrypted_temp --encrypt --recipient \
	'Elias Abderhalden' $file_archived_temp

mv $file_archived_temp $file_archived
mv $file_encrypted_temp $file_encrypted

if [ ! "$2" == "-s" ]; then
	rm -rf $file_archived $file_target
fi

if [ -L "open_enarc" ]; then
	rm open_enarc
fi


