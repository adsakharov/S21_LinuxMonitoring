#!/bin/bash
# This script displays or saves to a file information about the system

source ./functions.sh

# Check number of parameters
if [ $# -ne 0 ]
then
echo "Invalid input: no parameter is accepted."
exit 2
fi

# Save system info into variables
HOSTNAME=$(hostname)
TIMEZONE=$(get_timezone)
USER=$(whoami)
OS=$(get_os)
DATE=$(date +"%d %B %Y %T")
UPTIME=$(uptime -p)
UPTIME_SEC=$(awk '{print int($1)}' /proc/uptime)
IP=$(ip address | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | cut -d/ -f1)
MASK=$(ifconfig | grep 'inet ' | awk '{print $4}' | head -n1)
GATEWAY=$(ip route | grep 'default' | awk '{print $3}')
RAM_TOTAL=$(get_ram_total)
RAM_USED=$(get_ram_used)
RAM_FREE=$(get_ram_free)
SPACE_ROOT=$(get_space_root)
SPACE_ROOT_USED=$(get_space_root_used)
SPACE_ROOT_FREE=$(get_space_root_free)

# Display system info
echo -e "HOSTNAME = $HOSTNAME\nTIMEZONE = $TIMEZONE\nUSER = $USER\nOS = $OS"
echo -e "DATE = $DATE\nUPTIME = $UPTIME\nUPTIME_SEC = $UPTIME_SEC"
echo -e "IP = $IP\nMASK = $MASK\nGATEWAY = $GATEWAY"
echo -e "RAM_TOTAL = $RAM_TOTAL\nRAM_USED = $RAM_USED\nRAM_FREE = $RAM_FREE"
echo -e "SPACE_ROOT = $SPACE_ROOT\nSPACE_ROOT_USED = $SPACE_ROOT_USED\nSPACE_ROOT_FREE = $SPACE_ROOT_FREE"

# Ask user about saving info to a file 
read -p "Do you whant to save the information to a file? Answer (Y/N)" answer

# Saving info to a file in case of yY answer
if [[ $answer =~ ^[yY]$ ]]
then
info_file="$(date +'%d_%m_%y_%H_%M_%S').status"
{
  echo -e "HOSTNAME = $HOSTNAME\nTIMEZONE = $TIMEZONE\nUSER = $USER\nOS = $OS"
  echo -e "DATE = $DATE\nUPTIME = $UPTIME\nUPTIME_SEC = $UPTIME_SEC"
  echo -e "IP = $IP\nMASK = $MASK\nGATEWAY = $GATEWAY"
  echo -e "RAM_TOTAL = $RAM_TOTAL\nRAM_USED = $RAM_USED\nRAM_FREE = $RAM_FREE"
  echo -e "SPACE_ROOT = $SPACE_ROOT\nSPACE_ROOT_USED = $SPACE_ROOT_USED\nSPACE_ROOT_FREE = $SPACE_ROOT_FREE"
} >"$info_file"
echo "Information saved to $info_file"
fi

exit 1