#!/bin/bash

# root
# root

# Create wifi-profile
cat > /etc/netctl/wlan0-wifi << EOF
Description="Profile for wifi"
Interface=wlan0
Connection=wireless
Security=wpa
ESSID=ConciergeEntertainment
IP=dhcp
Key=djrebase
EOF

# Start the profile
netctl start wlan0-wifi
netctl enable wlan0-wifi

# now you can pul down provisioning script:
wget http://djrebase.com/rpi-setup.sh

bash -x rpi-setup.sh
