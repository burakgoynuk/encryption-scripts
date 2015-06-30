#!/bin/sh

#### Functions!!

passwordFileNotFound(){
	echo "Password file is NOT found!";
	echo "Try to use correct USB!"
}


passwordFile='/mnt/USBMount/password.txt'
#mkdir ./mountUsb
# sda1 for board sdb1 for laptop!

if [ -b /dev/sda1 ]
then 
	
	mount /dev/sda1 /mnt/USBMount
	
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
		echo "Mount success!"
		head -n 4 Tux.ppm > header.txt
		tail -n +5 Tux.ppm > body.bin 

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
				openssl enc -d -aes-128-cbc -nosalt -pass pass:$password -in body.bin -out body_ecr_cbc.bin
				
				cat header.txt body_ecr_cbc.bin > Tux.ppm
				echo "Decryption Completed!"
				rm body_ecr_cbc.bin	
			fi
	
		else
			# Password file is NOT exist
			echo "Password file is NOT found!"
			echo "Try to use correct USB!"
			
		fi
		umount /mnt/USBMount
		rm header.txt	
		rm body.bin
	
	else
		echo "Something went wrong with the mount..."
	fi

else
	echo "USB which includes the password file is NOT found!"
fi







