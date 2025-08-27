#!/bin/bash

# 1. Remove all existing files in /tftpboot/os (if directory exists)
if [ -d "/tftpboot/os" ]; then
    echo "[+] Clearing /tftpboot/os..."
    sudo rm -rf /tftpboot/os/*
    #sudo rm -rf /var/www/html/os/*
else
    echo "[+] Creating /tftpboot/os..."
    sudo mkdir -p /tftpboot/os
    #sudo mkdir -p /var/www/html/os/
fi

# 2. Mount the ISO
echo "[+] Mounting load.iso to /mnt..."
sudo umount /mnt 2>/dev/null  # Unmount if already mounted
sudo mount -o loop /tftpboot/load.iso /mnt

# 3. Copy all files (including hidden) from /mnt to /tftpboot/os
echo "[+] Copying files from ISO to /tftpboot/os..."
sudo cp -r /mnt/. /tftpboot/os/


# 4. Copy the original ISO into /tftpboot/os
#echo "[+] Copying load.iso to /tftpboot/os..."
#sudo cp /home/dbs/Desktop/load.iso /tftpboot/os/
#sudo cp /home/dbs/Desktop/load.iso /var/www/html/os/

# 5. Fix permissions (TFTP needs world-readable)
echo "[+] Setting permissions..."
sudo chmod -R 755 /tftpboot/os
sudo chown -R nobody:nogroup /tftpboot/os  # Adjust user/group as needed to tftpboot
#sudo chmod -R 755 /var/www/html/os/
#sudo chown -R nobody:nogroup /var/www/html/os/  # Adjust user/group as needed to html
# 6. Unmount ISO
echo "[+] Unmounting /mnt..."
sudo umount /mnt

echo "[+] Done! Files are ready in /tftpboot/os."
