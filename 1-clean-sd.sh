#!/bin/sh
hdd="/dev/sdb"
umount "$(echo $hdd)1"
umount "$(echo $hdd)2"

mkdir -p /root/rpi
cd /root/rpi
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
mount "$(echo $hdd)1" /root/rpi/boot

mkfs.ext4 "$(echo $hdd)2"
mount "$(echo $hdd)2" /root/rpi/root

if [! -f ArchLinuxARM-rpi-2-latest.tar.gz]; then
  tar xzf ArchLinuxARM-rpi-2-latest.tar.gz -C /root/rpi/root
else
  wget http://archlinuxarm.org/os/ArchLinuxARM-rpi-2-latest.tar.gz
  tar xzf ArchLinuxARM-rpi-2-latest.tar.gz -C /root/rpi/root
fi

sync
mv /root/rpi/root/boot/* /root/rpi/boot

umount /root/rpi/boot /root/rpi/root
