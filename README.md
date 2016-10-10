# CHDK Card Prep Script

This is a simple script that automates the process [outlined here](http://chdk.wikia.com/wiki/FAQ/Mac).

### Usage
1. Run the partitioner script with the disk label, e.g. `./chdk-partitioner /dev/disk2`
2. Run the formatter script with the disk and parition label, e.g. `./chdk-formatter /dev/disk2s2`
3. Transfer the correct CHDK version for your camera into `/Volumes/CANON_DC`

### Notes
- If your card is < 4GB, you'll only need to use the formatter script
