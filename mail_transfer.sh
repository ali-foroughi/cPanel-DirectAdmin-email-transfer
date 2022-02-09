#!/bin/bash
# A script to automatically transfer email accounts and content between DirectAdmin and cPanel

# Defining our constants
read -p 'Please specify source server (example: vm1122):' SRC
read -p 'Please specify destination server (example: vm1122):' DST
read -p 'Enter the username: ' USERNAME
USER_DIR="/home/$USERNAME"
DA_ID="/usr/local/directadmin/conf/directadmin.conf"
CP_ID="/usr/local/cpanel/cpconf"

##### Check different parameters before starting ######

# Check if the provided username exists on the server

USER_CHECK () {
if [ -d "$USER_DIR" ]; then
  echo "Username found. Contiuning..."
else
  echo "Username is incorrect. Check the username and run the script again."
  exit 1
fi
}

# Check if the server is using directadmin or cPanel as the control panel
PANEL_CHECK () {
if [ -f "$DA_ID" ]; then
  PANEL_TYPE="DirectAdmin"
  echo "DirectAdmin host detected."
elif [ -f "$CP_ID" ]; then
  PANEL_TYPE="cPanel"
  echo "cPanel host detected."
else 
  echo "Error: This script is only intended for cPanel and Directadmin servers. Quiting installer."
  exit 1
fi
}

USER_CHECK
PANEL_CHECK

#pass=$(openssl rand -base64 9)
#while read ACCOUNT  ; do
#/scripts/addpop $ACCOUNT@mehrrefractories.com $pass >> result.txt 

#done < /root/accounts.txt
