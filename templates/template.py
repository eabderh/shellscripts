#!/usr/bin/python

import sys, getopt
from os.path import basename, isfile
from subprocess import call

try:
	opts, args = getopt.getopt(sys.argv[1:], '' , [])
except getopt.GetoptError:
	print 'argument error'
	sys.exit(1);


def create():
	file = open(tempfile_path, 'wr')
	for path in args:
		if isfile(path):
			symlinkname = basename(path)
			if not isfile(symlinkname):
				file.write(symlinkname + '\n')
				command = "ln -s " + path + " " + symlinkname
				call(command, shell=True)
	#	if isdir(file):
	file.close()
	return

def destroy():
	file = open(tempfile_path, 'r')
	for path in file:
		call("rm " +  path[:-1], shell=True)
	call("rm " + tempfile_path, shell=True)
	file.close()
	return


tempfile_path = ".track_templates"
if not isfile(tempfile_path):
	if len(args) < 1:
		print "argument error"
		sys.exit(1)
	create()
else:
	destroy()






