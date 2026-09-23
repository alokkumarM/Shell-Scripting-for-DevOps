#!/bin/bash

echo "----for printing counting upto 10---------------------"
count=1
while [[ $count -le 10 ]]
do
	echo "$count"
	count=$((count + 1))
done
