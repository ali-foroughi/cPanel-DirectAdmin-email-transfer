#!/bin/bash
# A script to automatically transfer email accounts and content between DirectAdmin and cPanel

#options
PORT=3300

# Defining our parameters
read -p 'Please specify source server (example: vm1122):' SRC
read -p 'Please specify destination server (example: vm1122):' DST
read -p 'Enter the username: ' USERNAME
USER_DIR="/home/$USERNAME"
DA_ID="/usr/local/directadmin/conf/directadmin.conf"
CP_ID="/usr/local/cpanel/cpconf"
HOSTNAME=$(hostname | cut -d "." -f 1)

# Colors for output messages
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color


##### Checking different parameters before starting ######

#Check if the script is executed on the correct server 
SRC_HOSTNAME_CHECK () {
if [ $HOSTNAME == $SRC ]; then
  echo "hostname matched with server. Continuing..."
else
  echo -e "${RED}The specifed source server does not match the hostname. Please check the server name and run this script again.${NC}"
  exit 1
fi
}

# Check if the provided username exists on the server
SRC_USERNAME_CHECK () {
if [ -d "$USER_DIR" ]; then
  echo "Username found. Contiuning..."
else
  echo -e "${RED}Error: Username is incorrect. Check the username and run the script again.${NC}"
  exit 1
fi
}

# Check if the server is using directadmin or cPanel as the control panel
SRC_PANEL_CHECK () {
if [ -f "$DA_ID" ]; then
  PANEL_TYPE="DirectAdmin"
  echo "DirectAdmin source host detected."
elif [ -f "$CP_ID" ]; then
  PANEL_TYPE="cPanel"
  echo "cPanel source host detected."
else 
  echo -e "${RED}Error: This script is only intended for cPanel and Directadmin servers. Quiting installer.${NC}"
  exit 1
fi
}

#checks the destination server control panel
DST_PANEL_CHECK () {
ssh -p $PORT -tq root@$DST.euhosted.com << EOT
if [ -f "$DA_ID" ]; then
  DST_PANEL_TYPE="DirectAdmin"
  echo "DirectAdmin destination host detected."

elif [ -f "$CP_ID" ]; then
  DST_PANEL_TYPE="cPanel"
  echo "cPanel destination host detected."

else
  echo -e "${RED}Error: This script is only intended for cPanel and Directadmin servers. Quiting installer.${NC}"
  exit 1
fi
EOT
  exit
}

SRC_HOSTNAME_CHECK
SRC_USERNAME_CHECK
SRC_PANEL_CHECK
DST_PANEL_CHECK

#pass=$(openssl rand -base64 9)
#while read ACCOUNT  ; do
#/scripts/addpop $ACCOUNT@mehrrefractories.com $pass >> result.txt 

#done < /root/accounts.txt
