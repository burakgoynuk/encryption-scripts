#!/bin/sh

#### Functions!!
if [ -z ${1} ] 
then 
	echo "Usage of this script is: ./decryptFs /path/to/filesystem/to/decrypt"
else
	filesystem=${1}
	umount.ecryptfs $filesystem
fi









