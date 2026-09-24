#!/bin/bash

echo "------------Now creating script to check file exist or not by script argument as file name------------------"

file_name() {
	if [[ -f "$1" ]]; then
		echo "file exist"
		return 0
	else
		echo "file not exist"
		return 1
	fi
}

file_name "$1"
	
