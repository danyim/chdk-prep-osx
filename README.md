# CHDK Card Prep Script

This is a simple script that automates the process [outlined here](http://chdk.wikia.com/wiki/FAQ/Mac).

    If you have a card larger than 4 GB, the solution is to create two partitions on your card: a small FAT16 partition, and a larger FAT32 partition. (The FAT16 partition can be very small, like 2 MB, and must be the first partition on the card.) You would then install the CHDK boot files (DISKBOOT.BIN and possibly PS.FIR) on the FAT16 partition, and everything else on the FAT32 one.

    When using this system, CHDK will start from the FAT16 part of the card. It will then automatically detect the larger FAT32 partition, and "switch over" to use that one. All images, movies, etc. will be stored on the large partition, and all CHDK scripts and data files will be read from there. (The smaller partition cannot be accessed once CHDK is loaded, so don't put any scripts or other files on it that you want to use!)

### Usage
1. Run the partitioner script with the disk label, e.g. `./chdk-partitioner /dev/disk2`
2. Run the formatter script with the disk and parition label, e.g. `./chdk-formatter /dev/disk2s1`
3. Transfer the correct CHDK version for your camera into `/Volumes/CANON_DC`

### Notes
- If your card is < 4GB, you'll only need to use the formatter script

### Resources
  - If you're on Windows, maybe this will work for you: http://www.zenoshrdlu.com/macboot/macboot.html
