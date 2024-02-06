#!/bin/bash
# This script displays information about the system.
# Config.conf file is used to set the colours of backgrounds and fonts

source ./functions.sh
source ./color.sh

# Check number of parameters
if [ $# -ne 0 ]
then
echo "Invalid input: no parameter is accepted."
exit 2
fi

if [[ ! -f ./config.conf ]]
then
echo "Error: can't find config.conf file."
echo "Make sure config.conf exists and contains colour information:"
echo "      column1_background=x1"
echo "      column1_font_color=x2"
echo "      column2_background=x3"
echo "      column2_font_color=x4"
echo "where x1, x2, x3, x4 are numeric from 1 to 6"
echo "(1 - white, 2 - red, 3 - green, 4 - blue, 5 - purple, 6 - black)."
echo "The font and background colours of one column must not match."
echo "In case you leave config.conf emty default colour scheme will be used."
exit 2 
fi

#Check parameters are numbers from 1 to 6
if ! [[ $column1_background =~ ^[1-6]$ ]] || ! [[ $column1_font_color =~ ^[1-6]$ ]] ||
! [[ $column2_background =~ ^[1-6]$ ]] || ! [[ $column2_font_color =~ ^[1-6]$ ]]
then
echo "Invalid input: wrong parameters in confic.conf file."
echo "Make sure config.conf exists and contains colour information:"
echo "      column1_background=x1"
echo "      column1_font_color=x2"
echo "      column2_background=x3"
echo "      column2_font_color=x4"
echo "where x1, x2, x3, x4 are numeric from 1 to 6"
echo "(1 - white, 2 - red, 3 - green, 4 - blue, 5 - purple, 6 - black)."
echo "The font and background colours of one column must not match."
echo "In case you leave config.conf emty default colour scheme will be used"
exit 2
fi

##Check font and background colours don't match
if [ "$column1_background" = "$column1_font_color" ] || [ "$column2_background" = "$column2_font_color" ]
then
echo "Invalid input: the font and background colours of one column must not match"
echo "Make sure config.conf exists and contains colour information:"
echo "      column1_background=x1"
echo "      column1_font_color=x2"
echo "      column2_background=x3"
echo "      column2_font_color=x4"
echo "where x1, x2, x3, x4 are numeric from 1 to 6"
echo "(1 - white, 2 - red, 3 - green, 4 - blue, 5 - purple, 6 - black)."
echo "The font and background colours of one column must not match."
echo "In case you leave config.conf emty default colour scheme will be used"
exit 2
fi

#Save system info into variables
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

#Set colours according to parameters
bvn=${background_colors[$column1_background - 1]}
fvn=${font_colors[$column1_font_color - 1]}
bv=${background_colors[$column2_background - 1]}
fv=${font_colors[$column2_font_color - 1]}

#Display system info
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

#Output the colour scheme
if [ $colour_scheme == "default" ]
then
echo "Column 1 background = default (${colors_names[$column1_background_default - 1]})"
echo "Column 1 font color = default (${colors_names[$column1_font_color_default - 1]})"
echo "Column 2 background = default (${colors_names[$column2_background_default - 1]})"
echo "Column 2 font color = default (${colors_names[$column2_font_color_default - 1]})"
fi

if [ $colour_scheme == "user" ]
then
echo "Column 1 background = $column1_background (${colors_names[$column1_background - 1]})"
echo "Column 1 font color = $column1_font_color (${colors_names[$column1_font_color - 1]})"
echo "Column 2 background = $column2_background (${colors_names[$column2_background - 1]})"
echo "Column 2 font color = $column2_font_color (${colors_names[$column2_font_color - 1]})"
fi

exit 1