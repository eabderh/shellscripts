#!/bin/bash

# changes the ssh private key to one located in the ~/.ssh folder.
# assumes that all key pairs, private and public, are stored in
# subdirectories named with a descriptive and corresponding name.

# check for arguments
if [ $# -lt 1 ]; then
	echo false usage
	exit 1
fi

# check if ssh agent has been started
if [ -z $SSH_AUTH_SOCK ]; then
	echo agent not started
	exit 1
fi

# delete all keys currently in use
ssh-add -D

# add the target key
ssh-add ~/.ssh/$1/id_rsa



