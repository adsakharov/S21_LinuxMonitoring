#!/bin/bash

function get_timezone {
local tz_region=$(timedatectl | grep "Time zone:" | awk '{print $3}')
if [ $(timedatectl | grep "Time zone:" | awk '{print $5}' | cut -c2) == "0" ]
then
echo "$tz_region UTC $(timedatectl | grep "Time zone:" | awk '{split($5,a,""); print a[1]a[3]}')"
else
echo "$tz_region UTC $(timedatectl | grep "Time zone:" | awk '{split($5,a,""); print a[1]a[2]a[3]}')"
fi
}

function get_os {
source /etc/os-release
echo $PRETTY_NAME
}

function get_ram_total {
local ram_total=$(free | grep 'Mem:' | awk '{printf("%.3f", $2/1024/1024)}')
echo "$ram_total GB"
}

function get_ram_used {
local ram_used=$(free | grep 'Mem:' | awk '{printf("%.3f", $3/1024/1024)}')
echo "$ram_used GB"
}

function get_ram_free {
local ram_free=$(free | grep 'Mem:' | awk '{printf("%.3f", $4/1024/1024)}')
echo "$ram_free GB"
}

function get_space_root {
local space_root=$(df --output=size / | awk 'NR==2{printf("%.2f", $0/1024)}')
echo "$space_root MB"
}

function get_space_root_used {
local space_root=$(df --output=used / | awk 'NR==2{printf("%.2f", $0/1024)}')
echo "$space_root MB"
}

function get_space_root_free {
local space_root=$(df --output=avail / | awk 'NR==2{printf("%.2f", $0/1024)}')
echo "$space_root MB"
}