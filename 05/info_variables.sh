#!/bin/bash

# Variables whith info about a folder
num_folders=$(find $1 -type d | wc -l)
top5_folders=$(du -h $1 | sort -hr | head -n5 | awk '{print NR " - " $2 ", " $1}')
num_files=$(find $1 -type f |wc -l)
num_config=$(find $1 -type f -name "*.conf" | wc -l)
num_text=$(find $1 -type f -name "*.txt" | wc -l)
num_exec=$(find $1 -type f -executable | wc -l)
num_log=$(find $1 -type f -name "*.log" | wc -l)
num_arch=$(find $1 -type f \
    \( -name "*.zip" -o -name "*.rar" -o -name "*.7z" -o -name "*.cab" \
     -o -name "*.cbr" -o -name "*.deb" -o -name "*.gz" -o -name "*.gzip" \
     -o -name "*.jar" -o -name "*.rpm" -o -name "*.sitx" -o -name "*.tar" \
     -o -name "*.tar-gz" -o -name "*.zipx" \) | wc -l)
num_symlink=$(find $1 -type l | wc -l)
top10_files=$(find $1 -type f -exec du -ah {} + | sort -nr | head -n10 | \
    awk '{n=split ($2,a,/\//); m=split (a[n],b,"."); if (m>1) print NR " - " $2 ", " $1 ", " b[m]; else print NR " - " $2 ", " $1}')
top10_exec=$(find $1 -type f -executable -exec du -ah {} + | sort -nr | head -n10 | awk '{printf NR " - " $2 ", " $1 ", "; system("md5sum " $2 " | cut -d \" \" -f1")}')