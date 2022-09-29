#!/bin/bash

# get input wifi password 
read -s -p "Enter password: " password
# check if want to re-enter password
echo $password 
read -p "Is this correct? [y/n]: " -n 1 -r
echo 
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # connect to wifi
    nmcli device wifi connect Goel_5GHz password "$password"
fi