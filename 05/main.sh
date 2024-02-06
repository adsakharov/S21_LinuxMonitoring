#!/bin/bash
# This script displays information about a folder given in a parameter.

# Execution start
start_time=$(date +%s.%N)

# Check number of parameters
if [ $# -ne 1 ]
then
echo "Invalid input: wrong number of parameters. Only 1 Parameter is accepted."
echo "To call the script again use parameters:\n./main.sh <name_of_the_folder>"
exit 2
fi

# Check ending slash
if [ "${1: -1}" != "/" ]
then
echo "Invalid input: wrong parameter. Backslash '\' expected at the end of the parameter."
echo "To call the script again use parameters:\n./main.sh <name_of_the_folder>"
exit 2
fi

# Check the directory exists
if [ ! -d "$1" ]
then
echo "Error: can't find $1 folder."
exit 2
fi

source ./info_variables.sh

# Displays information about a folder
echo "Total number of folders (including all nested ones) = $num_folders"
echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
echo "$top5_folders"
echo "Total number of files = $num_files"
echo "Number of:"
echo "Configuration files (with the .conf extension) = $num_config"
echo "Text files = $num_text"
echo "Executable files = $num_exec"
echo "Log files (with the extension .log) = $num_log"
echo "Archive files = $num_arch"
echo "Symbolic links = $num_symlink"
echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
echo "$top10_files"
echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
echo "$top10_exec"

# Displays runtime of the script
end_time=$(date +%s.%N)
runtime=$( echo "$end_time - $start_time" | bc -l )
echo "Script execution time (in seconds) = $runtime"