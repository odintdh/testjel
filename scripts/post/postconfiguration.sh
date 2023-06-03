#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail
cd /tmp/
# disable due to /usr/local/lib unavailable on Fedora SilverBlue 
#pip install PQMusic
#git clone https://github.com/berarma/oversteer.git
#cd oversteer
#meson build
#cd build
#ninja install
#udevadm control --reload-rules && udevadm trigger
#rm -rf /tmp/oversteer
sed -i 's/#DefaultTimeoutStopSec.*/DefaultTimeoutStopSec=15s/' /etc/systemd/user.conf
sed -i 's/#DefaultTimeoutStopSec.*/DefaultTimeoutStopSec=15s/' /etc/systemd/system.conf
systemctl unmask dconf-update.service
systemctl enable dconf-update.service
