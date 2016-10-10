#!/bin/bash
set -e # Exit on error

disk=$1
if  [ -z "$1" ]; then
  echo "Please provide a device name as an argument, i.e. /dev/disk3"
  exit 1
fi

echo ""
echo "========================================================================="
echo "                 CHDK SD Card Prep Script (for OSX)"
echo "========================================================================="
echo "This script will partition an SD card into two partitions for CHDK."
echo ""
echo "The target device is..."
echo "     $disk"
echo ""
echo "Please verify that the above is ABSOLUTELY correct before continuing!"
echo "If you're not sure, run \"diskutil list\" to verify."
read a

# Repartition into two partitions
echo "Repartitioning $disk"
sudo diskutil unmountDisk $disk
sudo diskutil partitionDisk $disk 2 MBRFormat "MS-DOS FAT32" "BLANK" 40M "MS-DOS FAT32" "CHDK" R

# Setting partition ID with fdisk
echo "Setting partition ID"
sudo diskutil unmountDisk $disk
echo "setpid 1
1
write
exit
"| sudo fdisk -e $disk;

echo ""
echo "========================================================================="
echo "Complete!"
echo "========================================================================="
echo ""
