#!/bin/bash
#Yair Cohen 31851718 
# Finds and print all the lines related to the account,
grep -w "$1" "$2" 
# Outputs the account realated lines to a file.
grep -w "$1" "$2" > personalsum.txt 
cut -d " " -f 2  personalsum.txt > nums.txt # outputs the numbers to a file.
printf "Total balance: "
awk '{n += $1}; END{print n}' nums.txt # sums the lines in the numbers file.
