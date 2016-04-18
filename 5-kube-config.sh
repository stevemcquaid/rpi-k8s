# kill Docker
ps -ef | grep docker

kill

systemctl stop docker.service
systemctl stop docker.socket
systemctl disable docker.service
systemctl disable docker.socket

systemctl stop system-docker.socket
systemctl disable system-docker.socket

pkill docker


sed -i -- 's/rpi-3/rpi-2/g'  /etc/kubernetes/dynamic-env/env.conf

sed -i -- 's/eth0/wlan0/g' nano /usr/lib/systemd/system/k8s-worker.service

sed -i -- 's/eth0/wlan0/g' /usr/lib/systemd/system/k8s-master.service


# This script will install and setup docker etc.
# TIMEZONE=America/Los_Angeles SWAP=1 NEW_HOSTNAME=$hostname REBOOT=0 kube-config install
kube-config install

# kube-config enable-master

kube-config enable-worker 192.168.1.144
