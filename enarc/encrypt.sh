#!/bin/bash

# not yet quite sure what is going on right here
#set -e
# alternative
trap 'echo something went wrong' ERR

# check for options in the argument
while getopts ":sd:k:" opt; do
	case $opt in
		s)
			echo safe mode
			safe_mode=true;
			;;
		d)
			destination=$OPTARG
			;;
		k)
			publickey_uid=$OPTARG
			;;
		\?)
			echo invalid option
			exit 0
			;;
	esac
done

shift $(($OPTIND - 1))


# check for recipients
if [ -z $publickey_uid ]; then
	echo "using default recipient"
else
	gpg_recipient_arg="--recipient $publickey_uid"
fi

# check for pre-existing symlink to file opened by decryption
if [ -L "enarc_open" ]; then
	echo "using symlink from previous decryption"
	target=$(readlink -f enarc_open)
else
	target=$1
fi

# check if file is valid
if [[ -z $target || ! -e $target ]]; then
	echo no target file
	exit 0
fi

# expand the file path
target=$(readlink -f $target)

# check if a new destination exists
if [ -z $destination ]; then
	file_archived=$target.7z
	file_encrypted=$target.gpg
else
	file_archived=$destination.7z
	file_encrypted=$destination
fi

printf "\n"
echo "Target path: $target"
echo "Encrypted file path: $file_encrypted"
printf "\n"



# use different files so that the old files that still exist don't
# get overwritten
temp_file_archived=$file_archived.temp
temp_file_encrypted=$file_encrypted.temp
# check if temp files already exist
if [[ -e temp_file_archived || -e temp_file_encrypted ]]; then
	echo temp files already exist
	exit 0
fi


# actual work
7z a $temp_file_archived $target >/dev/null
gpg --output $temp_file_encrypted --encrypt \
	$gpg_recipient_arg \
	$temp_file_archived >/dev/null

# overwrite old files
mv $temp_file_archived $file_archived
mv $temp_file_encrypted $file_encrypted

# check if old files can be deleted
if [ ! "$safe_mode" = true ]; then
	rm -rf $file_archived $target
fi

# delete symlink
if [ -L "enarc_open" ]; then
	rm enarc_open
fi


