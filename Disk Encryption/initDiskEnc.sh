
#!/bin/sh


sudo cryptsetup create newMapper ${encryptedDisk}	 	
sudo mkfs.ext2 /dev/mapper/newMapper
sudo mount -t ext2 /dev/mapper/newMapper /mnt/EncrpytedDisk			
echo "Encryption Completed!"
echo "You can now write to /mnt/EncryptedDisk to write your encrypted disk."







