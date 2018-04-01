#!/bin/bash
# Author: Sean Reeves
# Date Created: 02/27/2018
# Date Modified: 04/01/2018
# Description: A simple script to install a SystemD service file for Googles AIY Voice Assistant
# License: MIT License

file="my_assistant.service"

if ! [ $(id -u) = 0 ]; then
   echo "script must be run as root"
   exit 1
fi

#[Sean Reeves] (03/31/2018) Comment: Menu with Google AIY Voice options.
option=$(whiptail --clear --nocancel --title "Google AIY Assistant" --ok-button "Select" --menu "Choose an option" 12 130 6 \ "assistant_grpc_demo.py" "A demo of the Google Assistant GRPC recognizer." \ "assistant_library_demo.py" "Run a recognizer using the Google Assistant Library." \ "assistant_library_with_button_demo.py" "Run a recognizer using the Google Assistant Library with button support." \ "assistant_library_with_local_commands_demo.py" "Run a recognizer using the Google Assistant Library." \ "cloudspeech_demo.py" "A demo of the Google CloudSpeech recognizer." 3>&1 1>&2 2>&3);
#[Sean Reeves] (03/31/2018) Comment: Trim spaces
trimmed=$(echo "${option}" | xargs);
#[Sean Reeves] (03/31/2018) Comment: Replace line in service file.
sed -i "s|replacement|$trimmed|g" "$file";

sudo cp my_assistant.service /lib/systemd/system/ 
sudo systemctl enable my_assistant.service
sudo service my_assistant start
sudo systemctl my_assistant.service status

