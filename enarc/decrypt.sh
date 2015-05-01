#!/bin/bash


# check for options in the argument
while getopts ":sd:" opt; do
	case $opt in
		s)
			# not implemented yet
			echo safe mode
			safe_mode=true;
			;;
		d)
			# not implemented yet
			destination=$OPTARG
			;;
		\?)
			echo invalid option
			exit 0
			;;
	esac
done

shift $(($OPTIND - 1))

file_encrypted=$1
# check if file is valid
if [[ -z $file_encrypted || ! -e $file_encrypted ]]; then
	echo no target file
	exit 0
fi

# expand the file path
file_encrypted=$(readlink -f $file_encrypted)

# check if file is right type
#file_archived=$(printf '%s' $file_encrypted | sed -r "s/.gpg//")
if [ "${file_encrypted##*.}" != "gpg" ]; then
	echo wrong filetype
	exit 0
fi

# get file name and archive name, if there is one
destination="${file_encrypted%.*}"
file_archived=$destination.7z

printf "\n"
echo "Encrypted file path: $file_encrypted"
echo "Destination file path: $file_encrypted"
printf "\n"

# decrypt and extract
gpg --output $file_archived --decrypt $file_encrypted >/dev/null
7z x $file_archived -o$(dirname $destination) >/dev/null

# place symlink to destination
ln -s $destination "enarc_open"


