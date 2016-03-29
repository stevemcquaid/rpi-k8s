#!/bin/bash
# Since Arch Linux gets frequent updates, it’s useful to upgrade it immediately after booting it up for the first time. The docker and salt packages can also be installed and enabled on the same go. Here are the commands:

pacman --noconfirm -Syu
pacman --noconfirm -S docker salt
systemctl enable docker.service salt-minion.service
timedatectl set-timezone America/Log_Angeles

# Docker needs a little configuration to make it listen to both the UNIX socket and the TCP port, so it can be controlled locally and from outside. This command will do the trick:
sed -e 's@/usr/bin/docker -d@/usr/bin/docker -d -H unix:///var/run/docker.sock -H tcp://0.0.0.0:2375@' -i /usr/lib/systemd/system/docker.service

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

# Finally, these commands will clear the SSH host keys so they will be automaticaly generated at boot time.

rm -f /etc/ssh/ssh_host*
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
sync

reboot -h now

# Now we have a working Arch Linux installation that runs Docker and the Salt Minion. This base OS can be used to boot up all the worker nodes of the private cloud. To make an image of it, you just turn the Raspberry Pi off, pull out the SDHC card and insert it into a Linux or OS X computer.