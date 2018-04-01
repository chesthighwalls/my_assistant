#!/bin/bash
# Author: Sean Reeves
# Date Created: 02/27/2018
# Date Modified: 
# Description: 
# License: MIT License

if ! [ $(id -u) = 0 ]; then
   echo "script must be run as root"
   exit 1
fi

sudo cp my_assistant.service /lib/systemd/system/ 
sudo systemctl enable my_assistant.service
sudo service my_assistant start
sudo systemctl my_assistant.service status

