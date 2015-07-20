#!/bin/sh

#### Functions!!

passwordFileNotFound(){
	echo "Password file is NOT found!";
	echo "Try to use correct USB!"
}


passwordFile='/mnt/USBMount/password.txt'
#mkdir ./mountUsb
# sda1 for board sdb1 for laptop!
if [ -z ${1} ] || [ -z ${2} ]
then 
	echo "Usage of this script is: ./fileEnc /path/to/file/to/encrypt /path/to/encrypted/file"
	echo "Note that the USB which contains pasword must be connected."
else
	toBeEncryptedFilePath=${1}
	encryptedFile=${2}
		
	if [ -b /dev/sdb ]
	then 
	
		mount /dev/sdb /mnt/USBMount
	
		# Different Mount Conditions
		if [ $? -eq 0 ]; 
		then
			#echo "Mount success!"
			mounted=1
		else
			#echo "Something went wrong with the mount..."
			mounted=0	
		fi
		
		if [ $mounted -eq 1 ]
		then

			if [ -f $passwordFile ]
			then
				# Read password file from the Mounted USB!		
				while read line
				do
				    name=$line
				    password=$line
				    break
				done < $passwordFile

				if [ -z $password ];
				then 
					# Password file exist, but is emtpy!			
					echo "Password is not set, wrong File!";
				else
					openssl enc -aes-128-cbc -nosalt -pass pass:$password -in $toBeEncryptedFilePath -out $encryptedFile
	
				fi
	
			else
				# Password file is NOT exist
				echo "Password file is NOT found!"
				echo "Try to use correct USB!"
			
			fi
			umount /mnt/USBMount

	
		else
			echo "Something went wrong with the mount..."
		fi

	else
		echo "USB which includes the password file is NOT found!"
	fi
fi






