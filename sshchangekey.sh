#!/bin/bash



if [ $# -lt 1 ]; then
	echo false usage
	exit 1
fi


if [ -z $SSH_AUTH_SOCK ]; then
	echo agent not started
	exit 1
fi

ssh-add -D
ssh-add ~/.ssh/$1



