#!/bin/bash
# This script displays information about the system.
# Parameters are used to set the colours of backgrounds and fonts

source ./functions.sh

# Check number of parameters
if [ $# -ne 4 ]
then
echo "Invalid input: wrong number of parameters. Only 4 parameters are accepted."
echo -e "To call the script again use parameters:\n./main.sh <background_value_names> <font_value_names> <background_values> <font_values>"
echo "The parameters are numeric from 1 to 6."
echo "Colour designations: (1 - white, 2 - red, 3 - green, 4 - blue, 5 - purple, 6 - black)."
echo "The font and background colours of one column must not match."
exit 2
fi

# Check parameters are numbers from 1 to 6
for (( i=1; i<=4; i++ ))
do
if ! [[ ${!i} =~ ^[1-6]$ ]]
then
echo "Invalid input: parameters have to be numbers from 1 to 6."
echo -e "To call the script again use parameters:\n./main.sh <background_value_names> <font_value_names> <background_values> <font_values>"
echo "Only 4 parameters are accepted."
echo "Colour designations: (1 - white, 2 - red, 3 - green, 4 - blue, 5 - purple, 6 - black)."
echo "The font and background colours of one column must not match."
exit 2
fi
done

# Check font and background colours don't match
if [ $1 == $2 ] || [ $3 == $4 ]
then
echo "Invalid input: the font and background colours of one column must not match"
echo -e "To call the script again use parameters:\n./main.sh <background_value_names> <font_value_names> <background_values> <font_values>"
echo "Only 4 parameters are accepted."
echo "The parameters are numeric from 1 to 6."
echo "Colour designations: (1 - white, 2 - red, 3 - green, 4 - blue, 5 - purple, 6 - black)."
exit 2
fi

# Save system info into variables
HOSTNAME=$(hostname)
TIMEZONE=$(get_timezone)
USER=$(whoami)
OS=$(get_os)
DATE=$(date +"%d %B %Y %T")
UPTIME=$(uptime -p)m
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

# Set colours arrays
background_colors=('47' '41' '42' '44' '45' '40')
font_colors=('97' '91' '92' '94' '95' '30')

# Choose colours according to parameters
bvn=${background_colors[$1 - 1]}
fvn=${font_colors[$2 - 1]}
bv=${background_colors[$3 - 1]}
fv=${font_colors[$4 - 1]}

# Display system info
echo -e "\e[${fvn};${bvn}mHOSTNAME = \e[${bv};${fv}m$HOSTNAME\e[0m"
echo -e "\e[${bvn};${fvn}mTIMEZONE = \e[${bv};${fv}m$TIMEZONE\e[0m"
echo -e "\e[${bvn};${fvn}mUSER = \e[${bv};${fv}m$USER\e[0m"
echo -e "\e[${bvn};${fvn}mOS = \e[${bv};${fv}m$OS\e[0m"
echo -e "\e[${bvn};${fvn}mDATE = \e[${bv};${fv}m$DATE\e[0m"
echo -e "\e[${bvn};${fvn}mUPTIME = \e[${bv};${fv}m$UPTIME\e[0m"
echo -e "\e[${bvn};${fvn}mUPTIME_SEC = \e[${bv};${fv}m$UPTIME_SEC\e[0m"
echo -e "\e[${bvn};${fvn}mIP = \e[${bv};${fv}m$IP\e[0m"
echo -e "\e[${bvn};${fvn}mMASK = \e[${bv};${fv}m$MASK\e[0m"
echo -e "\e[${bvn};${fvn}mGATEWAY = \e[${bv};${fv}m$GATEWAY\e[0m"
echo -e "\e[${bvn};${fvn}mRAM_TOTAL = \e[${bv};${fv}m$RAM_TOTAL\e[0m"
echo -e "\e[${bvn};${fvn}mRAM_USED = \e[${bv};${fv}m$RAM_USED\e[0m"
echo -e "\e[${bvn};${fvn}mRAM_FREE = \e[${bv};${fv}m$RAM_FREE\e[0m"
echo -e "\e[${bvn};${fvn}mSPACE_ROOT = \e[${bv};${fv}m$SPACE_ROOT\e[0m"
echo -e "\e[${bvn};${fvn}mSPACE_ROOT_USED = \e[${bv};${fv}m$SPACE_ROOT_USED\e[0m"
echo -e "\e[${bvn};${fvn}mSPACE_ROOT_FREE = \e[${bv};${fv}m$SPACE_ROOT_FREE\e[0m"

exit 1