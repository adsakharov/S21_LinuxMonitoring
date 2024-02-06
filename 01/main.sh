#!/bin/bash
# This script returns a parameter if it isn't a number

source ./functions.sh

# Check number of parameters
if [ $# -ne 1 ]
then
echo "Invalid input: wrong number of parameters. Only 1 Parameter is accepted."
exit 2
fi

if [ -z $1 ]
then
echo "Invalid input:empty parameter. Parameter must contain some text."
exit 2
fi

# Check that the parameter is not a number and print the parameter
if isnumber $1
then
echo "Invalid input: parameter hasn't to be the number. Only text parameter is accepted."
exit 2
fi

echo $1
exit 1