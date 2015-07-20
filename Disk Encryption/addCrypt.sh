#!/bin/sh
#mkdir ./mountUsb
# sda1 for board sdb1 for laptop!
if [ -z ${1} ]
then
	echo "The usage of this script is: ./addCrypt /path/to/disk/to/be/encrypted"
else	
	encryptedDisk=${1}	
	cryptsetup create newMapper ${encryptedDisk}	
	#sudo mkfs.ext2 /dev/mapper/newMapper
	mount -t ext2 /dev/mapper/newMapper /mnt/EncrpytedDisk			
	echo "Encryption Completed!"
	echo "You can now write to /mnt/EncryptedDisk to write your encrypted disk."

fi











