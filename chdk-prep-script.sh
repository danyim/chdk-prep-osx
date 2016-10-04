#!/bin/bash
disk="/dev/disk3s1"

echo ""
echo "========================================================================="
echo "                 CHDK SD Card Prep Script (for OSX)"
echo "========================================================================="
echo "Before you continue, please format the disk in Disk Utility as FAT32."
echo "This script will reformat the card to FAT16 and modify its boot sector"
echo "as a bootable disk."
echo ""
echo "The target device is..."
echo "     $disk"
echo ""
echo "Please verify that the above is ABSOLUTELY correct before continuing!"
echo "If you're not sure, run \"diskutil list\" to verify."
read a

# Reformat to FAT16
echo "Reformatting $disk to FAT16"
sudo diskutil unmount $disk
sudo newfs_msdos -F 16 -v Canon_DC -b 4096 -c 128 $disk

# Extract the boot sector from the disk
echo "Extracting boot sector"
sudo dd if=$disk of=BootSector.bin bs=512 count=1
sudo chown $USER BootSector.bin

# Modify the extracted file with "BOOTDISK" @ offset 40 (dec 64)
echo "BOOTDISK" > bootdisk.txt
dd if=bootdisk.txt count=8 bs=1 seek=64 of=BootSector.bin conv=notrunc

# Write the modified boot sector back to the disk
echo "Writing to bootdisk"
sudo dd if=BootSector.bin of=/dev/disk3s1 bs=512 count=1

# Mount the disk ready for use
sudo diskutil mount $disk

# echo "Copy CHDK?"
# read aaa
# sudo diskutil mount $disk
#cp -r ../1.5.0/ /Volumes/Canon_DC

# echo "Unmount?"
# read aaa
# sudo diskutil unmount $disk

# Clean up
rm bootdisk.txt
rm BootSector.bin
echo ""
echo "========================================================================="
echo "Complete! Your SD card is ready to install CHDK."
echo "========================================================================="
echo ""
