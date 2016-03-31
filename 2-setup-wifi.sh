#!/bin/bash

# root
# root

# Setup SSH
passwd # since ssh fails with default ps
rm -f /etc/ssh/ssh_host* # clear the SSH host keys so they will be automaticaly generated at boot time.
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config


# Fix hostname
echo "pi-$(tr -d ':' < /sys/class/net/eth0/address)" | xargs hostnamectl set-hostname

# Create wifi-profile
wpa_passphrase ConciergeEntertainment djrebase > /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
systemctl enable wpa_supplicant@wlan0.service

# Make sure nic gets IP via DHCP
cat > /etc/systemd/network/00-wireless-dhcp.network << EOF
[Match]
Name=wlan0

[Network]
DHCP=yes
EOF
systemctl start systemd-resolved
systemctl enable systemd-networkd

# Start the services
systemctl start wpa_supplicant@wlan0.service
systemctl restart systemd-networkd.service


# Clean up and restart
sync
reboot -h now
