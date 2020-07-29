#!/bin/bash
#Yair Cohen 31851718 
# This function check if a file matched the demands and prints it data, if it is a directory it is sent to a second function that only search for the wanted file.
searchDir (){
ls "$1" > 13.txt
sub="$2"
file="13.txt"
# goin through the files and see if they meet the demands. if it is a directory it is sent to a help function.
while IFS= read -r line
do
	p="$1""/""$line"
	if [ -d "${p}" ] ; then
		searchSubDir "${p}" "$2" 
	else
		if [[ "$line" == "$sub" ]]; then
			cat  "${p}"
			printf "\n"
		fi
	fi
done <"$file"
}


# This function helps the above function by searching in a sub directory for the wanted files.
searchSubDir () {
ls "$1" > "$1.txt" #prints the files names to a file.
sub="$2"
file="$1.txt"
# goin through the files and see if they meet the demands.
while IFS= read -r line
do
	p="$1""/""$line"
	if [ -d "${p}" ] ; then
		x=5
	else
		if [[ "$line" == "$sub" ]]; then
			cat  "${p}" # >> ttt.txt
			printf "\n"
		fi
	fi
done < "$file"
}


searchDir "$1" "$2" 
