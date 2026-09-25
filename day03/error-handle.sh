#!/bin/bash

echo "---------Now creating simple script by function for handling error for creating dir and for already present------------------- "
dir() {
	mkdir demo	
}
if ! dir; then
	echo "This dir. is already exist so code exited"
	exit 1
fi

echo "This message will only show if dir. successfully created "
