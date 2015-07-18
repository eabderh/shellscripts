#!/bin/bash






if [ $# -lt 1 ]; then
	echo no file
	exit 1
fi

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









