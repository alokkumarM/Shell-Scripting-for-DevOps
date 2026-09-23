#!/bin/bash

echo "----------------creating dir by fir loop---------------"

for (( i=1; i<=3; i++ )); do
	mkdir demo$i
	echo "demo$i folder is created"
done




echo "--------now creating dir with the name($1) as arguments and passing the starting($2) and end($3) range in argumants----------------------"

echo "Now creating dir name starting with $1 and from range $2 to $3"
for (( i=$2; i<=$3; i++ )); do
	mkdir $1$i
done

echo "$(ls)"

