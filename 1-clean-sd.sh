#!/bin/sh
hdd="/dev/sdb"
echo "o
p
n
p
1

+100M
t
c
n
p
2


w" | fdisk $hdd
mkfs.vfat "$(echo $hdd)1"
mount "$(echo $hdd)1" boot

mkfs.ext4 "$(echo $hdd)2"
mount "$(echo $hdd)2" root

tar xzf ArchLinuxARM-rpi-2-latest.tar.gz -C root
sync
mv root/boot/* boot

umount boot root
