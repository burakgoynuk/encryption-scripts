#!/bin/sh

#### Functions!!

passwordFileNotFound(){
	echo "Password file is NOT found!";
	echo "Try to use correct USB!"
}


if [ -z ${1} ] || [ -z ${2} ]
then 
	echo "Usage of this script is: ./imageDecr /path/to/encrypted/image /path/to/password/file" 
else
	imageFile=${1}
	passwordFile=${2}
	head -n 4  $imageFile > header.txt
	tail -n +5 $imageFile > body.bin 

	if [ -f $passwordFile ]
	then
		# Read password file from the password file!		
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
		
	fi
	rm header.txt	
	rm body.bin
fi	


