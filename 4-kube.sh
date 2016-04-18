#!/bin/bash


# kill Docker
systemctl disable docker
systemctl stop docker
# If this errors:
rm -rf /var/lib/docker/network/


### THIS!
ps -ef | grep docker
pkill docker
#kill <PID>





K8S_DIR="$ROOT/etc/kubernetes"
PROJROOT="/root/kubernetes-on-arm"

# git should be installed already
git clone https://github.com/stevemcquaid/kubernetes-on-arm

# Change to that directory
cd kubernetes-on-arm

# Prepopulate the rootfs
cp -rf sdcard/rootfs/kube-systemd/* /

# Copy current source
cp -rf $PROJROOT $K8S_DIR/source

# Remove the .sh
mv $ROOT/usr/bin/kube-config{.sh,}

# Make the docker dropin directory
mkdir -p $ROOT/usr/lib/systemd/system/docker.service.d
ln -sf ../../../../../etc/kubernetes/dropins/docker-overlay.conf $ROOT/usr/lib/systemd/system/docker.service.d/docker-overlay.conf

# Symlink latest built binaries to an easier path, TODO: seems to fail
mkdir -p $K8S_DIR/source/images/kubernetesonarm/_bin/latest
ln -sf ./source/images/kubernetesonarm/_bin/latest $K8S_DIR/binaries

# Symlink the addons to an easier path
ln -sf ./source/addons $K8S_DIR



# This script will install and setup docker etc.
# TIMEZONE=America/Los_Angeles SWAP=1 NEW_HOSTNAME=$hostname REBOOT=0 kube-config install
kube-config install

# kube-config enable-master

kube-config enable-worker 192.168.1.144
