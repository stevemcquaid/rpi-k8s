#!/bin/bash
# Since Arch Linux gets frequent updates, it’s useful to upgrade it immediately after booting it up for the first time. The docker and salt packages can also be installed and enabled on the same go. Here are the commands:

pacman --noconfirm -Syu
pacman --noconfirm -S salt git
systemctl enable salt-minion.service
timedatectl set-timezone America/Los_Angeles

# Arch Linux sets the default hostname to “alarmpi”, which causes every Raspberry Pi device to have the same hostname. This would confuse SaltStack, so we need to add a small custom systemd service to reset the hostname to the Ethernet adapter’s MAC address at boot. This can be done with the following commands:

cat > /usr/local/bin/sethostname.sh << EOF
#!/bin/sh
echo "pi-$(tr -d ':' < /sys/class/net/eth0/address)" | xargs hostnamectl set-hostname
EOF

chmod 755 /usr/local/bin/sethostname.sh
cat > /etc/systemd/system/sethostname.service << EOF
[Unit]
Description=Set hostname to MAC address
Before=salt-minion.service
[Service]
Type=oneshot
ExecStart=/usr/local/bin/sethostname.sh
[Install]
WantedBy=multi-user.target
EOF
systemctl enable sethostname.service


# Clean up and restart
sync
reboot -h now

# Now we have a working Arch Linux installation that runs Docker and the Salt Minion. This base OS can be used to boot up all the worker nodes of the private cloud. To make an image of it, you just turn the Raspberry Pi off, pull out the SDHC card and insert it into a Linux or OS X computer.