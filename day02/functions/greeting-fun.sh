#!/bin/bash

echo "----------this si simple use of function-----------"

greeting() {
	echo "HI ALOK KUMAR"
	echo "WELCOME TO SHELL SCRIPTING"
}

greeting

echo "-----------------------------------------------------------------------------------------------------"


echo "-----------------------Now getting the function calling by function arguments-----------------------"

greet_args() {
	echo "HI $1"
	echo "YOU ARE LEARNING $2"
}

greet_args "ALOK" "DEVOPS"

