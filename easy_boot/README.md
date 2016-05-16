# How to use these scripts:
  * Run `1-clean-sd.sh` in an ubuntu VM with the SD card plugged in
  * Insert the SD card into the Raspberry Pi 3 and connect the Raspberry Pi 3 into an ethernet network & power up
  * Get the IP address via router or nmap from a peer on the network
  * Run the ansible scripts to provision the Raspberry Pi: `easy_boot/ansible_install/README.md`
  * You should be good to go!



# Todo for getting an easy_boot hacking setup
  * Ansible to run & sync gpio scripts ( async? )
  * Add docker to install scripts
  * create dockerfile for gpio-1-led.py
  * Create ansible script to run & sync dockerfile
  * Same for gpio-2-buttons.py
  * PIR sensors
  * Usb webcam
