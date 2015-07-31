#!/bin/bash


trap 'echo something went wrong' ERR

# check for options in the argument
while getopts ":d:" opt; do
	case $opt in
		s)
			echo safe mode
			safe_mode=true;
			;;
		d)
			destination=$OPTARG
			;;
		\?)
			echo invalid option
			exit 0
			;;
	esac
done

shift $(($OPTIND - 1))



# check if target path is valid
if [ $# -lt 1 ]; then
	echo no file
	exit 1
fi

origin = $1
base = ${origin##*/}

ln -s origin base

echo full param
echo $param

echo check files
declare -a files
for i in $@; do
	echo $i
	if [ -d $i ]; then
		files=( ${files[@]} $(find $i -type f) )
	else
		files[${#files[@]} + 1]=$i
	fi

	echo files so far
	echo ${files[@]}
	echo ${#files[@]}
done

echo all files
echo ${files[@]}
echo ${#files[@]}
declare -p files

exit 0





function copy {

}

function remove {

}

function update {

}

function check {

}









