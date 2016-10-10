#!/bin/bash
set -e # Exit on error
disk=$1

if  [ -z "$1" ]; then
  echo "Please provide a volume label as an argument, i.e. /dev/disk3s1"
  exit 1
fi

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
echo ""
echo "Press [ENTER] to continue."
read a

sudo diskutil unmount $disk

echo -n "Is this for an SD card that is < 4GB? (Y/n): "
read -n 1 reformat
if [ "$reformat" == "Y" ]; then
  # Reformat to FAT16
  echo "Reformatting $disk to FAT16"
  sudo newfs_msdos -F 16 -v Canon_DC -b 4096 -c 128 $disk
fi

# Extract the boot sector from the disk
echo ""
echo "Extracting boot sector as a hex file"
sudo dd if=$disk of=BootSector.bin bs=512 count=1
sudo chown $USER BootSector.bin

# Modify the extracted file with "BOOTDISK" @ offset 40 (dec 64)
echo "BOOTDISK" > bootdisk.txt
dd if=bootdisk.txt count=8 bs=1 seek=64 of=BootSector.bin conv=notrunc

# Write the modified boot sector back to the disk
echo "Writing to boot sector"
sudo dd if=BootSector.bin of=$disk bs=512 count=1

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
