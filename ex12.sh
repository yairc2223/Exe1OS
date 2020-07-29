#!/bin/bash
#Yair Cohen 31851718 
#this lists all the file lexigraphically in a file.
ls "$1" | sort > lsfiles.txt
file="lsfiles.txt"
i=1
sub='.txt'
# Goes through the list and check for every line (file) if it is a directory or a file.
while IFS= read -r line
do
	n="$1""/""$line" 
	if [ -d "${n}" ] ; then
	x=5
	else
  	if [[ "$line" == *"$sub"* ]];
		then
		echo "$i $line is a file"
    ((i=i+1))
    fi
  fi 
done <"$file"
# prints the directories.  
while IFS= read -r line
do
	n="$1""/""$line" 
	if [ -d "${n}" ] ; then
		echo  "$i $line is a directory"
		((i=i+1))
	fi 
done <"$file"
 

