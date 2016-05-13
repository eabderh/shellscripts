#!/bin/bash

VBoxManage convertdd "$1.img" "$1.vdi" --format VDI

# undo
# VBoxManage clonehd "$1.vdi" "$1.img" --format RAW
