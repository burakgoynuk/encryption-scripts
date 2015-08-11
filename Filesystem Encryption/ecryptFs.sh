#!/bin/sh

#### Functions!!

passwordFileNotFound(){
	echo "Password file is NOT found!";
	echo "Try to use correct USB!"
}
if [ -z ${1} ] || [ -z ${2} ]   
then 
	echo "Usage of this script is: ./ecryptFs /path/to/filesystem/to/encrypt /path/to/password/file"
else
	filesystem=${1}
	passwordFile=${2}


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
			echo "Password is not set, wrong File!";
		else
			mountphrase=$password 

			#Add tokens into user session keyring
			printf "%s" "${mountphrase}" | ecryptfs-add-passphrase > tmp.txt

			#Now get the signature from the output of the above command
			sig=`tail -1 tmp.txt | awk '{print $6}' | sed 's/\[//g' | sed 's/\]//g'`
			rm -f tmp.txt #Remove temp file

			#Now perform the mount
			mount.ecryptfs $filesystem $filesystem -o key=passphrase:passphrase_passwd=${mountphrase},no_sig_cache=yes,verbose=no,ecryptfs_sig=${sig},ecryptfs_cipher=aes,ecryptfs_key_bytes=16,ecryptfs_passthrough=no,ecryptfs_enable_filename_crypto=no 
			echo "Encryption Completed!"
		fi

	else
		# Password file is NOT exist
		echo "Password file is NOT found!"
	fi
fi

