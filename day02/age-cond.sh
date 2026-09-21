#!/bin/bash

#Now in this script i so hands-on of conditionals statements

echo "--------------Now i am going to do hands-on of conditional using if and else------------------"

read -p"Enter the your age : " age
if [[ $age -ge 18 ]]; then
	echo "You are adult and eligible for voting"
else
	echo "You are not adult as well not eligible for voting"
	
fi
