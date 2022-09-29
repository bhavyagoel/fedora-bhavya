#!/bin/bash

# ------------------------- #
# Installing Wifi Driver    #
# ------------------------- #

git clone https://github.com/aircrack-ng/rtl8812au.git
cd rtl8812au
sudo make dkms_install 
cd ..
rm -rf rtl8812au