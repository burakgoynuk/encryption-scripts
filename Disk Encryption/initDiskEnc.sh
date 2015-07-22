#!/bin/sh

if [ -z ${1} ]
then
	echo "The usage of this script is: ./initDiskEnc.sh /path/to/disk/to/be/encrypted"
else
	encryptedDisk=${1}	
	cryptsetup create newMapper ${encryptedDisk}	 	
	mkfs.ext2 /dev/mapper/newMapper
	mount -t ext2 /dev/mapper/newMapper /mnt/EncrpytedDisk			
	echo "Encryption Completed!"
	echo "You can now write to /mnt/EncryptedDisk to write your encrypted disk."
fi
