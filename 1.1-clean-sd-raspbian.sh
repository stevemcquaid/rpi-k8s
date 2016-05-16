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
mkdir -p /root/rpi/boot
mount "$(echo $hdd)1" /root/rpi/boot

mkfs.ext4 "$(echo $hdd)2"
mkdir -p /root/rpi/root
mount "$(echo $hdd)2" /root/rpi/root

if [! -f 2016-03-18-raspbian-jessie-lite.zip]; then
  tar xzf 2016-03-18-raspbian-jessie-lite.zip -C /root/rpi/root
else
  wget https://downloads.raspberrypi.org/raspbian_lite/images/raspbian_lite-2016-03-18/2016-03-18-raspbian-jessie-lite.zip
  tar xzf 2016-03-18-raspbian-jessie-lite.zip -C /root/rpi/root
fi

sync
mv /root/rpi/root/boot/* /root/rpi/boot

umount /root/rpi/boot /root/rpi/root
