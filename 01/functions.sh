#!/bin/bash

# Check for number (american and european format)
function isnumber {
    [[ $1 =~ ^[+-]?[0-9]+([.,][0-9]+)?$ ]]
}
