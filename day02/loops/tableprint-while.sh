#!/bin/bash
echo "--------------print table by giving args as $1 of which table to print and $2 upto print like 10 or 20---------------"
num=0
while [[ $num -le $2 ]]
do 
	echo "$1 x $num =  $(($1*num))"
	num=$(( num +1))

done
