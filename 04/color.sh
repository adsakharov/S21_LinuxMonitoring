#!/bin/bash

#Set colours arrays
background_colors=('47' '41' '42' '44' '45' '40')
font_colors=('97' '91' '92' '94' '95' '30')
colors_names=("white" "red" "green" "blue" "purple" "black")

#Set default colour values
column1_background_default=4
column1_font_color_default=1
column2_background_default=3
column2_font_color_default=2

#Set empty values
column1_background=""
column1_font_color=""
column2_background=""
column2_font_color=""

#Parse config.conf file
column1_background=$(grep "^column1_background=" config.conf | cut -d= -f2)
column1_font_color=$(grep "^column1_font_color=" config.conf | cut -d= -f2)
column2_background=$(grep "^column2_background=" config.conf | cut -d= -f2)
column2_font_color=$(grep "^column2_font_color=" config.conf | cut -d= -f2)

#Check for empty parameters
if [[ -z $column1_background ]] || [[ -z $column1_font_color ]] ||
[[ -z $column2_background ]] || [[ -z $column2_font_color ]]
then
column1_background=$column1_background_default
column1_font_color=$column1_font_color_default
column2_background=$column2_background_default
column2_font_color=$column2_font_color_default
colour_scheme="default"
else
colour_scheme="user"
fi