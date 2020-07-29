#!/bin/bash
#Yair Cohen 318571718
# This grep command gets the line numbers in which the given word appears.
grep -wn "$2" "$1" | cut -c 1 > linenum.txt 
# This grep command gets the lines in which the given word appears.
grep -w "$2" "$1" > lines.txt
file="lines.txt"
i=0
# The loop reads through the lines and counts the words in every line and outputs to a file.
while IFS= read -r line
do
	i=$((i+1))
	if (($i < 2))
	then 
	echo "$line" | wc -w > count.txt
	else
	echo "$line" | wc -w >> count.txt
	fi
done <"$file"
# Merges the two files the counters of line and the line numbers.
paste -d " " linenum.txt count.txt > sum.txt
cat sum.txt
