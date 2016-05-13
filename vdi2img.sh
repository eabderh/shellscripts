#!/bin/bash

VBoxManage clonehd "$1.vdi" "$1.img" --format RAW

